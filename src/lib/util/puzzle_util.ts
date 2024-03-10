import _player_data from '$lib/data/players.json';
import _team_data from '$lib/data/teams.json';
import _team_player_map from '$lib/data/tpm.json';
import type { Puzzle, PuzzleRule } from '$lib/models/Puzzle';
import { Team } from '$lib/models/Team.ts';
import type { TeamPlayerMap } from '$lib/models/TeamPlayerMap';

const players = _player_data as {
	[key: string]: string[];
};
const teams = _team_data as {
	[key: string]: Team;
};
const tpm = _team_player_map as TeamPlayerMap;

const min_overlap = import.meta.env.VITE_PUZZLE_MINIMUM_OVERLAP_COUNT;
const min_level = "Primary";

export function generate_puzzle(): Puzzle | null {
	let columns: PuzzleRule[] = [];
	let rows: PuzzleRule[] = [];
	let _cand_rows: Team[] = [];
	let _cand_row_int: string[][] = [];
	let perfect_players = new Set<string>();

	let removed_columns: string[] = [];
	let removed_rows: string[] = [];

	let cr_flag = true;
	while (columns.length < 3 || rows.length < 3) {
		let added: PuzzleRule | undefined;
		if ((cr_flag && columns.length < 3) || rows.length == 3) {
			added = selectRule(columns, rows, perfect_players);
			if (added && !removed_columns.find(e => e == added.op)) {
				columns.push(added);
				cr_flag = !cr_flag;
				removed_columns = [];
			}
			else {
				removed_rows.push(rows.pop().op);
				cr_flag = !cr_flag;
			}
		}
		else if ((!cr_flag && rows.length < 3) || columns.length == 3) {
			added = selectRule(rows, columns, perfect_players);
			if (added && !removed_rows.find(e => e == added.op)) {
				rows.push(added);
				cr_flag = !cr_flag;
				removed_rows = [];
			}
			else {
				removed_columns.push(columns.pop().op);
				cr_flag = !cr_flag;
			}
		}
		// console.log(columns, rows);
		// console.log(columns.length, rows.length)
	}
	console.log("Puzzle loop complete");
	// console.log(columns, rows);
	// DEBUG LOG AVAILABLE PLAYERS
	for(let i = 0; i < 3; i++) {
		for (let j = 0; j < 3; j++) {
			let r_players = new Set();
			let c_players = new Set();
			rows[i].other_names.forEach((n: string) => {
				if (tpm[n.toLocaleLowerCase()] && tpm[n.toLocaleLowerCase()]["Primary"]) {
					for (const [role, players] of Object.entries(tpm[n.toLocaleLowerCase()]["Primary"])) {
						players.forEach((p: string) => {
							r_players.add(p);
						});
					}
				}
			})
			columns[j].other_names.forEach((n: string) => {
				if (tpm[n.toLocaleLowerCase()] && tpm[n.toLocaleLowerCase()]["Primary"]) {
					for (const [role, players] of Object.entries(tpm[n.toLocaleLowerCase()]["Primary"])) {
						players.forEach((p: string) => {
							c_players.add(p);
						});
					}
				}
			})
			console.log(rows[i].op, columns[j].op, r_players.intersection(c_players));
		}
	}

	return {
		columns: columns.map((t, i) => {
			return {
				...t,
				id: i
			};
		}),
		rows: rows.map((t, i) => {
			return {
				...t,
				id: i
			};
		})
	};
}

export function zip(a1: any[], a2: any[]) {
	return a1.map((x, i) => [x, a2[i]]);
}

export function is_valid(
	rule_one: PuzzleRule,
	rule_two: PuzzleRule,
	player: string | undefined
): number {
	if (player) {
		// Get player alt name list
		let player_key = player;
		if (player_key) {
			let pass_one = false;
			let pass_two = false;
			rule_one.other_names.forEach((n: string) => {
				if (tpm[n.toLocaleLowerCase()] && tpm[n.toLocaleLowerCase()]["Primary"]) {
					for (const [role, players] of Object.entries(tpm[n.toLocaleLowerCase()]["Primary"])) {
						players.forEach((p: string) => {
							if (p == player_key) pass_one = true;
						});
					}
				}
			})
			rule_two.other_names.forEach((n: string) => {
				if (tpm[n.toLocaleLowerCase()] && tpm[n.toLocaleLowerCase()]["Primary"]) {
					for (const [role, players] of Object.entries(tpm[n.toLocaleLowerCase()]["Primary"])) {
						players.forEach((p: string) => {
							if (p == player_key) pass_two = true;
						});
					}
				}
			})
			if (pass_one && pass_two) {
				return 2;
			}
		} else {
			console.log("couldn't find player");
		}
		return 1;
	}
	return 0;
}

export function getPlayerListKey(player: string) {
	return Object.keys(players).find((p: string) =>
		players[p].map((s) => s.toLocaleLowerCase()).includes(player.toLocaleLowerCase())
	);
}

/*
	Selects and adds a rule to a if it has valid answers for all in 3
*/
function selectRule(a: PuzzleRule[], b: PuzzleRule[], not_allowed: Set<string>) {
	let team_to_add: PuzzleRule;
	let team_keys = Object.keys(teams);
	let tried = new Set();
	let succeeded = false;
	do {
		team_to_add = teams[team_keys[(Math.floor(Math.random() * team_keys.length))]] as PuzzleRule;
		// check if already picked
		if (a.find(e => team_to_add.op == e.op) || b.find(e => team_to_add.op == e.op) || team_to_add.highest_level != "Primary") {
			tried.add(team_to_add.op);
			continue;
		}
		// Find players in tta
		let team_name_lc = team_to_add.op.toLocaleLowerCase();
		let tta_players = new Set<string>();
		if (tpm[team_name_lc] && tpm[team_name_lc]["Primary"]) {
			for (const [role, players] of Object.entries(tpm[team_name_lc]["Primary"])) {
				players.forEach((p: string) => {
					tta_players.add(p)
				});
			}
		}
		if (tta_players.size === 0) {
			tried.add(team_to_add.op);
			continue;
		}
		// check against all in b to see if looks good
		let passes_others = true;
		b.forEach((e: Team) => {
			let e_plrs = new Set();
			e.other_names.forEach((n: string) => {
				if (tpm[n.toLocaleLowerCase()] && tpm[n.toLocaleLowerCase()]["Primary"]) {
					for (const [role, players] of Object.entries(tpm[n.toLocaleLowerCase()]["Primary"])) {
						players.forEach((p: string) => {
							e_plrs.add(p)
						});
					}
				}
			})
			let answer_plrs: Set<string> = tta_players.intersection(e_plrs).difference(not_allowed);

			if (answer_plrs.size === 0) {
				passes_others = false;
			}
			else if (answer_plrs.size === 1) {
				// console.log("Adding perfect player", answer_plrs);
				answer_plrs.forEach(e => not_allowed.add(e));
			}
			else {
				// console.log("Common players for", team_to_add.op, "and", e.op, answer_plrs);
			}
		});
		if (!passes_others) {
			tried.add(team_to_add.op);
			continue;
		}
		succeeded = true;
	} while (!succeeded && tried.size < team_keys.length)
	if (succeeded) {
		return team_to_add;
	}
	else {
		// console.log("Exhausted all teams?")
		return undefined;
	}
}