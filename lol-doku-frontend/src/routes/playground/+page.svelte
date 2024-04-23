<script lang="ts">
	import DokuSquare from '$lib/components/puzzle/DokuSquare.svelte';
	import Header from '$lib/components/Header.svelte';
	import PuzzleBuilder from '$lib/components/PuzzleBuilder.svelte';
	import { onMount } from 'svelte';
	import DragNDrop from '$lib/components/dragndrop/DragNDrop.svelte';
	import DnDBucket from '$lib/components/dragndrop/DnDBucket.svelte';
	import DnDBucketItem from '$lib/components/dragndrop/DnDBucketItem.svelte';
	import { read_rule } from '$lib/util/puzzle_util';
	import type { Bucket } from '$lib/components/dragndrop/Bucket';

	const tabs = ['Home', 'Puzzle Builder'];

	let current_tab = 'Home';

	let tile_size = '200px';

	let player_grid: string[][][];
	[];

	let buckets: {
		[key: string]: Bucket
	} = {}

	function itemChangeCallback(items: any[], bucket_key: string) {
		let type = bucket_key.slice(0, 3);
		let loc = Number(bucket_key.slice(3)) - 1;
		if (items.length > 0 && player_grid) {
			read_rule(items[0].data.display_text).then((r) => {
				for (let i = 0; i < 3; i++) {
					if (type == 'row') {
						buckets[`col${i+1}`].items.subscribe(v => {
							if (v && v.length > 0) {
								read_rule(v[0].data.display_text).then(r2 => {
									player_grid[loc][i] = Array.from(r.valid_players.Primary.intersection(r2.valid_players.Primary));
								})
							} else {
								player_grid[loc][i] = Array.from(r.valid_players.Primary);
							}
						}) // do more here
					} else if (type == 'col') {
						buckets[`row${i+1}`].items.subscribe(v => {
							let set_a: Set<string> = new Set(r.valid_players.Primary);
							if (v && v.length > 0) {
								read_rule(v[0].data.display_text).then(r2 => {
									let set_b: Set<string> = new Set(r2.valid_players.Primary);
									player_grid[i][loc] = Array.from(set_a.intersection(set_b));
								})
							} else {
								player_grid[i][loc] = Array.from(set_a);
							}
						}) // do more here
					}
				}
			});
		} else if (items.length == 0 && player_grid) {
			for (let i = 0; i < 3; i++) {
					if (type == 'row') {
						buckets[`col${i+1}`].items.subscribe(v => {
							if (v && v.length > 0) {
								read_rule(v[0].data.display_text).then(r => {
									player_grid[loc][i] = Array.from(r.valid_players.Primary);
								})
							} else {
								player_grid[loc][i] = [];
							}
						})
					} else if (type == 'col') {
						buckets[`row${i+1}`].items.subscribe(v => {
							if (v && v.length > 0) {
								read_rule(v[0].data.display_text).then(r => {
									player_grid[i][loc] = Array.from(r.valid_players.Primary);
								})
							} else {
								player_grid[i][loc] = [];
							}
						})
					}
				}
		}
	}

	onMount(() => {
		player_grid = [
			[[], [], []],
			[[], [], []],
			[[], [], []]
		];
	});
</script>

<Header {tabs} bind:selected={current_tab} />
<div class="content">
	<DragNDrop class="dnd-container" bind:buckets>
		<div class="puzzle-builder-grid" style="--tile-size: {tile_size}">
			<div class="rule-tile"></div>
			<div class="column-span">
				<div class="rule-bucket">
					<DnDBucket
						bucket_key="col1"
						max_size={1}
						class="dnd-bucket"
						callback={itemChangeCallback}
					/>
				</div>
				<div class="rule-bucket">
					<DnDBucket
						bucket_key="col2"
						max_size={1}
						class="dnd-bucket"
						callback={itemChangeCallback}
					/>
				</div>
				<div class="rule-bucket">
					<DnDBucket
						bucket_key="col3"
						max_size={1}
						class="dnd-bucket"
						callback={itemChangeCallback}
					>
						<DnDBucketItem item_data={{ display_text: 'G2 Esports', class: 'rule-tile-item' }} />
					</DnDBucket>
				</div>
			</div>
			<div class="row-span">
				<div class="rule-bucket">
					<DnDBucket
						bucket_key="row1"
						max_size={1}
						class="dnd-bucket"
						callback={itemChangeCallback}
					>
						<DnDBucketItem item_data={{ display_text: 'Fnatic', class: 'rule-tile-item' }} />
					</DnDBucket>
				</div>
				<div class="rule-bucket">
					<DnDBucket
						bucket_key="row2"
						max_size={1}
						class="dnd-bucket"
						callback={itemChangeCallback}
					/>
				</div>
				<div class="rule-bucket">
					<DnDBucket
						bucket_key="row3"
						max_size={1}
						class="dnd-bucket"
						callback={itemChangeCallback}
					/>
				</div>
			</div>
			<div class="player-grid">
				{#if player_grid}
					{#each [0, 1, 2] as i}
						{#each [0, 1, 2] as j}
							<div class="player-tile">
								<ul>
									{#each player_grid[i][j] as plr}
										<li>{plr}</li>
									{/each}
								</ul>
							</div>
						{/each}
					{/each}
				{/if}
			</div>
		</div>
	</DragNDrop>
</div>

<style>
	.content {
		padding: 2rem 5rem;
	}

	:global(.dnd-container) {
		width: 100%;
		border: 1px solid black;
		padding: 10px;
		display: grid;
		grid-template-columns: repeat(2, auto);
		gap: 5px;
	}

	:global(.dnd-bucket) {
		border: 1px solid black;
		padding: 10px;
		display: flex;
		justify-content: center;
		align-items: center;
		width: calc(var(--tile-size) * 0.8);
		height: calc(var(--tile-size) * 0.8);
	}

	.rule-bucket {
		display: flex;
		justify-content: center;
		align-items: center;
	}

	:global(.rule-tile-item) {
		background-color: lightgray;
		cursor: pointer;
		display: inline-block;
		margin: 10px;
		padding: 10px;
		max-width: 100%;
		text-wrap: wrap;
		text-align: center;
	}
	:global(.rule-tile-item:hover) {
		background: orange;
		color: white;
	}

	.puzzle-builder-grid {
		display: grid;
		gap: 1px;
		margin: auto;
		width: calc(var(--tile-size) * 5);
		grid-template-columns: repeat(4, var(--tile-size));
		grid-template-rows: repeat(4, var(--tile-size));
	}

	.column-span {
		grid-column-end: span 3;
		display: grid;
		grid-template-columns: repeat(3, minmax(0px, 1fr));
		gap: 1px;
		overflow: hidden;
	}

	.row-span {
		grid-column-start: 1;
		grid-row-end: span 3;
		display: grid;
		grid-template-rows: repeat(3, minmax(0px, 1fr));
		gap: 2px;
		overflow: hidden;
	}

	.player-grid {
		display: grid;
		grid-area: span 3 / span 3 / span 3 / span 3;
		grid-template-columns: repeat(3, minmax(0px, 1fr));
		grid-template-rows: repeat(3, minmax(0px, 1fr));
		gap: 2px;
		border-radius: 15px;
		overflow: hidden;
	}

	.player-tile {
		display: flex;
		align-items: center;
		justify-content: center;
		overflow-y: hidden;
		background-color: gainsboro;
	}

	.player-tile > ul {
		overflow-y: scroll;
		overflow-x: hidden;
		height: 100%;
		width: 100%;
	}

	.player-tile span {
		padding: 1rem;
	}
</style>
