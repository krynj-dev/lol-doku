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
	import { onMount } from 'svelte';
	let tile_size = '150px';

	let puzzle: Puzzle;
	let rows: Rule[];
	let columns: Rule[];
	let lives: number;
	let correct: number;
	let modal_shown: boolean = false;
	let showModal: boolean = false;
	let score: number = 900;

	_puzzle.subscribe((value) => {
		puzzle = value;
		rows = getRows(value);
		columns = getColumns(value);
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
	<div class="ending-modal">
		<h4 class="ending-modal-title">Thank you for playing!</h4>
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
	<div class="doku-grid" style="--tile-size: {tile_size}">
		<div class="info-tile"></div>
		{#each puzzle.rules.filter((r) => r.axis == 'x') as col (col.index)}
			<div class="info-tile">
				<RuleTile rule={col.key} type={col.rule_type} size={tile_size} />
			</div>
		{/each}
		<div class="info-tile"></div>
		<div class="info-tile">
			<RuleTile bind:rule={rows[0].key} bind:type={rows[0].rule_type} size={tile_size} />
		</div>
		<div class="select-tile-span lol-border">
			{#each rows as row (row.index)}
				{#each columns as col (col.index)}
					<DokuTile index={row.index * 3 + col.index} bind:rule1={col} bind:rule2={row} />
				{/each}
			{/each}
		</div>
		<div class="info-tile">
			<div class="score-tile">
				<p>Uniqueness Rating: {score}</p>
			</div>
		</div>
		<div class="info-tile">
			<RuleTile bind:rule={rows[1].key} bind:type={rows[1].rule_type} size={tile_size} />
		</div>
		<div class="info-tile">
			<div class="score-tile">
				<p>Correct Guesses: {correct}/9</p>
			</div>
		</div>
		<div class="info-tile">
			<RuleTile bind:rule={rows[2].key} bind:type={rows[2].rule_type} size={tile_size} />
		</div>
		<div class="info-tile">
			<div class="score-tile">
				<p>Guesses Remaining: {lives}/10</p>
			</div>
		</div>
	</div>
{:else}
	<div></div>
{/if}

<style>
	.doku-grid {
		display: grid;
		gap: 1px;
		margin: auto;
		/* grid-template-columns: calc(var(--tile-size) / 2) var(--tile-size) var(--tile-size) var(
				--tile-size
			);
		grid-template-rows: calc(var(--tile-size) / 2) var(--tile-size) var(--tile-size) var(
				--tile-size
			); */
		width: calc(var(--tile-size) * 5);
		/* grid-template-areas:
			'corner col-0 col-1 col-2'
			'row-0 tile-0 tile-1 tile-2'
			'row-1 tile-3 tile-4 tile-5'
			'row-2 tile-6 tile-7 tile-8'; */
		grid-template-columns: repeat(5, calc(5px + var(--tile-size)));
		grid-template-rows: repeat(5, calc(5px + var(--tile-size)));
	}

	.info-tile {
		height: var(--tile-size);
		width: var(--tile-size);
		display: flex;
	}

	.score-tile {
		display: flex;
		justify-content: center;
		align-items: center;
		padding: 10px;
	}

	.score-tile p {
		text-align: center;
		font-size: 14px;
	}

	.select-tile-span {
		grid-area: span 3 / span 3 / span 3 / span 3;
		display: grid;
		grid-template-columns: repeat(3, var(--tile-size));
		grid-template-rows: repeat(3, var(--tile-size));
		overflow: hidden;
		padding: 4px;
		gap: 2px;
		background-color: var(--lol-hextech-black);
	}

	.ending-modal {
		padding: 10px;
	}

	.ending-modal-title {
		text-align: center;
		margin-top: 0;
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
