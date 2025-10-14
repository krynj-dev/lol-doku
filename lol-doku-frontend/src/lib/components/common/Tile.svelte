<script lang="ts">
	interface Props {
		variant?: 'light' | 'dark';
		class?: string;
		children?: import('svelte').Snippet;
	}

	let { variant = 'dark', class: clazz = '', children }: Props = $props();
</script>

<div class="tile-container lol-border {variant} {clazz}">
	{@render children?.()}
</div>

<style>
	.tile-container {
		box-sizing: border-box;
	}

	.light {
		background-color: var(--lol-doku-white-1);
		color: var(--lol-hextech-black);
	}

	.dark {
		background-color: var(--lol-hextech-black);
		color: var(--lol-doku-white-1);
	}
</style>
