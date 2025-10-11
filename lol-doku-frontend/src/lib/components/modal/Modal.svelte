<script lang="ts">
	import { run, self, createBubbler, stopPropagation } from 'svelte/legacy';

	const bubble = createBubbler();
	import Cross from '../vector-image/Cross.svelte';




	interface Props {
		showModal: Boolean;
		dialog?: HTMLDialogElement | undefined;
		modalCloseCallback?: any;
		size?: string;
		title?: import('svelte').Snippet;
		children?: import('svelte').Snippet;
	}

	let {
		showModal = $bindable(),
		dialog = $bindable(undefined),
		modalCloseCallback = (
		event: Event & { currentTarget: EventTarget & HTMLDialogElement }
	) => {},
		size = '500',
		title,
		children
	}: Props = $props();

	let onClose = (event: Event & { currentTarget: EventTarget & HTMLDialogElement }) => {
		modalCloseCallback(event);
		showModal = false;
	};

	run(() => {
		if (dialog && showModal) dialog.showModal();
	});
</script>

<!-- svelte-ignore a11y_click_events_have_key_events, a11y_no_noninteractive_element_interactions -->

<dialog
	bind:this={dialog}
	onclick={self(() => {
		if (dialog) dialog.close();
	})}
	onclose={onClose}
	style={`--modal-width: ${size}px;`}
>
	<!-- svelte-ignore a11y_no_static_element_interactions -->
	<div class="modal" onclick={stopPropagation(bubble('click'))}>
		<div class="modal-header">
			<div class="modal-title-container">
				{@render title?.()}
			</div>
			<button
				class="modal-cross"
				onclick={() => {
					if (dialog) dialog.close();
				}}><Cross fill="var(--lol-gold-4)" /></button
			>
		</div>
		<div class="modal-content">
			{@render children?.()}
		</div>
	</div>
</dialog>

<style>
	.modal > * {
		margin: 0 1rem;
	}
	.modal-title-container {
		padding: 0 57px;
		width: 100%;
	}
	.modal-cross {
		width: 25px;
		height: 25px;
		padding: 3px;
		margin: 16px;
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
