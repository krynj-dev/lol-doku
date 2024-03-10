export class TeamPlayerMap {
    [key: string]: TeamPlayerMapTeamEntry;
}

class TeamPlayerMapTeamEntry {
    "Primary": PlayersByLevel;
    "Secondary": PlayersByLevel;
    "Showmatch": PlayersByLevel;
    "": PlayersByLevel;
}

class PlayersByLevel {
    "Top": string[];
    "Jungle": string[];
    "Mid": string[];
    "Bot": string[];
    "Support": string[];
}