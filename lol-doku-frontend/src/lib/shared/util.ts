import { type GameState } from "$lib/models/new/GameState";
import { type GuessStats } from "$lib/models/new/GuessStats";
import { type Rule } from "$lib/models/new/Rule";
import { type SlotGuess } from "$lib/models/new/SlotGuess";
import { _finalised, _lives, _puzzle, _selected_players } from "../../stores";
import { get } from 'svelte/store'

export function decimal_number(num: number, places: number) {
    return (Math.round(num * 10**places) / 10**places).toFixed(places);
}


