import _player_data from '$lib/data/players.json'
import _team_data from '$lib/data/teams.json'
import { Team } from '$lib/models/Team.ts'

const players = _player_data;
const teams = _team_data["chains"] as Team[];

export function generate_puzzle() {
    let columns: Team[] & {id: number}[] = [];
    let rows: Team[] & {id: number}[] = [];
    let _cand_rows: Team[] = [];

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
            if (intersect.length > 2) {
                _cand_rows.push(team);
            }
        });
    } while (_cand_rows.length < 3);
    // Pick three rows
    while (rows.length < 3) {
        let r = _cand_rows[(Math.floor(Math.random() * _cand_rows.length))];
        if (!columns.includes(r) && !rows.includes(r)) {
            rows.push(r);
        }
    }
    // Pick the last two columns
    let _cand_cols: Team[] = [];
    teams.forEach(team => {
        let intersect = [];
        let works = true;
        for (let i = 0; i < rows.length; i++) {
            intersect = rows[i].players.filter(value => team.players.includes(value) && rows[i] != team && columns[0] != team);
            if (intersect.length < 2) {
                works = false;
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
        "cols": columns.map((t, i) => {
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
