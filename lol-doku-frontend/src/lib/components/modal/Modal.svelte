<script lang="ts">
	export let showModal: Boolean; // boolean

	export let dialog: HTMLDialogElement | undefined = undefined; // HTMLDialogElement

	export let modalCloseFallback = (event: Event & { currentTarget: EventTarget & HTMLDialogElement }) => {};

	export let size: string = '400';

	let onClose = (event: Event & { currentTarget: EventTarget & HTMLDialogElement }) => {
		modalCloseFallback(event);
		showModal = false;
	}

	$: if (dialog && showModal) dialog.showModal();

</script>

<!-- svelte-ignore a11y-click-events-have-key-events a11y-no-noninteractive-element-interactions -->

<dialog
	bind:this={dialog}
	on:click|self={() => {if (dialog) dialog.close()}}
	on:close={onClose}
	style={`--modal-width: ${size}px;`}
>
	<!-- svelte-ignore a11y-no-static-element-interactions -->
	<div on:click|stopPropagation>
		<slot />
	</div>
</dialog>

<style>
	dialog {
		width: var(--modal-width);
		border: 2px solid var(--lol-gold-4);
		padding: 0;
		background-color: var(--lol-hextech-black);
		color: var(--lol-gold-1);
		cursor: auto;
	}
	dialog::backdrop {
		background: rgba(0, 0, 0, 0.3);
	}
	dialog > div {
		padding: 1em;
	}
	dialog[open] {
		animation: zoom 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
	}
	dialog:focus {
		outline-offset: 2px;
	}
	@keyframes zoom {
		from {
			transform: scale(0.95);
		}
		to {
			transform: scale(1);
		}
	}
	dialog[open]::backdrop {
		animation: fade 0.2s ease-out;
	}
	@keyframes fade {
		from {
			opacity: 0;
		}
		to {
			opacity: 1;
		}
	}
</style>
