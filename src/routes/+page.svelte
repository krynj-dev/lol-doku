<script lang="ts">
	import DokuSquare from '$lib/components/puzzle/DokuSquare.svelte';
	import Header from '$lib/components/Header.svelte';
	import { generate_puzzle } from '$lib/util/puzzle_util';
	import { _puzzle, _lives, _correct, _selected_players } from '../stores';
	import { limit_region_count } from '$lib/util/puzzle_restrictions';

	function gen_puz() {
		_puzzle.set(
			generate_puzzle([
				// limit_region_count(
				// 	['Latin America', 'SEA', 'Brazil', 'CIS', 'Turkey', 'LMS', 'Vietnam', 'Oceania', 'PCS', 'Japan', 'MENA'],
				// 	2
				// ),
				// limit_region_count(
				// 	['Korea'],
				// 	3
				// ),
				// limit_region_count(
				// 	['China'],
				// 	3
				// ),
				// limit_region_count(
				// 	['North America'],
				// 	3
				// ),
				// limit_region_count(
				// 	['Europe', 'EMEA'],
				// 	43
				// )
			])
		);
		_lives.set(9);
		_correct.set(0);
		_selected_players.set([null, null, null, null, null, null, null, null, null]);
	}
</script>

<Header />
<div class="content">
	{#if _puzzle}
		<DokuSquare />
	{/if}
	<button on:click={gen_puz}>Get Puzzle</button>
</div>

<style>
	.content {
		padding: 2rem 5rem;
	}
</style>
