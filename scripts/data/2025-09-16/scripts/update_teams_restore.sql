BEGIN;
-- Restore metadata --
DELETE FROM meta_dataupdate WHERE id in (SELECT id FROM meta_dataupdate WHERE app='teams' ORDER BY date DESC LIMIT 1);
-- Deactivate readded teams
UPDATE teams_team SET active=FALSE WHERE op in (
'Azules Esports',
'Isurus',
'Estral Esports'
);
-- Reactivate redundant teams
UPDATE teams_team SET active=TRUE WHERE op in (
'Ultimate',
'Isurus Estral',
'Natus Vincere.CIS'
);
-- Removing all new sister teams --
DELETE FROM teams_teamsisterteam WHERE id in (SELECT id FROM teams_teamsisterteam WHERE (
(team_op_id=(SELECT id FROM teams_team WHERE op='Natus Vincere') AND sister_team_name IN ('Natus Vincere.CIS')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='E-Champ Gaming') AND sister_team_name IN ('E-Champ Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MGN Vikings Esports') AND sister_team_name IN ('MGN Vikings Esports'))));
-- Removing all new alternate names --
DELETE FROM teams_teamalternatename WHERE id in (SELECT id FROM teams_teamalternatename WHERE (
(team_op_id=(SELECT id FROM teams_team WHERE op='Dragons Esports') AND alternate_name IN ('Dragons Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Natus Vincere') AND alternate_name IN ('Natus Vincere', 'Natus Vincere.CIS')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Anyone''s Legend') AND alternate_name IN ('AG.AL')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Isurus') AND alternate_name IN ('Isurus Estral'))));
-- Downdating teams --
UPDATE teams_team SET region='Latin America' WHERE op='Azules Esports';
UPDATE teams_team SET region='Latin America' WHERE op='Coscu Army';
UPDATE teams_team SET region='Latin America' WHERE op='Estral Esports';
UPDATE teams_team SET short='FX7M' WHERE op='Fluxo W7M';
UPDATE teams_team SET came_from=NULL, image='Isuruslogo profile.png', region='Latin America' WHERE op='Isurus';
UPDATE teams_team SET becomes=NULL, image='Sengoku Gaminglogo profile.png', region='Asia Pacific', short='SG' WHERE op='Sengoku Gaming';
UPDATE teams_team SET image='TALON (Hong Kong Team)logo profile.png', name='TALON', region='Asia Pacific', short='TLN' WHERE op='TALON (Hong Kong Team)';
-- Removing new teams --
DELETE FROM teams_team WHERE op in (
'Dragons Esports',
'Natus Vincere'
);
COMMIT;