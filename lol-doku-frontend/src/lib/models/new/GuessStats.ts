export interface PlayerGuessStat {
    player: string,
    guesses: number
}

export interface GuessStats {
    results: PlayerGuessStat[]
    total_guesses: number
    x: string
    y: string
}
