<script lang="ts">
	import type { SlotGuess } from '$lib/models/new/SlotGuess';
	import { get_player_image_src } from '$lib/shared/img';
	import { _lives, _correct, _selected_players, _puzzle, _finalised } from '../../../stores';
	import StatModal from '../modal/StatModal.svelte';
	import Spinner from '../spinner/Spinner.svelte';
	import PlayerModal from '../modal/PlayerModal.svelte';
	export let index: number;
	let lives: number;
	let correct: number;
	let selectedPlayers: SlotGuess[] = [];
	let selectedPlayer: SlotGuess | undefined;
	let finalised: boolean;
	let loading: boolean = false;
	let error_flashing = false;
	let transitoning = false;

	$: {
		if (selectedPlayer) {
			get_player_image_src(selectedPlayer.player).then((p) => {
				image_src = p;
			});
		}
		image_src = '';
	}

	let image_src: string | undefined = '';

	_lives.subscribe((value) => {
		lives = value;
	});
	_correct.subscribe((value) => {
		correct = value;
	});
	_selected_players.subscribe((value) => {
		selectedPlayers = value;
		let new_selected = value.find((p) => p.slot == index);
		if (selectedPlayer != new_selected) selectedPlayer = new_selected;
	});
	_finalised.subscribe((value) => {
		finalised = value;
	});

	let stylish = $$props.style;

	let showModal = false;

	$: valid = selectedPlayer ? checkValid(selectedPlayer.player) : '';
	$: tile_color = 'white';
	$: rarity_class = selectedPlayer ? getRarityClassName() : '';

	$: {
		if (error_flashing) {
			setTimeout(() => {
				transitoning = true;
				setTimeout(() => (transitoning = false), 2000);
			}, 100);
		}
	}

	function toggleModal(e: Event) {
		if (
			!showModal &&
			((e instanceof KeyboardEvent && e.code === 'Space') || !(e instanceof KeyboardEvent)) &&
			valid !== 'valid'
		) {
			showModal = true;
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
		let player_stats = selectedPlayer.guess.results.find((g) => g.player == player_key);
		if (!player_stats) return undefined;

		return (
			Math.round(
				((player_stats.guesses + (finalised ? 0 : 1)) /
					(selectedPlayer.guess.total_guesses + (finalised ? 0 : 1))) *
					100 *
					10
			) / 10
		);
	}

	function isUniquePick() {
		if (!selectedPlayer) return undefined;
		let player_key = selectedPlayer.player;
		if (!player_key) return undefined;
		let player_stats = selectedPlayer.guess.results.find((g) => g.player == player_key);
		if (!player_stats) return undefined;
		return player_stats.guesses == 0 || (finalised && player_stats.guesses == 1);
	}

	function getRarityClassName(): string {
		let p = getPercentage();
		if (!p) return '';
		if (isUniquePick()) {
			return 'pick-unique';
		} else if (p < 5.0) {
			return 'pick-legendary';
		} else if (p < 10.0) {
			return 'pick-epic';
		} else if (p < 20.0) {
			return 'pick-rare';
		} else if (p < 30.0) {
			return 'pick-uncommon';
		}
		return 'pick-common';
	}
</script>

<div
	role="button"
	tabindex="0"
	on:click={toggleModal}
	on:keyup={toggleModal}
	style="--tile-color: {tile_color};"
	class={`doku-tile lol-border${error_flashing ? ' error-flash' : ''}${transitoning ? ' transition-2s' : ''} ${rarity_class}`}
>
	{#if !finalised}
		<PlayerModal bind:showModal bind:index bind:loading bind:error_flashing />
	{:else}
		<StatModal slot={Number(index)} bind:showModal />
	{/if}
	{#if loading}
		<div class="spinner-container"><Spinner /></div>
	{:else if selectedPlayer}
		<div class="img-container">
			<p class="text-overlay percentage">{getPercentage()}%</p>
			<img class="tile-img" src={image_src} alt={selectedPlayer.player} />
			<p class="text-overlay name">{selectedPlayer.player}</p>
		</div>
	{/if}
</div>

<style>
	.doku-tile {
		background-color: var(--lol-hextech-black);
		display: flex;
		align-items: center;
		justify-content: center;
		text-align: center;
		max-height: 100%;
		overflow: hidden;
		cursor: pointer;
	}
	.doku-tile:hover {
		background-color: var(--lol-grey-cool);
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

	.spinner-container {
		display: flex;
		height: 100%;
		position: relative;
		width: 100%;
		overflow: hidden;
		justify-content: center;
		padding: 30%;
	}

	.error-flash {
		background-color: #e45d5d;
		transition: all 0.15s;
	}

	.error-flash:hover {
		background-color: #e45d5d;
		transition: all 0.15s;
	}

	.transition-2s {
		transition: all 0.5s;
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
		font-size: 0.8rem;
	}

	.rainbow-text {
		background: linear-gradient(
			to right,
			#ef5350,
			#f48fb1,
			#7e57c2,
			#2196f3,
			#26c6da,
			#43a047,
			#eeff41,
			#f9a825,
			#ff5722
		);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
	}

	.pick-unique {
		background: linear-gradient(
			to bottom right,
			#ea2a27,
			#ea27d0,
			#8f27ea,
			#276fea,
			#26c6da,
			#43a047,
			#eeff41,
			#f9a825,
			#ea2a27
		);
	}

	.pick-legendary {
		background: linear-gradient(to bottom right, #ea2a27, var(--lol-hextech-black));
	}

	.pick-epic {
		background: linear-gradient(to bottom right, #ea27d0, var(--lol-hextech-black));
	}

	.pick-rare {
		background: linear-gradient(to bottom right, #8f27ea, var(--lol-hextech-black));
	}

	.pick-uncommon {
		background: linear-gradient(to bottom right, #276fea, var(--lol-hextech-black));
	}

	.pick-common {
		background: linear-gradient(to bottom right, #27ea37, var(--lol-hextech-black));
	}
</style>
