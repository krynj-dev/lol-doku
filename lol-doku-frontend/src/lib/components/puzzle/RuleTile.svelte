<script lang="ts">
	import { run } from 'svelte/legacy';

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

	interface Props {
		rule: Rule;
	}

	let { rule }: Props = $props();
	let showModal = $state(false);
	let image: string = $state();

	let country_codes: object;

	let alt_images: any = $state({});

	_country_codes.subscribe((v) => (country_codes = v));

	function toggleModal(e: Event) {
		if (!showModal) {
			showModal = true;
		} else {
			showModal = false;
		}
	}

	let filtered_alt_names = $derived(rule.other_names?.filter(
		(n) => n.toLocaleLowerCase() != rule.key.toLocaleLowerCase()
	));

	const get_champion_count_number = (rule_key: string) => {
		let count_regex = new RegExp('^.+ (\\d+\\+)$');
		return count_regex.exec(rule_key)?.[1];
	}

	const getimgs = async (names: string[]) => {
		if (!names) return;
		let obj: any = {};
		// let res = get_rule_image_src(n, rule.rule_type).then(src => src);
		for (let i = 0; i < names.length; i++) {
			const n = names[i];
			const element = names[i];
			let src = await get_rule_image_src(n, rule.rule_type);
			obj[n] = src;
		}
		return obj;
	};

	run(() => {
		getimgs(filtered_alt_names).then(o => {alt_images = o})
	});

	let modalLight = $state(false);
	let modalLightFill = $state('var(--lol-doku-white-1)');

	let toggleModalLight = () => {
		if (modalLight) {
			modalLightFill = 'var(--lol-doku-white-1)';
		} else {
			modalLightFill = 'var(--lol-hextech-black)';
		}
		modalLight = !modalLight;
	};

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
		onclick={toggleModal}
		onkeyup={toggleModal}
	>
		<Modal bind:showModal>
			{#snippet title()}
						<h4 class="rule-modal-title" >{rule.key}</h4>
					{/snippet}
			<div class="rule-modal">
				<div class={`rule-image-container lol-border${modalLight ? ' white-bg' : ''}`}>
					<img class="rule-image" src={image} alt={rule.key} />
					<div class="button-modal-container">
						<button
							class={`button-modal-light-toggle${modalLight ? ' rotate-180-deg' : ''}`}
							onclick={toggleModalLight}
						>
							<ColorToggle fill={modalLightFill} />
						</button>
					</div>
				</div>
				{#if alt_images && Object.keys(alt_images).length > 0}
				<h5>Also Known As</h5>
				<div class="alt-container lol-border">
					{#each Object.entries(alt_images) as [key, value]}
						<div class={`alt-img-container lol-border-small`}>
							<div class={`lol-border-small another-container${modalLight ? ' white-bg' : ''}`} style="padding: 5px"><img class="rule-tile-img" src={String(value)} alt={key} /></div>
							<div>
								<p class="alt-name-caption h6">{key}</p>
							</div>
						</div>
					{/each}
				</div>
				{:else if filtered_alt_names && filtered_alt_names.length > 0}
				<h5>Also Known As</h5>
				<div>
					{#each filtered_alt_names as alt_name}
						<div class={`alt-img-container lol-border-small`}>
							<div>
								<p class="alt-name-caption h6">{alt_name}</p>
							</div>
						</div>
					{/each}
					</div>
				{/if}
			</div>
		</Modal>
		{#if rule.rule_type == 'tournament' || rule.rule_type == 'finalist'}
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
				{#if rule.rule_type == 'champion'}
				<div class="champion-rule-overlay-container">
					<p class="h2 champion-rule-overlay">{get_champion_count_number(rule.key)}</p>
				</div>
				{/if}
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
	.champion-rule-overlay-container {
		position: absolute;
		display: flex;
		flex-direction: column;
		align-items: flex-end;
		justify-content: flex-start;
		width: calc(100% - 20px);
		height: calc(100% - 15px);
	}

	.champion-rule-overlay {
		color: var(--lol-gold-1);
		margin: 0;
		-webkit-text-stroke: 2px var(--lol-hextech-black);
	}

	.alt-container {
		display: flex;
		flex-direction: column;
		padding: 5px;
		gap: 5px;
	}

	.alt-img-container {
		height: 92px;
		display: grid;
		grid-template-columns: 92px auto;
		padding: 5px;
	}

	.alt-img-container > div {
		display: flex;
		justify-content: center;
		align-items: center;
	}

	.another-container {
		height: 80px;
	}

	.alt-name-caption {
		padding: 0;
		margin: 0;
		text-align: center;
		height: min-content;
	}

	.alt-img {
		width: auto;
		height: 100%;
		box-sizing: content-box;
	}

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
		position: relative;
	}

	.role-image {
		padding: 10px;
	}

	.rule-modal {
		padding: 0 10px;
		box-sizing: border-box;
		max-height: 600px;
	}

	.rule-image-container {
		box-sizing: border-box;
		width: 100%;
		height: 400px;
		padding: 40px 10px;
		position: relative;
		margin: 10px 0;
		transition: 0.5s;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-content: center;
	}

	.white-bg {
		background-color: var(--lol-doku-white-1);
	}

	.rule-image {
		display: block;
		max-width: 100%;
		max-height: 100%;
		overflow: hidden;
		box-sizing: border-box;
		object-fit: scale-down;
	}

	.button-modal-container {
		position: absolute;
		padding: 10px;
		height: 20px;
		bottom: 0;
		right: 0;
	}

	.button-modal-light-toggle {
		box-sizing: border-box;
		border: 0;
		border-radius: 0;
		background-color: transparent;
		width: 20px;
		height: 20px;
		padding: 0;
		cursor: pointer;
		transition: 0.5s;
	}

	.rule-modal-title {
		text-align: center;
		margin: 1rem 0;
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
