export class Team {
    'team_names': string[]
    'players': string[]
    'team_dates': string[]

    
}

export function getLatestTeamName(team: Team) {
    if (!team.team_names || team.team_names.length == 0) {
        return null;
    }
    return team.team_names[team.team_names.length-1];
}

export function getLatestTeamDate(team: Team) {
    if (!team.team_dates || team.team_dates.length == 0) {
        return null;
    }
    return team.team_dates[team.team_dates.length-1];
}
