BEGIN;
INSERT INTO teams_team (becomes, came_from, highest_level, image, name, op, region, short) VALUES
(NULL, NULL, 'Primary', 'Disguisedlogo profile.png', 'Disguised', 'Disguised', 'Americas' ,'DSG');
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Axis Empirelogo square.png', name='Axis Empire', op='Axis Empire', region='SEA', short='AXE' WHERE op='Axis Empire';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Bren Esportslogo square.png', name='Bren Esports', op='Bren Esports', region='SEA', short='BRE' WHERE op='Bren Esports';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='FENNELlogo profile.png', name='FENNEL', op='FENNEL', region='Asia Pacific', short='FL' WHERE op='FENNEL';
UPDATE teams_team SET becomes=NULL, came_from='FearX', highest_level='Primary', image='BNK FEARXlogo profile.png', name='BNK FEARX', op='BNK FEARX', region='Korea', short='BFX' WHERE op='FearX';
UPDATE teams_team SET becomes=NULL, came_from='Fluxo', highest_level='Primary', image='Fluxo W7Mlogo square.png', name='Fluxo W7M', op='Fluxo W7M', region='Americas', short='FX7M' WHERE op='Fluxo';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Gravity Logo.png', name='Gravity', op='Gravity (North American Team)', region='North America', short='GV' WHERE op='Gravity (North American Team)';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Kaos Latin Gamerslogo profile.png', name='Kaos Latin Gamers', op='Kaos Latin Gamers', region='Latin America', short='KLG' WHERE op='Kaos Latin Gamers';
UPDATE teams_team SET becomes=NULL, came_from='Kwangdong Freecs', highest_level='Primary', image='DN Freecslogo profile.png', name='DN Freecs', op='DN Freecs', region='Korea', short='DNF' WHERE op='Kwangdong Freecs';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Liyab Esportslogo square.png', name='Liyab Esports', op='Liyab Esports', region='Asia Pacific', short='LYB' WHERE op='Liyab Esports';
UPDATE teams_team SET becomes=NULL, came_from='Flamengo Los Grandes', highest_level='Primary', image='Los Grandeslogo square.png', name='Los Grandes', op='Los Grandes', region='Americas', short='LOS' WHERE op='Los Grandes';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Lowkey Esports.Vietnamlogo square.png', name='Lowkey Esports.Vietnam', op='Lowkey Esports.Vietnam', region='Vietnam', short='LK' WHERE op='Lowkey Esports.Vietnam';
UPDATE teams_team SET becomes=NULL, came_from='MAD Lions KOI', highest_level='Primary', image='Movistar KOIlogo square.png', name='Movistar KOI', op='Movistar KOI', region='EMEA', short='MKOI' WHERE op='MAD Lions KOI';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='NASR ESPORTSlogo profile.png', name='NASR eSports Turkey', op='NASR eSports Turkey', region='EMEA', short='NASR' WHERE op='NASR eSports Turkey';
UPDATE teams_team SET becomes='PSG Talon', came_from='PSG Talon', highest_level='Primary', image='TALON (Hong Kong Team)logo profile.png', name='TALON', op='TALON (Hong Kong Team)', region='Asia Pacific', short='TLN' WHERE op='PSG Talon';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Team Liquidlogo profile.png', name='Team Liquid', op='Team Liquid', region='Americas', short='TL' WHERE op='Team Liquid';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='UltraVires.jpg', name='Team Ultra Vires', op='Team Ultra Vires', region='Europe', short='TUV' WHERE op='Team Ultra Vires';
UPDATE teams_team SET becomes=NULL, came_from='Vikings Esports (2023 Vietnamese Team)', highest_level='Primary', image='MGN Vikings Esportslogo profile.png', name='MGN Vikings Esports', op='MGN Vikings Esports', region='Asia Pacific', short='MVKE' WHERE op='Vikings Esports (2023 Vietnamese Team)';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Vivo Keyd Starslogo profile.png', name='Vivo Keyd Stars', op='Vivo Keyd Stars', region='Americas', short='VKS' WHERE op='Vivo Keyd Stars';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='West Point Esports Philippineslogo square.png', name='West Point Esports', op='West Point Esports Philippines', region='Asia Pacific', short='WP' WHERE op='West Point Esports Philippines';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Isurus Estrallogo square.png', name='Isurus Estral', op='Isurus Estral', region='Americas', short='IE' WHERE op='Estral Esports';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='LYON (2024 American Team)logo profile.png', name='LYON', op='LYON (2024 American Team)', region='Americas', short='LYON' WHERE op='Lyon Gaming (2013 Latin American Team)';
UPDATE teams_team SET becomes=NULL, came_from=NULL, highest_level='Primary', image='Team Secret Whaleslogo profile.png', name='Team Secret Whales', op='Team Secret Whales', region='Asia Pacific', short='TSW' WHERE op='Team Secret (Vietnamese Team)';
DELETE FROM teams_teamalternatename WHERE alternate_name='Azules Esports' AND team_op_id=(SELECT id FROM teams_team WHERE op='Azules Esports');
DELETE FROM teams_teamsisterteam WHERE sister_team_name='Azules Esports' AND team_op_id=(SELECT id FROM teams_team WHERE op='Azules Esports');
DELETE FROM teams_team WHERE op='Azules Esports';
DELETE FROM teams_teamalternatename WHERE alternate_name='Curse Academy' AND team_op_id=(SELECT id FROM teams_team WHERE op='Curse Academy');
DELETE FROM teams_team WHERE op='Curse Academy';
DELETE FROM teams_teamalternatename WHERE alternate_name='Friends Forever Gaming' AND team_op_id=(SELECT id FROM teams_team WHERE op='Friends Forever Gaming');
DELETE FROM teams_team WHERE op='Friends Forever Gaming';
DELETE FROM teams_teamalternatename WHERE alternate_name='GamingGear.eu' AND team_op_id=(SELECT id FROM teams_team WHERE op='GamingGear.eu');
DELETE FROM teams_team WHERE op='GamingGear.eu';
DELETE FROM teams_teamalternatename WHERE alternate_name='ISC Pro Team' AND team_op_id=(SELECT id FROM teams_team WHERE op='ISC Pro Team');
DELETE FROM teams_team WHERE op='ISC Pro Team';
DELETE FROM teams_teamalternatename WHERE alternate_name='Mineski' AND team_op_id=(SELECT id FROM teams_team WHERE op='Mineski');
DELETE FROM teams_team WHERE op='Mineski';
DELETE FROM teams_teamalternatename WHERE alternate_name='Rascal Jester' AND team_op_id=(SELECT id FROM teams_team WHERE op='Rascal Jester');
DELETE FROM teams_teamsisterteam WHERE sister_team_name='Rascal Jester' AND team_op_id=(SELECT id FROM teams_team WHERE op='Rascal Jester');
DELETE FROM teams_team WHERE op='Rascal Jester';
DELETE FROM teams_teamalternatename WHERE alternate_name='Royal Youth' AND team_op_id=(SELECT id FROM teams_team WHERE op='Royal Youth');
DELETE FROM teams_teamalternatename WHERE alternate_name='Royal Bandits' AND team_op_id=(SELECT id FROM teams_team WHERE op='Royal Youth');
DELETE FROM teams_teamsisterteam WHERE sister_team_name='Royal Youth' AND team_op_id=(SELECT id FROM teams_team WHERE op='Royal Youth');
DELETE FROM teams_team WHERE op='Royal Youth';
DELETE FROM teams_teamalternatename WHERE alternate_name='SEM9' AND team_op_id=(SELECT id FROM teams_team WHERE op='SEM9');
DELETE FROM teams_team WHERE op='SEM9';
DELETE FROM teams_teamalternatename WHERE alternate_name='SEM9 WPE' AND team_op_id=(SELECT id FROM teams_team WHERE op='SEM9 WPE');
DELETE FROM teams_team WHERE op='SEM9 WPE';
DELETE FROM teams_teamalternatename WHERE alternate_name='Team Curse' AND team_op_id=(SELECT id FROM teams_team WHERE op='Team Curse');
DELETE FROM teams_team WHERE op='Team Curse';
DELETE FROM teams_teamalternatename WHERE alternate_name='Team Empire (Malaysian Team)' AND team_op_id=(SELECT id FROM teams_team WHERE op='Team Empire (Malaysian Team)');
DELETE FROM teams_teamalternatename WHERE alternate_name='Team Empire' AND team_op_id=(SELECT id FROM teams_team WHERE op='Team Empire (Malaysian Team)');
DELETE FROM teams_team WHERE op='Team Empire (Malaysian Team)';
DELETE FROM teams_teamalternatename WHERE alternate_name='Team oNe eSports' AND team_op_id=(SELECT id FROM teams_team WHERE op='Team oNe eSports');
DELETE FROM teams_team WHERE op='Team oNe eSports';
DELETE FROM teams_teamalternatename WHERE alternate_name='Keyd Warriors' AND team_op_id=(SELECT id FROM teams_team WHERE op='Vivo Keyd');
DELETE FROM teams_teamalternatename WHERE alternate_name='Vivo Keyd' AND team_op_id=(SELECT id FROM teams_team WHERE op='Vivo Keyd');
DELETE FROM teams_teamalternatename WHERE alternate_name='Keyd Stars' AND team_op_id=(SELECT id FROM teams_team WHERE op='Vivo Keyd');
DELETE FROM teams_teamsisterteam WHERE sister_team_name='Keyd Warriors' AND team_op_id=(SELECT id FROM teams_team WHERE op='Vivo Keyd');
DELETE FROM teams_team WHERE op='Vivo Keyd';
DELETE FROM teams_teamalternatename WHERE alternate_name='Isurus' AND team_op_id=(SELECT id FROM teams_team WHERE op='Isurus');
DELETE FROM teams_teamsisterteam WHERE sister_team_name='Isurus' AND team_op_id=(SELECT id FROM teams_team WHERE op='Isurus');
DELETE FROM teams_team WHERE op='Isurus';
DELETE FROM teams_teamalternatename WHERE alternate_name='Movistar R7' AND team_op_id=(SELECT id FROM teams_team WHERE op='Movistar R7');
DELETE FROM teams_teamalternatename WHERE alternate_name='Rainbow7' AND team_op_id=(SELECT id FROM teams_team WHERE op='Movistar R7');
DELETE FROM teams_team WHERE op='Movistar R7';
DELETE FROM teams_teamalternatename WHERE alternate_name='Six Karma' AND team_op_id=(SELECT id FROM teams_team WHERE op='Six Karma');
DELETE FROM teams_team WHERE op='Six Karma';
DELETE FROM teams_teamalternatename WHERE alternate_name='Luxury Esports' AND team_op_id=(SELECT id FROM teams_team WHERE op='Team Whales');
DELETE FROM teams_teamalternatename WHERE alternate_name='GMedia Luxury' AND team_op_id=(SELECT id FROM teams_team WHERE op='Team Whales');
DELETE FROM teams_teamalternatename WHERE alternate_name='Team Whales' AND team_op_id=(SELECT id FROM teams_team WHERE op='Team Whales');
DELETE FROM teams_teamalternatename WHERE alternate_name='Cherry Esports' AND team_op_id=(SELECT id FROM teams_team WHERE op='Team Whales');
DELETE FROM teams_teamsisterteam WHERE sister_team_name='Team Whales' AND team_op_id=(SELECT id FROM teams_team WHERE op='Team Whales');
DELETE FROM teams_team WHERE op='Team Whales';
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES
('Disguised', (SELECT id FROM teams_team WHERE op = 'Disguised')),
('Team Empire (Malaysian Team)', (SELECT id FROM teams_team WHERE op = 'Axis Empire')),
('Team Empire', (SELECT id FROM teams_team WHERE op = 'Axis Empire')),
('ISC Pro Team', (SELECT id FROM teams_team WHERE op = 'Bren Esports')),
('Rascal Jester', (SELECT id FROM teams_team WHERE op = 'FENNEL')),
('BNK FEARX', (SELECT id FROM teams_team WHERE op = 'BNK FEARX')),
('Fluxo W7M', (SELECT id FROM teams_team WHERE op = 'Fluxo W7M')),
('Curse Academy', (SELECT id FROM teams_team WHERE op = 'Gravity (North American Team)')),
('Azules Esports', (SELECT id FROM teams_team WHERE op = 'Kaos Latin Gamers')),
('DN Freecs', (SELECT id FROM teams_team WHERE op = 'DN Freecs')),
('Mineski', (SELECT id FROM teams_team WHERE op = 'Liyab Esports')),
('Team oNe eSports', (SELECT id FROM teams_team WHERE op = 'Los Grandes')),
('Friends Forever Gaming', (SELECT id FROM teams_team WHERE op = 'Lowkey Esports.Vietnam')),
('Movistar KOI', (SELECT id FROM teams_team WHERE op = 'Movistar KOI')),
('Royal Youth', (SELECT id FROM teams_team WHERE op = 'NASR eSports Turkey')),
('Royal Bandits', (SELECT id FROM teams_team WHERE op = 'NASR eSports Turkey')),
('TALON (Hong Kong Team)', (SELECT id FROM teams_team WHERE op = 'TALON (Hong Kong Team)')),
('Team Curse', (SELECT id FROM teams_team WHERE op = 'Team Liquid')),
('GamingGear.eu', (SELECT id FROM teams_team WHERE op = 'Team Ultra Vires')),
('MGN Vikings Esports', (SELECT id FROM teams_team WHERE op = 'MGN Vikings Esports')),
('Keyd Warriors', (SELECT id FROM teams_team WHERE op = 'Vivo Keyd Stars')),
('Vivo Keyd', (SELECT id FROM teams_team WHERE op = 'Vivo Keyd Stars')),
('Keyd Stars', (SELECT id FROM teams_team WHERE op = 'Vivo Keyd Stars')),
('SEM9 WPE', (SELECT id FROM teams_team WHERE op = 'West Point Esports Philippines')),
('SEM9', (SELECT id FROM teams_team WHERE op = 'West Point Esports Philippines')),
('Isurus Estral', (SELECT id FROM teams_team WHERE op = 'Isurus Estral')),
('Isurus', (SELECT id FROM teams_team WHERE op = 'Isurus Estral')),
('Rainbow7', (SELECT id FROM teams_team WHERE op = 'LYON (2024 American Team)')),
('Movistar R7', (SELECT id FROM teams_team WHERE op = 'LYON (2024 American Team)')),
('LYON (2024 American Team)', (SELECT id FROM teams_team WHERE op = 'LYON (2024 American Team)')),
('Six Karma', (SELECT id FROM teams_team WHERE op = 'LYON (2024 American Team)')),
('Team Secret Whales', (SELECT id FROM teams_team WHERE op = 'Team Secret Whales')),
('GMedia Luxury', (SELECT id FROM teams_team WHERE op = 'Team Secret Whales')),
('Luxury Esports', (SELECT id FROM teams_team WHERE op = 'Team Secret Whales')),
('Team Whales', (SELECT id FROM teams_team WHERE op = 'Team Secret Whales')),
('Cherry Esports', (SELECT id FROM teams_team WHERE op = 'Team Secret Whales'));
INSERT INTO teams_teamsisterteam (sister_team_name, team_op_id) VALUES
('Rascal Jester', (SELECT id FROM teams_team WHERE op = 'FENNEL')),
('BNK FEARX', (SELECT id FROM teams_team WHERE op = 'BNK FEARX')),
('Azules Esports', (SELECT id FROM teams_team WHERE op = 'Kaos Latin Gamers')),
('DN Freecs', (SELECT id FROM teams_team WHERE op = 'DN Freecs')),
('Movistar KOI', (SELECT id FROM teams_team WHERE op = 'Movistar KOI')),
('Royal Youth', (SELECT id FROM teams_team WHERE op = 'NASR eSports Turkey')),
('TALON (Hong Kong Team)', (SELECT id FROM teams_team WHERE op = 'TALON (Hong Kong Team)')),
('Keyd Warriors', (SELECT id FROM teams_team WHERE op = 'Vivo Keyd Stars')),
('Isurus', (SELECT id FROM teams_team WHERE op = 'Isurus Estral')),
('LYON (2024 American Team)', (SELECT id FROM teams_team WHERE op = 'LYON (2024 American Team)')),
('Lyon Gaming (2013 Latin American Team)', (SELECT id FROM teams_team WHERE op = 'LYON (2024 American Team)')),
('Team Secret Whales', (SELECT id FROM teams_team WHERE op = 'Team Secret Whales')),
('Team Whales', (SELECT id FROM teams_team WHERE op = 'Team Secret Whales'));
INSERT INTO meta_dataupdate (date, app) VALUES (date('now'), 'teams');
COMMIT;