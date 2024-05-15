<script lang="ts">
	import DokuSquare from '$lib/components/puzzle/DokuSquare.svelte';
	import Header from '$lib/components/Header.svelte';
	import { _puzzle, _lives, _correct, _selected_players, _players } from '../stores';
	import { onMount } from 'svelte';

	import type { Puzzle } from '$lib/models/new/Puzzle';
	import type { Player } from '$lib/models/new/Player';
	import { refresh_state } from '$lib/shared/api';

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
	{#if _puzzle}
		<DokuSquare />
	{/if}
</div>

<style>
	.content {
		padding: 2rem 5rem;
	}
</style>
