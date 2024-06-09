import { _country_codes } from '../../stores';
import _team_image_data from '$lib/data/team_images.json';

let team_image_data = _team_image_data as {
    [key: string]: string;
};

let country_codes: object;

_country_codes.subscribe((v) => (country_codes = v));

export async function get_player_image_src(player_key: string) {
    let res = await fetch(`img/players/${player_key}.webp`);
    if (res.status == 200) return `img/players/${player_key}.webp`;
    return "img/players/missing_image.svg";
}

export async function get_rule_image_src(rule_key: string, rule_type: string) {
    // const rule: Rule = await read_rule(rule_key);
    switch (rule_type) {
        case 'team':
            if (Object.keys(team_image_data).includes(rule_key)) return team_image_data[rule_key];
            return `img/teams/Logo_square.webp`;
        case 'role':
            switch (rule_key) {
                case 'Mid':
                    return 'img/roles/middle.svg';
                case 'Bot':
                    return 'img/roles/bottom.svg';
                case 'Jungle':
                    return 'img/roles/jungle.svg';
                case 'Top':
                    return 'img/roles/top.svg';
                case 'Support':
                    return 'img/roles/support.svg';
                default:
                    return `img/champion/None.jpg`;
            }
        case 'teammate':
            let res = await fetch(`img/players/${rule_key}.webp`);
            if (res.status == 200) return `img/players/${rule_key}.webp`;
            return undefined;
        case 'champion':
            let split = rule_key.split(' ');
            let champ_key;
            if (split.length == 2) champ_key = split[0];
            else champ_key = split.slice(0, split.length - 1).join(' ');
            if (champ_key != 'Any')
                return `img/champion/${champ_key?.replace(' ', '').replace("'", '')}.png`;
            return `img/champion/None.jpg`;
        case 'finalist':
        case 'tournament':
            return `img/worlds.svg`;
        case 'country':
            if (country_codes) {
                for (const [k, v] of Object.entries(country_codes)) {
                    if (v == rule_key) {
                        return `img/country/${k.toLocaleLowerCase()}.svg`;
                    }
                }
            }
        default:
            return undefined;
    }
}