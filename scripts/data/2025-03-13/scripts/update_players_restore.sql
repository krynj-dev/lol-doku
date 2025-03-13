BEGIN;
-- Restore metadata --
DELETE FROM meta_dataupdate WHERE id in (SELECT id FROM meta_dataupdate WHERE app='players' ORDER BY date DESC LIMIT 1);
-- Removing all new alternate names --
DELETE FROM players_playeralternatename WHERE id in (SELECT id FROM players_playeralternatename WHERE (
(player_name_id=(SELECT id FROM players_player WHERE display_name='Guns') AND alternate_name IN ('Guns')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='SERAPH') AND alternate_name IN ('SERAPH')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='TomRio') AND alternate_name IN ('TomRio'))));
-- Downdating players --
UPDATE players_player SET age=22, display_name='Bisbo', residency='Vietnam' WHERE display_name='Biob';
UPDATE players_player SET display_name='Bunn', residency='Vietnam' WHERE display_name='Seebulabu';
UPDATE players_player SET display_name='M1lo' WHERE display_name='Kuroko1';
UPDATE players_player SET age=19, display_name='Nogo', residency='Vietnam' WHERE display_name='Zzeta';
UPDATE players_player SET age=19, display_name='Pain (Lê Quốc Anh)' WHERE display_name='Pain5';
UPDATE players_player SET display_name='Sanji (Tô Hoàng Đăng Phương)', real_name='', residency='Vietnam' WHERE display_name='Dipi';
UPDATE players_player SET age=29, display_name='Seraph', residency='Korea' WHERE display_name='SERAPH';
UPDATE players_player SET age=20, display_name='Tomrio', residency='Vietnam' WHERE display_name='TomRio';
UPDATE players_player SET display_name='VIN (Trần Hoài Vinh)' WHERE display_name='Vin (Trần Hoài Vinh)';
-- Removing new players --
DELETE FROM players_player WHERE display_name in (
'Guns'
);
COMMIT;