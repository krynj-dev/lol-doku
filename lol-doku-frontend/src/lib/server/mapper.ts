import { Puzzle } from "$lib/models/new/Puzzle";
import { Rule } from "$lib/models/new/Rule";

export function mapRule(object: any): Rule {
    return {
        axis: object.axis,
        index: object.index,
        key: object.rules_rule.key,
        rule_type: object.rules_rule.rule_type
    } as Rule
}

export function mapPuzzle(object: any): Puzzle {
    return {
        date: object.date,
        rules: object.puzzles_puzzle.puzzles_puzzlerule.map((pr: any) => mapRule(pr)),
        id: object.puzzles_puzzle.id
    } as Puzzle
}

