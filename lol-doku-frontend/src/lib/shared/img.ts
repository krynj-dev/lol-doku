
export async function get_player_image_src(player_key: string) {
    let res = await fetch(`img/players/${player_key}.webp`);
    if (res.status == 200) return `img/players/${player_key}.webp`;
    return "img/players/missing_image.svg";
}
