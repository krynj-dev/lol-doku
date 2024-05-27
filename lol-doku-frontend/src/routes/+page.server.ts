import { getOrCreateGameState, getOrCreateSession } from '$lib/server/api.js';
import { Cookies } from '@sveltejs/kit';
/** @type {import('./$types').PageLoad} */
/** @type {import('./$types').Actions} */

export async function load({ cookies }) {
  let session_id = getOrCreateSession(cookies);
  let game_state = await getOrCreateGameState(session_id, new Date());
  return { game_state: game_state };
}
