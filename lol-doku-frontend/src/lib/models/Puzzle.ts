import { Rule } from './Rule';
import type { Team } from './Team';

export interface Puzzle {
	meta: {
		regions?: {
			[key: string]: number;
		},
		difficulty?: number;
	}
	columns: Rule[];
	rows: Rule[];
}

