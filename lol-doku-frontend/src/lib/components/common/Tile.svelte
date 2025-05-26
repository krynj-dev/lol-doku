<script lang="ts">
    export let variant: 'light' | 'dark' = 'dark';
    let clazz: string = '';
    export { clazz as class };
</script>

<div class="tile-container lol-border {variant} {clazz}">
    <slot />
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