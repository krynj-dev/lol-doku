<script lang="ts">
	// import type { Player } from '$lib/models/Team';
	import _team_data from '$lib/data/teams.json';
	import type { Team } from '$lib/models/Team';
	import { getLatestTeamDate, getLatestTeamName } from '$lib/models/Team';
	import PlayerModal from './PlayerModal.svelte';
	export let index: number;
	export let rule1: Team & { id: number };
	export let rule2: Team & { id: number };
	export let lives: number;
	export let correct: number;
	export let selectedPlayers: string[];

	const team_data = _team_data['chains'] as Team[];

	let stylish = $$props.style;

	let showModal = false;
	let selectedPlayer: string | undefined;
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

	function checkValid(player: string | undefined): string {
		if (player) {
			let team1 = team_data.find((x: Team) => {
				return (
					getLatestTeamName(x) == getLatestTeamName(rule1) &&
					getLatestTeamDate(x) == getLatestTeamDate(rule1)
				);
			});
			console.log("found team1: ", team1);
			let team2 = team_data.find((x: Team) => {
				if (getLatestTeamName(x) == getLatestTeamName(rule2) && getLatestTeamDate(x) == getLatestTeamDate(rule2))
					console.log(getLatestTeamName(x), getLatestTeamName(rule2));
				return (
					getLatestTeamName(x) == getLatestTeamName(rule2) &&
					getLatestTeamDate(x) == getLatestTeamDate(rule2)
				);
			});
			console.log("found team2: ", team2);
			if (team1 !== undefined && team2 !== undefined) {
				console.log(team1.players.filter((value) => team2.players.includes(value)));
			}
			if (
				team1 !== undefined &&
				team2 !== undefined &&
				team1['players'].includes(player) &&
				team2['players'].includes(player)
			) {
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
	{selectedPlayer ? selectedPlayer : ''}
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
