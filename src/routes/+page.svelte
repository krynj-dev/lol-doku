<script lang="ts">
    import { Category } from '$lib/categories.ts';
    import DokuSquare from '$lib/components/puzzle/DokuSquare.svelte';
    import Header from '$lib/components/Header.svelte';
    import playerList from '$lib/players.json';
    import { generate_puzzle } from '$lib/util/puzzle_util';
    import type { Team } from '$lib/models/Team'

    // let p = generate_puzzle();
    // while (p == null) {
    //     console.log("invalid");
    //     p = generate_puzzle();
    // }
    // console.log(p);

    let columns: Team[] & {id: number}[];
    let rows: Team[] & {id: number}[];

    function gen_puz() {
        let p = generate_puzzle();
        while (p == null) {
            console.log("invalid");
            p = generate_puzzle();
        }
        console.log(p);
        columns = p.cols;
        rows = p.rows;
    }
</script>


<Header />
<div class="content">
    <DokuSquare bind:columns bind:rows />
    <button on:click={gen_puz}>Get Puzzle</button>
</div>

<style>
    .content {
        padding: 2rem 5rem;
    }
</style>
