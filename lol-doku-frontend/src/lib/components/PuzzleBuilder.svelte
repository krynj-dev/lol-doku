<script lang="ts">
	import { get_key_letters, read_rules } from '$lib/shared/puzzle_util';
	import { onMount } from 'svelte';
	import { flip } from 'svelte/animate';
	import _rules_letters from '$lib/data/rule_type_letters.json';
	import type { Rule } from '$lib/models/Rule';

	let tile_size = '150px';
	const rules_letters = _rules_letters as {
		[key: string]: string[];
	};

	const ruleTypes = [
		['Team', 'team'],
		['Player Teammate', 'teammate'],
		['Games on Champion', 'champion'],
		['Role', 'role']
	];
	let selected_type: string = 'team';
	let selected_letter: string = 'A';
	let visible_rules: Rule[] = [];
	let visible_letters: string[] = [];

	let baskets: { name: string; items: Rule[] }[] = [
		{
			name: 'Row 1',
			items: []
		},
		{
			name: 'Row 2',
			items: []
		},
		{
			name: 'Row 3',
			items: []
		},
		{
			name: 'Column 1',
			items: []
		},
		{
			name: 'Column 2',
			items: []
		},
		{
			name: 'Column 3',
			items: []
		},
		{
			name: 'Rules',
			items: []
		}
	];

	let hoveringOverBasket: string | null;

	function update_visible_rules(rules: any[]) {
		let filtered_rules: Rule[] = rules.filter((r) => {
			return (
				(r.valid_crosses.Primary.some((c: string) => {
					return baskets
						.slice(0, 3)
						.flatMap((e) => e.items)
						.some((i) => i.key == c);
				}) ||
					r.valid_crosses.Primary.some((c: string) => {
						return baskets
							.slice(3, 6)
							.flatMap((e) => e.items)
							.some((i) => i.key == c);
					})) &&
				!baskets
					.slice(0, 6)
					.flatMap((e) => e.items)
					.includes(r.key)
			);
		});
		if (baskets.slice(0, 6).flatMap((e) => e.items).length == 0) {
			filtered_rules = rules;
		}
		visible_rules = filtered_rules;
		baskets[6].items = filtered_rules;
		baskets = baskets;
	}

	function dragStart(event: DragEvent, basketIndex: number, itemIndex: number) {
		// The data we want to make available when the element is dropped
		// is the index of the item being dragged and
		// the index of the basket from which it is leaving.
		const data = { basketIndex, itemIndex };
		if (event.dataTransfer) {
			event.dataTransfer.setData('text/plain', JSON.stringify(data));
		}
	}

	function drop(event: DragEvent, basketIndex: number) {
		event.preventDefault();
		if (event.dataTransfer) {
			const json = event.dataTransfer.getData('text/plain');
			const data = JSON.parse(json);

			// Remove the item from one basket.
			// Splice returns an array of the deleted elements, just one in this case.
			let item: Rule;
			if (data.basketIndex < 6) {
				[item] = baskets[data.basketIndex].items.splice(data.itemIndex, 1);
			} else {
				item = baskets[data.basketIndex].items[data.itemIndex];
			}

			console.log(item);

			// Add the item to the drop target basket.
			if (basketIndex < 6) {
				baskets[basketIndex].items = [item];
			}

			update_visible_rules(visible_rules);
			console.log(baskets);
			baskets = baskets;
			hoveringOverBasket = null;
		}
	}

	function update_visible_letters(rule_type: string) {
		let all_letters = get_key_letters();
	}

	function get_valid_players(a: Rule | undefined, b: Rule | undefined): string[] {
		if (!a && !b) {
			return [];
		} else if (!a && b) {
			return Array.from(b.valid_players.Primary);
		} else if (!b && a) {
			return Array.from(a.valid_players.Primary);
		}

		if (a && b) {
			let set_a: Set<string> = new Set(a.valid_players.Primary);
			let set_b: Set<string> = new Set(b.valid_players.Primary);
			return Array.from(set_a.intersection(set_b));
		}
	}

	function handleTypeClick(e: MouseEvent) {
		e.preventDefault();
		if (e.target instanceof HTMLElement && e.target.dataset.tabType) {
			let type = e.target.dataset.tabType;
			read_rules(selected_letter)
				.then((res) => {
					update_visible_rules(Object.values(res).filter((r) => r.type == type));
					selected_type = type;
				})
				.catch((e) => {
					console.error(e);
				});
			visible_letters = rules_letters[type].map((c) => c.toLocaleUpperCase());
		}
	}

	function handleLetterClick(e: MouseEvent) {
		e.preventDefault();
		if (e.target instanceof HTMLElement && e.target.dataset.tabLetter) {
			let letter = e.target.dataset.tabLetter;
			read_rules(letter)
				.then((res) => {
					update_visible_rules(Object.values(res).filter((r) => r.type == selected_type));
					selected_letter = letter;
				})
				.catch((e) => {
					console.error(e);
				});
			visible_letters = rules_letters[selected_type].map((c) => c.toLocaleUpperCase());
		}
	}

	onMount(() => {
		read_rules(selected_letter)
			.then((res) => {
				console.log(res);
				update_visible_rules(Object.values(res).filter((r) => r.type == selected_type));
			})
			.catch((e) => {
				console.error(e);
			});
		visible_letters = rules_letters[selected_type].map((c) => c.toLocaleUpperCase());
	});
