<script lang="ts">
	import DokuTile from './DokuTile.svelte';
	let tile_size = '150px';

	export let columns: { id: number; team: string }[];
	export let rows: { id: number; team: string }[];

    let lives = 9;
	let correct = 0;
	let selectedPlayers: string[] = [];
</script>

<div class="doku-grid" style="--tile-size: {tile_size}">
	<div class="info-tile"><img src="https://raw.githubusercontent.com/ribeirogab/scuttle-crab/master/examples/logo.png" alt="scuttle crab"/></div>
	{#each columns as col (col.id)}
		<div class="info-tile"><span>{col.team}</span></div>
	{/each}
	<div class="info-tile"><img src="https://static.wikia.nocookie.net/leagueoflegends/images/5/54/Rift_Herald_Render.png" alt="rift herald"/></div>
	<div class="info-tile"><span>{rows[0].team}</span></div>
	<div class="select-tile-span">
		{#each rows as row (row.id)}
			{#each columns as col (col.id)}
				<DokuTile index={row.id * 3 + col.id} rule1={col.team} rule2={row.team} bind:lives bind:correct bind:selectedPlayers/>
			{/each}
		{/each}
	</div>
	<div class="info-tile"><span>Uniqueness Rating: 900</span></div>
	<div class="info-tile"><span>{rows[1].team}</span></div>
	<div class="info-tile"><span>Correct Guesses: {correct}/9</span></div>
	<div class="info-tile"><span>{rows[2].team}</span></div>
	<div class="info-tile"><span>Guesses Remaining: {lives}/9</span></div>
</div>

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
		grid-template-rows: calc(var(--tile-size) * (2 / 3)) repeat(3, var(--tile-size));
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
        gap: 1px;
        border-radius: 15px;
        overflow: hidden;
	}
</style>
