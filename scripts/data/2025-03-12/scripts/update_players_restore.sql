BEGIN;
-- Restore metadata --
DELETE FROM meta_dataupdate WHERE id in (SELECT id FROM meta_dataupdate WHERE app='players' ORDER BY date DESC LIMIT 1);
-- Removing all new alternate names --
DELETE FROM players_playeralternatename WHERE id in (SELECT id FROM players_playeralternatename WHERE (
));
-- Downdating players --

-- Removing new players --
DELETE FROM players_player WHERE display_name in (

);
COMMIT;