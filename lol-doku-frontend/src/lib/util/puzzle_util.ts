import _player_data from '$lib/data/players.json';
import _team_data from '$lib/data/teams.json';
import type { Player } from '$lib/models/Player';
import type { Rule } from '$lib/models/Rule';
import { Team } from '$lib/models/Team';

const players = _player_data as {
	[key: string]: Player;
};
const teams = _team_data as {
	[key: string]: Team;
};

export async function read_rule(key: string): Promise<Rule> {
	const first_char = key.toLocaleLowerCase().charAt(0);
	const response = await fetch(`../rules/rules_${first_char}.json`);
	const rules = await response.json();
	return rules[key] as Rule;
}

export async function read_rules(key: string): Promise<{ [key: string]: Rule }> {
	const first_char = key.toLocaleLowerCase().charAt(0);
	const response = await fetch(`../rules/rules_${first_char}.json`);
	const rules = await response.json();
	return rules as { [key: string]: Rule };
}

export function get_key_letters(): string[] {
	let letters: Set<string> = new Set();
	Object.keys(players).forEach(key => {
		letters.add(key.toLocaleUpperCase()[0]);
	})
	return [...letters];
}


export function zip(a1: any[], a2: any[]) {
	return a1.map((x, i) => [x, a2[i]]);
}

export function is_valid(
	rule_one: Rule,
	rule_two: Rule,
	player: string | null
): number {
	if (player) {
		// Get player alt name list
		let player_key = player;
		let pass_one = false;
		let pass_two = false;
		if (player_key && rule_one.valid_players.Primary && rule_two.valid_players.Primary) {
			for (const x of rule_one.valid_players.Primary) {
				if (x == player) {
					pass_one = true;
				}
			}
			for (const x of rule_two.valid_players.Primary) {
				if (x == player) {
					pass_two = true;
				}
			}
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
		players[p].alternate_names.map((s) => s.toLocaleLowerCase()).includes(player.toLocaleLowerCase())
	);
}
