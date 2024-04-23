<script lang="ts">
	import _team_data from '$lib/data/teams.json';
	import _team_image_data from '$lib/data/team_images.json';
	import _player_image_data from '$lib/data/player_images.json';
	import TeamModal from './TeamModal.svelte';
	import { read_rule } from '$lib/util/puzzle_util';
	import type { Rule } from '$lib/models/Rule';
	import { onMount } from 'svelte';
	import tippy from 'tippy.js';
	import 'tippy.js/dist/tippy.css';

	let team_image_data = _team_image_data as {
		[key: string]: string;
	};

	let player_image_data = _player_image_data as {
		[key: string]: {
			SortDate?: string | null
			DateStart?: string | null
			URL: string
		};
	};

	async function get_image_src(rule_key: string) {
		const rule: Rule = await read_rule(rule_key);
		switch (type) {
			case 'team':
				if (Object.keys(team_image_data).includes(rule_key)) return team_image_data[rule_key];
				return `img/teams/Logo_square.webp`;
			case 'role':
				return `img/Position_Challenger-${rule_key}.png`;
			case 'teammate':
				let res = await fetch(`img/players/${rule_key}.webp`);
				if (res.status == 200) return `img/players/${rule_key}.webp`;
				return undefined;
			case 'champion':
				let split = rule_key.split(" ");
				let champ_key;
				if (split.length == 2) champ_key = split[0];
				else split.slice(0, split.length - 2).join(' ');
				if (champ_key != "Any") return `img/champion/${champ_key?.replace(' ', '').replace('\'', '')}.png`
				return `img/champion/None.jpg`;
			default:
				return undefined;
		}
	}

	export let rule: string;
	export let type: string;
	let showModal = false;
	let image: string;

	function toggleModal(e: Event) {
		if (!showModal) {
			showModal = true;
		} else {
			showModal = false;
		}
	}

	onMount(() => {
		get_image_src(rule).then((src) => {
			if (src) {
				image = src;
			}
		});
	});
</script>

<div
	class="rule-tile-button"
	role="button"
	tabindex="0"
	on:click={toggleModal}
	on:keyup={toggleModal}
	use:tippy={{content: rule, placement: 'bottom'}}
>
	<TeamModal bind:showModal bind:team={rule}></TeamModal>
	{#if image}
		<img class="rule-tile-img" src={image} alt={rule} />
	{:else}
		{#if type == "teammate"}
			<img class="rule-tile-img" src={player_image_data[""].URL} alt={rule} />
			<span>{rule}</span>
		{:else}
			<span>{rule}</span>
		{/if}
	{/if}
</div>

<style>
	.rule-tile-button {
		max-height: 100%;
		max-width: 100%;
		display: flex;
		flex-direction: column;
		justify-content: space-around;
		align-items: center;
		padding: 1rem;
	}

	.rule-tile-img {
		max-width: calc(100% - 1rem);
		max-height: calc(100% - 1rem);
	}
</style>
