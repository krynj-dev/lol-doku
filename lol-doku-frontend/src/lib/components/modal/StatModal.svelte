<script lang="ts">
	import { onMount } from "svelte";
	import { _finalised } from "../../../stores";
	import Modal from "./Modal.svelte";
	import { get_player_stats } from "$lib/shared/api";
	import type { GuessStats, PlayerGuessStat } from "$lib/models/new/GuessStats";
	import { decimal_number } from "$lib/shared/util";
	import { get_player_image_src } from "$lib/shared/img";
    
    export let slot: number;

    export let showModal = false;
    let allowToggle = false;

    _finalised.subscribe((v) => allowToggle = v);

    let stats: GuessStats;

    let player_image_srcs: any = {};

    $: {
        if (allowToggle && stats && showModal) {
            stats.results.forEach(stat => {
                get_player_image_src(stat.player).then(res => {
                    if (res) {
                        player_image_srcs[stat.player] = res;
                    }
                })
            });
        }
    }

    onMount(() => {
        get_player_stats(slot).then(res_obj => {
            let new_stats = res_obj as GuessStats;
            new_stats.results.sort((a, b) => b.guesses - a.guesses);
            stats = new_stats;
        })
    })
</script>

{#if allowToggle}
    <Modal bind:showModal>
        {#if stats}
            <h4 class="rule-cross-tile-title">{stats.x} / {stats.y}</h4>
            <div class="player-stat-container">
                {#each stats.results as player_stat}
                    <div class="player-stat-item">
                        <img src={player_image_srcs[player_stat.player]} alt={player_stat.player}/>
                        <p>{player_stat.player}</p>
                        <p>{decimal_number(player_stat.guesses * 100 / stats.total_guesses, 1)}%</p>
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
        display: flex;
        justify-content: space-between;
        align-items: center;
        height: 100px;
    }

    .player-stat-item p {
        padding: 0 10px;
        font-size: 14px;
    }

    .player-stat-item img {
        height: 100%;
        width: auto;
        padding: 10px;
        box-sizing: border-box;
    }

    .rule-cross-tile-title {
        margin-top: 15px;
        margin-bottom: 15px;
        font-size: 22px;
        font-weight: 500;
    }

</style>