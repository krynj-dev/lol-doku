<script lang="ts">
	import { getContext, onMount, setContext } from 'svelte';
	import key from './DragNDrop.svelte';
	import type { Bucket } from './Bucket';
	import DragNDrop from './DragNDrop.svelte';
	import DnDBucket from './DnDBucket.svelte';
	import type { BucketItem } from './BucketItem';

	let clazz = '';
	export { clazz as class };

	const { getItemsStore, getCallback, getBucketKey } = getContext<DnDBucket>('dnd-bucket');
	const { getBucketsStore } = getContext<DragNDrop>('dnd');

	let item_key = Symbol('item');
    export let item_data: BucketItem;

	onMount(() => {
		const item = {
			key: item_key,
            data: item_data
		};

		getItemsStore().update((v: any[]) => {
			let new_v = [...v, item]
			getCallback()(new_v, getBucketKey());
			return new_v;
		});
	});
</script>
