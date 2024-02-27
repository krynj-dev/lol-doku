<script lang="ts">
	console.log('loaded header');
</script>

<nav class="header-container">
	<div class="flex header">
		<div class="inline-flex site-title-container">
			<span>LolDoku</span>
		</div>
		<div class="inline-flex thing-on-right">
			RIGHT TEXT
		</div>
	</div>
</nav>

<style>
	.header-container {
		display: block;
		padding: 0;
		height: 4rem;
		background-color: #c6c6c6;
		box-shadow: 0 0 2px 2px #555;
	}

	.flex {
		display: flex;
	}

	.inline-flex {
		display: inline-flex;
	}

	.header {
		justify-content: space-between;
		align-items: center;
		align-content: center;
		height: 100%;
		padding: 0 2rem;
	}

	.site-title-container {
		padding: 0.5rem;
	}

	.thing-on-right {
		padding: 0.5rem;
	}
</style>
