import { error, json } from '@sveltejs/kit';
import prisma from '$lib/prisma';
import { commitStats, getOrCreateGameState, getRosteredPuzzle } from '$lib/server/api.js';
/** @type {import('./$types').RequestHandler} */

export async function POST({ request, cookies }) {
    const session_id = cookies.get('session_id');
    if (!session_id) {
        return error(400);
    }
    const rostered_puzzle = await getRosteredPuzzle(new Date());
    const game = await prisma.game_game.findUnique({
        where: { rostered_puzzle_id_sessionid: { sessionid: session_id, rostered_puzzle_id: rostered_puzzle.id } }
    })
    if (game.status == "finalised") {
        return error(400);
    }
    await commitStats(rostered_puzzle, session_id);
    let updated_game = await prisma.game_game.update({
        where: { rostered_puzzle_id_sessionid: { sessionid: session_id, rostered_puzzle_id: rostered_puzzle.id } },
        data: {
            status: "finalised"
        }
    })
    return json({});
};