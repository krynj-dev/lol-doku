import { Writable } from "svelte/store"

export interface Bucket {
    key: string
    max_size: number
    items: Writable<any[]>
    class: string
}