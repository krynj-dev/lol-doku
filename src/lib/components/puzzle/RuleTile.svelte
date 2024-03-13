<script lang="ts">
	import _team_data from '$lib/data/teams.json';
	import TeamModal from './TeamModal.svelte';

	export let team: string;
	let showModal = false;

	function toggleModal(e: Event) {
		if (!showModal) {
			showModal = true;
		} else {
			showModal = false;
		}
	}
</script>

<div
	class="rule-tile-button"
	role="button"
	tabindex="0"
	on:click={toggleModal}
	on:keyup={toggleModal}
>
	<TeamModal bind:showModal bind:team></TeamModal>
	<span>{team}</span>
</div>

<style>
	.rule-tile-button {
		height: 100%;
		width: 100%;
		display: flex;
		justify-content: space-around;
		align-items: center;
	}
</style>
