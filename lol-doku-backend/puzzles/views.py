from django.shortcuts import render
from django.http import HttpResponse, JsonResponse, HttpRequest
from puzzles.util import create_puzzle, is_solvable
from rules.models import Rule
from puzzles.serializers import PuzzleSerializer
from rest_framework import viewsets, permissions
from rest_framework.response import Response
from rest_framework.request import Request
from rest_framework.views import APIView
import json
from puzzles.models import Puzzle, PuzzleRule
from django.views.decorators.csrf import csrf_exempt

class PuzzleViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = Puzzle.objects.all().order_by('id')
    serializer_class = PuzzleSerializer
    permission_classes = [permissions.DjangoModelPermissions]

    def create(self, request: Request):
        req_body = request.data
        p = Puzzle()
        p.save()
        xes = []
        yes = []
        try:
            for x in range(len(req_body["rows"])):
                r_key = req_body["rows"][x]["key"]
                pr = PuzzleRule(axis=PuzzleRule.RuleAxis.X, 
                    rule=Rule.objects.get(key=r_key),
                    puzzle=p, index=x)
                pr.save()
                xes.append(pr.rule)
            for y in range(len(req_body["columns"])):
                r_key = req_body["columns"][y]["key"]
                pr = PuzzleRule(axis=PuzzleRule.RuleAxis.Y, 
                    rule=Rule.objects.get(key=req_body["columns"][y]["key"]),
                    puzzle=p, index=y)
                pr.save()
                yes.append(pr.rule)
        except Rule.DoesNotExist as e:
            p.delete()
            return Response(json.dumps({
                "status": 404,
                "message": f"Rule {r_key} not found"
            }), status=404)
        except Exception as e:
            p.delete()
            return Response(json.dumps({
                "status": 500,
                "message": "Server error",
                "error": str(e)
            }), status=500)
        if not is_solvable(xes[0], xes[1:], yes):
            return Response(json.dumps({
                "status": 400,
                "message": "Invalid puzzle"
            }), status=400)
        elif puzzle_exists(xes, yes):
            return Response(json.dumps({
                "status": 400,
                "message": "Puzzle exists"
            }), status=400)
        else:
            p.save()
        ps = PuzzleSerializer(p, context={'request': request})
        return Response(ps.data, status=201)     

class PuzzleGenerateApiView(APIView):
    permission_classes = [permissions.IsAdminUser]

    def post(self, request: Request):
        # Unpack options
        req_body = request.data
        min_answers = 1
        allowed_regions = []
        rule_type_minimums = []
        if "answer_count" in req_body.keys() and "min" in req_body["answer_count"]:
            min_answers = int(req_body["answer_count"]["min"])
        if "allowed_regions" in req_body.keys():
            allowed_regions = req_body["allowed_regions"]
        if "rule_type_minimums" in req_body.keys():
            rule_type_minimums = req_body["rule_type_minimums"]
        if "include_rules" in req_body.keys():
            included_rules = req_body["include_rules"]

        p = create_puzzle(min_answers, allowed_regions, rule_type_minimums, included_rules)
        if p is None:
            return Response({"message": "failed to generate"}, status=400)
        return Response(p)

def puzzle_exists(xes, yes):
    db_puzzles = Puzzle.objects.all()
    for db_puzzle in db_puzzles:
        db_axis_one = set([r.key for r in [pr.rule for pr in db_puzzle.assoc_rules.filter(axis=PuzzleRule.RuleAxis.X)]])
        db_axis_two = set([r.key for r in [pr.rule for pr in db_puzzle.assoc_rules.filter(axis=PuzzleRule.RuleAxis.Y)]])
        if (xes == db_axis_one and yes == db_axis_two) or (xes == db_axis_two and yes == db_axis_one):
            return True
    return False
