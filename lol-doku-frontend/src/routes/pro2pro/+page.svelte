<script lang="ts">
	import { run } from 'svelte/legacy';

	import Header from '$lib/components/Header.svelte';
	import Footer from '$lib/components/Footer.svelte';
	import { onMount } from 'svelte';
	import CurrentPlayerPortrait from '$lib/components/pro2pro/CurrentPlayerPortrait.svelte';
	import { get_player_image_src } from '$lib/shared/img';
	import { get_roster_by_name, get_roster_by_id, get_roster_links } from '$lib/shared/api';
	import {
	RosterLinkRole,
		type ReducedRosterLink,
		type Roster,
		type RosterLink,
		type RosterLinkPlayer
	} from '$lib/models/pro2pro/RosterLinks';
	import Tile from '$lib/components/common/Tile.svelte';
	import ColorToggle from '$lib/components/vector-image/ColorToggle.svelte';
	import FittingImage from '$lib/components/common/FittingImage.svelte';

	const tabs = ['Home', 'Puzzle Builder', 'Endless'];

	let current_tab = $state('Home');

	let roster_links;
	run(() => {
		roster_links = [] as RosterLink[];
	});
	let player_links;
	run(() => {
		player_links = [] as ReducedRosterLink[];
	});

	interface Guess {
		name: string;
		team: string;
		type: 'roster' | 'player';
	}

	let from: Guess = { name: 'Worlds 2024 Main Event', type: 'roster', team: 'G2 Esports' };
	let to: Guess = { name: 'TCL 2018 Winter', type: 'roster', team: 'Team AURORA' };

	let guess_stack;
	run(() => {
		guess_stack = [{ name: 'Worlds 2024 Main Event', type: 'roster', team: 'G2 Esports' }] as Guess[];
	});

	let player_key;
	run(() => {
		player_key = guess_stack.findLast((g) => g.type == 'player')?.name;
	});

	interface TournamentPlayer {
		player: string;
		roles: Set<string>;
	}

	interface MappedTournament {
		date: Date;
		tournament: string;
		team: string;
		link: string;
	}

	interface ButtonInfo {
		text: string;
		type: 'roster' | 'player';
		link: string;
		guess: Guess;
		image: string;
	}

	let button_handler = () => {
		if (guess_stack[0].team == 'G2 Esports') {
			guess_stack = [to]
		} else {
			guess_stack = [from]
		}
		refresh_data();
	}

	let role_image = (role: string) => {
		switch (role) {
			case 'Top':
				return 'top';
			case 'Jungle':
				return 'jungle';
			case 'Mid':
				return 'middle';
			case 'Bot':
				return 'bottom';
			case 'Support':
				return 'support';
			default:
				return 'middle';
		}
	}

	let map_player = (link: RosterLink): ButtonInfo => ({
		text: `${link.roster.tournament.name}`,
		type: 'roster',
		link: link.roster.url,
		guess: {
			name: link.roster.tournament.name,
			team: link.roster.team.team_name,
			type: 'roster'
		},
		image: link.roster.team.team_name
	});

	let map_roster = (link: ReducedRosterLink): ButtonInfo => ({
		text: `${link.player.display_name}`,
		type: 'player',
		link: link.link_url,
		guess: {
			name: link.player.display_name,
			team: '',
			type: 'player'
		},
		image: link.role
	});

	let refresh_data = () => {
		let recent = guess_stack[guess_stack.length - 1];
		switch (recent.type) {
			case 'player':
				get_roster_links(recent.name).then((res) => {
					console.log(res);
					roster_links = res.results;
					player_key = recent.name;
				});
				break;
			case 'roster':
				get_roster_by_name(recent.name, recent.team).then((res) => {
					console.log(res);
					player_links = res.results[0].players;
				});
				break;
			default:
				break;
		}
	};

	let clickHandler = (event: MouseEvent): void => {
		event.preventDefault();
		console.log('Button clicked!', event);
		console.log(event?.currentTarget?.dataset['link']);
		// Add to guesses
		if (event?.currentTarget?.dataset['guess']) {
			let guess: Guess = JSON.parse(event.currentTarget.dataset['guess']);
			guess_stack.push(guess);
			guess_stack = guess_stack;
			refresh_data();
		}
	};

	let pop_to = (i: number) => {
		console.log('popping to', i);
		while (guess_stack.length > i + 1) {
			guess_stack.pop();
		}
		console.log(guess_stack);
		guess_stack = guess_stack;
		refresh_data();
	};

	onMount(() => {
		console.log(`${import.meta.env.VITE_BACKEND_ENDPOINT}`);
		refresh_data();
	});
</script>

