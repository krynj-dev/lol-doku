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

	let puzzle: Puzzle;
	$: rows = (puzzle ? puzzle.rules.filter(r => r.axis == 'x').sort((a, b) => a.index - b.index): []);
	$: columns = (puzzle ? puzzle.rules.filter(r => r.axis == 'y').sort((a, b) => a.index - b.index): []);
	let lives: number;
	let correct: number;
	let modal_shown: boolean = false;
	let showModal: boolean = false;
	let score: number = 900;

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
	<h4 class="ending-modal-title" slot="title">Thank you for playing!</h4>
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
		<div class="column-span">
			{#each puzzle.rules.filter((c) => c.axis == 'x') as col (col.index)}
				<div class="info-tile">
				<RuleTile bind:rule={col} />
				</div>
			{/each}
		</div>
		<div class="row-span">
			{#each puzzle.rules.filter((r) => r.axis == 'y') as row (row.index)}
				<div class="info-tile">
					<RuleTile bind:rule={row} />
				</div>
			{/each}
		</div>
		<div class="select-tile-span lol-border">
			{#each rows as row (row.index)}
				{#each columns as col (col.index)}
					<DokuTile index={row.index * 3 + col.index} bind:rule1={col} bind:rule2={row} />
				{/each}
			{/each}
		</div>
		<div class="score-span">
			<div class="info-tile">
				<div class="score-tile">
					<p>Uniqueness Rating: {score}</p>
				</div>
			</div>
			<div class="info-tile">
				<div class="score-tile">
					<p>Correct Guesses: {correct}/9</p>
				</div>
			</div>
			<div class="info-tile">
				<div class="score-tile">
					<p>Guesses Remaining: {lives}/10</p>
				</div>
			</div>
		</div>
	</div>
{:else}
	<div></div>
{/if}

<style>
	.doku-grid {
		display: grid;
		margin: 0;
		grid-template-columns: repeat(4, calc((100vw - 10px) / 4));
		grid-template-rows: repeat(5, calc((100vw - 10px) / 4));
	}
	
	.info-tile {
		height: calc((100vw - 10px) / 4);
		width: calc((100vw - 10px) / 4);
		display: flex;
		justify-content: center;
	}

	.select-tile-span {
		grid-area: span 3 / span 3 / span 3 / span 3;
		display: grid;
		grid-template-columns: repeat(3, calc((100vw - 10px) / 4 - 5px));
		grid-template-rows: repeat(3, calc((100vw - 10px) / 4 - 5px));
		overflow: hidden;
		padding: 4px;
		gap: 2px;
		background-color: var(--lol-hextech-black);
	}

	.column-span {
		grid-column: 2 / span 3;
		display: flex;
		justify-content: space-around;
	}

	.row-span {
		grid-row: span 3;
		display: flex;
		flex-direction: column;
		justify-content: space-around;
		grid-column-start: 1;
	}

	.score-span {
		display: flex;
		flex-direction: row;
		justify-content: space-around;
		grid-row-start: 5;
		grid-column: 2 / span 3;
	}

	@media only screen and (min-width: 769px) {
		.doku-grid {
			grid-template-columns: repeat(5, 155px);
			grid-template-rows: repeat(4, 155px);
		}

		.info-tile {
			height: 150px;
			width: 150px;
		}

		.select-tile-span {
			grid-template-columns: repeat(3, 150px);
			grid-template-rows: repeat(3, 150px);
		}

		.score-span {
			grid-row: span 3;
			display: flex;
			flex-direction: column;
			justify-content: space-around;
			grid-column-start: 5;
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
