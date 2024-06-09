<script lang="ts">
	import _team_image_data from '$lib/data/team_images.json';
	import { read_rule } from '$lib/shared/puzzle_util';
	import type { Rule } from '$lib/models/new/Rule';
	import { onMount } from 'svelte';
	import tippy from 'tippy.js';
	import 'tippy.js/dist/tippy.css';
	import { _country_codes } from '../../../stores';
	import { get_rule_image_src } from '$lib/shared/img';
	import Worlds from '../vector-image/Worlds.svelte';
	import Modal from '../modal/Modal.svelte';
	import ColorToggle from '../vector-image/ColorToggle.svelte';


	export let rule: Rule;
	let showModal = false;
	let image: string;

	let country_codes: object;

	_country_codes.subscribe((v) => (country_codes = v));

	function toggleModal(e: Event) {
		if (!showModal) {
			showModal = true;
		} else {
			showModal = false;
		}
	}

	$: filtered_alt_names = rule.other_names?.filter(n => n.toLocaleLowerCase() != rule.key.toLocaleLowerCase());

	let modalLight = false;
	let modalLightFill = "var(--lol-doku-white-1)";

	let toggleModalLight = () => {
		if (modalLight) {
			modalLightFill = "var(--lol-doku-white-1)";
		} else {
			modalLightFill = "var(--lol-hextech-black)";
		}
		modalLight = !modalLight;
	}

	onMount(() => {
		fetch('countries.json')
			.then((x) => x.json())
			.then((r) => {
				_country_codes.set(r);
				get_rule_image_src(rule.key, rule.rule_type).then((src) => {
					if (src) {
						image = src;
					}
				});
			});
	});
</script>

<div class="rule-tile-container">
	<div
		class="rule-tile-button"
		role="button"
		tabindex="0"
		on:click={toggleModal}
		on:keyup={toggleModal}
	>
		<Modal bind:showModal>
			<div class="rule-modal">
				<h4>{rule.key}</h4>
				<div class={`rule-image-container lol-border${modalLight ? ' white-bg': ''}`}>
					<img class="rule-image" src={image} alt={rule.key}/>
					<div class="button-modal-container">
						<button class={`button-modal-light-toggle${modalLight ? ' rotate-180-deg': ''}`} on:click={toggleModalLight}>
							<ColorToggle fill={modalLightFill}/>
						</button>
					</div>
				</div>
				{#if filtered_alt_names && filtered_alt_names.length > 0}
					<hr />
					<ul>
						{#each filtered_alt_names as alt_n}
							<li>{alt_n}</li>
						{/each}
					</ul>
				{/if}
			</div>
		</Modal>
		{#if rule.rule_type == 'tournament' || rule.rule_type == "finalist"}
			<div class="rule-tile-img-container">
				<Worlds />
			</div>
			<div class="caption">
				<p>{rule.key}</p>
			</div>
		{:else if image}
			<div class="rule-tile-img-container">
				<img
					class={`rule-tile-img ${rule.rule_type == 'role' ? 'role-image ' : ''}`}
					src={image}
					alt={rule.key}
				/>
			</div>
			{#if rule.rule_type == 'teammate'}
				<div class="caption">
					<p>{rule.key} Teammate</p>
				</div>
			{:else}
				<div class="caption">
					<p>{rule.key}</p>
				</div>
			{/if}
		{:else}
			<p>{rule.key}</p>
		{/if}
	</div>
</div>

<style>
	.rule-tile-container {
		display: flex;
	}

	.rule-tile-button {
		height: 100%;
		width: 100%;
		cursor: pointer;
		display: flex;
		justify-content: center;
		align-items: center;
	}

	.rule-tile-img {
		display: block;
		max-width: 100%;
		max-height: 100%;
		overflow: hidden;
		box-sizing: border-box;
		object-fit: scale-down;
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
		font-size: 0.8rem;
		font-weight: bold;
		height: auto;
	}

	.rule-tile-img-container {
		display: none;
	}

	.role-image {
		padding: 10px;
	}

	.rule-modal {
		padding: 0 10px;
		box-sizing: border-box;
	}

	.rule-image-container {
		box-sizing: border-box;
		width: 100%;
		padding: 40px 10px 10px;
		position: relative;
		margin: 10px 0;
	}

	.white-bg {
		background-color: var(--lol-doku-white-1);
	}

	.rule-image {
		width: 100%;
	}

	.button-modal-container {
		display: flex;
		width: 100%;
		justify-content: end;
		margin-top: 10px;
	}

	.button-modal-light-toggle {
		box-sizing: border-box;
		border: 0;
		border-radius: 0;
		background-color: transparent;
		width: 30px;
		height: 30px;
		padding: 0;
		cursor: pointer;
		transition: 0.5s;
	}

	.rotate-180-deg {
		transform: rotate(180deg);
	}

	@media only screen and (min-width: 769px) {
		.rule-tile-button {
			display: grid;
			grid-template-rows: auto 30px;
			gap: 2px;
		}

		.rule-tile-img-container {
			width: auto;
			height: 100%;
			overflow: hidden;
			box-sizing: border-box;
			display: flex;
			justify-content: center;
			padding: 10px 10px 5px;
		}
	}
</style>