<Header {tabs} bind:selected={current_tab} />
<div class="content">
	<div class="puzzle-portrait-container">
		<Tile>
			<div class="player-portrait-container">
				<div class="player-portrait-image-container lol-border-small">
					<FittingImage src="img/teams/G2 Esports.webp" alt="G2 Esports" variant='scale-down' />
				</div>
				<div class="caption-container lol-border-small">
					<p class="h5 player-caption text-center">G2 Esports</p>
					<p class="h6 player-caption text-center">Worlds 2024 Main Event</p>
				</div>
			</div>
		</Tile>
		<button style="font-weight: bold" class="h2" onclick={button_handler}>→</button>
		<Tile>
			<div class="player-portrait-container">
				<div class="player-portrait-image-container lol-border-small">
					<FittingImage src="img/teams/Team AURORA.webp" alt="Team AURORA" variant='scale-down' />
				</div>
				<div class="caption-container lol-border-small">
					<p class="h5 player-caption text-center">Team AURORA</p>
					<p class="h6 player-caption text-center">TCL 2018 Winter</p>
				</div>
			</div>
		</Tile>
	</div>
	<div class="stack-container">
		{#each guess_stack as guess, i}
			<div class="stack-group">
				<button onclick={() => pop_to(i)} class="stack-button">
					<Tile variant={guess.type == 'player' ? 'dark' : 'light'}>
						<div class="stack-image">
							<FittingImage
								src={`img/${guess.type == 'player' ? 'players' : 'teams'}/${
									guess.type == 'player' ? guess.name : guess.team
								}.webp`}
								alt={guess.name}
								variant={guess.type == 'player' ? 'cover' : 'scale-down'}
							/>
						</div>
					</Tile>
				</button>
				<p style="font-weight: bold;">→</p>
			</div>
		{/each}
		<p class="stack-tile">{guess_stack[guess_stack.length - 1].name}</p>
	</div>
	{#if guess_stack[guess_stack.length - 1].type == 'player'}
		{#each roster_links.map(map_player) as link}
			<div class="roster-tile-container">
				<Tile>
					<button
						class="roster-tile-button"
						data-guess={JSON.stringify(link.guess)}
						data-link={link.link}
						onclick={clickHandler}
					>
						<Tile variant="light">
							<div class="roster-tile-image">
								<FittingImage src={`img/teams/${link.image}.webp`} alt="Fnatic logo" />
							</div>
						</Tile>
						<p style="text-align: center;" class="h4">{link.text}</p>
					</button>
				</Tile>
			</div>
		{/each}
	{:else if guess_stack[guess_stack.length - 1].type == 'roster'}
		{#each player_links.map(map_roster) as link}
			<div class="roster-tile-container">
				<Tile>
					<button
						class="roster-tile-button"
						data-guess={JSON.stringify(link.guess)}
						data-link={link.link}
						onclick={clickHandler}
					>
						<Tile variant="dark">
							<div class="roster-tile-image role-image">
								<FittingImage src={`img/roles/${role_image(link.image)}.svg`} alt="Fnatic logo" />
							</div>
						</Tile>
						<p style="text-align: center;" class="h4">{link.text}</p>
					</button>
				</Tile>
			</div>
		{/each}
	{/if}
</div>
<Footer />

<style>
	.role-image {
		padding: 2px;
	}

	.caption-container {
		padding: 2px;
		min-height: 4rem;
		display: flex;
		justify-content: center;
		flex-direction: column;
	}

	.player-portrait-image-container {
        width: 20vh;
		background-color: var(--lol-doku-white-1);
    }

	.player-portrait-container {
        display: grid;
        grid-template-rows: 20vh auto;
        padding: 4px;
		gap: 2px;
	}

	.content {
		width: 100vw;
		padding: 2rem 10vw;
		display: flex;
		flex-direction: column;
		align-items: center;
		box-sizing: border-box;
		justify-content: center;
		gap: 5px;
	}

	@media(min-width: 1200px){
		.content {
			padding: 2rem 20vw;
		}
	}

	.puzzle-portrait-container {
		display: flex;
		flex-direction: row;
		gap: 20px;
		justify-content: space-between;
		width: 100%;
		height: 100%;
		align-items: center;
		padding: 5px;
	}

	.stack-container {
		display: flex;
		flex-direction: row;
		flex-wrap: wrap;
		width: 100%;
		gap: 5px;
		align-items: center;
	}

	.stack-button {
		display: flex;
		flex-direction: row;
		align-items: center;
	}

	.stack-group {
		display: flex;
		flex-direction: row;
		gap: 5px;
		align-items: center;
	}

	.stack-tile {
		padding: 2px 5px;
	}

	.stack-image {
		width: 40px;
		height: 40px;
	}

	.roster-tile-container {
		width: 100%;
	}

	.roster-tile-image {
		width: 50px;
		height: 50px;
	}

	p {
		margin: 0;
	}

	.roster-tile-button {
		padding: 10px;
		display: flex;
		flex-direction: row;
		gap: 10px;
		width: 100%;
		align-items: center;
	}

	.roster-tile-button:hover {
		background-color: var(--lol-blue-6);
	}

	button {
		background: none;
		color: inherit;
		border: none;
		padding: 0;
		font: inherit;
		cursor: pointer;
		outline: inherit;
	}
</style>
