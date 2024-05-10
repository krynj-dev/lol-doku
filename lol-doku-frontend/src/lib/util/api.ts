import { type GameState } from "$lib/models/new/GameState";
import { type GuessStats } from "$lib/models/new/GuessStats";
import { type Rule } from "$lib/models/new/Rule";
import { type SlotGuess } from "$lib/models/new/SlotGuess";
import { _finalised, _lives, _puzzle, _selected_players } from "../../stores";
import { get } from 'svelte/store'

async function init_puzzle(): Promise<GameState> {
    // Get Session
    let session_res = await fetch('http://localhost:8000/game/session', { credentials: "include" }).then((r) => r.json());
    // Get Game
    let game_res = await fetch('http://localhost:8000/game/today', { credentials: "include" }).then((r) => r.json());
    let game_state = game_res as GameState;
    return game_state;
}

async function get_player_stats(slot: number) {
    let res = fetch(`http://localhost:8000/stats/today`, {
        credentials: "include",
        method: "POST",
        body: JSON.stringify({
            x: slot % 3,
            y: Math.floor(slot / 3)
        })
    }).then((r) => r.json());
    return res;
}

async function finalise_game() {
    let res = fetch(`http://localhost:8000/game/finalise/today`, {
        credentials: "include",
        method: "POST"
    }).then((r) => r.json());
    return res;
}

export async function refresh_state() {
    init_puzzle().then((game_state) => {
        _puzzle.set(game_state.puzzle);
        _finalised.set(game_state.status == 'finalised');
        game_state.guesses.forEach(g => {
            let selected_players = get(_selected_players);
            let idx = selected_players.findIndex(p => p.slot == g.slot);
            if ((idx == -1 || g.player != selected_players[idx].player) && g.correct) {
                get_player_stats(g.slot).then((stats: GuessStats) => {
                    let selected: SlotGuess = {
                        player: g.player,
                        slot: g.slot,
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
        _lives.set(game_state.remaining_guesses);
        if (game_state.status != "finalised" && (game_state.remaining_guesses == 0 || game_state.guesses.reduce((acc, n) => acc + (n.correct ? 1 : 0), 0) == 9)) {
            finalise_game();
            _finalised.set(true);
        }
    });
}

export function submit_guess(slot: number, player_key: string) {
    fetch(`http://localhost:8000/game/guess/today`, {
        credentials: "include",
        method: "POST",
        body: JSON.stringify({
            x: slot % 3,
            y: Math.floor(slot / 3),
            player: player_key
        })
    }).then((r) => r.json())
        .then(r => {
            refresh_state();
        });
}

export async function get_rule(key: string): Promise<Rule> {
	let rule_res = await fetch(`http://localhost:8000/rules/?search="${key}"`, { credentials: "include" }).then((r) => r.json());
    return rule_res[0] as Rule;
}

export async function get_player_src(player_key: string) {
    let res = await fetch(`img/players/${player_key}.webp`);
    if (res.status == 200) return `img/players/${player_key}.webp`;
    return "";
}
