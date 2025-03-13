BEGIN;
-- Restore metadata --
DELETE FROM meta_dataupdate WHERE id in (SELECT id FROM meta_dataupdate WHERE app='teams' ORDER BY date DESC LIMIT 1);
-- Reactivate redendant teams
UPDATE teams_team SET active=TRUE WHERE op in (
'Winterfox'
);
-- Removing all new sister teams --
DELETE FROM teams_teamsisterteam WHERE id in (SELECT id FROM teams_teamsisterteam WHERE (
(team_op_id=(SELECT id FROM teams_team WHERE op='Evil Geniuses.NA') AND sister_team_name IN ('Evil Geniuses.EU', 'Evil Geniuses.NA'))));
-- Removing all new alternate names --
DELETE FROM teams_teamalternatename WHERE id in (SELECT id FROM teams_teamalternatename WHERE (
(team_op_id=(SELECT id FROM teams_team WHERE op='Evil Geniuses.NA') AND alternate_name IN ('Evil Geniuses.EU', 'Evil Geniuses.NA', 'Winterfox'))));
-- Downdating teams --
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
UPDATE teams_team SET region='Brazil', short='LLL' WHERE op='LOUD';
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
-- Removing new teams --
DELETE FROM teams_team WHERE op in (
'Evil Geniuses.NA'
);
COMMIT;