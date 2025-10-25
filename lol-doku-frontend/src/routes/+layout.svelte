<script lang="ts">
	import Header from '$lib/components/Header.svelte';
	import Footer from '$lib/components/Footer.svelte';
	import { SvelteToast } from '@zerodevx/svelte-toast';
	let { children } = $props();

	const tabs = ['Home', 'Puzzle Builder', 'Endless'];
	const options = {};

	let current_tab = 'Home';
</script>

<Header {tabs} bind:selected={current_tab} />
<div class="page-content">
	{@render children()}
</div>
<Footer />
<SvelteToast {options} />

<style>
	.page-content {
		padding: 1rem 2rem;
	}
</style>
