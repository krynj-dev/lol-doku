import prisma from '$lib/prisma';
import { Puzzle } from '$lib/models/new/Puzzle.js';
import { mapPuzzle } from './mapper';
import { Cookies } from '@sveltejs/kit';

export async function getOrCreateGameState(session_id: string, date: Date) {
    const puzzle_response = await getRosteredPuzzle(date);
    let game_obj = await getOrCreateGame(session_id, puzzle_response);
    let puzzle: Puzzle = mapPuzzle(puzzle_response);
    for (let i = 0; i < puzzle.rules.length; i++) {
        let rule = puzzle.rules[i];
        if (rule.rule_type == "team") {
            // fetch team
            let team_response = await prisma.teams_team.findFirst({
                where: { name: rule.key },
                include: {
                    teams_teamalternatename: true
                }
            })
            let team_info = {
                ...team_response,
                other_names: team_response.teams_teamalternatename.map((x: any) => x.alternate_name),
            }
            delete team_info.teams_teamalternatename;
            delete team_info.id;
            puzzle.rules[i].extra_info = team_info;
        } else if (rule.rule_type == "teammate") {
            // fetch player
            let player_response = await prisma.players_player.findFirst({
                where: { display_name: rule.key },
                include: {
                    players_playeralternatename: true
                }
            })
            let player_info = {
                ...player_response,
                other_names: player_response.players_playeralternatename.map((x: any) => x.alternate_name),
            }
            delete player_info.players_playeralternatename;
            delete player_info.id;
            puzzle.rules[i].extra_info = player_info;
        }
    }
    const guesses = await prisma.game_gameguess.findMany({
        where: { game_id: game_obj.id },
        include: { players_player: true }
    })
    return {
        remaining_guesses: game_obj.remaining_guesses,
        status: game_obj.status,
        puzzle: puzzle,
        guesses: guesses.map((g: any) => {
            return {
                player: g.players_player.display_name,
                slot: g.slot,
                correct: g.correct
            }
        })
    };
}

async function getOrCreateGame(session_id: string, game_roster: any) {
    let game_response = await prisma.game_game.findFirst({
        where: { sessionid: session_id, rostered_puzzle_id: game_roster.id },
        include: {}
    })
    if (game_response == null) {
        game_response = await prisma.game_game.create({
            data: {
                sessionid: session_id,
                rostered_puzzle_id: game_roster.id,
                remaining_guesses: 10,
                status: "in_progress"
            }
        })
    }
    return game_response;
}

export async function getRosteredPuzzle(date: Date) {
    return prisma.game_gameroster.findUnique({
        where: { date: date },
        include: {
            puzzles_puzzle: {
                include: {
                    puzzles_puzzlerule: {
                        include: { rules_rule: true }
                    }
                }
            }
        }
    })
}

export function getOrCreateSession(cookies: Cookies) {
    let existing_session = cookies.get('session_id');
    let session_id;
    if (!existing_session) {
        session_id = crypto.randomUUID();
        cookies.set('session_id', session_id, {
            httpOnly: false,
            secure: true,
            path: '',
            sameSite: 'none'
        })
    } else {
        session_id = existing_session;
    }
    return session_id;
}

export async function isCorrect(player_key: string, slot: number, puzzle: any) {
    let slot_x = slot % 3;
    let slot_y = Math.floor(slot / 3);
    let rules = [];
    for (let i = 0; i < puzzle.puzzles_puzzlerule.length; i++) {
        let rule = await prisma.rules_rule.findUnique({
            where: { id: puzzle.puzzles_puzzlerule[i].rule_id },
            include: {
                rules_rule_valid_players: {
                    include: {
                        players_player: true
                    }
                }
            }
        })
        rules.push({
            puzzle_rule: puzzle.puzzles_puzzlerule[i],
            rule: rule
        });
    }
    let rule_one = rules.find((o: any) => {
        return o.puzzle_rule.axis == "x" && o.puzzle_rule.index == slot_x;
    });
    let rule_two = rules.find((o: any) => {
        return o.puzzle_rule.axis == "y" && o.puzzle_rule.index == slot_y;
    });
    if (rule_one && rule_two) {
        let set_one = rule_one.rule.rules_rule_valid_players.map((pr: any) => pr.players_player.display_name);
        let set_two = rule_two.rule.rules_rule_valid_players.map((pr: any) => pr.players_player.display_name);
        let answers = set_one.filter((value: string) => set_two.includes(value));
        if (answers.includes(player_key)) return true;
    }
    return false;
}

export async function commitStats(rostered_puzzle: any, session_id: string) {
    const x_rules = rostered_puzzle.puzzles_puzzle.puzzles_puzzlerule.filter((pr: any) => pr.axis == "x").sort((a: any, b: any) => a.index - b.index);
    const y_rules = rostered_puzzle.puzzles_puzzle.puzzles_puzzlerule.filter((pr: any) => pr.axis == "y").sort((a: any, b: any) => a.index - b.index);
    console.log(x_rules, y_rules)
    for (let x = 0; x < x_rules.length; x++) {
        for (let y = 0; y < y_rules.length; y++) {
            let slot = 3 * y + x;
            let guessed_player = await prisma.game_gameguess.findFirst({
                where: { game_game: { sessionid: session_id, rostered_puzzle_id: rostered_puzzle.id }, slot: slot }
            })
            console.log(guessed_player);
            if (guessed_player.correct) {
                let existing_stat = await prisma.stats_correctplayerguess.findUnique({
                    where: {
                        x_id_y_id_player_id_roster_id: {
                            player_id: guessed_player.player_id,
                            roster_id: rostered_puzzle.id,
                            x_id: x_rules[x].rule_id,
                            y_id: y_rules[y].rule_id
                        }
                    }
                })
                let updated_stat = await prisma.stats_correctplayerguess.update({
                    where: { id: existing_stat.id },
                    data: {
                        guess_count: existing_stat.guess_count + 1
                    }
                })
            }
        }
    }
}