import type { Puzzle } from '$lib/models/Puzzle';
import { readable, writable } from 'svelte/store';
import _puzzle_list from '$lib/data/puzzles.json';

export const _puzzle = writable<Puzzle>();
export const _lives = writable<number>(9);
export const _correct = writable<number>(0);
export const _selected_players = writable<(string | null)[]>([
	null,
	null,
	null,
	null,
	null,
	null,
	null,
	null,
	null
]);
