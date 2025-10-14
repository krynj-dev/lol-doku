<!-- @migration-task Error while migrating Svelte code: Can't migrate code with afterUpdate. Please migrate by hand. -->
<script lang="ts">
	import { get_player_image_src } from '$lib/shared/img';
	import { onMount, afterUpdate } from 'svelte';
	import Tile from '../common/Tile.svelte';
	import { get_roster_links } from '$lib/shared/api';
	import FittingImage from '../common/FittingImage.svelte';

	export let player_key: string = 'Rekkles';

	let player_img: string;

	onMount(() => {
		get_player_image_src(player_key).then((res) => {
			console.log(res);
			player_img = res;
		});
	});

	afterUpdate(() => {
		get_player_image_src(player_key).then((res) => {
			console.log(res);
			player_img = res;
		});
	});
</script>

<Tile>
	<div class="player-portrait-container">
		<FittingImage src={player_img} alt={player_key} class="lol-border-small" variant="cover" />
		<div class="caption-container lol-border-small">
			<p class="h5 player-caption">{player_key}</p>
		</div>
	</div>
</Tile>

<style>
	.player-portrait-container {
		width: 20vh;
		display: grid;
		grid-template-rows: 20vh auto;
		padding: 3px;
	}

	.img-container {
		width: 100%;
		height: 100%;
		box-sizing: border-box;
		position: relative;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-content: center;
		overflow: hidden;
	}

	.fitting-img {
		display: block;
		min-width: 100%;
		min-height: 100%;
		overflow: hidden;
		box-sizing: border-box;
		object-fit: cover;
	}

	.player-caption {
		color: var(--lol-gold-1);
		text-align: center;
		margin: 0.5rem 0;
	}
</style>
