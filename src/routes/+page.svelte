<script lang="ts">
    import { Category } from '$lib/categories.ts';
    import DokuSquare from '$lib/components/puzzle/DokuSquare.svelte';
    import Header from '$lib/components/Header.svelte';
    import playerList from '$lib/players.json';

    let columns = [{team: "G2", id: 0}, {team: "KC", id: 1}, {team: "MDK", id: 2}];

    let rows = [{team: "FNC", id: 0}, {team: "RGE", id: 1}, {team: "VIT", id: 2}];
</script>


<Header />
<div class="content">
    <DokuSquare bind:columns bind:rows />
</div>

<style>
    .content {
        padding: 2rem 5rem;
    }
</style>
