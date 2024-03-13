import type { Puzzle } from '$lib/models/Puzzle';
import { writable } from 'svelte/store';

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
