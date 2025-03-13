BEGIN;
-- Update metadata --
INSERT INTO meta_dataupdate (date, app) VALUES ('2025-03-13', 'teams');
-- Adding new teams --
INSERT INTO teams_team (becomes, came_from, highest_level, image, name, op, region, short) VALUES
('Winterfox', 'Winterfox', 'Primary', 'Evil Geniuses.NAlogo profile.png', 'Evil Geniuses', 'Evil Geniuses.NA', 'North America', 'EG');
-- Updating teams --
UPDATE teams_team SET region='Americas', short='100T' WHERE op='100 Thieves';
UPDATE teams_team SET region='Asia Pacific' WHERE op='AXIZ';
UPDATE teams_team SET region='Asia Pacific' WHERE op='AXIZ CREST';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Ahq eSports Club';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Antic Esports';
UPDATE teams_team SET region='Asia Pacific' WHERE op='BOOM Esports';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Berjaya Dragons';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Beyond Gaming';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Burning Core Toyama';
UPDATE teams_team SET region='Asia Pacific' WHERE op='CERBERUS Esports (Vietnamese Team)';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Chiefs Esports Club';
UPDATE teams_team SET region='Americas' WHERE op='Cloud9';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Crest Gaming Act';
UPDATE teams_team SET becomes='BBL Dark Passage' WHERE op='Dark Passage';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Deep Cross Gaming';
UPDATE teams_team SET region='Asia Pacific' WHERE op='DetonatioN FocusMe';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Dewish Team';
UPDATE teams_team SET region='Americas' WHERE op='Dignitas';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Dire Wolves';
UPDATE teams_team SET region='Americas' WHERE op='E-Champ Gaming';
UPDATE teams_team SET region='Americas' WHERE op='Eclipse Gaming (Latin American Team)';
UPDATE teams_team SET image='Energy Pacemaker.Alllogo square.png' WHERE op='Energy Pacemaker.All';
UPDATE teams_team SET region='Asia Pacific' WHERE op='FENNEL';
UPDATE teams_team SET region='Americas' WHERE op='FURIA';
UPDATE teams_team SET region='Asia Pacific' WHERE op='FURY Global';
UPDATE teams_team SET region='Americas' WHERE op='FlyQuest';
UPDATE teams_team SET short='FTS' WHERE op='Fortius';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Frank Esports';
UPDATE teams_team SET image='Fukuoka_SoftBank_HAWKS_gaminglogo_profile.png', region='Asia Pacific' WHERE op='Fukuoka SoftBank HAWKS gaming';
UPDATE teams_team SET region='Americas' WHERE op='Furious Gaming';
UPDATE teams_team SET region='Asia Pacific' WHERE op='G-Rex';
UPDATE teams_team SET region='Asia Pacific' WHERE op='GAM Esports';
UPDATE teams_team SET image='Galakticoslogo square.png' WHERE op='Galakticos';
UPDATE teams_team SET image='Gama Dreamlogo profile.png' WHERE op='Gama Dream';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Ground Zero Gaming';
UPDATE teams_team SET region='Asia Pacific' WHERE op='HELL PIGS';
UPDATE teams_team SET image='Heroes Teamlogo square.png' WHERE op='Heroes Team';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Hong Kong Attitude';
UPDATE teams_team SET region='Asia Pacific', short='HKUF' WHERE op='Hungkuang Falcon';
UPDATE teams_team SET region='Americas' WHERE op='INFINITY';
UPDATE teams_team SET region='Americas' WHERE op='INTZ';
UPDATE teams_team SET region='Asia Pacific' WHERE op='ION Global Esports';
UPDATE teams_team SET came_from='Alternative Gaming' WHERE op='Impunity';
UPDATE teams_team SET region='Asia Pacific' WHERE op='J Team';
UPDATE teams_team SET becomes='KaBuM! Ilha das Lendas', region='Americas' WHERE op='KaBuM! Esports';
UPDATE teams_team SET short='KG' WHERE op='Kanaya Gaming';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Kanga Esports';
UPDATE teams_team SET region='Americas', short='LOUD' WHERE op='LOUD';
UPDATE teams_team SET region='Americas' WHERE op='Leviatan';
UPDATE teams_team SET image='LinGan e-Sportslogo profile.png' WHERE op='LinGan e-Sports';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Liyab Esports';
UPDATE teams_team SET region='Americas' WHERE op='Los Grandes';
UPDATE teams_team SET region='Asia Pacific' WHERE op='MAMMOTH';
UPDATE teams_team SET region='Asia Pacific' WHERE op='MGN Blue Esports';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Machi Esports';
UPDATE teams_team SET short='MG' WHERE op='Mad Gods Gaming';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Meta Falcon Team';
UPDATE teams_team SET image='Moss Seven Clublogo square.png' WHERE op='Moss Seven Club';
UPDATE teams_team SET name='NRG Kia', region='Americas' WHERE op='NRG';
UPDATE teams_team SET short='NAGA' WHERE op='Naga Esports';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Nate9527';
UPDATE teams_team SET image='Newbeelogo profile.png' WHERE op='Newbee';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Nova Esports (Thai Team)';
UPDATE teams_team SET region='Asia Pacific' WHERE op='PEACE (Oceanic Team)';
UPDATE teams_team SET region='Americas', short='PAIN' WHERE op='PaiN Gaming';
UPDATE teams_team SET image='People''s Red Wolf Gaminglogo profile.png' WHERE op='People''s Red Wolf Gaming';
UPDATE teams_team SET image='Positive Energylogo profile.png' WHERE op='Positive Energy';
UPDATE teams_team SET image='Pulse Esportslogo profile.png', region='Europe' WHERE op='Pulse Esports';
UPDATE teams_team SET region='Americas' WHERE op='RED Canids';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Resurgence';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Sengoku Gaming';
UPDATE teams_team SET region='Americas' WHERE op='Shopify Rebellion';
UPDATE teams_team SET image='ShowTimelogo profile.png' WHERE op='ShowTime';
UPDATE teams_team SET image='Team Acer Polandlogo square.png' WHERE op='Team Acer Poland';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Team Bliss';
UPDATE teams_team SET image='Team DKlogo profile.png' WHERE op='Team DK';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Team Flash.Vietnam';
UPDATE teams_team SET region='Americas' WHERE op='Team Liquid';
UPDATE teams_team SET short='NXL' WHERE op='Team nxl';
UPDATE teams_team SET region='Asia Pacific' WHERE op='V3 Esports';
UPDATE teams_team SET region='Asia Pacific' WHERE op='Vertex Esports Club';
UPDATE teams_team SET region='Americas' WHERE op='Vivo Keyd Stars';
UPDATE teams_team SET region='Asia Pacific' WHERE op='West Point Esports Philippines';
-- Inserting all new alternate names --
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES
('Evil Geniuses.EU', (SELECT id FROM teams_team WHERE op='Evil Geniuses.NA')),
('Evil Geniuses.NA', (SELECT id FROM teams_team WHERE op='Evil Geniuses.NA')),
('Winterfox', (SELECT id FROM teams_team WHERE op='Evil Geniuses.NA'));
-- Inserting all new sister teams --
INSERT INTO teams_teamsisterteam (sister_team_name, team_op_id) VALUES
('Evil Geniuses.EU', (SELECT id FROM teams_team WHERE op='Evil Geniuses.NA')),
('Evil Geniuses.NA', (SELECT id FROM teams_team WHERE op='Evil Geniuses.NA'));
-- Deactivate redendant teams
UPDATE teams_team SET active=FALSE WHERE op in (
'Winterfox'
);
COMMIT;