import type { Puzzle } from '$lib/models/new/Puzzle';
import { readable, writable } from 'svelte/store';
import _puzzle_list from '$lib/data/puzzles.json';
import { type Player } from '$lib/models/new/Player';
import { type SlotGuess } from '$lib/models/new/SlotGuess';

export const _puzzle = writable<Puzzle>();
export const _lives = writable<number>(0);
export const _correct = writable<number>(0);
export const _selected_players = writable<SlotGuess[]>([
]);
export const _players = writable<Player[]>([]);
export const _finalised = writable<boolean>(false);
