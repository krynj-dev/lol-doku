<script lang="ts">
	// import type { Player } from '$lib/models/Team';
	import _team_data from '$lib/data/teams.json';
	import type { PuzzleRule } from '$lib/models/Puzzle';
	import type { Team } from '$lib/models/Team';
	import { is_valid } from '$lib/util/puzzle_util';
	import { _lives, _correct, _selected_players } from '../../../stores';
	import PlayerModal from './PlayerModal.svelte';
	export let index: number;
	export let rule1: PuzzleRule;
	export let rule2: PuzzleRule;
	let lives: number;
	let correct: number;
	let selectedPlayers: (string | null)[];
	let selectedPlayer: string | null;

	_lives.subscribe((value) => {
		lives = value;
	});
	_correct.subscribe((value) => {
		correct = value;
	});
	_selected_players.subscribe((value) => {
		selectedPlayers = value;
		selectedPlayer = value[index];
	});

	const team_data = _team_data as {
		[key: string]: Team;
	};

	let stylish = $$props.style;

	let showModal = false;
	let validity: { [key: string]: string } = {
		neutral: 'white',
		invalid: '#d18a8a',
		valid: '#9cd18a'
	};

	$: valid = checkValid(selectedPlayer);
	$: tile_color = validity[valid];

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
		let validity = is_valid(rule1, rule2, player);
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
</script>

<div
	role="button"
	tabindex="0"
	on:click={toggleModal}
	on:keyup={toggleModal}
	style="--tile-color: {tile_color}; {stylish}"
>
	<PlayerModal bind:showModal bind:index rules={[rule1, rule2]}>
		<span data-index={index}>Select Player:</span>
	</PlayerModal>
	{selectedPlayer ? selectedPlayer : ''}
</div>

<style>
	div {
		background-color: var(--tile-color);
		display: flex;
		align-items: center;
		justify-content: center;
		text-align: center;
		max-height: 100%;
		overflow: hidden;
	}
	div:hover {
		background-color: gainsboro;
	}
</style>
