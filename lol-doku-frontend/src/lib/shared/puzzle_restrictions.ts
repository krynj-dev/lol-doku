import type { PuzzleRule } from "$lib/models/Puzzle";

export function limit_region_count(regions: string[], limit: number): (a: PuzzleRule[], b: PuzzleRule[], candidate: PuzzleRule) => boolean {
    return (a: PuzzleRule[], b: PuzzleRule[], candidate: PuzzleRule): boolean => {
        let count = 0;
        a.forEach(r => {
            if (regions.some(reg => r.region == reg)) {
                count++;
            }
        })
        b.forEach(r => {
            if (regions.some(reg => r.region == reg)) {
                count++;
            }
        })
        if (regions.some(reg => candidate.region == reg)) {
            count++;
        }
        return count <= limit;
    }
}
