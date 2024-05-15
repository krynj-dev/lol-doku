import { type GuessStats } from "./GuessStats";

export interface SlotGuess {
    guess: GuessStats;
    correct: boolean;
    slot: number;
    player: string;
}