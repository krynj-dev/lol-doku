import { type Puzzle } from "./Puzzle"

export interface GameState {
    remaining_guesses: number,
    guesses: any[]
    puzzle: Puzzle
    status: "in_progress" | "finalised"
}