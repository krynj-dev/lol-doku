import type { Puzzle } from '$lib/models/new/Puzzle';
import { writable } from 'svelte/store';
import { type Player } from '$lib/models/new/Player';
import { type SlotGuess } from '$lib/models/new/SlotGuess';
import { type FailResponse } from '$lib/models/FailResponse';

export const _puzzle = writable<Puzzle>();
export const _lives = writable<number>(0);
export const _correct = writable<number>(0);
export const _selected_players = writable<SlotGuess[]>([
]);
export const _players = writable<Player[]>([]);
export const _finalised = writable<boolean>(false);
export const _country_codes = writable<object>({});
export const _failed_load = writable<FailResponse|undefined>(undefined);
