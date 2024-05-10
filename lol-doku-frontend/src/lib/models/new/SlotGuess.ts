import { type GuessStats } from "./GuessStats";

export interface SlotGuess {
    guess: GuessStats
    slot: number;
    player: string;
}