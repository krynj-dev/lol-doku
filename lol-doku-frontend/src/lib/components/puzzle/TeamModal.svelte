<script lang="ts">
	import _players from '$lib/data/players.json';
	import { onMount } from 'svelte';
	import { get_rule, get_team } from '$lib/shared/api';

	export let showModal: Boolean; // boolean
	export let team: string;

	let dialog: HTMLDialogElement; // HTMLDialogElement

	const player_data = _players as {
		[key: string]: any;
	};

	$: if (dialog && showModal) dialog.showModal();
	let names: {
		key: string;
		alt_names: string[];
	};

	onMount(() => {
		get_rule(team).then((src) => {
			if (src) {
				switch (src.rule_type) {
					case 'team':
						get_team(team).then((teams_search_results) => {
							if (teams_search_results.length > 1) console.log("multiple teams have this name", teams_search_results);
							names = {
								key: src.key,
								alt_names: teams_search_results[0].other_names
							};
						});
						return;
					case 'teammate':
						names = {
							key: src.key,
							alt_names: player_data[src.key].alternate_names
						};
						return;
					default:
						names = {
							key: src.key,
							alt_names: []
						};
						return;
				}
			}
		});
	});
</script>

<!-- svelte-ignore a11y-click-events-have-key-events a11y-no-noninteractive-element-interactions -->
{#if names}
	<dialog
		bind:this={dialog}
		on:click|self={() => dialog.close()}
		on:close={(e) => (showModal = false)}
	>
		<!-- svelte-ignore a11y-no-static-element-interactions -->
		<div on:click|stopPropagation>
			<slot name="header" />
			<span>{names.key}</span>
			<hr />
			<slot />
			<ul>
				{#each names.alt_names as alt_n}
					<li>{alt_n}</li>
				{/each}
			</ul>
		</div>
	</dialog>
{/if}

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
