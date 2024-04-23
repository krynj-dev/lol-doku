<script lang="ts">
	import { getContext, onMount, setContext } from 'svelte';
	import key from './DragNDrop.svelte';
	import type { Bucket } from './Bucket';
	import DragNDrop from './DragNDrop.svelte';
	import { writable, type Writable } from 'svelte/store';

	let clazz = '';
	export { clazz as class };

	const { getBucketsStore, getKey } = getContext<DragNDrop>('dnd');
	const buckets_store: Writable<{ [key: string]: Bucket }> = getBucketsStore();
	let buckets: {
		[key: string]: Bucket;
	} = {};

	buckets_store.subscribe((v) => (buckets = v));

	export let bucket_key: string;
	export let max_size: number;
    export let callback = (items: any[], bucketKey: string) => {}

	setContext('dnd-bucket', {
		getItemsStore: () => item_store,
		getCallback: () => callback,
		getBucketKey: () => bucket_key
	});

	const item_store = writable([] as any[]);

	let items: any[] = [];
	const dndKey = getKey();

	item_store.subscribe((v) => {
        callback(v, bucket_key);
		items = v;
	});

	let hovering_over = false;

	$: bucket = {
		key: bucket_key,
		max_size: max_size,
		items: item_store,
		class: clazz
	};

	function handleDrop(event: DragEvent) {
		hovering_over = false;
		event.preventDefault();
		if (event.dataTransfer) {
			const json = event.dataTransfer.getData('text/plain');
			const data = JSON.parse(json);
			if (data.dndKey != dndKey) {
				return;
			}
			let from_items: any[] = [];
			buckets[data.bucket_key].items.subscribe((v) => {
				from_items = v;
			});
			const [item] = from_items.splice(data.itemIndex, 1);

			buckets[data.bucket_key].items.set(from_items);
			if ((!max_size) || max_size === 0 || items.length < max_size) {
				item_store.update((i: any[]) => [...i, item]);
			} else {
                buckets[data.bucket_key].items.update((i: any[]) => [...i, items[0]])
				item_store.update((i: any[]) => [...i.splice(1), item]);
			}
		}
	}

	function handleDragStart(event: DragEvent, itemIndex: number, dndKey: Symbol) {
		const data = { bucket_key, itemIndex, dndKey };
		if (event.dataTransfer) event.dataTransfer.setData('text/plain', JSON.stringify(data));
	}

	onMount(() => {
		buckets_store.update((v) => {
			v[bucket_key] = bucket;
			return v;
		});
	});
</script>

<slot />
<div
	class={clazz}
	class:hovering={hovering_over}
	on:dragenter={() => (hovering_over = true)}
	on:dragleave={() => (hovering_over = false)}
	on:drop={(event) => handleDrop(event)}
	on:dragover={(event) => event.preventDefault()}
	role="listitem"
>
	{#each items as item, itemIndex (item)}
		<div
			on:dragstart={(e) => handleDragStart(e, itemIndex, dndKey)}
			role="listitem"
			style="cursor: pointer; display: inline-block"
			draggable={true}
            class={item.data.class}
		> 
			<span>{item.data.display_text}</span>
		</div>
	{/each}
</div>

<style>
	.hovering {
		border-color: orange;
	}
</style>
