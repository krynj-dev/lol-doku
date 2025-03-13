BEGIN;
-- Update metadata --
INSERT INTO meta_dataupdate (date, app) VALUES ('2025-02-25', 'teams');
-- Adding new teams --
INSERT INTO teams_team (becomes, came_from, highest_level, image, name, op, region, short) VALUES
(NULL, 'FearX', 'Primary', 'BNK FEARXlogo profile.png', 'BNK FEARX', 'BNK FEARX', 'Korea', 'BFX'),
(NULL, 'Kwangdong Freecs', 'Primary', 'DN Freecslogo profile.png', 'DN Freecs', 'DN Freecs', 'Korea', 'DNF'),
(NULL, NULL, 'Primary', 'Disguisedlogo profile.png', 'Disguised', 'Disguised', 'Americas', 'DSG'),
(NULL, 'Fluxo', 'Primary', 'Fluxo W7Mlogo square.png', 'Fluxo W7M', 'Fluxo W7M', 'Americas', 'FX7M'),
(NULL, NULL, 'Primary', 'Isurus Estrallogo square.png', 'Isurus Estral', 'Isurus Estral', 'Americas', 'IE'),
(NULL, NULL, 'Primary', 'LYON (2024 American Team)logo profile.png', 'LYON', 'LYON (2024 American Team)', 'Americas', 'LYON'),
(NULL, 'Vikings Esports (2023 Vietnamese Team)', 'Primary', 'MGN Vikings Esportslogo profile.png', 'MGN Vikings Esports', 'MGN Vikings Esports', 'Asia Pacific', 'MVKE'),
(NULL, 'MAD Lions KOI', 'Primary', 'Movistar KOIlogo square.png', 'Movistar KOI', 'Movistar KOI', 'EMEA', 'MKOI'),
('PSG Talon', 'PSG Talon', 'Primary', 'TALON (Hong Kong Team)logo profile.png', 'TALON', 'TALON (Hong Kong Team)', 'Asia Pacific', 'TLN'),
(NULL, NULL, 'Primary', 'Team Secret Whaleslogo profile.png', 'Team Secret Whales', 'Team Secret Whales', 'Asia Pacific', 'TSW');
-- Updating teams --
UPDATE teams_team SET region='North America', short='100' WHERE op='100 Thieves';
UPDATE teams_team SET region='PCS' WHERE op='AXIZ';
UPDATE teams_team SET region='PCS' WHERE op='AXIZ CREST';
UPDATE teams_team SET region='PCS' WHERE op='Ahq eSports Club';
UPDATE teams_team SET region='PCS' WHERE op='Antic Esports';
UPDATE teams_team SET region='PCS' WHERE op='BOOM Esports';
UPDATE teams_team SET region='PCS' WHERE op='Berjaya Dragons';
UPDATE teams_team SET region='PCS' WHERE op='Beyond Gaming';
UPDATE teams_team SET region='PCS' WHERE op='Burning Core Toyama';
UPDATE teams_team SET region='Vietnam' WHERE op='CERBERUS Esports (Vietnamese Team)';
UPDATE teams_team SET region='PCS' WHERE op='Chiefs Esports Club';
UPDATE teams_team SET region='North America' WHERE op='Cloud9';
UPDATE teams_team SET region='PCS' WHERE op='Crest Gaming Act';
UPDATE teams_team SET becomes=NULL WHERE op='Dark Passage';
UPDATE teams_team SET region='PCS' WHERE op='Deep Cross Gaming';
UPDATE teams_team SET region='PCS' WHERE op='DetonatioN FocusMe';
UPDATE teams_team SET region='PCS' WHERE op='Dewish Team';
UPDATE teams_team SET region='North America' WHERE op='Dignitas';
UPDATE teams_team SET region='PCS' WHERE op='Dire Wolves';
UPDATE teams_team SET region='Brazil' WHERE op='E-Champ Gaming';
UPDATE teams_team SET region='Latin America' WHERE op='Eclipse Gaming (Latin American Team)';
UPDATE teams_team SET image='EPA 2016 logo.png' WHERE op='Energy Pacemaker.All';
UPDATE teams_team SET region='PCS' WHERE op='FENNEL';
UPDATE teams_team SET region='Brazil' WHERE op='FURIA';
UPDATE teams_team SET region='PCS' WHERE op='FURY Global';
UPDATE teams_team SET region='North America' WHERE op='FlyQuest';
UPDATE teams_team SET short='Fortius' WHERE op='Fortius';
UPDATE teams_team SET region='PCS' WHERE op='Frank Esports';
UPDATE teams_team SET image='Fukuoka SoftBank HAWKS gaminglogo square.png', region='PCS' WHERE op='Fukuoka SoftBank HAWKS gaming';
UPDATE teams_team SET region='Latin America' WHERE op='Furious Gaming';
UPDATE teams_team SET region='PCS' WHERE op='G-Rex';
UPDATE teams_team SET region='Vietnam' WHERE op='GAM Esports';
UPDATE teams_team SET image='Team_Galakticoslogo_square.png' WHERE op='Galakticos';
UPDATE teams_team SET image='Gama Dreamlogo_square.png' WHERE op='Gama Dream';
UPDATE teams_team SET region='PCS' WHERE op='Ground Zero Gaming';
UPDATE teams_team SET region='PCS' WHERE op='HELL PIGS';
UPDATE teams_team SET image='Heroes_Logo.png' WHERE op='Heroes Team';
UPDATE teams_team SET region='PCS' WHERE op='Hong Kong Attitude';
UPDATE teams_team SET region='PCS', short='HKF' WHERE op='Hungkuang Falcon';
UPDATE teams_team SET region='Latin America' WHERE op='INFINITY';
UPDATE teams_team SET region='Brazil' WHERE op='INTZ';
UPDATE teams_team SET region='PCS' WHERE op='ION Global Esports';
UPDATE teams_team SET came_from=NULL WHERE op='Impunity';
UPDATE teams_team SET region='PCS' WHERE op='J Team';
UPDATE teams_team SET becomes='KaBuM! Orange', region='Brazil' WHERE op='KaBuM! Esports';
UPDATE teams_team SET short='Kanaya' WHERE op='Kanaya Gaming';
UPDATE teams_team SET region='PCS' WHERE op='Kanga Esports';
UPDATE teams_team SET region='Brazil' WHERE op='LOUD';
UPDATE teams_team SET region='Latin America' WHERE op='Leviatan';
UPDATE teams_team SET image='LinGan e-Sportslogo_square.png' WHERE op='LinGan e-Sports';
UPDATE teams_team SET region='PCS' WHERE op='Liyab Esports';
UPDATE teams_team SET region='Brazil' WHERE op='Los Grandes';
UPDATE teams_team SET region='PCS' WHERE op='MAMMOTH';
UPDATE teams_team SET region='Vietnam' WHERE op='MGN Blue Esports';
UPDATE teams_team SET region='PCS' WHERE op='Machi Esports';
UPDATE teams_team SET short='Mad Gods' WHERE op='Mad Gods Gaming';
UPDATE teams_team SET region='PCS' WHERE op='Meta Falcon Team';
UPDATE teams_team SET image='MSClogo_square.png' WHERE op='Moss Seven Club';
UPDATE teams_team SET name='NRG', region='North America' WHERE op='NRG';
UPDATE teams_team SET short='Naga' WHERE op='Naga Esports';
UPDATE teams_team SET region='PCS' WHERE op='Nate9527';
UPDATE teams_team SET image='Newbee logo.png' WHERE op='Newbee';
UPDATE teams_team SET region='PCS' WHERE op='Nova Esports (Thai Team)';
UPDATE teams_team SET region='PCS' WHERE op='PEACE (Oceanic Team)';
UPDATE teams_team SET region='Brazil', short='PNG' WHERE op='PaiN Gaming';
UPDATE teams_team SET image='People''s Red Wolf Gaminglogo square.png' WHERE op='People''s Red Wolf Gaming';
UPDATE teams_team SET image='PE logo new.png' WHERE op='Positive Energy';
UPDATE teams_team SET image='Pulse - Classic_Logo.png', region='North America' WHERE op='Pulse Esports';
UPDATE teams_team SET region='Brazil' WHERE op='RED Canids';
UPDATE teams_team SET region='PCS' WHERE op='Resurgence';
UPDATE teams_team SET region='PCS' WHERE op='Sengoku Gaming';
UPDATE teams_team SET region='North America' WHERE op='Shopify Rebellion';
UPDATE teams_team SET image='ShowTime logo.png' WHERE op='ShowTime';
UPDATE teams_team SET image='Team Acer logo.png' WHERE op='Team Acer Poland';
UPDATE teams_team SET region='PCS' WHERE op='Team Bliss';
UPDATE teams_team SET image='Dk logo.png' WHERE op='Team DK';
UPDATE teams_team SET region='Vietnam' WHERE op='Team Flash.Vietnam';
UPDATE teams_team SET region='North America' WHERE op='Team Liquid';
UPDATE teams_team SET short='nxl' WHERE op='Team nxl';
UPDATE teams_team SET region='PCS' WHERE op='V3 Esports';
UPDATE teams_team SET region='PCS' WHERE op='Vertex Esports Club';
UPDATE teams_team SET region='Brazil' WHERE op='Vivo Keyd Stars';
UPDATE teams_team SET region='PCS' WHERE op='West Point Esports Philippines';
-- Inserting all new alternate names --
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES
('BNK FEARX', (SELECT id FROM teams_team WHERE op='BNK FEARX')),
('FearX', (SELECT id FROM teams_team WHERE op='BNK FEARX')),
('Liiv SANDBOX', (SELECT id FROM teams_team WHERE op='BNK FEARX')),
('Liiv SANDBOX Challengers', (SELECT id FROM teams_team WHERE op='BNK FEARX')),
('SANDBOX Gaming', (SELECT id FROM teams_team WHERE op='BNK FEARX')),
('Team BattleComics', (SELECT id FROM teams_team WHERE op='BNK FEARX')),
('Afreeca Freecs', (SELECT id FROM teams_team WHERE op='DN Freecs')),
('Afreeca Freecs Challengers', (SELECT id FROM teams_team WHERE op='DN Freecs')),
('Anarchy', (SELECT id FROM teams_team WHERE op='DN Freecs')),
('DN Freecs', (SELECT id FROM teams_team WHERE op='DN Freecs')),
('Kwangdong Freecs', (SELECT id FROM teams_team WHERE op='DN Freecs')),
('Rebels Anarchy', (SELECT id FROM teams_team WHERE op='DN Freecs')),
('Disguised', (SELECT id FROM teams_team WHERE op='Disguised')),
('Fluxo', (SELECT id FROM teams_team WHERE op='Fluxo W7M')),
('Fluxo W7M', (SELECT id FROM teams_team WHERE op='Fluxo W7M')),
('Estral Esports', (SELECT id FROM teams_team WHERE op='Isurus Estral')),
('Isurus', (SELECT id FROM teams_team WHERE op='Isurus Estral')),
('Isurus Estral', (SELECT id FROM teams_team WHERE op='Isurus Estral')),
('LYON (2024 American Team)', (SELECT id FROM teams_team WHERE op='LYON (2024 American Team)')),
('Lyon Gaming (2013 Latin American Team)', (SELECT id FROM teams_team WHERE op='LYON (2024 American Team)')),
('Movistar R7', (SELECT id FROM teams_team WHERE op='LYON (2024 American Team)')),
('Rainbow7', (SELECT id FROM teams_team WHERE op='LYON (2024 American Team)')),
('Six Karma', (SELECT id FROM teams_team WHERE op='LYON (2024 American Team)')),
('Dashing Buffalo', (SELECT id FROM teams_team WHERE op='MGN Vikings Esports')),
('MGN Vikings Esports', (SELECT id FROM teams_team WHERE op='MGN Vikings Esports')),
('Phong Vũ Buffalo', (SELECT id FROM teams_team WHERE op='MGN Vikings Esports')),
('Saigon Buffalo', (SELECT id FROM teams_team WHERE op='MGN Vikings Esports')),
('Vikings Esports (2023 Vietnamese Team)', (SELECT id FROM teams_team WHERE op='MGN Vikings Esports')),
('Vikings Gaming', (SELECT id FROM teams_team WHERE op='MGN Vikings Esports')),
('Young Generation', (SELECT id FROM teams_team WHERE op='MGN Vikings Esports')),
('MAD Lions', (SELECT id FROM teams_team WHERE op='Movistar KOI')),
('MAD Lions E.C. Colombia', (SELECT id FROM teams_team WHERE op='Movistar KOI')),
('MAD Lions KOI', (SELECT id FROM teams_team WHERE op='Movistar KOI')),
('Movistar KOI', (SELECT id FROM teams_team WHERE op='Movistar KOI')),
('Splyce', (SELECT id FROM teams_team WHERE op='Movistar KOI')),
('PSG Talon', (SELECT id FROM teams_team WHERE op='TALON (Hong Kong Team)')),
('PSG Talon Academy', (SELECT id FROM teams_team WHERE op='TALON (Hong Kong Team)')),
('TALON (Hong Kong Team)', (SELECT id FROM teams_team WHERE op='TALON (Hong Kong Team)')),
('Cherry Esports', (SELECT id FROM teams_team WHERE op='Team Secret Whales')),
('GMedia Luxury', (SELECT id FROM teams_team WHERE op='Team Secret Whales')),
('Luxury Esports', (SELECT id FROM teams_team WHERE op='Team Secret Whales')),
('Team Secret (Vietnamese Team)', (SELECT id FROM teams_team WHERE op='Team Secret Whales')),
('Team Secret Whales', (SELECT id FROM teams_team WHERE op='Team Secret Whales')),
('Team Whales', (SELECT id FROM teams_team WHERE op='Team Secret Whales')),
('Team Empire (Malaysian Team)', (SELECT id FROM teams_team WHERE op='Axis Empire')),
('Team Empire', (SELECT id FROM teams_team WHERE op='Axis Empire')),
('ISC Pro Team', (SELECT id FROM teams_team WHERE op='Bren Esports')),
('Rascal Jester', (SELECT id FROM teams_team WHERE op='FENNEL')),
('Curse Academy', (SELECT id FROM teams_team WHERE op='Gravity (North American Team)')),
('Azules Esports', (SELECT id FROM teams_team WHERE op='Kaos Latin Gamers')),
('Mineski', (SELECT id FROM teams_team WHERE op='Liyab Esports')),
('Team oNe eSports', (SELECT id FROM teams_team WHERE op='Los Grandes')),
('Friends Forever Gaming', (SELECT id FROM teams_team WHERE op='Lowkey Esports.Vietnam')),
('Royal Bandits', (SELECT id FROM teams_team WHERE op='NASR eSports Turkey')),
('Royal Youth', (SELECT id FROM teams_team WHERE op='NASR eSports Turkey')),
('Team Curse', (SELECT id FROM teams_team WHERE op='Team Liquid')),
('GamingGear.eu', (SELECT id FROM teams_team WHERE op='Team Ultra Vires')),
('Keyd Stars', (SELECT id FROM teams_team WHERE op='Vivo Keyd Stars')),
('Vivo Keyd', (SELECT id FROM teams_team WHERE op='Vivo Keyd Stars')),
('Keyd Warriors', (SELECT id FROM teams_team WHERE op='Vivo Keyd Stars')),
('SEM9 WPE', (SELECT id FROM teams_team WHERE op='West Point Esports Philippines')),
('SEM9', (SELECT id FROM teams_team WHERE op='West Point Esports Philippines'));
-- Inserting all new sister teams --
INSERT INTO teams_teamsisterteam (sister_team_name, team_op_id) VALUES
('BNK FEARX', (SELECT id FROM teams_team WHERE op='BNK FEARX')),
('DN Freecs', (SELECT id FROM teams_team WHERE op='DN Freecs')),
('Estral Esports', (SELECT id FROM teams_team WHERE op='Isurus Estral')),
('Isurus', (SELECT id FROM teams_team WHERE op='Isurus Estral')),
('LYON (2024 American Team)', (SELECT id FROM teams_team WHERE op='LYON (2024 American Team)')),
('Lyon Gaming (2013 Latin American Team)', (SELECT id FROM teams_team WHERE op='LYON (2024 American Team)')),
('Movistar KOI', (SELECT id FROM teams_team WHERE op='Movistar KOI')),
('TALON (Hong Kong Team)', (SELECT id FROM teams_team WHERE op='TALON (Hong Kong Team)')),
('Team Secret (Vietnamese Team)', (SELECT id FROM teams_team WHERE op='Team Secret Whales')),
('Team Secret Whales', (SELECT id FROM teams_team WHERE op='Team Secret Whales')),
('Team Whales', (SELECT id FROM teams_team WHERE op='Team Secret Whales')),
('Rascal Jester', (SELECT id FROM teams_team WHERE op='FENNEL')),
('Azules Esports', (SELECT id FROM teams_team WHERE op='Kaos Latin Gamers')),
('Royal Youth', (SELECT id FROM teams_team WHERE op='NASR eSports Turkey')),
('Keyd Warriors', (SELECT id FROM teams_team WHERE op='Vivo Keyd Stars'));
-- Deactivate redendant teams
UPDATE teams_team SET active=FALSE WHERE op in (
'Friends Forever Gaming',
'SEM9',
'Team Curse',
'FearX',
'Kwangdong Freecs',
'Lyon Gaming (2013 Latin American Team)',
'PSG Talon',
'Rascal Jester',
'Movistar R7',
'Team Whales',
'Vikings Esports (2023 Vietnamese Team)',
'Estral Esports',
'Fluxo',
'Vivo Keyd',
'Team Secret (Vietnamese Team)',
'Six Karma',
'Team oNe eSports',
'DG Esports',
'Mineski',
'GamingGear.eu',
'MAD Lions KOI',
'Team Empire (Malaysian Team)',
'Curse Academy',
'Azules Esports',
'SEM9 WPE',
'Isurus',
'ISC Pro Team',
'Royal Youth'
);
COMMIT;