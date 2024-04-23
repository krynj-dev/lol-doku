export interface Rule {
    key: string
    type: string
    valid_players: {
        Primary: Set<string>,
        Secondary: Set<string>
    }
    id: number
}