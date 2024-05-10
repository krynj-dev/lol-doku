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

def generate(request):
    # Create puzzle ID
    p = create_puzzle(False)
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
            pr = PuzzleRule(axis=PuzzleRule.RuleAxis.X, 
                rule=Rule.objects.get(key=req_body["rows"][x]["key"]),
                puzzle=p, index=x)
            pr.save()
            xes.append(pr.rule)
        for y in range(len(req_body["columns"])):
            pr = PuzzleRule(axis=PuzzleRule.RuleAxis.Y, 
                rule=Rule.objects.get(key=req_body["columns"][y]["key"]),
                puzzle=p, index=y)
            pr.save()
            yes.append(pr.rule)
    except Exception as e:
        print(e)
        p.delete()
        return HttpResponse(json.dumps({
            "status": 400,
            "message": "Server error"
        }), status=500)
    if not is_solvable(xes[0], xes[1:], yes, False):
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
