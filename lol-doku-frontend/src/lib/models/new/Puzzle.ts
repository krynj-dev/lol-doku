import { type Rule } from './Rule';

export interface Puzzle {
	date: string
	url: string
	rules: Rule[]
}

export function getRows(puzzle: Puzzle) {
	if (!puzzle) {
		return [];
	}
	return puzzle.rules.filter(r => r.axis == 'y').sort((a, b) => a.index - b.index);
}

export function getColumns(puzzle: Puzzle) {
	if (!puzzle) {
		return [];
	}
	return puzzle.rules.filter(r => r.axis == 'x').sort((a, b) => a.index - b.index);
}
