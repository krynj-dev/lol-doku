<script lang="ts">
	import DokuSquare from '$lib/components/puzzle/DokuSquare.svelte';
	import Header from '$lib/components/Header.svelte';
	import PuzzleBuilder from '$lib/components/PuzzleBuilder.svelte';
	import { _puzzle, _lives, _correct, _selected_players, _players } from '../stores';
	import { onMount } from 'svelte';

	import _puzzle_list from '$lib/data/puzzles.json';
	import type { Puzzle } from '$lib/models/new/Puzzle';
	import type { Player } from '$lib/models/new/Player';
	import { refresh_state } from '$lib/shared/api';

	const puzzle_list = _puzzle_list as any[];
	const tabs = [
		"Home",
		"Puzzle Builder",
		"Endless"
	]

	let current_tab = "Home";

	let puzzle: Puzzle;
	_puzzle.subscribe((value) => {
		puzzle = value;
	});
	let players: Player[];
	_players.subscribe((value) => {
		players = value;
	});

	onMount(() => {
		refresh_state();
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
