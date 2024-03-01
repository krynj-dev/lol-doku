import type { Team } from './Team';

export interface Puzzle {
	columns: PuzzleRule[];
	rows: PuzzleRule[];
}

export interface PuzzleRule extends Team {
	id: number;
}
