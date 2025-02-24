BEGIN;
DELETE FROM teams_teamsisterteam WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Team Secret Whales') AND sister_team_name='Team Whales';
DELETE FROM teams_teamsisterteam WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Team Secret Whales') AND sister_team_name='Team Secret Whales';
DELETE FROM teams_teamsisterteam WHERE team_op_id=(SELECT id FROM teams_team WHERE op='LYON (2024 American Team)') AND sister_team_name='Lyon Gaming (2013 Latin American Team)';
DELETE FROM teams_teamsisterteam WHERE team_op_id=(SELECT id FROM teams_team WHERE op='LYON (2024 American Team)') AND sister_team_name='LYON (2024 American Team)';
DELETE FROM teams_teamsisterteam WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Isurus Estral') AND sister_team_name='Isurus';
DELETE FROM teams_teamsisterteam WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Vivo Keyd Stars') AND sister_team_name='Keyd Warriors';
DELETE FROM teams_teamsisterteam WHERE team_op_id=(SELECT id FROM teams_team WHERE op='TALON (Hong Kong Team)') AND sister_team_name='TALON (Hong Kong Team)';
DELETE FROM teams_teamsisterteam WHERE team_op_id=(SELECT id FROM teams_team WHERE op='NASR eSports Turkey') AND sister_team_name='Royal Youth';
DELETE FROM teams_teamsisterteam WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Movistar KOI') AND sister_team_name='Movistar KOI';
DELETE FROM teams_teamsisterteam WHERE team_op_id=(SELECT id FROM teams_team WHERE op='DN Freecs') AND sister_team_name='DN Freecs';
DELETE FROM teams_teamsisterteam WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Kaos Latin Gamers') AND sister_team_name='Azules Esports';
DELETE FROM teams_teamsisterteam WHERE team_op_id=(SELECT id FROM teams_team WHERE op='BNK FEARX') AND sister_team_name='BNK FEARX';
DELETE FROM teams_teamsisterteam WHERE team_op_id=(SELECT id FROM teams_team WHERE op='FENNEL') AND sister_team_name='Rascal Jester';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Team Secret Whales') AND alternate_name='Cherry Esports';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Team Secret Whales') AND alternate_name='Team Whales';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Team Secret Whales') AND alternate_name='Luxury Esports';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Team Secret Whales') AND alternate_name='GMedia Luxury';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Team Secret Whales') AND alternate_name='Team Secret Whales';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='LYON (2024 American Team)') AND alternate_name='Six Karma';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='LYON (2024 American Team)') AND alternate_name='LYON (2024 American Team)';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='LYON (2024 American Team)') AND alternate_name='Movistar R7';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='LYON (2024 American Team)') AND alternate_name='Rainbow7';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Isurus Estral') AND alternate_name='Isurus';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Isurus Estral') AND alternate_name='Isurus Estral';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='West Point Esports Philippines') AND alternate_name='SEM9';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='West Point Esports Philippines') AND alternate_name='SEM9 WPE';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Vivo Keyd Stars') AND alternate_name='Keyd Stars';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Vivo Keyd Stars') AND alternate_name='Vivo Keyd';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Vivo Keyd Stars') AND alternate_name='Keyd Warriors';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='MGN Vikings Esports') AND alternate_name='MGN Vikings Esports';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Team Ultra Vires') AND alternate_name='GamingGear.eu';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Team Liquid') AND alternate_name='Team Curse';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='TALON (Hong Kong Team)') AND alternate_name='TALON (Hong Kong Team)';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='NASR eSports Turkey') AND alternate_name='Royal Bandits';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='NASR eSports Turkey') AND alternate_name='Royal Youth';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Movistar KOI') AND alternate_name='Movistar KOI';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Lowkey Esports.Vietnam') AND alternate_name='Friends Forever Gaming';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Los Grandes') AND alternate_name='Team oNe eSports';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Liyab Esports') AND alternate_name='Mineski';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='DN Freecs') AND alternate_name='DN Freecs';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Kaos Latin Gamers') AND alternate_name='Azules Esports';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Gravity (North American Team)') AND alternate_name='Curse Academy';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Fluxo W7M') AND alternate_name='Fluxo W7M';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='BNK FEARX') AND alternate_name='BNK FEARX';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='FENNEL') AND alternate_name='Rascal Jester';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Bren Esports') AND alternate_name='ISC Pro Team';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Axis Empire') AND alternate_name='Team Empire';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Axis Empire') AND alternate_name='Team Empire (Malaysian Team)';
DELETE FROM teams_teamalternatename WHERE team_op_id=(SELECT id FROM teams_team WHERE op='Disguised') AND alternate_name='Disguised';
INSERT INTO teams_team (id, becomes, came_from, highest_level, image, name, op, region, short) VALUES(45, NULL, NULL, 'Primary', 'Azules Esportslogo square.png', 'Azules Esports', 'Azules Esports', 'Latin America' ,'UCH'),
(92, NULL, NULL, 'Primary', 'Curse_Academy.png', 'Curse Academy', 'Curse Academy', 'North America' ,'CA'),
(175, NULL, NULL, 'Primary', 'Friends Forever Gaminglogo profile.png', 'Friends Forever Gaming', 'Friends Forever Gaming', 'Vietnam' ,'FFQ'),
(195, NULL, NULL, 'Primary', 'GamingGear.eu.jpg', 'Gaminggear.EU', 'GamingGear.eu', 'CIS' ,'GG.EU'),
(234, NULL, NULL, 'Primary', 'ISC Pro Teamlogo square.png', 'ISC Pro Team', 'ISC Pro Team', 'SEA' ,'ISC'),
(319, NULL, NULL, 'Primary', 'Mineski logo.png', 'Mineski', 'Mineski', 'SEA' ,'MSK'),
(394, NULL, 'PeachServer Allstars', 'Primary', 'Rascal Jesterlogo profile.png', 'Rascal Jester', 'Rascal Jester', 'Japan' ,'RJ'),
(413, NULL, 'Royal Bandits', 'Primary', 'Royal Youthlogo square.png', 'Royal Youth', 'Royal Youth', 'Turkey' ,'RYL'),
(416, NULL, NULL, 'Primary', 'SEM9logo profile.png', 'SEM9', 'SEM9', 'PCS' ,'S9'),
(417, NULL, NULL, 'Primary', 'SEM9 WPElogo square.png', 'SEM9 WPE', 'SEM9 WPE', 'PCS' ,'S9W'),
(477, NULL, NULL, 'Primary', 'TeamCurseLogo2014.png', 'Team Curse', 'Team Curse', 'North America' ,'CRS'),
(484, NULL, NULL, 'Primary', 'Team Empire (Malaysian Team)logo square.png', 'Team Empire', 'Team Empire (Malaysian Team)', 'SEA' ,'EMP'),
(538, NULL, NULL, 'Primary', 'Team oNe eSportslogo square.png', 'Team oNe eSports', 'Team oNe eSports', 'Brazil' ,'ONE'),
(585, NULL, 'Keyd Stars', 'Primary', 'Vivo Keydlogo square.png', 'Vivo Keyd', 'Vivo Keyd', 'Brazil' ,'VK'),
(251, NULL, NULL, 'Primary', 'Isuruslogo profile.png', 'Isurus', 'Isurus', 'Latin America' ,'ISG'),
(323, NULL, 'Rainbow7', 'Primary', 'Movistar R7logo square.png', 'Movistar R7', 'Movistar R7', 'Latin America' ,'R7'),
(445, NULL, NULL, 'Primary', 'Six Karmalogo square.png', 'Six Karma', 'Six Karma', 'Latin America' ,'6K'),
(532, NULL, 'Luxury Esports', 'Primary', 'Team Whaleslogo profile.png', 'Team Whales', 'Team Whales', 'Vietnam' ,'TW');
INSERT INTO teams_teamsisterteam (sister_team_name, team_op_id) VALUES ('Team Whales', (SELECT id FROM teams_team WHERE op='Team Whales'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Cherry Esports', (SELECT id FROM teams_team WHERE op='Team Whales'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Team Whales', (SELECT id FROM teams_team WHERE op='Team Whales'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('GMedia Luxury', (SELECT id FROM teams_team WHERE op='Team Whales'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Luxury Esports', (SELECT id FROM teams_team WHERE op='Team Whales'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Six Karma', (SELECT id FROM teams_team WHERE op='Six Karma'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Rainbow7', (SELECT id FROM teams_team WHERE op='Movistar R7'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Movistar R7', (SELECT id FROM teams_team WHERE op='Movistar R7'));
INSERT INTO teams_teamsisterteam (sister_team_name, team_op_id) VALUES ('Isurus', (SELECT id FROM teams_team WHERE op='Isurus'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Isurus', (SELECT id FROM teams_team WHERE op='Isurus'));
INSERT INTO teams_teamsisterteam (sister_team_name, team_op_id) VALUES ('Keyd Warriors', (SELECT id FROM teams_team WHERE op='Vivo Keyd'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Keyd Stars', (SELECT id FROM teams_team WHERE op='Vivo Keyd'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Vivo Keyd', (SELECT id FROM teams_team WHERE op='Vivo Keyd'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Keyd Warriors', (SELECT id FROM teams_team WHERE op='Vivo Keyd'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Team oNe eSports', (SELECT id FROM teams_team WHERE op='Team oNe eSports'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Team Empire', (SELECT id FROM teams_team WHERE op='Team Empire (Malaysian Team)'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Team Empire (Malaysian Team)', (SELECT id FROM teams_team WHERE op='Team Empire (Malaysian Team)'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Team Curse', (SELECT id FROM teams_team WHERE op='Team Curse'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('SEM9 WPE', (SELECT id FROM teams_team WHERE op='SEM9 WPE'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('SEM9', (SELECT id FROM teams_team WHERE op='SEM9'));
INSERT INTO teams_teamsisterteam (sister_team_name, team_op_id) VALUES ('Royal Youth', (SELECT id FROM teams_team WHERE op='Royal Youth'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Royal Bandits', (SELECT id FROM teams_team WHERE op='Royal Youth'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Royal Youth', (SELECT id FROM teams_team WHERE op='Royal Youth'));
INSERT INTO teams_teamsisterteam (sister_team_name, team_op_id) VALUES ('Rascal Jester', (SELECT id FROM teams_team WHERE op='Rascal Jester'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Rascal Jester', (SELECT id FROM teams_team WHERE op='Rascal Jester'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Mineski', (SELECT id FROM teams_team WHERE op='Mineski'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('ISC Pro Team', (SELECT id FROM teams_team WHERE op='ISC Pro Team'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('GamingGear.eu', (SELECT id FROM teams_team WHERE op='GamingGear.eu'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Friends Forever Gaming', (SELECT id FROM teams_team WHERE op='Friends Forever Gaming'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Curse Academy', (SELECT id FROM teams_team WHERE op='Curse Academy'));
INSERT INTO teams_teamsisterteam (sister_team_name, team_op_id) VALUES ('Azules Esports', (SELECT id FROM teams_team WHERE op='Azules Esports'));
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES ('Azules Esports', (SELECT id FROM teams_team WHERE op='Azules Esports'));
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Team Secret (Vietnamese Team)logo profile.png', name='Team Secret', op='Team Secret (Vietnamese Team)', region='Vietnam', short='TS' WHERE op='Team Secret Whales';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Lyon Gaming logo new.png', name='Lyon Gaming', op='Lyon Gaming (2013 Latin American Team)', region='LAN', short='LYN' WHERE op='LYON (2024 American Team)';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Estral Esportslogo profile.png', name='Estral Esports', op='Estral Esports', region='Latin America', short='EST' WHERE op='Isurus Estral';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='West Point Esports Philippineslogo square.png', name='West Point Esports', op='West Point Esports Philippines', region='PCS', short='WP' WHERE op='West Point Esports Philippines';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Vivo Keyd Starslogo profile.png', name='Vivo Keyd Stars', op='Vivo Keyd Stars', region='Brazil', short='VKS' WHERE op='Vivo Keyd Stars';
UPDATE teams_team SET becomes=NULL, came_from='Saigon Buffalo', highest_level='Primary', image='Vikings Esports (2023 Vietnamese Team)logo profile.png', name='Vikings Esports', op='Vikings Esports (2023 Vietnamese Team)', region='Vietnam', short='VKE' WHERE op='MGN Vikings Esports';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='UltraVires.jpg', name='Team Ultra Vires', op='Team Ultra Vires', region='Europe', short='TUV' WHERE op='Team Ultra Vires';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Team Liquidlogo profile.png', name='Team Liquid', op='Team Liquid', region='North America', short='TL' WHERE op='Team Liquid';
UPDATE teams_team SET becomes=NULL, came_from='Talon Esports', highest_level='Primary', image='PSG Talonlogo profile.png', name='PSG Talon', op='PSG Talon', region='Asia Pacific', short='PSG' WHERE op='TALON (Hong Kong Team)';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='NASR ESPORTSlogo profile.png', name='NASR eSports Turkey', op='NASR eSports Turkey', region='EMEA', short='NASR' WHERE op='NASR eSports Turkey';
UPDATE teams_team SET becomes=NULL, came_from='MAD Lions', highest_level='Primary', image='MAD Lions KOIlogo square.png', name='MAD Lions KOI', op='MAD Lions KOI', region='EMEA', short='MDK' WHERE op='Movistar KOI';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Lowkey Esports.Vietnamlogo square.png', name='Lowkey Esports.Vietnam', op='Lowkey Esports.Vietnam', region='Vietnam', short='LK' WHERE op='Lowkey Esports.Vietnam';
UPDATE teams_team SET becomes=NULL, came_from='Flamengo Los Grandes', highest_level='Primary', image='Los Grandeslogo square.png', name='Los Grandes', op='Los Grandes', region='Brazil', short='LOS' WHERE op='Los Grandes';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Liyab Esportslogo square.png', name='Liyab Esports', op='Liyab Esports', region='PCS', short='LYB' WHERE op='Liyab Esports';
UPDATE teams_team SET becomes=NULL, came_from='Afreeca Freecs', highest_level='Primary', image='Kwangdong Freecslogo profile.png', name='Kwangdong Freecs', op='Kwangdong Freecs', region='Korea', short='KDF' WHERE op='DN Freecs';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Kaos Latin Gamerslogo profile.png', name='Kaos Latin Gamers', op='Kaos Latin Gamers', region='Latin America', short='KLG' WHERE op='Kaos Latin Gamers';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Gravity Logo.png', name='Gravity', op='Gravity (North American Team)', region='North America', short='GV' WHERE op='Gravity (North American Team)';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Fluxologo square.png', name='Fluxo', op='Fluxo', region='Brazil', short='FX' WHERE op='Fluxo W7M';
UPDATE teams_team SET becomes=NULL, came_from='Liiv SANDBOX', highest_level='Primary', image='FearXlogo profile.png', name='FearX', op='FearX', region='Korea', short='FOX' WHERE op='BNK FEARX';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='FENNELlogo profile.png', name='FENNEL', op='FENNEL', region='PCS', short='FL' WHERE op='FENNEL';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Bren Esportslogo square.png', name='Bren Esports', op='Bren Esports', region='SEA', short='BRE' WHERE op='Bren Esports';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Axis Empirelogo square.png', name='Axis Empire', op='Axis Empire', region='SEA', short='AXE' WHERE op='Axis Empire';
DELETE FROM teams_team WHERE op='Disguised';
SELECT setval('teams_team_id_seq', 610, true);
DELETE FROM meta_dataupdate WHERE id in (SELECT id FROM meta_dataupdate WHERE app='teams' ORDER BY date DESC LIMIT 1);
COMMIT;