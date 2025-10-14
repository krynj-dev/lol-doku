<script lang="ts">
	interface Props {
		timezone?: string;
	}

	let { timezone = $bindable('Australia/Sydney') }: Props = $props();

	import { onDestroy } from 'svelte';

	let timeLeft = $state(getTimeLeft());

	const interval = setInterval(() => {
		timeLeft = getTimeLeft();
	}, 1000);

	function getTimeLeft() {
		const now = new Date();

		// get current time in the target timezone
		const nowInTZ = new Date(now.toLocaleString('en-US', { timeZone: timezone }));

		// calculate next midnight in that timezone
		const midnight = new Date(nowInTZ);
		midnight.setHours(24, 0, 0, 0);

		const diff = midnight.getTime() - nowInTZ.getTime();

		const hours = Math.floor(diff / (1000 * 60 * 60));
		const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
		const seconds = Math.floor((diff % (1000 * 60)) / 1000);

		return { hours, minutes, seconds };
	}

	onDestroy(() => clearInterval(interval));
</script>

<div class="countdown-content inline sm">
	<p class="sm wrap">
		<!-- <span class="countdown-label">Next puzzle in&nbsp</span> -->
		<span class="timer-text">
			{timeLeft.hours.toString().padStart(2, '0')}:
			{timeLeft.minutes.toString().padStart(2, '0')}:
			{timeLeft.seconds.toString().padStart(2, '0')}
		</span>
	</p>
</div>

<style>
	.countdown-content {
		background: var(--lol-blue-4);
		border-radius: 4px;
		padding: 5px 10px;
		margin: 0 0.5rem;
	}

	.timer-text {
		font-family: monospace;
	}

	@media (max-width: 359px) {
		.countdown-content {
			padding: 5px 2px;
			margin: 0 0.2rem;
		}
		.timer-text {
			font-size: 0.5rem;
		}
	}

	@media (max-width: 399px) {
		.countdown-content {
			padding: 5px 5px;
		}
		.timer-text {
			font-size: 0.6rem;
		}
	}

	.wrap {
		height: 100%;
		margin: 0;
	}

	.countdown-label {
		line-height: 100%;
	}
</style>
