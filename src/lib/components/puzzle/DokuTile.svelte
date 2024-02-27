<script lang="ts">
	import type { Player } from '$lib/models/Player';
	import PlayerModal from './PlayerModal.svelte';
	export let index: number;
	export let rule1: string;
	export let rule2: string;
    export let lives: number;
	export let correct: number;
	export let selectedPlayers: string[];

	let stylish = $$props.style;

	let showModal = false;
	let selectedPlayer: Player | undefined;
    let validity: {[key: string]: string} = {
        'neutral': 'white',
        'invalid': '#d18a8a',
        'valid': '#9cd18a'
    }

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

	function checkValid(player: Player | undefined): string {
		if (player) {
			if (player.rules[rule1] && player.rules[rule2]) {
				correct += 1;
			
				return 'valid';
			}
			return 'invalid';
		}
        return 'neutral';
	}
</script>

<div
	role="button"
	tabindex="0"
	on:click={toggleModal}
	on:keyup={toggleModal}
	style="--tile-color: {tile_color}; {stylish}"
>
	<PlayerModal bind:showModal bind:selectedPlayer bind:lives bind:selectedPlayers>
		<span data-index={index}>Select Player:</span>
	</PlayerModal>
	{selectedPlayer ? selectedPlayer.name : ''}
</div>

<style>
	div {
		background-color: var(--tile-color);
        display: flex;
        align-items: center;
        justify-content: center;
	}
	div:hover {
		background-color: gainsboro;
	}
</style>
