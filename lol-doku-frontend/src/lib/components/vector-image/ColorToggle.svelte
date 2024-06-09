<script lang="ts">
	export let fill = '#000000';
</script>

<div class="info-svg-container">
	<svg
		version="1.0"
		xmlns="http://www.w3.org/2000/svg"
		width="100%"
		height="100%"
		viewBox="0 0 32 32"
		preserveAspectRatio="xMidYMid meet"
		style={`--info-svg-fill:${fill}`}
	>
		<g id="layer1">
			<path
				id="path1"
				style="fill:var(--info-svg-fill);fill-opacity:1;stroke-width:0.264583"
				d="M 15.875,0 A 15.875,15.875 0 0 0 0,15.875 15.875,15.875 0 0 0 15.875,31.75 15.875,15.875 0 0 0 31.75,15.875 15.875,15.875 0 0 0 15.875,0 Z m 0,2.6458333 A 13.229167,13.229167 0 0 1 29.104167,15.875 13.229167,13.229167 0 0 1 15.875,29.104167 13.229167,13.229167 0 0 1 2.6458333,15.875 13.229167,13.229167 0 0 1 15.875,2.6458333 Z"
			/>
			<path
				id="path1-0"
				style="fill:var(--info-svg-fill);fill-opacity:1;stroke:none;stroke-width:1.19063;stroke-dasharray:none;stroke-opacity:1"
				d="m 15.875,3.96875 v 23.8125 A 11.90625,11.90625 0 0 0 27.78125,15.875 11.90625,11.90625 0 0 0 15.875,3.96875 Z"
			/>
		</g>
	</svg>
</div>

<style>
	.info-svg-container {
		height: 100%;
		width: 100%;
	}
	.info-svg-container * {
		fill: var(--info-svg-fill);
	}
</style>
