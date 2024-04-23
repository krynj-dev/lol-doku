<script lang="ts">
    import { setContext } from "svelte";
	import type { Bucket } from "./Bucket";
    import {v4 as uuidv4} from "uuid";
	import { writable } from "svelte/store";

    export const key = uuidv4();

    let clazz = '';
	export { clazz as class };

    let container;
    const buckets_store = writable({} as {
        [key: string]: Bucket
    });

    setContext("dnd", {
        getBucketsStore: () => buckets_store,
        getKey: () => key
    })

    export let buckets: {
        [key: string]: Bucket
    } = {};

    buckets_store.subscribe(v => buckets = v)
</script>

<div class={clazz} bind:this={container}>
    <slot />
    <button on:click={e => console.log(buckets)}>Log Buckets</button>
</div>
