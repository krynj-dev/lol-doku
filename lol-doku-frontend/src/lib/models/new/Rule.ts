
export interface Rule {
    axis: "x" | "y"
    index: number
    url: string
    key: string
    rule_type: string
    valid_players: string[]
}
