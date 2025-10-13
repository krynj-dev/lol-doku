<script lang="ts">
	import { getColumns, getRows, type Puzzle } from '$lib/models/new/Puzzle';
	import { type Rule } from '$lib/models/new/Rule';
	import {
		_puzzle,
		_correct,
		_lives,
		_selected_players,
		_finalised,
		_country_codes
	} from '../../../stores';
	import DokuTile from './DokuTile.svelte';
	import Modal from '../modal/Modal.svelte';
	import RuleTile from './RuleTile.svelte';
	import { calculate_unique_score } from '$lib/shared/util';

	let puzzle: Puzzle = $state();
	let rows = ($derived(puzzle ? puzzle.rules.filter(r => r.axis == 'x').sort((a, b) => a.index - b.index): []));
	let columns = ($derived(puzzle ? puzzle.rules.filter(r => r.axis == 'y').sort((a, b) => a.index - b.index): []));
	let lives: number = $state();
	let correct: number = $state();
	let modal_shown: boolean = false;
	let showModal: boolean = $state(false);
	let score: number = $state(900);

	_puzzle.subscribe((value) => {
		puzzle = value;
	});
	_lives.subscribe((value) => {
		lives = value;
	});
	_correct.subscribe((value) => {
		correct = value;
	});
	_finalised.subscribe((value) => {
		if (puzzle && value && !modal_shown) {
			showModal = true;
			modal_shown = true;
		}
	});
	_selected_players.subscribe((value) => (score = calculate_unique_score()));

</script>

<Modal bind:showModal>
	{#snippet title()}
		<h4 class="ending-modal-title" >Thank you for playing!</h4>
	{/snippet}
	<div class="ending-modal">
		<div class="ending-modal-row-2">
			<p>{`Correct guesses:`}</p>
			<p>{`${correct}`}</p>
		</div>
		<div class="ending-modal-row-2">
			<p>{`Uniqueness score:`}</p>
			<p>{`${score}`}</p>
		</div>
		<div class="ending-modal-row-1">
			<p>Click on the grid cells to view guess stats!</p>
		</div>
	</div>
</Modal>
{#if puzzle}
	<div class="doku-grid">
			{#each puzzle.rules.filter((c) => c.axis == 'x') as col (col.index)}
				<div class="info-tile" style="grid-area: x{col.index}">
				<RuleTile rule={col} />
				</div>
			{/each}
			{#each puzzle.rules.filter((r) => r.axis == 'y') as row (row.index)}
				<div class="info-tile" style="grid-area: y{row.index}">
					<RuleTile rule={row} />
				</div>
			{/each}
			{#each rows as row (row.index)}
				{#each columns as col (col.index)}
					<div class="answer-tile" style="grid-area: r{col.index}{row.index}">
						<DokuTile index={row.index * 3 + col.index} rule1={col} rule2={row}  />
					</div>
				{/each}
			{/each}
			<div class="info-tile" style="grid-area: s0">
				<div class="score-tile">
					<p>Uniqueness Rating: {score}</p>
				</div>
			</div>
			<div class="info-tile"  style="grid-area: s1">
				<div class="score-tile">
					<p>Correct Guesses: {correct}/9</p>
				</div>
			</div>
			<div class="info-tile"  style="grid-area: s2">
				<div class="score-tile">
					<p>Guesses Remaining: {lives}/10</p>
				</div>
			</div>
			<div class="answer-grid"></div>
	</div>
{:else}
	<div></div>
{/if}

<style>
	.doku-grid {
		width: 100%;
        aspect-ratio: 4 / 5;
		grid-template-columns: repeat(4, 25%);
		grid-template-rows: repeat(5, 20%);
        display: grid;
        grid-template-areas: 
			". x0 x1 x2"
			"y0 r00 r01 r02"
			"y1 r10 r11 r12"
			"y2 r20 r21 r22"
			". s0 s1 s2";
        box-sizing: border-box;
	}

	.doku-grid > * {
		padding: 3px;
	}
	
	.info-tile {
		width: 100%;
		aspect-ratio: 1 / 1;
		display: flex;
		justify-content: center;
		box-sizing: border-box;
	}

	.answer-grid {
		position: relative;
		z-index: -1;
		background: var(--lol-hextech-black);
		box-shadow: 0 0 0 6px var(--lol-gold-4);
		outline: 4px solid var(--lol-hextech-black);
		grid-area: 2 / 2 / span 3 / span 3;
		height: 100%;
		width: 100%;
		box-sizing: border-box;
	}

	@media only screen and (min-width: 841px) {
		.doku-grid {
			aspect-ratio: 5 / 4;
			grid-template-columns: repeat(5, 20%);
			grid-template-rows: repeat(4, 25%);
			grid-template-areas: 
				". x0 x1 x2 ."
				"y0 r00 r01 r02 s0"
				"y1 r10 r11 r12 s1"
				"y2 r20 r21 r22 s2";
			box-sizing: border-box;
		}

	}


	.score-tile {
		display: flex;
		justify-content: center;
		align-items: center;
		padding: 10px;
	}

	.score-tile p {
		text-align: center;
		font-size: 10pt;
	}

	.ending-modal {
		padding: 10px;
	}

	.ending-modal-title {
		text-align: center;
		margin: 1rem 0;
	}

	.ending-modal-row-2 {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}

	.ending-modal-row-1 {
		display: flex;
		align-items: center;
	}

	.ending-modal-row-1 > * {
		flex-grow: 1;
	}
</style>
