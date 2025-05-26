<script lang="ts">
    export let src: string;
    export let alt: string;
    let clazz = "";
    export { clazz as class };
    export let variant: 'cover' | 'scale-down' = 'scale-down';
</script>

<div class={`img-container ${clazz || ''}`}>
    <img class={`fitting-img ${variant}`} src={src} alt={alt} />
</div>

<style>
    .img-container {
        width: 100%;
        height: 100%;
		box-sizing: border-box;
		position: relative;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-content: center;
        overflow: hidden;
	}

	.fitting-img {
		display: block;
		min-width: 100%;
		min-height: 100%;
		overflow: hidden;
		box-sizing: border-box;
	}

    .cover {
        object-fit: cover;
    }

    .scale-down {
        object-fit: scale-down;
    }
</style>