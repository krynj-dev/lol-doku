import { error, json } from '@sveltejs/kit';
import prisma from '$lib/prisma';
import { getRosteredPuzzle } from '$lib/server/api.js';
/** @type {import('./$types').RequestHandler} */

export async function POST({ request, cookies }) {
    const body = await request.json();
    const session_id = cookies.get('session_id');
    if (!session_id) {
        return error(400);
    }
    const x = body.x;
    const y = body.y;
    // Get Puzzle
    const rostered_puzzle = await getRosteredPuzzle(new Date());
    // Get Rules
    const rule_x = rostered_puzzle.puzzles_puzzle.puzzles_puzzlerule.find((pr: any) => pr.axis == 'x' && pr.index == x);
    const rule_y = rostered_puzzle.puzzles_puzzle.puzzles_puzzlerule.find((pr: any) => pr.axis == 'y' && pr.index == y);
    const player_guesses = await prisma.stats_correctplayerguess.findMany({
        where: {roster_id: rostered_puzzle.id, x_id: rule_x.rule_id, y_id: rule_y.rule_id },
        include: {
            players_player: true
        }
    })
    return json({
        results: player_guesses.map((pg: any) => {
            return {
                player: pg.players_player.display_name,
                guesses: pg.guess_count
            }
        }),
        total_guesses: player_guesses.reduce((acc: number, pg: any) => acc + pg.guess_count, 0),
        x: rule_x.rules_rule.key,
        y: rule_y.rules_rule.key,
        total_games: 0
    });
}