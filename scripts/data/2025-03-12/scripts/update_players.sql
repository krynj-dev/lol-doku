BEGIN;
-- Update metadata --
INSERT INTO meta_dataupdate (date, app) VALUES ('2025-03-12', 'players');
-- Adding new players --
INSERT INTO players_player (display_name, real_name, age, country, residency) VALUES
;
-- Updating players --

-- Inserting all new alternate names --
INSERT INTO players_playeralternatename (alternate_name, player_name_id) VALUES
;
COMMIT;