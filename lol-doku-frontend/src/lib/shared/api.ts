import { type GameState } from "$lib/models/new/GameState";
import { type GuessStats } from "$lib/models/new/GuessStats";
import { type Rule } from "$lib/models/new/Rule";
import { type SlotGuess } from "$lib/models/new/SlotGuess";
import { _correct, _finalised, _lives, _puzzle, _selected_players, _failed_load } from "../../stores";
import { get } from 'svelte/store'
import { type Player } from "$lib/models/new/Player";
import { type FailResponse } from "$lib/models/FailResponse";



async function init_puzzle(): Promise<GameState> {
    // Get Session
    let session_res = await fetch(`${import.meta.env.VITE_BACKEND_ENDPOINT}/game/session`, { credentials: "include" }).then((r) => r.json())
    .catch(e => {
        console.error(e)
        _failed_load.set({
            "reason": "Failed to retrieve session."
        } as FailResponse)
        throw new Error("Failed to retrieve session")
    });
    // Get Game
    let game_res = await fetch(`${import.meta.env.VITE_BACKEND_ENDPOINT}/game/today`, { credentials: "include" })
        .then((r) => {
            _failed_load.set(undefined);
            return r.json();
        })
        .catch(e => {
            console.error(e)
            _failed_load.set({
                "reason": "Failed to retrieve game for today."
            } as FailResponse)
            throw new Error("Failed to retrieve todays game")
        });
    console.log(game_res);
    let game_state = game_res as GameState;
    return game_state;
}

export async function get_player_stats(slot: number) {
    let res = fetch(`${import.meta.env.VITE_BACKEND_ENDPOINT}/stats/today`, {
        credentials: "include",
        method: "POST",
        body: JSON.stringify({
            x: slot % 3,
            y: Math.floor(slot / 3)
        })
    }).then((r) => r.json());
    return res;
}

export async function get_players(player_name: string, limit: number): Promise<{
    count: number
    next?: any
    previous?: any
    results: Player[]
}> {
    let res = fetch(`${import.meta.env.VITE_BACKEND_ENDPOINT}/players/?search='${encodeURIComponent(player_name)}'&limit=${limit}`, {
        credentials: "include"
    }).then((r) => r.json());
    return res;
    //TODO: Change the call to this in the search tab to cache all results on two letters maybe?
}

export async function get_team(team: string) {
    let res = fetch(`${import.meta.env.VITE_BACKEND_ENDPOINT}/teams/?search='${encodeURIComponent(team)}'`, {
        credentials: "include"
    }).then((r) => r.json());
    return res;
}

export async function finalise_game() {
    let res = fetch(`${import.meta.env.VITE_BACKEND_ENDPOINT}/game/finalise/today`, {
        credentials: "include",
        method: "POST"
    }).then((r) => r.json());
    return res;
}

export async function refresh_state() {
    init_puzzle().then((game_state) => {
        _puzzle.set(game_state.puzzle);
        console.log(game_state);
        _finalised.set(game_state.status == 'finalised');
        game_state.guesses.forEach(g => {
            let selected_players = get(_selected_players);
            let idx = selected_players.findIndex(p => p.slot == g.slot);
            if ((idx == -1 || g.player != selected_players[idx].player) && g.correct) {
                get_player_stats(g.slot).then((stats: GuessStats) => {
                    let selected: SlotGuess = {
                        player: g.player,
                        slot: g.slot,
                        correct: g.correct,
                        guess: stats
                    }
                    _selected_players.update(o => {
                        let idx = o.findIndex(p => p.slot == g.slot);
                        if (idx == -1) {
                            o.push(selected);
                        } else {
                            o[idx] = selected;
                        }
                        return o;
                    })
                })
            }
        })
        _correct.set(game_state.guesses.reduce((acc, g) => g.correct ? acc + 1 : acc, 0));
        _lives.set(game_state.remaining_guesses);
        if (game_state.status != "finalised" && (game_state.remaining_guesses == 0 || game_state.guesses.reduce((acc, n) => acc + (n.correct ? 1 : 0), 0) == 9)) {
            finalise_game().then(r => {
                _finalised.set(true);
            })
        }
    })
    .catch(e => console.error(e));
}

export async function submit_guess(slot: number, player_key: string) {
    let guess_res = await fetch(`${import.meta.env.VITE_BACKEND_ENDPOINT}/game/guess/today`, {
        credentials: "include",
        method: "POST",
        body: JSON.stringify({
            x: slot % 3,
            y: Math.floor(slot / 3),
            player: player_key
        })
    })
    refresh_state();
    return guess_res.json();
}

export async function get_rule(key: string): Promise<Rule> {
    let rule_res = await fetch(`${import.meta.env.VITE_BACKEND_ENDPOINT}/rules/?search="${encodeURIComponent(key)}"`, { credentials: "include" }).then((r) => r.json());
    return rule_res[0] as Rule;
}


