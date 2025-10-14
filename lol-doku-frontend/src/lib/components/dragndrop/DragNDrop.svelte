<script lang="ts">
	import { setContext } from 'svelte';
	import type { Bucket } from './Bucket';
	import { v4 as uuidv4 } from 'uuid';
	import { writable } from 'svelte/store';

	export const key = uuidv4();

	let container = $state();
	const buckets_store = writable(
		{} as {
			[key: string]: Bucket;
		}
	);

	setContext('dnd', {
		getBucketsStore: () => buckets_store,
		getKey: () => key
	});

	interface Props {
		class?: string;
		buckets?: {
			[key: string]: Bucket;
		};
		children?: import('svelte').Snippet;
	}

	let { class: clazz = '', buckets = $bindable({}), children }: Props = $props();

	buckets_store.subscribe((v) => (buckets = v));
</script>

<div class={clazz} bind:this={container}>
	{@render children?.()}
	<button onclick={(e) => console.log(buckets)}>Log Buckets</button>
</div>
