BEGIN;
-- Update metadata --
INSERT INTO meta_dataupdate (date, app) VALUES ('2025-09-16', 'teams');
-- Adding new teams --
INSERT INTO teams_team (becomes, came_from, highest_level, image, name, op, region, short) VALUES
(NULL, NULL, 'Primary', 'Dragons Esportslogo square.png', 'Dragons Esports', 'Dragons Esports', 'EMEA', 'DRAG'),
(NULL, NULL, 'Primary', 'Natus Vincerelogo square.png', 'Natus Vincere', 'Natus Vincere', 'EMEA', 'NAVI');
-- Updating teams --
UPDATE teams_team SET region='Americas' WHERE op='Azules Esports';
UPDATE teams_team SET region='Americas' WHERE op='Coscu Army';
UPDATE teams_team SET region='Americas' WHERE op='Estral Esports';
UPDATE teams_team SET short='FXW7' WHERE op='Fluxo W7M';
UPDATE teams_team SET came_from='Isurus Estral', image='Isuruslogo square.png', region='Americas' WHERE op='Isurus';
UPDATE teams_team SET becomes='QT DIG', image=NULL, region=NULL, short=NULL WHERE op='Sengoku Gaming';
UPDATE teams_team SET image=NULL, name='TALON (Hong Kong Team)', region=NULL, short=NULL WHERE op='TALON (Hong Kong Team)';
-- Inserting all new alternate names --
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES
('Dragons Esports', (SELECT id FROM teams_team WHERE op='Dragons Esports')),
('Natus Vincere', (SELECT id FROM teams_team WHERE op='Natus Vincere')),
('Natus Vincere.CIS', (SELECT id FROM teams_team WHERE op='Natus Vincere')),
('AG.AL', (SELECT id FROM teams_team WHERE op='Anyone''s Legend')),
('Isurus Estral', (SELECT id FROM teams_team WHERE op='Isurus'));
-- Inserting all new sister teams --
INSERT INTO teams_teamsisterteam (sister_team_name, team_op_id) VALUES
('Natus Vincere.CIS', (SELECT id FROM teams_team WHERE op='Natus Vincere')),
('E-Champ Gaming', (SELECT id FROM teams_team WHERE op='E-Champ Gaming')),
('MGN Vikings Esports', (SELECT id FROM teams_team WHERE op='MGN Vikings Esports'));
-- Deactivate redundant teams
UPDATE teams_team SET active=FALSE WHERE op in (
'Ultimate',
'Isurus Estral',
'Natus Vincere.CIS'
);
-- Reactivate readded teams
UPDATE teams_team SET active=TRUE WHERE op in (
'Azules Esports',
'Isurus',
'Estral Esports'
);
COMMIT;