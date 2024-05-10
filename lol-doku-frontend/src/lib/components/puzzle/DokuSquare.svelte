<script lang="ts">
	import { getColumns, getRows, type Puzzle } from '$lib/models/new/Puzzle';
	import { type Rule } from '$lib/models/new/Rule';
	import { _puzzle, _correct, _lives, _selected_players, _finalised } from '../../../stores';
	import DokuTile from './DokuTile.svelte';
	import Modal from './Modal.svelte';
	import RuleTile from './RuleTile.svelte';
	let tile_size = '150px';

	let puzzle: Puzzle;
	let rows: Rule[];
	let columns: Rule[];
	let lives: number;
	let correct: number;
	let modal_shown: boolean = false;
	let showModal: boolean = false;

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
</script>

<Modal bind:showModal>
	<p>Thank you for playing</p>
	<p>You're the GOAT fr fr</p>
</Modal>
{#if puzzle}
	<div class="doku-grid" style="--tile-size: {tile_size}">
		<div class="info-tile">
			<img
				src="https://raw.githubusercontent.com/ribeirogab/scuttle-crab/master/examples/logo.png"
				alt="scuttle crab"
			/>
		</div>
		{#each puzzle.rules.filter((r) => r.axis == 'x') as col (col.index)}
			<div class="info-tile">
				<RuleTile rule={col.key} type={col.rule_type} />
			</div>
		{/each}
		<div class="info-tile">
			<img
				src="https://static.wikia.nocookie.net/leagueoflegends/images/5/54/Rift_Herald_Render.png"
				alt="rift herald"
			/>
		</div>
		<div class="info-tile">
			<RuleTile bind:rule={rows[0].key} bind:type={rows[0].rule_type} />
		</div>
		<div class="select-tile-span">
			{#each rows as row (row.index)}
				{#each columns as col (col.index)}
					<DokuTile index={row.index * 3 + col.index} bind:rule1={col} bind:rule2={row} />
				{/each}
			{/each}
		</div>
		<div class="info-tile"><span>Uniqueness Rating: 900</span></div>
		<div class="info-tile">
			<RuleTile bind:rule={rows[1].key} bind:type={rows[1].rule_type} />
		</div>
		<div class="info-tile"><span>Correct Guesses: {correct}/9</span></div>
		<div class="info-tile">
			<RuleTile bind:rule={rows[2].key} bind:type={rows[2].rule_type} />
		</div>
		<div class="info-tile"><span>Guesses Remaining: {lives}/9</span></div>
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
		grid-template-columns: repeat(5, var(--tile-size));
		grid-template-rows: repeat(5, var(--tile-size));
	}

	.info-tile {
		display: flex;
		align-items: center;
		justify-content: center;
	}

	.info-tile img {
		max-width: 100%;
		max-height: 100%;
	}

	.info-tile span {
		padding: 1rem;
	}

	.select-tile-span {
		grid-area: span 3 / span 3 / span 3 / span 3;
		display: grid;
		grid-template-columns: repeat(3, minmax(0px, 1fr));
		grid-template-rows: repeat(3, minmax(0px, 1fr));
		gap: 1px;
		border-radius: 15px;
		overflow: hidden;
	}

	dialog {
		width: 400px;
		border-radius: 0.2em;
		border: none;
		padding: 0;
	}
	dialog::backdrop {
		background: rgba(0, 0, 0, 0.3);
	}
	dialog > div {
		padding: 1em;
	}
	dialog[open] {
		animation: zoom 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
	}
	@keyframes zoom {
		from {
			transform: scale(0.95);
		}
		to {
			transform: scale(1);
		}
	}
	dialog[open]::backdrop {
		animation: fade 0.2s ease-out;
	}
	@keyframes fade {
		from {
			opacity: 0;
		}
		to {
			opacity: 1;
		}
	}
</style>
