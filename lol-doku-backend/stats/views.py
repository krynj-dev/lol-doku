import json
import datetime as dt

from rest_framework.response import Response
from rest_framework.request import Request
from rest_framework.views import APIView
from rest_framework import permissions

from stats.models import CorrectPlayerGuess
from stats.serializers import CorrectPlayerGuessSerializer
from game.models import GameRoster, Game
from puzzles.models import PuzzleRule

class StatsAPIView(APIView):
    permission_classes = [permissions.AllowAny]
    authentication_classes = []

    def post(self, request: Request):
        session_id = request.COOKIES.get('loldoku_sessionid')
        if session_id is None:
            return Response(status=400)
        # Get slot from request
        request_body = request.data
        x = request_body["x"]
        y = request_body["y"]
        timenow = dt.date.today()
        # Create game using roster and session ID
        todays_puzzle = GameRoster.objects.get(date=timenow)
        # Get all valid players for x and y
        x_rule = todays_puzzle.puzzle.assoc_rules.get(index=x, axis=PuzzleRule.RuleAxis.X).rule
        y_rule = todays_puzzle.puzzle.assoc_rules.get(index=y, axis=PuzzleRule.RuleAxis.Y).rule
        # Grab all the objects
        guesses = CorrectPlayerGuess.objects.filter(roster=todays_puzzle, x=x_rule, y=y_rule)
        serializer = CorrectPlayerGuessSerializer(guesses, many=True, context={'request': request})
        data_list = [d for d in serializer.data]
        total_games = len(Game.objects.all().filter(rostered_puzzle=todays_puzzle, status=Game.Status.FINALISED))
        return Response({
            'results': data_list,
            'total_guesses': sum([d["guesses"] for d in data_list]),
            'x': x_rule.key,
            'y': y_rule.key,
            "total_games": total_games
            })
