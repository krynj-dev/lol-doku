BEGIN;
-- Update metadata --
INSERT INTO meta_dataupdate (date, app) VALUES ('2025-03-13', 'players');
-- Adding new players --
INSERT INTO players_player (display_name, real_name, age, country, residency) VALUES
('Guns', 'Aymen Rahmani', NULL, 'Tunisia', 'EMEA');
-- Updating players --
UPDATE players_player SET age=23, display_name='Biob', residency='Asia Pacific' WHERE display_name='Bisbo';
UPDATE players_player SET display_name='Seebulabu', residency='Asia Pacific' WHERE display_name='Bunn';
UPDATE players_player SET display_name='Kuroko1' WHERE display_name='M1lo';
UPDATE players_player SET age=20, display_name='Zzeta', residency='Asia Pacific' WHERE display_name='Nogo';
UPDATE players_player SET age=20, display_name='Pain5' WHERE display_name='Pain (Lê Quốc Anh)';
UPDATE players_player SET display_name='Dipi', real_name='Tô Hoàng Đăng Phương', residency='Asia Pacific' WHERE display_name='Sanji (Tô Hoàng Đăng Phương)';
UPDATE players_player SET age=30, display_name='SERAPH', residency='Americas' WHERE display_name='Seraph';
UPDATE players_player SET age=21, display_name='TomRio', residency='Asia Pacific' WHERE display_name='Tomrio';
UPDATE players_player SET display_name='Vin (Trần Hoài Vinh)' WHERE display_name='VIN (Trần Hoài Vinh)';
-- Inserting all new alternate names --
INSERT INTO players_playeralternatename (alternate_name, player_name_id) VALUES
('Guns', (SELECT id FROM players_player WHERE display_name='Guns')),
('SERAPH', (SELECT id FROM players_player WHERE display_name='SERAPH')),
('TomRio', (SELECT id FROM players_player WHERE display_name='TomRio'));
COMMIT;