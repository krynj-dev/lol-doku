BEGIN;
-- Update metadata --
INSERT INTO meta_dataupdate (date, app) VALUES ('2025-03-12', 'teams');
-- Adding new teams --
INSERT INTO teams_team (becomes, came_from, highest_level, image, name, op, region, short) VALUES
;
-- Updating teams --

-- Inserting all new alternate names --
INSERT INTO teams_teamalternatename (alternate_name, team_op_id) VALUES
;
-- Inserting all new sister teams --
INSERT INTO teams_teamsisterteam (sister_team_name, team_op_id) VALUES
;
-- Deactivate redendant teams
UPDATE teams_team SET active=FALSE WHERE op in (

);
COMMIT;