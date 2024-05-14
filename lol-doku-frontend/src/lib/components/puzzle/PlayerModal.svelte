<script lang="ts">
	import _playerList from '$lib/data/players.json';
	import type { Rule } from '$lib/models/Rule';
	import type { Player } from '$lib/models/new/Player';
	import type { SlotGuess } from '$lib/models/new/SlotGuess';
	import { submit_guess } from '$lib/shared/api';
	import { is_valid } from '$lib/shared/puzzle_util';
	import { _correct, _lives, _selected_players } from '../../../stores';

	export let showModal: Boolean; // boolean
	export let index: number;

	let playerList: Player[] = [];

	async function getPlayers(search_phrase: string) {
		if (!search_phrase || search_phrase.length < 2) {
			playerList = [];
			return;
		}
		let response_object = await fetch(`http://localhost:8000/players/?limit=50&search=${search_phrase}`, {credentials: "include"}).then((r) => r.json());
		let players_list = response_object.results;
		playerList = players_list;
		return;
	}

	let selectedPlayers: SlotGuess[];
	let lives: number;
	let selectedPlayer: SlotGuess;

	_lives.subscribe((value) => {
		lives = value;
	});
	_selected_players.subscribe((value) => {
		selectedPlayers = value;
		let player = selectedPlayers.find(sp => sp.slot == index);
		if (player) {
			selectedPlayer = player;
		}
	});

	let filter = '';

	$: {
		getPlayers(filter);
	}

	let dialog: HTMLDialogElement; // HTMLDialogElement

	$: if (dialog && showModal) dialog.showModal();

	function handleClose(player?: string) {
		if (player) {
			submit_guess(index, player).then(res => {
				if (!res.correct) {
					dialog.returnValue = "";
				}
			});
		}
		showModal = false;
	}

	function handlePlayerSelection(event: Event, clickedPlayer: string) {
		dialog.close(clickedPlayer);
	}
</script>

<!-- svelte-ignore a11y-click-events-have-key-events a11y-no-noninteractive-element-interactions -->
<dialog
	bind:this={dialog}
	on:close={(e) => {
		handleClose(
			e.currentTarget.returnValue &&
				(!selectedPlayer || (selectedPlayer && e.currentTarget.returnValue !== selectedPlayer.player))
				? playerList.map(p => p.display_name).find((p) => p == e.currentTarget.returnValue)
				: undefined
		)}}
	on:click|self={() => dialog.close()}
>
	<!-- svelte-ignore a11y-no-static-element-interactions -->
	<div on:click|stopPropagation class="player-modal-container">
		<slot name="header" />
		<!-- <span>{rules[0].key} | {rules[1].key}</span> -->
		<hr />
		<div>
			<slot />
			<input bind:value={filter} />
		</div>
		<hr />
		<div class="player-button-box">
			
			{#each playerList.sort((a, b) => a.display_name.toLowerCase().localeCompare(b.display_name.toLowerCase())) as plr}
				<button
					class={`player-modal-button`}
					on:click={(e) => handlePlayerSelection(e, plr.display_name)}
					disabled={lives <= 0 || selectedPlayers.find((p) => p.player === plr.display_name) != undefined}>{plr.display_name}</button
				>
			{/each}
		</div>
	</div>
</dialog>

<style>
	dialog {
		width: 400px;
		height: 600px;
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
	button {
		display: block;
	}
	.player-modal-button {
		width: 100%;
		margin-bottom: 2px;
		padding: 8px 8px;
		text-align: left;
		border-radius: 0;
		border: 0;
	}
	.player-modal-button:hover {
		background-color: beige;
	}
	.player-modal-debug-correct {
		background-color: lightgreen;
	}
	.player-modal-debug-correct:hover {
		background-color: greenyellow;
	}
	.player-button-box {
		overflow-y: auto;
		padding: 0 5px;
	}

	.player-modal-container {
		height: 94%;
		display: flex;
		flex-direction: column;
	}
</style>
