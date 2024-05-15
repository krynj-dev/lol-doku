import { type GameState } from "$lib/models/new/GameState";
import { type GuessStats } from "$lib/models/new/GuessStats";
import { type Rule } from "$lib/models/new/Rule";
import { type SlotGuess } from "$lib/models/new/SlotGuess";
import { _finalised, _lives, _puzzle, _selected_players } from "../../stores";
import { get } from 'svelte/store'

export function decimal_number(num: number, places: number) {
    return (Math.round(num * 10**places) / 10**places).toFixed(places);
}

export function calculate_unique_score() {
    let sp: SlotGuess[] = get(_selected_players);
    let is_finalised = get(_finalised);
    let base_score = 900;
    sp.forEach(guess => {
        if (guess.correct) {
            let the_stat = guess.guess.results.find(r => r.player == guess.player);
            if (the_stat) {
                base_score -= Number(decimal_number((the_stat.guesses + (is_finalised ? 0 : 1)) * 100 / (guess.guess.total_guesses + (is_finalised ? 0 : 1)), 0));
            }
        }
    });
    return base_score;
}