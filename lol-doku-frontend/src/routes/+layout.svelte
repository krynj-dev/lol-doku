<script lang="ts">
	import Header from '$lib/components/Header.svelte';
	import Footer from '$lib/components/Footer.svelte';
	let { children } = $props();

	const tabs = ['Home', 'Puzzle Builder', 'Endless'];

	let current_tab = 'Home';
</script>

<Header {tabs} bind:selected={current_tab} />
<div class="page-content">
	{@render children()}
</div>
<Footer />

<style>
	.page-content {
		padding: 1rem 2rem;
	}
</style>
