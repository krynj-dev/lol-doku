<script lang="ts">
	import type { Rule } from '$lib/models/new/Rule';
	import type { SlotGuess } from '$lib/models/new/SlotGuess';
	import { get_rule } from '$lib/shared/api';
	import { get_player_image_src } from '$lib/shared/img';
	import { _lives, _correct, _selected_players, _puzzle, _finalised } from '../../../stores';
	import StatModal from '../modal/StatModal.svelte';
	import Spinner from '../spinner/Spinner.svelte';
	import PlayerModal from './PlayerModal.svelte';
	export let index: number;
	export let rule1: Rule;
	export let rule2: Rule;
	let lives: number;
	let correct: number;
	let selectedPlayers: SlotGuess[] = [];
	let selectedPlayer: SlotGuess | undefined;
	let finalised: boolean;
	let loading: boolean = false;

	$: {
		if (selectedPlayer) {
			get_player_image_src(selectedPlayer.player).then((p) => {
				image_src = p;
			});
		}
		image_src = "";
	}

	let image_src: string | undefined = "";

	_lives.subscribe((value) => {
		lives = value;
	});
	_correct.subscribe((value) => {
		correct = value;
	});
	_selected_players.subscribe((value) => {
		selectedPlayers = value;
		let new_selected = value.find(p => p.slot == index);
		if (selectedPlayer != new_selected) selectedPlayer = new_selected;
	});
	_finalised.subscribe((value) => {
		finalised = value;
	})

	let stylish = $$props.style;

	let showModal = false;

	$: valid = (selectedPlayer ? checkValid(selectedPlayer.player) : '');
	$: tile_color = 'white';

	function toggleModal(e: Event) {
		if (
			!showModal &&
			((e instanceof KeyboardEvent && e.code === 'Space') || !(e instanceof KeyboardEvent)) &&
			valid !== 'valid'
		) {
			showModal = true;
			get_rule(rule1.key).then((r1) => {
				get_rule(rule2.key).then((r2) => {
					const a_set: Set<string> = new Set(r1.valid_players);
					const b_set: Set<string> = new Set(r2.valid_players);
					console.log(a_set.intersection(b_set));
				});
			});
		}
	}

	function checkValid(player: string | null): string {
		// let validity = is_valid(rule1, rule2, player);
		let validity = 0;
		switch (validity) {
			case 2:
				return 'valid';
			case 1:
				return 'invalid';
			case 0:
				return 'neutral';
			default:
				break;
		}
		return '';
	}

	function getPercentage() {
		if (!selectedPlayer) return undefined;
		let player_key = selectedPlayer.player;
		if (!player_key) return undefined;
		let player_stats = selectedPlayer.guess.results.find(g => g.player == player_key);
		if (!player_stats) return undefined;

		return Math.round((player_stats.guesses + (finalised ? 0 : 1)) / (selectedPlayer.guess.total_guesses + (finalised ? 0 : 1)) * 100 * 10) / 10;
	}

	function isUniquePick() {
		if (!selectedPlayer) return undefined;
		let player_key = selectedPlayer.player;
		if (!player_key) return undefined;
		let player_stats = selectedPlayer.guess.results.find(g => g.player == player_key);
		if (!player_stats) return undefined;
		return player_stats.guesses == 0 || finalised && player_stats.guesses == 1;
	}
</script>

<div
	role="button"
	tabindex="0"
	on:click={toggleModal}
	on:keyup={toggleModal}
	style="--tile-color: {tile_color}; {stylish}"
	class="doku-tile"
>
	{#if !finalised}
		<PlayerModal bind:showModal bind:index bind:loading>
			<span data-index={index}>Select Player:</span>
		</PlayerModal>
	{:else}
		<StatModal slot={Number(index)} bind:showModal />
	{/if}
	<div class="img-container">
		{#if loading}
			<Spinner size={64}/>
		{:else if selectedPlayer}
			<p class="text-overlay percentage">{getPercentage()}%</p>
			<img class="tile-img" src={image_src} alt={selectedPlayer.player} />
			<p class="text-overlay name"><span class="{isUniquePick() ? "rainbow-text" : ""}">{selectedPlayer.player}</span></p>
		{/if}
	</div>
</div>

<style>
	.doku-tile {
		background-color: var(--tile-color);
		display: flex;
		align-items: center;
		justify-content: center;
		text-align: center;
		max-height: 100%;
		overflow: hidden;
		cursor: pointer;
	}
	.doku-tile:hover {
		background-color: gainsboro;
	}

	.tile-img {
		height: 100%;
	}

	.img-container {
		display: flex;
		height: 100%;
		position: relative;
		width: 100%;
		overflow: hidden;
		justify-content: center;
	}

	.percentage {
		right: 0;
		top: 0;
	}

	.name {
		width: 100%;
		bottom: 0;
	}

	.text-overlay {
		position: absolute;
		margin: 0;
		padding: 3px;
		background-color: rgba(0, 0, 0, 0.8);
		color: white;
		font-size: 12px;
	}

	.rainbow-text {
		background: linear-gradient(to right, #ef5350, #f48fb1, #7e57c2, #2196f3, #26c6da, #43a047, #eeff41, #f9a825, #ff5722);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
	}
</style>
