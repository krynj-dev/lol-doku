from django.shortcuts import render
from django.http import HttpResponse , HttpRequest, JsonResponse
from rest_framework.response import Response as DRFResponse
from rest_framework import viewsets, permissions
from rest_framework.decorators import api_view, renderer_classes
from rest_framework.renderers import JSONRenderer, TemplateHTMLRenderer
from lol_doku_backend import settings
from players.models import Player
from game.models import GameRoster, Game, GameGuess
from game.serializers import GameRosterSerializer, GameSerializer, GameGuessSerializer
from puzzles.models import PuzzleRule
from puzzles.util import is_valid_guess
from stats.util import update_stats
import json, uuid
import datetime as dt
from django.views.decorators.csrf import csrf_exempt

def get_session(request: HttpRequest):
    existing_cookie = request.COOKIES.get('loldoku_sessionid')
    response = HttpResponse(json.dumps({
        "message": "session retrieved"
    }))  
    if existing_cookie is None:
        response.set_cookie('loldoku_sessionid', uuid.uuid4(), secure=settings.SESSION_COOKIE_SECURE, samesite=settings.SESSION_COOKIE_SAMESITE)
    return response

class GameRosterViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = GameRoster.objects.all().order_by('id')
    serializer_class = GameRosterSerializer
    permission_classes = [permissions.AllowAny]

class GameViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = Game.objects.all().order_by('id')
    serializer_class = GameSerializer
    permission_classes = [permissions.AllowAny]

def get_or_create_game(request: HttpRequest):
    session_id = request.COOKIES.get('loldoku_sessionid')
    print("REQ COOKIES", request.COOKIES)
    if session_id is None:
        return JsonResponse({
            "message": "missing session ID",
            "cookie_string": request.COOKIES
        }, status=400)
    timenow = dt.date.today()
    # Create game using roster and session ID
    todays_puzzle = GameRoster.objects.get(date=timenow)
    game, created = Game.objects.get_or_create(sessionid=session_id, rostered_puzzle=todays_puzzle)
    gs = GameSerializer(game, context={'request': request})
    return JsonResponse(gs.data)

@csrf_exempt
def make_guess(request: HttpRequest):
    request_body = json.loads(request.body)
    session_id = request.COOKIES.get('loldoku_sessionid')
    if session_id is None:
        return HttpResponse(status=400)
    timenow = dt.date.today()
    # Create game using roster and session ID
    todays_puzzle = GameRoster.objects.get(date=timenow)
    try:
        game = Game.objects.get(sessionid=session_id, rostered_puzzle=todays_puzzle)
        player = Player.objects.get(display_name=request_body["player"])
    except:
        return HttpResponse(status=400)
    if game.remaining_guesses == 0:
        return HttpResponse(status=400)
    # Check if guesses remaining
    # Change guess
    slot = 3*request_body["y"] + request_body["x"]
    gg, created = GameGuess.objects.get_or_create(game=game, slot=slot)
    r1 = todays_puzzle.puzzle.assoc_rules.get(axis=PuzzleRule.RuleAxis.X, index=request_body["x"]).rule
    r2 = todays_puzzle.puzzle.assoc_rules.get(axis=PuzzleRule.RuleAxis.Y, index=request_body["y"]).rule
    gg.correct = is_valid_guess(r1, r2, player)
    gg.player = player
    gg.save()
    game.remaining_guesses -= 1
    game.save()
    gs = GameGuessSerializer(gg, context={'request': request})
    return JsonResponse(gs.data)

@csrf_exempt
def finalise(request: HttpRequest):
    session_id = request.COOKIES.get('loldoku_sessionid')
    if session_id is None:
        return HttpResponse(status=400)
    timenow = dt.date.today()
    # Create game using roster and session ID
    todays_puzzle = GameRoster.objects.get(date=timenow)
    try:
        game = Game.objects.get(sessionid=session_id, rostered_puzzle=todays_puzzle)
    except:
        return HttpResponse(status=400)
    # Submit stats
    for x in range(3):
        for y in range(3):
            try:
                update_stats(todays_puzzle, x, y, GameGuess.objects.get(game=game, slot=3*y+x).player)
            except Exception as e:
                print("Stat Update Failed:", e)
    # Update status
    game.status = 'finalised'
    game.save()
    return JsonResponse({
        "message": "game finalised"
    })
