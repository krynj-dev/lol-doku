import _player_data from '$lib/data/players.json'
import _team_data from '$lib/data/teams.json'
import type { Puzzle, PuzzleRule } from '$lib/models/Puzzle';
import { Team } from '$lib/models/Team.ts';

const players = _player_data as {
    [key: string]: string[]
};
const teams = _team_data["chains"] as Team[];

const min_overlap = import.meta.env.VITE_PUZZLE_MINIMUM_OVERLAP_COUNT;

export function generate_puzzle(): Puzzle | null {
    let columns: Team[] & { id: number }[] = [];
    let rows: Team[] & { id: number }[] = [];
    let _cand_rows: Team[] = [];
    let _cand_row_int: string[][] = [];
    let perfect_players: string[] = [];

    do {
        // Pick initial column
        if (columns.length > 0) {
            columns = [];
        }
        let t = teams[(Math.floor(Math.random() * teams.length))];
        columns.push(t);
        // Find compatible rows
        _cand_rows = [];
        // console.log("picked row ", columns[0].team_names[columns[0].team_names.length - 1]);
        teams.forEach(team => {
            let intersect = columns[0].players.filter(value => team.players.includes(value) && columns[0] != team);
            if (intersect.length >= min_overlap) {
                _cand_rows.push(team);
               _cand_row_int.push(intersect);
            }
        });
    } while (_cand_rows.length < 3);
    // Pick three rows
    while (rows.length < 3) {
        let i = (Math.floor(Math.random() * _cand_rows.length));
        let r = _cand_rows[i];
        if (!columns.includes(r) && !rows.includes(r)) {
            let pk = getPlayerListKey(_cand_row_int[i][0]);
            if (_cand_row_int[i].length == 1 && pk) {
                if (players[pk].some(p => perfect_players.includes(p))) {
                    return null;
                }
                players[pk].forEach((p) => perfect_players.push(p));
            }
            rows.push(r);
        }
    }
    // Pick the last two columns
    let _cand_cols: Team[] = [];
    teams.forEach(team => {
        let intersect = [];
        let works = true;
        for (let i = 0; i < rows.length; i++) {
            intersect = rows[i].players.filter(value => team.players.filter(p => !perfect_players.includes(p))
                .includes(value) && rows[i] != team && columns[0] != team);
            if (intersect.length < min_overlap) {
                works = false;
            }
            if (intersect.length == 1) {
                let pk = getPlayerListKey(intersect[0]);
                if (pk && players[pk].some(p => perfect_players.includes(p))) {
                    works = false;
                }
            }
        }
        if (works) _cand_cols.push(team);
    });
    if (_cand_cols.length < 2) {
        return null;
    }
    while (columns.length < 3) {
        let r = _cand_cols[(Math.floor(Math.random() * _cand_cols.length))];
        if (!columns.includes(r) && !rows.includes(r)) {
            columns.push(r);
        }
    }
    return {
        "columns": columns.map((t, i) => {
            return {
                ...t,
                'id': i
            }
        }),
        "rows": rows.map((t, i) => {
            return {
                ...t,
                'id': i
            }
        })
    };
}

export function zip(a1: any[], a2: any[]) {
    return a1.map((x, i) => [x, a2[i]]);
};

export function is_valid(rule_one: PuzzleRule, rule_two: PuzzleRule, player: string | undefined): number {
    if (player) {
        // Get player alt name list
        let player_key = getPlayerListKey(player);
        if (player_key) {
            // Test Rule 1
            let pass_rule_one = players[player_key].some(alias => rule_one.players.includes(alias));
            // Test Rule 2
            let pass_rule_two = players[player_key].some(alias => rule_two.players.includes(alias));
            if (pass_rule_one && pass_rule_two) {
                return 2;
            }
        }
        else {
            console.log("couldn't find player")
        }
        return 1;
    }
    return 0;
};

export function getPlayerListKey(player: string) {
    return Object.keys(players)
            .find((p: string) => players[p].map(s => s.toLocaleLowerCase()).includes(player.toLocaleLowerCase()));
}
