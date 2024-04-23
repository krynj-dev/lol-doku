<script lang="ts">
	import DokuSquare from '$lib/components/puzzle/DokuSquare.svelte';
	import Header from '$lib/components/Header.svelte';
	import PuzzleBuilder from '$lib/components/PuzzleBuilder.svelte';
	import { read_rule } from '$lib/util/puzzle_util';
	import { _puzzle, _lives, _correct, _selected_players } from '../stores';
	import { limit_region_count } from '$lib/util/puzzle_restrictions';
	import type { Rule } from '$lib/models/Rule';
	import { onMount } from 'svelte';

	import _puzzle_list from '$lib/data/puzzles.json';
	import _team_list from '$lib/data/teams.json';
	import type { Puzzle } from '$lib/models/Puzzle';
	import type { Team } from '$lib/models/Team';

	const puzzle_list = _puzzle_list as any[];
	const team_list = _team_list as {
		[key: string]: Team;
	};
	const tabs = [
		"Home",
		"Puzzle Builder"
	]

	let current_tab = "Home";

	async function pick_puzzle(): Promise<Puzzle> {
		let filtered_puzzles = puzzle_list.filter(p => p.meta.difficulty > 150 && p.meta.difficulty < 300);
		let puzzle_from_file = filtered_puzzles[Math.floor(Math.random() * filtered_puzzles.length)];
		let puz = {
			meta: puzzle_from_file.meta,
			rows: [],
			columns: []
		} as Puzzle;
		let i = 0;
		for (const ele of puzzle_from_file.rows) {
			let r = await read_rule(ele);
			puz.rows.push({
				...r,
				id: i
			});
			i++;
		};
		i = 0;
		for (const ele of puzzle_from_file.columns) {
			let c = await read_rule(ele);
			puz.columns.push({
				...c,
				id: i
			});
			i++;
		};
		console.log(puz);
		return puz;
	}

	let puzzle: Puzzle;
	_puzzle.subscribe((value) => {
		puzzle = value;
	});

	onMount(() => {
		if (!puzzle) {
			pick_puzzle().then((puz) => {
				_puzzle.set(puz);
			});
		}
	});
</script>

<Header tabs={tabs} bind:selected={current_tab}/>
<div class="content">
	{#if current_tab == "Home"}
		{#if _puzzle}
			<DokuSquare />
		{/if}
	{:else if current_tab == "Puzzle Builder"}
		<PuzzleBuilder />
	{/if}
</div>

<style>
	.content {
		padding: 2rem 5rem;
	}
</style>
