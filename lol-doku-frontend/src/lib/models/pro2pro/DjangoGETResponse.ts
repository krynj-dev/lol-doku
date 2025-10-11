export interface DjangoGETResponse<T> {
    count: number
	next: string
	previous: string
	results: T[]
}
