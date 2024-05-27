import { type GameState } from "$lib/models/new/GameState";
import { type GuessStats } from "$lib/models/new/GuessStats";
import { type Rule } from "$lib/models/new/Rule";
import { type SlotGuess } from "$lib/models/new/SlotGuess";
import { _correct, _finalised, _lives, _puzzle, _selected_players } from "../../stores";
import { get } from 'svelte/store'
import { type Player } from "$lib/models/new/Player";
import type { PageData } from "./$types";

export async function get_player_stats(slot: number) {
    let res = fetch(`game/guess/stats`, {
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
    results: Player[]
}> {
    let res = fetch(`/player?search=${encodeURIComponent(player_name)}&limit=${limit}`, {
        credentials: "include"
    }).then((r) => r.json());
    return res;
}

export async function finalise_game() {
    let res = fetch(`game/finalise`, {
        credentials: "include",
        method: "POST"
    }).then((r) => r.json());
    return res;
}

export async function refresh_state(state: any) {
    _finalised.set(state.status == 'finalised');
    let cur_puz = get(_puzzle);
    console.log(cur_puz, state.puzzle)
    if (!cur_puz || cur_puz.id != state.puzzle.id) _puzzle.set(state.puzzle);
    _lives.set(state.remaining_guesses);
    getSelectedPlayers(state.guesses).then(gs => {
        gs.forEach(g => {
            _selected_players.update((o) => {
                let idx = o.findIndex((p) => p.slot == g.slot);
                if (idx == -1) {
                    o.push(g);
                } else if (o[idx].player != g.player) {
                    o[idx] = g;
                }
                return o;
            });
        })
    })
    let c = state.guesses.reduce((acc: number, g: any) => (g.correct ? acc + 1 : acc), 0);
    _correct.set(c);
    if (state.status != "finalised" && (state.remaining_guesses == 0 || state.guesses.reduce((acc: number, n: any) => acc + (n.correct ? 1 : 0), 0) == 9)) {
        finalise_game().then(r => {
            _finalised.set(true);
        })
    }
}

export async function submit_guess(slot: number, player_key: string) {
    let guess_res: any = await fetch(`game/guess`, {
        credentials: "include",
        method: "POST",
        body: JSON.stringify({
            x: slot % 3,
            y: Math.floor(slot / 3),
            player: player_key
        })
    })
    let guess_json = await guess_res.json();
    _lives.set(guess_json.remaining_guesses);
    fetch('game').then(res => res.json()).then(state => {
        refresh_state(state).then(() => {
            if (state.status != "finalised" && (state.remaining_guesses == 0 || state.guesses.reduce((acc: number, n: any) => acc + (n.correct ? 1 : 0), 0) == 9)) {
                finalise_game().then(r => {
                    _finalised.set(true);
                })
            }
        })
    })
    return guess_json;
}

export async function getSelectedPlayers(guesses: any[]) {
    let selected_players: any[] = [];
    let correct_guesses = guesses.filter(g => g.correct);
    for (let i = 0; i < correct_guesses.length; i++) {
        let g = correct_guesses[i];
        let idx = selected_players.findIndex((p) => p.slot == g.slot);
        if ((idx == -1 || g.player != selected_players[idx].player) && g.correct) {
            let stats = await get_player_stats(g.slot);
            let selected: SlotGuess = {
                player: g.player,
                slot: g.slot,
                correct: g.correct,
                guess: stats
            };
            selected_players.push(selected);
        }
    };
    return selected_players;
}
