<script lang="ts">
	import DokuSquare from '$lib/components/puzzle/DokuSquare.svelte';
	import Header from '$lib/components/Header.svelte';
	import { _puzzle, _lives, _correct, _selected_players, _players, _finalised, _failed_load } from '../stores';
	import { onMount } from 'svelte';
	import { browser } from '$app/environment';

	import type { Puzzle } from '$lib/models/new/Puzzle';
	import type { Player } from '$lib/models/new/Player';
	import { finalise_game, refresh_state } from '$lib/shared/api';
	import Spinner from '$lib/components/spinner/Spinner.svelte';
	import type { FailResponse } from '$lib/models/FailResponse';
	import Footer from '$lib/components/Footer.svelte';

	const tabs = ['Home', 'Puzzle Builder', 'Endless'];

	let current_tab = 'Home';

	let failed_load: FailResponse | undefined;
	_failed_load.subscribe((value) => {
		failed_load = value;
	});
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
		console.log(`${import.meta.env.VITE_BACKEND_ENDPOINT}`)
	});
</script>

<Header {tabs} bind:selected={current_tab} />
<div class="content">
	{#if failed_load}
		<h2>Puzzle failed to load.</h2>
		<p>{failed_load.reason}</p>
	{:else if puzzle}
		<DokuSquare />
		<button class="giveup-button lol-border" on:click={() => {
			finalise_game().then(r => {
                _finalised.set(true);
            })
		}}>Give Up</button>
	{:else}
		<div class="spinner-container"><Spinner /></div>
		<p class="h2" style="text-align: center;">Loading puzzle. Please wait...</p>
	{/if}
</div>
<Footer />

<style>
	.content {
		width: 100vw;
		padding: 2rem 5px;
		display: flex;
		flex-direction: column;
		align-items: center;
		box-sizing: border-box;
		gap: 30px;
	}

	.giveup-button {
		padding: 10px 20px;
		background-color: var(--lol-hextech-black);
		color: var(--lol-gold-1);
		cursor: pointer;
		font-size: 1rem;
	}

	.giveup-button:hover {
		background-color: var(--lol-grey-cool);
	}
</style>
