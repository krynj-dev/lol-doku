<script lang="ts">
	import { Category } from '$lib/categories.ts';
	import DokuSquare from '$lib/components/puzzle/DokuSquare.svelte';
	import Header from '$lib/components/Header.svelte';
	import playerList from '$lib/players.json';
	import { generate_puzzle } from '$lib/util/puzzle_util';
	import type { Team } from '$lib/models/Team';
	import type { Puzzle } from '$lib/models/Puzzle';

	// let p = generate_puzzle();
	// while (p == null) {
	//     console.log("invalid");
	//     p = generate_puzzle();
	// }
	// console.log(p);

	let puzzle: Puzzle;

	function gen_puz() {
		let candidate_puzzle = generate_puzzle();
		while (candidate_puzzle == null) {
			console.log('invalid');
			candidate_puzzle = generate_puzzle();
		}
		puzzle = candidate_puzzle;
	}
</script>

<Header />
<div class="content">
	{#if puzzle}
		<DokuSquare bind:puzzle />
	{/if}
	<button on:click={gen_puz}>Get Puzzle</button>
</div>

<style>
	.content {
		padding: 2rem 5rem;
	}
</style>
