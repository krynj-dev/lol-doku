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
    const matching_teams = await prisma.teams_team.findMany({
        skip: Number(page),
        take: Number(limit),
        where: {
            OR: [
                {
                    name: {
                        contains: searchTerm,
                        mode: 'insensitive'
                    }
                },
                {
                    op: {
                        contains: searchTerm,
                        mode: 'insensitive'
                    }
                },
                {
                    teams_teamalternatename: {
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
            teams_teamalternatename: true
        }
    })
    return json({
        count: matching_teams.length,
        results: matching_teams.map((team: any) => {
            return {
                id: Number(team.id),
                name: team.name,
                op: team.op,
                region: team.region,
                becomes: team.becomes,
                came_from: team.came_from,
                other_names: team.teams_teamalternatename.map((an: any) => an.alternate_name)
            }
        })
    })
}