import json
import datetime as dt

from django.http import HttpRequest, HttpResponse, JsonResponse
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from rest_framework.response import Response

from stats.models import CorrectPlayerGuess
from stats.serializers import CorrectPlayerGuessSerializer
from rules.models import Rule
from players.models import Player
from game.models import GameRoster
from puzzles.models import PuzzleRule


@csrf_exempt
def get_puzzle_slot_stats(request: HttpRequest):
    session_id = request.COOKIES.get('loldoku_sessionid')
    if session_id is None:
        return HttpResponse(status=400)
    # Get slot from request
    request_body = json.loads(request.body)
    x = request_body["x"]
    y = request_body["y"]
    timenow = dt.date.today()
    # Create game using roster and session ID
    todays_puzzle = GameRoster.objects.get(date=timenow)
    # Get all valid players for x and y
    x_rule = todays_puzzle.puzzle.assoc_rules.get(index=x, axis=PuzzleRule.RuleAxis.X).rule
    y_rule = todays_puzzle.puzzle.assoc_rules.get(index=y, axis=PuzzleRule.RuleAxis.Y).rule
    valid_players = set(x_rule.valid_players.primary.all()) & set(y_rule.valid_players.primary.all())
    # Try fetching the correct guess for all players, if a player isn't in there yet, make entry starting at zero
    # Grab all the objects
    guesses = CorrectPlayerGuess.objects.filter(roster=todays_puzzle, x=x_rule, y=y_rule)
    serializer = CorrectPlayerGuessSerializer(guesses, many=True, context={'request': request})
    data_list = [d for d in serializer.data]
    return JsonResponse({
        'results': data_list,
        'total_guesses': sum([d["guesses"] for d in data_list]),
        'x': x_rule.key,
        'y': y_rule.key
        })
