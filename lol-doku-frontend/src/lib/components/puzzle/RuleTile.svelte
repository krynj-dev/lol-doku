<script lang="ts">
	import _team_image_data from '$lib/data/team_images.json';
	import TeamModal from './TeamModal.svelte';
	import { read_rule } from '$lib/shared/puzzle_util';
	import type { Rule } from '$lib/models/new/Rule';
	import { onMount } from 'svelte';
	import tippy from 'tippy.js';
	import 'tippy.js/dist/tippy.css';
	import { _country_codes } from '../../../stores';

	let team_image_data = _team_image_data as {
		[key: string]: string;
	};

	let country_codes: object;

	_country_codes.subscribe((v) => (country_codes = v));

	async function get_image_src(rule_key: string) {
		// const rule: Rule = await read_rule(rule_key);
		switch (type) {
			case 'team':
				if (Object.keys(team_image_data).includes(rule_key)) return team_image_data[rule_key];
				return `img/teams/Logo_square.webp`;
			case 'role':
				switch (rule_key) {
					case 'Mid':
						return 'img/roles/middle.svg';
					case 'Bot':
						return 'img/roles/bottom.svg';
					case 'Jungle':
						return 'img/roles/jungle.svg';
					case 'Top':
						return 'img/roles/top.svg';
					case 'Support':
						return 'img/roles/support.svg';
					default:
						return `img/champion/None.jpg`;
				}
			case 'teammate':
				let res = await fetch(`img/players/${rule_key}.webp`);
				if (res.status == 200) return `img/players/${rule_key}.webp`;
				return undefined;
			case 'champion':
				let split = rule_key.split(' ');
				let champ_key;
				if (split.length == 2) champ_key = split[0];
				else split.slice(0, split.length - 2).join(' ');
				if (champ_key != 'Any')
					return `img/champion/${champ_key?.replace(' ', '').replace("'", '')}.png`;
				return `img/champion/None.jpg`;
			case 'finalist':
			case 'tournament':
				return `img/worlds.svg`;
			case 'country':
				if (country_codes) {
					for (const [k, v] of Object.entries(country_codes)) {
						if (v == rule_key) {
							console.log(k, v);
							return `img/country/${k.toLocaleLowerCase()}.svg`;
						}
					}
				}
			default:
				return undefined;
		}
	}

	export let rule: string;
	export let type: string;
	export let size: string;
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

<div style="--tile-size: {size}" class="rule-tile-container">
	<div
		class="rule-tile-button"
		role="button"
		tabindex="0"
		on:click={toggleModal}
		on:keyup={toggleModal}
	>
		<TeamModal bind:showModal bind:team={rule}></TeamModal>
		{#if image}
			<div class="rule-tile-img-container">
				<img class={`rule-tile-img ${type == 'role' ? 'role-image ' : ''}${type == 'country' ? 'country-image' : ''}`} src={image} alt={rule} />
			</div>
			{#if type == 'teammate'}
				<div class="caption">
					<p>{rule} Teammate</p>
				</div>
			{:else}
				<div class="caption">
					<p>{rule}</p>
				</div>
			{/if}
		{:else}
			<p>{rule}</p>
		{/if}
	</div>
</div>

<style>
	.rule-tile-container {
		display: flex;
	}

	.rule-tile-button {
		height: var(--tile-size);
		width: var(--tile-size);
		display: grid;
		grid-template-rows: auto 30px;
		gap: 2px;
		cursor: pointer;
	}

	.rule-tile-img {
		width: auto;
		height: 100%;
		overflow: hidden;
		box-sizing: border-box;
		object-fit: cover;
	}

	.caption {
		display: flex;
		justify-content: center;
		align-items: center;
		height: 25px;
	}

	.caption p {
		text-align: center;
		padding: 0;
		margin: 0 10px;
		font-size: 12px;
		font-weight: bold;
		height: auto;
	}

	.rule-tile-img-container {
		width: auto;
		height: 100%;
		overflow: hidden;
		box-sizing: border-box;
		display: flex;
		justify-content: center;
		padding: 10px 10px 0;
	}

	.role-image {
		padding: 10px;
	}

	.country-image {
		width: 100%;
		height: auto;
		object-fit: scale-down;
	}
</style>
