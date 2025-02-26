<script lang="ts">
	import _playerList from '$lib/data/players.json';
	import type { Player } from '$lib/models/new/Player';
	import type { Puzzle } from '$lib/models/new/Puzzle';
	import type { SlotGuess } from '$lib/models/new/SlotGuess';
	import { get_players, submit_guess } from '$lib/shared/api';
	import { get_player_image_src } from '$lib/shared/img';
	import { _correct, _lives, _puzzle, _selected_players } from '../../../stores';
	import Modal from './Modal.svelte';

	export let showModal: Boolean; // boolean
	export let index: number;
	export let loading: boolean = false;
	export let error_flashing: boolean = false;
	export let ref: HTMLElement | null = null;

	let playerList: Player[] = [];
	let player_image_srcs: any = {};

	let cached_filter = '';
	let cached_player_list: any[] = [];

	let selectedPlayers: SlotGuess[];
	let lives: number;
	let selectedPlayer: SlotGuess;
	let puzzle: Puzzle;

	_puzzle.subscribe((value) => (puzzle = value));

	_lives.subscribe((value) => {
		lives = value;
	});
	_selected_players.subscribe((value) => {
		selectedPlayers = value;
		let player = selectedPlayers.find((sp) => sp.slot == index);
		if (player) {
			selectedPlayer = player;
		}
	});

	let clean_name = (name: string): string | undefined => {
		let expr = /(.+)\s+\(.*\)/g;
		let name_only = expr.exec(name)?.[1];
		console.log("exr", expr.exec(name));
		return name_only ? name_only : name;
	}

	let process_name = (name: string): string | undefined => {
		let new_name = name.replace("&amp;nbsp;", "&nbsp;");
		return new_name;
	}

	let filter = '';

	$: {
		if (filter.length >= 2) {
			get_players(filter, 20).then((res) => {
				let results = res.results;
				playerList = results;
				results.forEach((player) => {
					get_player_image_src(player.display_name).then((res) => {
						if (res) {
							player_image_srcs[player.display_name] = res;
						}
					});
				});
			});
			// } else if (filter.length > 2) {
			// 	playerList = cached_player_list.filter((x: Player) => x.display_name.toLocaleLowerCase().includes(filter.toLocaleLowerCase())).slice(0, 12);
		} else {
			playerList = [];
		}
	}

	let dialog: HTMLDialogElement; // HTMLDialogElement

	$: if (dialog && showModal) dialog.showModal();

	let rulesFromIndex = (index: number) => {
		let x = index % 3;
		let y = Math.floor(index / 3);
		if (puzzle) {
			return [
				puzzle.rules.filter((r) => r.axis == 'x')[x],
				puzzle.rules.filter((r) => r.axis == 'y')[y]
			];
		}
		return [];
	};

	$: rules = rulesFromIndex(index);

	let handleModalClose = (event: Event & { currentTarget: EventTarget & HTMLDialogElement }) => {
		let player_string =
			event.currentTarget.returnValue &&
			(!selectedPlayer ||
				(selectedPlayer && event.currentTarget.returnValue !== selectedPlayer.player))
				? playerList.map((p) => p.display_name).find((p) => p == event.currentTarget.returnValue)
				: undefined;
		if (player_string) {
			loading = true;
			submit_guess(index, player_string).then((res) => {
				if (!res.correct) {
					dialog.returnValue = '';
					error_flashing = true;
					setTimeout(() => (error_flashing = false), 200);
				}
				loading = false;
			});
		}
		filter = '';
	};

	function handlePlayerSelection(event: Event, clickedPlayer: string) {
		dialog.close(clickedPlayer);
	}
</script>

<Modal bind:showModal bind:modalCloseCallback={handleModalClose} bind:dialog size="600">
	<div class="rule-cross-title" slot="title">
		{#if rules.length > 0}
			<h3>{rules[0].key} X {rules[1].key}</h3>
		{/if}
	</div>
	<hr />
	<div>
		<p class="input-label">Search Player:</p>
		<!-- svelte-ignore a11y-autofocus -->
		<input bind:value={filter} bind:this={ref} autofocus />
	</div>
	<hr />
	<div class="player-button-box">
		{#each playerList.sort((a, b) => a.display_name
				.toLowerCase()
				.localeCompare(b.display_name.toLowerCase())) as plr}
			<button
				class={`player-modal-button`}
				on:click={(e) => handlePlayerSelection(e, plr.display_name)}
				disabled={lives <= 0 ||
					selectedPlayers.find((p) => p.player === plr.display_name) != undefined}
			>
				<div class="player-modal-image-container">
					<img src={player_image_srcs[plr.display_name]} alt={plr.display_name} />
				</div>
				<div class="player-modal-name-container">
					<div class="player-modal-title-container">
						<p class="player-modal-title-dname">{clean_name(plr.display_name)}</p>
						<p class="player-modal-title-rname">{@html process_name(plr.real_name)}</p>
					</div>
					<div class="player-modal-subtitle">
						{#each plr.alternate_names.filter((x) => x != plr.display_name) as alt_name}
							<p class="player-modal-alt-name">{clean_name(alt_name)}</p>
						{/each}
					</div>
				</div>
			</button>
		{/each}
	</div>
</Modal>

<style>
	button {
		display: block;
	}
	.player-modal-button {
		width: 100%;
		height: 100px;
		padding: 10px 16px 10px 10px;
		text-align: left;
		border-radius: 0;
		border: 0;
		display: grid;
		grid-template-columns: 80px auto;
		background-color: #eeeeee;
	}
	.player-modal-button:not(:last-child) {
		margin-bottom: 2px;
	}
	.player-modal-button:hover {
		background-color: #dddddd;
	}

	.player-button-box {
		overflow-y: auto;
		padding: 0 10px;
		height: 500px;
	}

	.player-modal-image-container {
		width: 80px;
		height: 100%;
		display: flex;
		justify-content: center;
		overflow: hidden;
		box-sizing: border-box;
	}

	.player-modal-image-container img {
		height: 100%;
		width: auto;
		box-sizing: border-box;
		object-fit: cover;
		overflow: hidden;
	}

	.input-label {
		display: inline;
		margin: 0 10px;
	}

	p.player-modal-alt-name {
		color: #595959;
		margin: 0 0 4px 0;
		padding: 0px;
	}

	.player-modal-alt-name:not(:last-child) {
		margin-right: 10px;
	}

	p.player-modal-title-dname {
		margin: 5px 0;
		font-size: 1.1rem;
	}

	p.player-modal-title-rname {
		margin: 5px 0;
		font-size: 1.1rem;
		flex-grow: 1;
		color: #595959;
	}

	.player-modal-title-container {
		display: flex;
		gap: 10px;
	}

	.player-modal-subtitle {
		display: flex;
		flex-wrap: wrap;
		padding: 0;
	}

	.player-modal-name-container {
		padding-left: 20px;
		display: flex;
		flex-direction: column;
		justify-content: center;
		height: 100%;
	}

	.rule-cross-title > h3 {
		margin-bottom: 1rem;
	}
</style>