</script>

<div class="puzzle-builder">
	<div class="puzzle-builder-grid" style="--tile-size: {tile_size}">
		<div class="rule-tile">corner</div>
		<div class="column-span">
			{#each baskets.slice(3, 6) as basket, basketIndex (basket)}
				<div animate:flip class="rule-tile">
					<div
						class="rule-tile-container"
						class:hovering={hoveringOverBasket === basket.name}
						on:dragenter={() => (hoveringOverBasket = basket.name)}
						on:dragleave={() => (hoveringOverBasket = null)}
						on:drop={(event) => drop(event, basketIndex + 3)}
						on:dragover={(e) => e.preventDefault()}
						role="gridcell"
						tabindex="0"
					>
						{#each basket.items as item, itemIndex (item)}
							<div class="item" animate:flip>
								<div
									class="rule-tile-item"
									draggable={true}
									on:dragstart={(event) => dragStart(event, basketIndex + 3, itemIndex)}
									role="listitem"
								>
									<span class="rule-name">{item.key}</span>
								</div>
							</div>
						{/each}
					</div>
				</div>
			{/each}
		</div>
		<div class="row-span">
			{#each baskets.slice(0, 3) as basket, basketIndex (basket)}
				<div animate:flip class="rule-tile">
					<div
						class="rule-tile-container"
						class:hovering={hoveringOverBasket === basket.name}
						on:dragenter={() => (hoveringOverBasket = basket.name)}
						on:dragleave={() => (hoveringOverBasket = null)}
						on:drop={(event) => drop(event, basketIndex)}
						on:dragover={(e) => e.preventDefault()}
						role="gridcell"
						tabindex="0"
					>
						{#each basket.items as item, itemIndex (item)}
							<div class="item" animate:flip>
								<div
									class="rule-tile-item"
									draggable={true}
									on:dragstart={(event) => dragStart(event, basketIndex, itemIndex)}
									role="listitem"
								>
									<span class="rule-name">{item.key}</span>
								</div>
							</div>
						{/each}
					</div>
				</div>
			{/each}
		</div>
		<div class="player-grid">
			{#each [0, 1, 2] as i}
				{#each [0, 1, 2] as j}
					<div class="player-tile">
						<ul>
							{#if baskets[i].items.length > 0 && baskets[3 + j].items.length > 0}
								{#each get_valid_players(baskets[i].items[0], baskets[3 + j].items[0]) as valid_player}
									<li>{valid_player}</li>
								{/each}
							{:else if baskets[i].items.length > 0 && baskets[3 + j].items.length == 0}
								{#each get_valid_players(baskets[i].items[0], undefined) as valid_player}
									<li>{valid_player}</li>
								{/each}
							{:else if baskets[i].items.length == 0 && baskets[3 + j].items.length > 0}
								{#each get_valid_players(baskets[3 + j].items[0], undefined) as valid_player}
									<li>{valid_player}</li>
								{/each}
							{:else}
								<li></li>
							{/if}
						</ul>
					</div>
				{/each}
			{/each}
		</div>
	</div>
	<div class="rule-selector">
		<div class="rule-tab-type">
			{#each ruleTypes as rule_type}
				<button tabindex="0" data-tab-type={rule_type[1]} on:click={handleTypeClick}
					>{rule_type[0]}</button
				>
			{/each}
		</div>
		<div class="rule-tab-letter">
			{#each visible_letters.sort() as letter}
				<button tabindex="0" data-tab-letter={letter} on:click={handleLetterClick}>{letter}</button>
			{/each}
		</div>
		<div class="rule-tab-rules">
			{#if visible_rules}
				<div
					class="rule-tab-rules-inner"
					class:hovering={hoveringOverBasket === baskets[6].name}
					on:dragenter={() => (hoveringOverBasket = baskets[6].name)}
					on:dragleave={() => (hoveringOverBasket = null)}
					on:drop={(event) => drop(event, 6)}
					on:dragover={(e) => e.preventDefault()}
					role="listitem"
				>
					{#each visible_rules as rule, ruleIndex (rule)}
						<div class="item" animate:flip>
							<div
								role="listitem"
								class="rule-tile-item"
								draggable={true}
								on:dragstart={(event) => dragStart(event, 6, ruleIndex)}
							>
								<span class="rule-name">{rule.key}</span>
							</div>
						</div>
					{/each}
				</div>
			{/if}
		</div>
	</div>
</div>

<style>
	.hovering {
		border-color: orange;
	}
	.item {
		display: inline; /* required for flip to work */
	}
	.rule-tile-item {
		background-color: lightgray;
		cursor: pointer;
		display: inline-block;
		margin: 10px;
		padding: 10px;
		max-width: 100%;
		text-wrap: wrap;
		text-align: center;
	}
	.rule-tile-item:hover {
		background: orange;
		color: white;
	}
	.rule-tile-container {
		border: solid lightgray 1px;
		display: flex; /* required for drag & drop to work when .item display is inline */
		width: calc(var(--tile-size) * 0.8);
		height: calc(var(--tile-size) * 0.8);
		justify-content: center;
		align-items: center;
	}

	.puzzle-builder {
		display: flex;
		height: calc(var(--tile-size) * 5);
	}

	.puzzle-builder-grid {
		display: grid;
		gap: 1px;
		margin: auto;
		width: calc(var(--tile-size) * 5);
		grid-template-columns: repeat(5, var(--tile-size));
		grid-template-rows: repeat(5, var(--tile-size));
	}

	.rule-selector {
		display: flex;
		flex-direction: column;
		max-height: calc(var(--tile-size) * 5);
		overflow: hidden;
		gap: 10px;
	}

	.column-span {
		grid-column-end: span 3;
		display: grid;
		grid-template-columns: repeat(3, minmax(0px, 1fr));
		gap: 1px;
		border-radius: 15px;
		overflow: hidden;
	}

	.row-span {
		grid-column-start: 1;
		grid-row-end: span 3;
		display: grid;
		grid-template-rows: repeat(3, minmax(0px, 1fr));
		gap: 2px;
		border-radius: 15px;
		overflow: hidden;
	}

	.player-grid {
		display: grid;
		grid-area: span 3 / span 3 / span 3 / span 3;
		grid-template-columns: repeat(3, minmax(0px, 1fr));
		grid-template-rows: repeat(3, minmax(0px, 1fr));
		gap: 2px;
		border-radius: 15px;
		overflow: hidden;
	}

	.player-tile {
		display: flex;
		align-items: center;
		justify-content: center;
		overflow-y: hidden;
		background-color: gainsboro;
	}

	.player-tile > ul {
		overflow-y: scroll;
		overflow-x: hidden;
		height: 100%;
		width: 100%;
	}

	.player-tile span {
		padding: 1rem;
	}

	.rule-tile {
		display: flex;
		align-items: center;
		justify-content: center;
		max-height: var(--tile-size);
		max-width: var(--tile-size);
	}

	.rule-name {
		font-size: 0.8em;
	}

	.rule-tab-type {
		display: flex;
		border-bottom: 1px black solid;
	}

	.rule-tab-type > button {
		font-size: 16pt;
		padding: 10px 10px 2px 10px;
		border: none;
		background-color: transparent;
	}
	.rule-tab-type > button:hover {
		background-color: antiquewhite;
	}

	.rule-tab-letter {
		display: flex;
		flex-wrap: wrap;
		border-bottom: 1px black solid;
	}

	.rule-tab-letter > button {
		font-size: 11pt;
		padding: 10px 10px 2px 10px;
		border: none;
		background-color: transparent;
	}
	.rule-tab-letter > button:hover {
		background-color: antiquewhite;
	}

	.rule-tab-rules-inner {
		overflow-y: scroll;
		height: 70vh;
	}
</style>
