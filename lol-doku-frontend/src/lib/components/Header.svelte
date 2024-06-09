<script lang="ts">
	import { browser } from '$app/environment';
	import Modal from "./modal/Modal.svelte";
	import Info from './vector-image/Info.svelte';
	import Worlds from './vector-image/Worlds.svelte';

	export let tabs: string[];
	export let selected: string | undefined;
	
	let showModal = true;
	let dialog: HTMLDialogElement;

	function update_selected(e: Event) {
		e.preventDefault();
		if (e.target instanceof HTMLElement) {
			selected = e.target.dataset.tabName;
		}
	}

	$: {
		if (browser) {
			let welcome_seen = localStorage.getItem("welcome_seen");
			if (welcome_seen == null) {
				showModal = true;
				localStorage.setItem("welcome_seen", "1");
			}
		}
	}
</script>

<Modal bind:showModal bind:dialog size=600>
	<div class="info-modal">
		<h3>Welcome to LoLProGrid!</h3>
		<p>Fill the grid with professional LoL players who fit in the categories!</p>
		<p>Only games played in primary-level tournaments count towards a player's membership of a given category.<br>
		This includes typical premier tournaments such as LEC, LCS, LCK, LPL and all minor region equivalents as well as international events such as MSI, Worlds and even IEMs.<br>
		There are also some interesting inclusions such as Promotion tournaments and season open showmatches.</p>
		<p>All cells in the grid contain at least two correct answers.</p>
		<p>You get 10 guesses, that means one mulligan. Use it wisely!</p>
		<p>You <span class="strong">are</span> allowed to change your answers but it will cost you a guess to do so.</p>
		<p>Any one player is only allowed to be used in one cell. No repeats.</p>
		<hr />
		<h4>The following categories may appear:</h4>
		<ul class="category-list">
			<li>
				<h5>Team</h5><p class="rule-description">Any player who has played at least <span class="strong">one</span> game for the team.</p>
				<div class="example-rule-container">
					<div class="example-rule"><img src="img/teams/Fnatic.webp" alt="Fnatic"/><p class="example-rule-caption">Fnatic</p></div>
				</div>
			</li>
			<li>
				<h5>Teammate</h5><p class="rule-description">Any player who has been on the same roster as the specified player. This does <span  class="strong">not</span> include players listed as substitutes (if a sub played a match they're typically briefly listed as a main player and <span class="strong">do</span> count)</p>
				<div class="example-rule-container">
					<div class="example-rule"><img src="img/players/Faker.webp" alt="Faker"/><p class="example-rule-caption">Faker Teammate</p></div>
				</div>
			</li>
			<li>
				<h5>Role</h5><p class="rule-description">Any player who has recorded at least one game on the specified role.</p>
				<div class="example-rule-container">
					<div class="example-rule"><img src="img/roles/jungle.svg" alt="Jungle"/><p class="example-rule-caption">Jungle</p></div>
				</div>
			</li>
			<li>
				<h5>Champion</h5><p class="rule-description">Any player who has recorded 40 or more official games on the specified champion <span class="strong">or</span> any player who has at least 75 games on any one champion.</p>
				<div class="example-rule-container">
					<div class="example-rule"><img src="img/champion/Kassadin.png" alt="Kassadin"/><p class="example-rule-caption">Kassadin 40+</p></div>
				</div>
			</li>
			<li>
				<h5>Country</h5><p class="rule-description">Any player who's country of origin is the specified country. This is <span class="strong">not</span> the player's residency.</p>
				<div class="example-rule-container">
					<div class="example-rule"><img src="img/country/au.svg" alt="Australia"/><p class="example-rule-caption">Australia</p></div>
				</div>
			</li>
			<li>
				<h5>Tournament</h5><p class="rule-description">Any player who played at least one game in the specified tournament. For Worlds this only includes Group Stage onwards.</p>
				<div class="example-rule-container">
					<div class="example-rule"><Worlds fill="var(--lol-gold-1)"/><p class="example-rule-caption">Worlds 2015 Participant</p></div>
				</div>
			</li>
			<li>
				<h5>Finalist</h5><p class="rule-description">Any player who played in the final series of the specified tournament.</p>
				<div class="example-rule-container">
					<div class="example-rule"><Worlds fill="var(--lol-gold-1)"/><p class="example-rule-caption">Worlds Finalist</p></div>
				</div>
			</li>
		</ul>
	</div>
</Modal>
<nav class="header-container">
	<div class="header">
		<div class="site-title-container header-border">
			<div class="header-tab">
				<h2>LoLProGrid</h2>
			</div>
		</div>
		<div class="header-tabs-container header-border">
			<!-- {#each tabs as tab}
				<button tabindex="0" class="header-tab header-tab-hover" on:click={(e) => update_selected(e)} data-tab-name={tab}>{tab}</button>
			{/each} -->
		</div>
		<div class="thing-on-right header-border">
			<button class="info-button" on:click={() => showModal = true}><Info fill="var(--lol-gold-1)" /></button>
		</div>
	</div>
</nav>

<style>

	.header-container {
		display: block;
		padding: 0;
		height: 80px;
		color: var(--lol-gold-1);
		background-color: var(--lol-hextech-black);
		border-bottom: 2px solid var(--lol-gold-4);
		width: 100vw;
	}

	.header h2 {
		margin: 0;
	}

	.header {
		display: flex;
		align-items: center;
		justify-content: space-between;
		height: 80px;
		box-sizing: border-box;
		width: 100vw;
	}

	.header > * {
		height: 100%;
		box-sizing: border-box;
		padding: 5px;
		display: flex;
		align-items: center;
	}

	.header-tabs-container {
		flex-grow: 1;
		padding: 0;
	}

	.header-tab {
		background-color: transparent;
		border: 0;
		transition: background-color 0.2s;
		color: inherit;
		margin: 0;
		padding: 0 20px;
		height: 100%;
		display: flex;
		align-items: center;
		cursor: pointer;
	}

	.header-tab-hover:hover {
		background-color: var(--lol-grey-cool);
	}

	.header-border {
		border: 1px solid var(--lol-grey-1);
		border-bottom: 0;
	}

	.header-border:not(:last-child) {
		border-right: 0;
	}

	.thing-on-right {
		height: 100%;
		padding: 15px;
		box-sizing: border-box;
		display: flex;
		width: max-content;
	}

	.info-modal {
		padding: 0 15px;
		max-height: 60vh;
	}

	.info-modal h4 {
		color: var(--lol-gold-2);
	}

	.category-list {
		list-style-type: none;
		padding: 0;
	}

	.category-list > li {
		min-height: 80px;
		display: grid;
		align-items: center;
		grid-template-columns: 27% auto 15%;
		box-sizing: border-box;
	}

	.strong {
		font-weight: bold;
	}

	.category-list img {
		object-fit: contain;
		max-width: 100%;
		max-height: 100%;
	}

	.example-rule {
		display: grid;
		grid-template-rows: auto min-content;
		height: 100%;
		box-sizing: border-box;
		overflow: hidden;
		justify-content: center;
		padding: 5px;
	}

	.example-rule-container {
		padding: 5px 0;
		width: 100%;
		box-sizing: border-box;
	}

	.example-rule-caption {
		margin: 0;
		text-align: center;
		font-size: 0.8rem;
	}

	.rule-description {
		padding: 0 20px;
	}

	.info-button {
		height: 100%;
		background-color: inherit;
		border: 0;
		padding: 0;
		display: flex;
		box-sizing: border-box;
	}
	.info-button:hover {
		background-color: inherit;
		cursor: pointer;
	}

	.info-button-image {
		max-width: 100%;
		max-height: 100%;
		object-fit: scale-down;
		box-sizing: border-box;
	}
</style>
