<script lang="ts">
	import Cross from '../vector-image/Cross.svelte';

	export let showModal: Boolean; // boolean

	export let dialog: HTMLDialogElement | undefined = undefined; // HTMLDialogElement

	export let modalCloseCallback = (
		event: Event & { currentTarget: EventTarget & HTMLDialogElement }
	) => {};

	export let size: string = '400';

	let onClose = (event: Event & { currentTarget: EventTarget & HTMLDialogElement }) => {
		modalCloseCallback(event);
		showModal = false;
	};

	$: if (dialog && showModal) dialog.showModal();
</script>

<!-- svelte-ignore a11y-click-events-have-key-events a11y-no-noninteractive-element-interactions -->

<dialog
	bind:this={dialog}
	on:click|self={() => {
		if (dialog) dialog.close();
	}}
	on:close={onClose}
	style={`--modal-width: ${size}px;`}
>
	<!-- svelte-ignore a11y-no-static-element-interactions -->
	<div class="modal" on:click|stopPropagation>
		<div class="modal-header">
			<div class="modal-title-container">
				<slot name="title" />
			</div>
			<button
				class="modal-cross"
				on:click={() => {
					if (dialog) dialog.close();
				}}><Cross fill="var(--lol-gold-4)" /></button
			>
		</div>
		<div class="modal-content">
			<slot />
		</div>
	</div>
</dialog>

<style>
	.modal > * {
		margin: 0 1rem;
	}
	.modal-title-container {
		padding: 0 35px;
		width: 100%;
	}
	.modal-cross {
		width: 25px;
		height: 25px;
		padding: 3px;
		margin: 5px;
		right: 0;
		top: 0;
		box-sizing: border-box;
		border: 2px solid var(--lol-gold-4);
		background-color: transparent;
		cursor: pointer;
		position: absolute;
	}
	.modal-header {
		display: flex;
		flex-direction: row-reverse;
		margin: 0;
		position: relative;
		min-height: 35px;
	}
	.modal {
		overflow: hidden;
	}
	.modal-content {
		overflow-y: auto;
		margin-bottom: 1rem;
	}
	dialog {
		width: var(--modal-width);
		max-height: 90vh;
		border: 2px solid var(--lol-gold-4);
		padding: 0;
		background-color: var(--lol-hextech-black);
		color: var(--lol-gold-1);
		cursor: auto;
	}
	dialog::backdrop {
		background: rgba(0, 0, 0, 0.3);
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
