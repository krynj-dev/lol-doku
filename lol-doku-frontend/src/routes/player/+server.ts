import { error, json } from '@sveltejs/kit';
import prisma from '$lib/prisma';
/** @type {import('./$types').RequestHandler} */

export async function GET({ url }) {
    let encoded_search_term = url.searchParams.get('search');
    const page = url.searchParams.get('page') || 0;
    const limit = url.searchParams.get('limit') || 20;
    let searchTerm;
    if (encoded_search_term) {
        searchTerm = url.searchParams.get('search')
    } else {
        searchTerm = url.searchParams.get('search')
    }
    if (!searchTerm || searchTerm.length < 2) {
        return error(400)
    }
    const matching_players = await prisma.players_player.findMany({
        skip: Number(page),
        take: Number(limit),
        where: {
            OR: [
                {
                    display_name: {
                        contains: searchTerm,
                        mode: 'insensitive'
                    }
                },
                {
                    players_playeralternatename: {
                        some: {
                            alternate_name: {
                                contains: searchTerm,
                                mode: 'insensitive'
                            }
                        }
                    }
                }
            ]
        },
        include: {
            players_playeralternatename: true
        }
    })
    return json({
        count: matching_players.length,
        results: matching_players.map((plr: any) => {
            return {
                id: Number(plr.id),
                display_name: plr.display_name,
                real_name: plr.real_name,
                country: plr.country,
                age: plr.age,
                residency: plr.residency,
                alternate_names: plr.players_playeralternatename.map((an: any) => an.alternate_name)
            }
        })
    })
}