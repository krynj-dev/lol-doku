from django.shortcuts import render
from django.http import HttpResponse, JsonResponse, HttpRequest
from puzzles.util import create_puzzle, is_solvable
from rules.models import Rule
from puzzles.serializers import PuzzleSerializer
from rest_framework.request import Request
from rest_framework import viewsets, permissions
import json, os, random
from puzzles.models import Puzzle, PuzzleRule
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt

class PuzzleViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = Puzzle.objects.all().order_by('id')
    serializer_class = PuzzleSerializer
    permission_classes = [permissions.AllowAny]

@csrf_exempt
def generate(request):
    # Unpack options
    req_body = json.loads(request.body)
    if "answer_count" in req_body.keys() and "min" in req_body["answer_count"]:
        min_answers = int(req_body["answer_count"]["min"])
    if "allowed_regions" in req_body.keys():
        allowed_regions = req_body["allowed_regions"]

    p = create_puzzle(min_answers, allowed_regions)
    return JsonResponse(p)


@csrf_exempt
def save_puzzle(request: HttpRequest):
    req_body = json.loads(request.body)

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
        return HttpResponse(json.dumps({
            "status": 404,
            "message": f"Rule {r_key} not found"
        }), status=404)
    except Exception as e:
        p.delete()
        return HttpResponse(json.dumps({
            "status": 500,
            "message": "Server error",
            "error": str(e)
        }), status=500)
    if not is_solvable(xes[0], xes[1:], yes):
        return HttpResponse(json.dumps({
            "status": 400,
            "message": "Invalid puzzle"
        }), status=400)
    elif puzzle_exists(xes, yes):
        return HttpResponse(json.dumps({
            "status": 400,
            "message": "Puzzle exists"
        }), status=400)
    else:
        p.save()
    return HttpResponse(json.dumps({
            "status": 201,
            "message": "Puzzle created"
        }), status=201)

def puzzle_exists(xes, yes):
    db_puzzles = Puzzle.objects.all()
    for db_puzzle in db_puzzles:
        db_axis_one = set([r.key for r in [pr.rule for pr in db_puzzle.assoc_rules.filter(axis=PuzzleRule.RuleAxis.X)]])
        db_axis_two = set([r.key for r in [pr.rule for pr in db_puzzle.assoc_rules.filter(axis=PuzzleRule.RuleAxis.Y)]])
        if (xes == db_axis_one and yes == db_axis_two) or (xes == db_axis_two and yes == db_axis_one):
            return True
    return False
