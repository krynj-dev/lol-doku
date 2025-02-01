import { error, json } from '@sveltejs/kit';
import prisma from '$lib/prisma';
import { Puzzle } from '$lib/models/new/Puzzle.js';
import { isCorrect } from '$lib/server/api';
/** @type {import('./$types').RequestHandler} */

export async function POST({ request, cookies }) {
    const body = await request.json();
    const session_id = cookies.get('session_id');
    const slot = 3 * body.y + body.x;
    if (!session_id) {
        return error(400);
    }
    console.log(body)
    const puzzle_response = await prisma.game_gameroster.findUnique({
        where: { date: new Date() },
        include: {
            puzzles_puzzle: {
                include: {
                    puzzles_puzzlerule: {
                        include: true
                    }
                }
            }
        }
    })
    let game_session = await getGame(session_id, puzzle_response);
    let correct = await isCorrect(body.player, slot, puzzle_response.puzzles_puzzle)
    let player = await prisma.players_player.findFirst({
        where: { display_name: body.player }
    })
    console.log("guessing", game_session.id, slot, correct)
    let guess = await prisma.game_gameguess.upsert({
        where: {
            game_id_slot: {
                game_id: game_session.id,
                slot: slot
            }
        },
        create: {
            game_id: game_session.id,
            slot: slot,
            correct: correct,
            player_id: player.id
        },
        update: {
            correct: correct,
            player_id: player.id
        }
    })
    let update_session = await prisma.game_game.update({
        where: { id: game_session.id },
        data: {
            remaining_guesses: game_session.remaining_guesses - 1
        }
    })
    console.log("big kjeks");
    
    return json({
        player: body.player,
        slot: slot,
        correct: correct,
        remaining_guesses: update_session.remaining_guesses
    })
}

async function getGame(session_id: string, game_roster: any) {
    let game_response = await prisma.game_game.findFirst({
        where: { sessionid: session_id, rostered_puzzle_id: game_roster.id },
        include: {}
    })
    return game_response;
}
