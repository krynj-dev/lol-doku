<script lang="ts">
	import { onMount } from 'svelte';
	import { get_players, get_rule, get_team } from '$lib/shared/api';
	import Modal from './Modal.svelte';

	export let showModal: Boolean; // boolean
	export let rule_key: string;

	let dialog: HTMLDialogElement; // HTMLDialogElement
	

	$: if (dialog && showModal) dialog.showModal();
	let names: {
		key: string;
		alt_names: string[];
	};

	onMount(() => {
		get_rule(rule_key).then((src) => {
			if (src) {
				switch (src.rule_type) {
					case 'team':
						get_team(rule_key).then((teams_search_results) => {
							if (teams_search_results.length > 1) console.log("multiple teams have this name", teams_search_results);
							names = {
								key: src.key,
								alt_names: teams_search_results[0].other_names
							};
						});
						return;
					case 'teammate':
						get_players(rule_key, 1).then((player_search_results) => {
							let first_result = player_search_results.results[0];
							names = {
								key: src.key,
								alt_names: first_result.alternate_names
							};
						});
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
	<Modal bind:showModal>
		<div class="rule-modal">
			<h4>{names.key}</h4>
			{#if names.alt_names.length > 0}
				<hr />
				<ul>
					{#each names.alt_names as alt_n}
						<li>{alt_n}</li>
					{/each}
				</ul>
			{/if}
		</div>
	</Modal>
{/if}

<style>
	.rule-modal {
		padding: 0 10px;
	}
</style>