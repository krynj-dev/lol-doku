<script lang="ts">
	import _teams from '$lib/data/teams.json';
	import type { Team } from '$lib/models/Team';

	export let showModal: Boolean; // boolean
	export let team: string;

	let dialog: HTMLDialogElement; // HTMLDialogElement
	const team_data = _teams as {
		[key: string]: Team;
	};

	$: if (dialog && showModal) dialog.showModal();
	$: alt_names = team_data[team].other_names.filter((s) => s != team);
</script>

<!-- svelte-ignore a11y-click-events-have-key-events a11y-no-noninteractive-element-interactions -->
<dialog
	bind:this={dialog}
	on:click|self={() => dialog.close()}
	on:close={(e) => (showModal = false)}
>
	<!-- svelte-ignore a11y-no-static-element-interactions -->
	<div on:click|stopPropagation>
		<slot name="header" />
		<span>{team}</span>
		<hr />
		<slot />
		<ul>
			{#each alt_names as alt_n}
				<li>{alt_n}</li>
			{/each}
		</ul>
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
</style>
