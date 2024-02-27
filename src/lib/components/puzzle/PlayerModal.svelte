<script lang="ts">
	import _playerList from '$lib/players.json';
	import type { Player } from '$lib/models/Player';

	export let showModal: Boolean; // boolean
	export let selectedPlayer: Player | undefined;
	export let selectedPlayers: string[];
	export let lives: number;
	let playerList = _playerList as Player[];

	let dialog: HTMLDialogElement; // HTMLDialogElement

	$: if (dialog && showModal) dialog.showModal();

	function handleClose(player?: Player) {
		if (player) {
			if (selectedPlayer) {
				let curPlr = selectedPlayer;
				let itemIdx = selectedPlayers.findIndex(x => x === curPlr.name);
				selectedPlayers.splice(itemIdx, 1);
				selectedPlayers = [...selectedPlayers];
			}
			selectedPlayer = player;
			selectedPlayers = [...selectedPlayers, player.name];
			lives -= 1;
		}
		showModal = false;
	}
</script>

<!-- svelte-ignore a11y-click-events-have-key-events a11y-no-noninteractive-element-interactions -->
<dialog
	bind:this={dialog}
	on:close={(e) =>
		handleClose(
			e.currentTarget.returnValue &&
				(!selectedPlayer || (selectedPlayer && e.currentTarget.returnValue !== selectedPlayer.name))
				? playerList.find((p) => p.name == e.currentTarget.returnValue)
				: undefined
		)}
	on:click|self={() => dialog.close()}
>
	<!-- svelte-ignore a11y-no-static-element-interactions -->
	<div on:click|stopPropagation>
		<slot name="header" />
		<hr />
		<slot />
		<hr />
		{#each playerList as plr}
			<button on:click={(e) => dialog.close(plr.name)} disabled={lives <= 0 || selectedPlayers.find(p => p === plr.name) != undefined}>{plr.name}</button>
		{/each}
		<button on:click={() => dialog.close()}>cancel</button>
	</div>
</dialog>

<style>
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
	button {
		display: block;
	}
</style>
