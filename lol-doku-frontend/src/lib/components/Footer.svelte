<script lang="ts">
	import Info from './vector-image/Info.svelte';
	import MediaQuery from './media-query/MediaQuery.svelte';
	import { onMount } from 'svelte';
	import { get_metadata } from '$lib/shared/api';
	import { stringify } from 'uuid';

	let kofi: any;
	let kofiHtml: string;

	$: data_update_date = undefined as string | undefined;

	onMount(() => {
		kofi = (window as any).kofiwidget2;
		kofi.init('Donate on Ko-fi', 'var(--lol-blue-4)', 'T6T61A5K5H');
		kofiHtml = kofi.getHTML();

		get_metadata().then(res => {
			console.log("fetched", res);
			data_update_date = res.data_update_date;
		})
	});
</script>

<div class="footer-container">
	<div class="footer">
		<div class="footer-tab">
			<p class="credits center">
				Created by Hayden. Data sourced from 
				<a href='https://lol.fandom.com/wiki/League_of_Legends_Esports_Wiki'>Leaguepedia</a>
			</p>
			{#if data_update_date}
				<p class="data-update center">Last updated {data_update_date}</p>
			{/if}
		</div>
		<div>
			{#if kofi}
				<MediaQuery query="(max-width: 999px)" let:matches>
					{#if matches}
						<div class="footer-tab">
							{@html kofiHtml}
						</div>
					{/if}
				</MediaQuery>
			{/if}
		</div>
</div>
</div>

<style>
	.footer-container {
		display: block;
		padding: 0;
		height: 60px;
		background-color: var(--lol-doku-white-1);
		/* border-top: 2px solid var(--lol-gold-4); */
		width: 100vw;
	}

	.footer h2 {
		margin: 0;
	}

	.footer {
		display: flex;
		align-items: center;
		justify-content: center;
		height: 60px;
		box-sizing: border-box;
		width: 100vw;
	}

	.credits {
		margin: 0;
	}

	.footer-tabs-container {
		flex-grow: 1;
		padding: 0;
		justify-content: right;
	}

	.center {
		text-align: center;
		margin: 0;
	}

	.footer-tab {
		background-color: transparent;
		border: 0;
		color: inherit;
		margin: 0;
		padding: 0 20px;
		height: 100%;
		display: flex;
		flex-direction: column;
		gap: 2px;
		justify-content: center;
	}

	.footer-border:not(:last-child) {
		border-right: 0;
	}

	.data-update {
		font-size: 0.9rem;
		color: var(--lol-grey-3);
	}

	.thing-on-right {
		height: 100%;
		padding: 15px;
		box-sizing: border-box;
		display: flex;
		width: max-content;
	}

	.info-button {
		height: 100%;
		background-color: inherit;
		border: 0;
		padding: 0;
		display: flex;
		box-sizing: border-box;
	}
	.info-button:hover {
		background-color: inherit;
		cursor: pointer;
	}

	.info-button-image {
		max-width: 100%;
		max-height: 100%;
		object-fit: scale-down;
		box-sizing: border-box;
	}
</style>
