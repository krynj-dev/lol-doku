<script lang="ts">
	import { onMount } from 'svelte';
	import { _finalised } from '../../../stores';
	import Modal from './Modal.svelte';
	import { get_player_stats, get_players } from '$lib/shared/api';
	import type { GuessStats, PlayerGuessStat } from '$lib/models/new/GuessStats';
	import { decimal_number } from '$lib/shared/util';
	import { get_player_image_src } from '$lib/shared/img';

	export let slot: number;

	let dialog: HTMLDialogElement;

	export let showModal = false;
	let allowToggle = false;

	_finalised.subscribe((v) => (allowToggle = v));

	let stats: GuessStats;

	let alt_names: any = {};

	let player_image_srcs: any = {};

	let percentage_correct = '100.0';

	$: {
		if (allowToggle && stats && showModal) {
			stats.results.forEach((stat) => {
				get_player_image_src(stat.player).then((res) => {
					if (res) {
						player_image_srcs[stat.player] = res;
					}
				});
			});
		}
	}

	onMount(() => {
		get_player_stats(slot).then((res_obj) => {
			let new_stats = res_obj as GuessStats;
			new_stats.results.sort((a, b) => b.guesses - a.guesses);
			stats = new_stats;
			percentage_correct = decimal_number((new_stats.total_guesses * 100) / new_stats.total_games, 1);
			stats.results.forEach((plr_guess) => {
				let plr_key = plr_guess.player;
				get_players(plr_key, 1).then((plr) => {
					if (plr) {
						alt_names[plr_key] = plr.results[0].alternate_names.filter((x) => x != plr_key);
                        console.log(alt_names);
					}
				});
			});
		});
	});
</script>

{#if allowToggle}
	<Modal bind:showModal size="600" bind:dialog>
		{#if stats}
			<h4 class="rule-cross-tile-title">{stats.x} / {stats.y}</h4>
			<p class="rule-cross-tile-percentage">Percentage correct: {percentage_correct}%</p>
			<hr />
			<div class="player-stat-container">
				{#each stats.results as player_stat}
					<div class="player-stat-item">
						<div class="player-stat-image-container">
							<img src={player_image_srcs[player_stat.player]} alt={player_stat.player} />
						</div>
						<div class="player-stat-name-container">
							<h5 class="player-stat-name">{player_stat.player}</h5>
                            {#if alt_names[player_stat.player]}
                                <div class="player-stat-subtitle">
                                    {#each alt_names[player_stat.player] as alt_name}
                                        <p class="player-stat-alt-name">{alt_name}</p>
                                    {/each}
                                </div>
                            {/if}
						</div>
						<div class="player-stat-stats">
							<p>{decimal_number((player_stat.guesses * 100) / stats.total_guesses, 1)}%</p>
							<p>({player_stat.guesses})</p>
						</div>
					</div>
				{/each}
			</div>
		{/if}
	</Modal>
{/if}

<style>
	.player-stat-container {
		display: flex;
		flex-direction: column;
	}

	.player-stat-item {
		display: grid;
        grid-template-columns: 100px auto auto;
		height: 100px;
	}

	.player-stat-item p {
		padding: 0 10px;
		font-size: 16px;
	}

	.player-stat-name-container {
		text-align: left;
        display: flex;
        flex-direction: column;
        justify-content: center;
        box-sizing: border-box;
		padding: 0 10px;
	}

    .player-stat-name {
        margin: 5px 0;
        width: 100%;
    }

	.player-stat-item img {
		height: 100%;
		width: auto;
		padding: 10px;
		box-sizing: border-box;
		object-fit: cover;
	}

	.player-stat-image-container {
		width: 100px;
		height: 100%;
		display: flex;
		justify-content: center;
		overflow: hidden;
		margin-right: 20px;
	}

	.rule-cross-tile-title {
		margin-top: 15px;
		margin-bottom: 15px;
		font-size: 22px;
		font-weight: 500;
	}

	.rule-cross-tile-percentage {
		font-weight: 500;
		font-size: 20px;
	}

    .player-stat-stats {
        display: flex;
        flex-direction: column;
        justify-content: center;
    }

	.player-stat-stats p {
		margin: 5px 0;
		text-align: right;
	}

    p.player-stat-alt-name {
        font-size: 14px;
        color: #595959;
        margin: 0 0 4px 0;
        padding: 0px;
    }

    .player-stat-alt-name:not(:last-child) {
        margin-right: 10px;
    }

    .player-stat-subtitle {
        display: flex;
        flex-wrap: wrap;
        padding: 0;
    }
</style>
