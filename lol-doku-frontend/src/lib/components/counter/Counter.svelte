<script lang="ts">

    let counter_interval: number | undefined;

    export function start() {
        console.log("starting");
        base_date = new Date();
        if (!counter_interval) {
            counter_interval = setInterval(() => {
                cur_time = (new Date()).getSeconds() - base_date.getSeconds();
            }, 100);
        }
    }

    export function stop() {
        if (counter_interval) {
            clearInterval(counter_interval);
            console.log("cleared interval", counter_interval);
            counter_interval = undefined;
        }
    }

    let base_date: Date;
    let cur_time = 0;
    
</script>

<div>
    <p>{cur_time}</p>
</div>

<style>
    p {
        text-align: center;
    }
</style>