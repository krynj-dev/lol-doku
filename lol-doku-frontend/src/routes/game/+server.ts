import { error, json } from '@sveltejs/kit';
import prisma from '$lib/prisma';
import { Puzzle } from '$lib/models/new/Puzzle.js';
import { getOrCreateGameState, getOrCreateSession } from '$lib/server/api';
/** @type {import('./$types').RequestHandler} */

export async function GET({ cookies }) {
    let session_id = getOrCreateSession(cookies);
    let game_state = await getOrCreateGameState(session_id, new Date());
    let response_string = JSON.stringify(game_state, (k, v) =>
        typeof v === 'bigint'
            ? parseInt(v.toString())
            : v
    )
    return json(JSON.parse(response_string));
}