BEGIN;
-- Restore metadata --
DELETE FROM meta_dataupdate WHERE id in (SELECT id FROM meta_dataupdate WHERE app='teams' ORDER BY date DESC LIMIT 1);
-- Deactivate readded teams
UPDATE teams_team SET active=FALSE WHERE op in (
'Royal Youth',
'PSG Talon',
'Azules Esports',
'Isurus',
'Estral Esports'
);
-- Reactivate redundant teams
UPDATE teams_team SET active=TRUE WHERE op in (
'Beşiktaş Esports',
'Cyber Gaming',
'Dark Passage',
'Denial eSports EU',
'Kx.Happy',
'NASR eSports Turkey',
'Nigma Galaxy Male',
'QLASH MENA',
'Shadow Battlica',
'Spear Gaming',
'TALON (Hong Kong Team)',
'Team Flash.Vietnam',
'Winners'
);
-- Removing all new sister teams --
DELETE FROM teams_teamsisterteam WHERE id in (SELECT id FROM teams_teamsisterteam WHERE (
(team_op_id=(SELECT id FROM teams_team WHERE op='00 Nation') AND sister_team_name IN ('00 Prospects')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='4Elements Esports') AND sister_team_name IN ('4Elements Scuttle Squad')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='A One Man Army Prime') AND sister_team_name IN ('A One Man Army', 'A One Man Army Prime Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ANc Outplayed') AND sister_team_name IN ('Outplayed Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ATR esports Denmark') AND sister_team_name IN ('ATR esports Denmark')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AZIO eSports') AND sister_team_name IN ('AZIO eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Absolved') AND sister_team_name IN ('Absolved Female', 'Absolved UK')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Aethra Esports Strijders') AND sister_team_name IN ('Aethra Esports', 'Aethra Esports Academy', 'Aethra Esports Belgium')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Angry Bats') AND sister_team_name IN ('Angry Bats Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Anorthosis Famagusta Esports') AND sister_team_name IN ('Anorthosis Famagusta Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Apex Mission Impossible') AND sister_team_name IN ('Apex Flame Horizon')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Arctic Gaming Mexico') AND sister_team_name IN ('Arctic Academy', 'Arctic Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Atleta Esport') AND sister_team_name IN ('Atleta Esport Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Awesome') AND sister_team_name IN ('Awesome Spear', 'Awesome Spear Academy', 'Spear Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BRUTE') AND sister_team_name IN ('BRUTE Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Barrage.NA') AND sister_team_name IN ('Barrage (British Team)', 'Barrage Academy', 'Barrage Esports Retirement Home')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Berlin International Gaming') AND sister_team_name IN ('Berlin International Gaming Chroma')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Beşiktaş.Oyun Hizmetleri') AND sister_team_name IN ('Beşiktaş Academy', 'Beşiktaş Esports', 'Beşiktaş.Oyun Hizmetleri')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Bifrost White') AND sister_team_name IN ('Bifrost')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Blue Otter') AND sister_team_name IN ('Blue Otter')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Bodin E-Sports') AND sister_team_name IN ('Bodin E-Sports Black', 'Bodin E-Sports White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Brussels Guardians Academy') AND sister_team_name IN ('Brussels Guardians')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CCG Esports') AND sister_team_name IN ('CCG Futures')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Chilly Mountain Wolves') AND sister_team_name IN ('Chilly Mountain Chipmunks')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Chungnam Juego Esports') AND sister_team_name IN ('Chungnam Juego Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Conviction') AND sister_team_name IN ('ConViction Moon', 'ConViction Sun')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CowBoySquad Imperials Esports') AND sister_team_name IN ('CowBoySquad Imperials Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cream Real Betis.EU') AND sister_team_name IN ('Cream Esports', 'Cream Real Betis.Mexico')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Crypto Esports.CIS') AND sister_team_name IN ('Crypto Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cyber Gaming Academy') AND sister_team_name IN ('Cyber Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DMG Esports') AND sister_team_name IN ('DMG Esports Denmark', 'DMG Esports Finland', 'DMG Esports Norway', 'DMG Esports Sweden', 'DMG Esports United Kingdom', 'DMG Esports Wings')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DOCISK') AND sister_team_name IN ('DOCISK Academy', 'DOCISK WSCHODNI', 'ESPORT ARENA DOCISK II')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dare Gaming') AND sister_team_name IN ('Dare Black', 'Dare White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dark Tigers') AND sister_team_name IN ('Dark Tigers Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dawn Esports') AND sister_team_name IN ('Dawn Esports Blaze', 'Dawn Esports Shock')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Deliverance Esports Peru') AND sister_team_name IN ('Deliverance Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Denial eSports.East') AND sister_team_name IN ('Denial eSports', 'Denial eSports EU')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Devils.one Academy') AND sister_team_name IN ('Devils.one', 'Devils.one Academy', 'Komputronik Gaming Scouting Grounds', 'devils.one Female')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dorado Gaming') AND sister_team_name IN ('Dorado Gaming Black', 'Dorado Gaming White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dynamo Eclot Talents') AND sister_team_name IN ('Dynamo Eclot')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dynasty') AND sister_team_name IN ('Dynasty Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='E-corp Gaming') AND sister_team_name IN ('E-corp Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EGN Esports') AND sister_team_name IN ('EGN Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ESuba') AND sister_team_name IN ('KIA.eSuba Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EWolves Ignis') AND sister_team_name IN ('EWolves Brazil', 'EWolves Lycans')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EYES ON U Europe') AND sister_team_name IN ('EYES ON U Europe')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Emerald Prisoners') AND sister_team_name IN ('Emerald Prisoners Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Europe Saviors Club') AND sister_team_name IN ('Europe Saviors Ice', 'Europe Saviors Omega', 'Europe Saviors Sugaar', 'Europe Saviors Tempest')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FLY5') AND sister_team_name IN ('FLY5 Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FPT Hanoi') AND sister_team_name IN ('FPT Ho Chi Minh')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Falcon E-Sports') AND sister_team_name IN ('Falcon E-Sports Red')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Falkol') AND sister_team_name IN ('Falkol Academy', 'Falkol Storm')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Flamengo MDL') AND sister_team_name IN ('Flamengo Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Flayn eSports') AND sister_team_name IN ('Flayn eSports', 'Flayn eSports CZSK Edition', 'Flayn eSports Danish Edition', 'Flayn eSports Dutch')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='For The Win Esports') AND sister_team_name IN ('For The Win Esports', 'For The Win Evolution')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Future Perfect Blue') AND sister_team_name IN ('Future Perfect Azure', 'Future Perfect Demacia', 'Future Perfect Ionia', 'Future Perfect Noxus', 'Future Perfect Orange', 'Future Perfect Purple', 'Future Perfect UA', 'Future Perfect WLGaming', 'Future Perfect Zaun')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GGEsports') AND sister_team_name IN ('GGEsports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Galaxy Racer Esports MENA Male') AND sister_team_name IN ('Galaxy Racer Esports EU Female', 'Galaxy Racer Esports EU Male', 'Galaxy Racer Esports MENA Female')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Galions') AND sister_team_name IN ('Galions Pearl')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GameWard') AND sister_team_name IN ('GameWard Academy', 'GameWard Astrals')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gamespace Mediterranean College Esports') AND sister_team_name IN ('Gamespace Mediterranean College Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gentlemen''s Gaming') AND sister_team_name IN ('Gentlemen''s Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Glacial Esports') AND sister_team_name IN ('Glacial Red')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gravity (2024 North American Team)') AND sister_team_name IN ('Gravity Galaxy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Grow uP eSports') AND sister_team_name IN ('Grow uP Escolinhas', 'Grow uP Girls EU')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Havan Liberty Gaming') AND sister_team_name IN ('Havan Liberty Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hive Athens EC') AND sister_team_name IN ('Hive Athens Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Htp eSport Akademie Hannover') AND sister_team_name IN ('ROSSMANN Centaurs')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hybrid Esports') AND sister_team_name IN ('Hybrid Esports Benelux', 'Hybrid Esports UK')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Inaequalis') AND sister_team_name IN ('Inaequalis Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Inside Games') AND sister_team_name IN ('Inside Games Academy', 'Inside Games Challengers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ion Squad') AND sister_team_name IN ('Ion Squad Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Izanagi eSports') AND sister_team_name IN ('Izanagi Ignis')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Janus Panter') AND sister_team_name IN ('Janus Esports', 'Janus Esports Academy', 'Janus Vipers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KV Mechelen Esports') AND sister_team_name IN ('KV Mechelen Esports Academy', 'KV Mechelen Esports Strijders')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KaBuM! IDM Gaming') AND sister_team_name IN ('KaBuM! IDM Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Keyd Warriors') AND sister_team_name IN ('Vivo Keyd')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LDLC OL') AND sister_team_name IN ('Tony Parker Adéquat Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LDM Esports') AND sister_team_name IN ('LDM Mexico')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LDN UTD') AND sister_team_name IN ('LDN UTD Ice')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LODIS (Polish Team)') AND sister_team_name IN ('LODIS Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Laranja Mecânica') AND sister_team_name IN ('Laranja Mecânica Ignis')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lotus (North American Team)') AND sister_team_name IN ('5 Seasons', 'Black Lotus', 'Keep Pathing Bot', 'Kurulean''s Kittens', 'Lotus Exiles')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lotus Bloom') AND sister_team_name IN ('Lotus Esports (2019 North American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LowLandLions') AND sister_team_name IN ('LowLandLions', 'LowLandLions.White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MIRAI (Brazilian Team)') AND sister_team_name IN ('MIRAI KICKS')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MNM Gaming') AND sister_team_name IN ('MnM Gaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Macko Academy') AND sister_team_name IN ('Macko Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Malvinas Gaming') AND sister_team_name IN ('Malvinas Gaming EU')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Maturalni Forsaken Academy') AND sister_team_name IN ('Maturalni Forsaken')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Maze Gaming') AND sister_team_name IN ('Maze Gaming Academy', 'Maze Gaming Female')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Milk Esports Whole Milk') AND sister_team_name IN ('Milk Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mirage Alliance') AND sister_team_name IN ('Mirage Alliance Developmental')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mkers Academy') AND sister_team_name IN ('Mkers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Munster Rugby Gaming') AND sister_team_name IN ('Munster Rugby Gaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NASR eSports') AND sister_team_name IN ('NASR eSports', 'NASR eSports Turkey', 'NASR eSports Turkey Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NORD Esports') AND sister_team_name IN ('NORD Polaris')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NYYRIKKI') AND sister_team_name IN ('NYYRIKKI', 'NYYRIKKI Academy', 'NYYRIKKI White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Naguara Team') AND sister_team_name IN ('Naguara Mexico')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='No Need Orga') AND sister_team_name IN ('NNO Prime', 'NNOwO')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ODD Esports') AND sister_team_name IN ('ODD Wara')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Orbit Anonymo Esports') AND sister_team_name IN ('Meavedron Anonymo Master Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PRIDE (Polish Team)') AND sister_team_name IN ('PRIDE Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PSV Esports') AND sister_team_name IN ('PSV Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Peak Performance X') AND sister_team_name IN ('Peak Performance X', 'Peak Performance Y')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Pentagon Rejects') AND sister_team_name IN ('Rejects Gaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Piratesports') AND sister_team_name IN ('Piratesports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Polar Squad Esports') AND sister_team_name IN ('Polar Squad Esports Female')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Pulse Star') AND sister_team_name IN ('Pulse Gooners', 'Pulse Star Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='QLASH Egypt') AND sister_team_name IN ('QLASH Egypt', 'QLASH Forge', 'QLASH Forge Academy', 'QLASH Midnight', 'QLASH Spain', 'Team QLASH Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Raizen Kicks') AND sister_team_name IN ('Raizen E-Sports', 'Tropa Raizen')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Resolve Blue') AND sister_team_name IN ('Resolve', 'Resolve Academy', 'Resolve NA')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Riddle NO') AND sister_team_name IN ('Riddle Esports', 'Riddle Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Rise Gaming') AND sister_team_name IN ('Rise Gaming Ignis')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='S2V Esports') AND sister_team_name IN ('S2V Esports', 'S2V Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sector One') AND sister_team_name IN ('Sector One Academy', 'Sector One Black', 'Sector One Fox')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Shadow Corp') AND sister_team_name IN ('GJ Shadow', 'Shadow Academy', 'Shadow Anyche', 'Shadow Battlica', 'Shadow Battlica Y', 'Shadow Boxing', 'Shadow Cool', 'Shadow Dawn', 'Shadow Deeplol', 'Shadow Dreamer', 'Shadow EK', 'Shadow ELG', 'Shadow GT', 'Shadow IBJ', 'Shadow LNG', 'Shadow New', 'Shadow RGS', 'Shadow SF', 'Shadow Zero', 'Shadow fOu')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Solary') AND sister_team_name IN ('Lunary', 'Solary Academy', 'Solary Legends')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Starlan Gaming Club Academy') AND sister_team_name IN ('Starlan Gaming Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='StormMedia Fajnie Mieć Skład') AND sister_team_name IN ('Fajnie Mieć Skład Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Striking Vipers Champions') AND sister_team_name IN ('Striking Vipers', 'Striking Vipers Maestros')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Supernova') AND sister_team_name IN ('Dark Matter', 'Super Nova Sentinels', 'Supernova', 'Supernova Comets')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Tan''i eSports') AND sister_team_name IN ('Tan''i eSports Academy', 'Tan''i eSports CZ')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team 7AM') AND sister_team_name IN ('Team 7AM Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Ambition') AND sister_team_name IN ('Team Ambition Black', 'Team Ambition Blaze', 'Team Ambition Red', 'Team Ambition Sussy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Atlantis') AND sister_team_name IN ('Team Atlantis')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Flash.Singapore') AND sister_team_name IN ('Team Flash.Vietnam')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Forge') AND sister_team_name IN ('Team Forge')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team MCES') AND sister_team_name IN ('MCES Italia', 'MCES Italia Academy', 'Team MCES Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Phantasma') AND sister_team_name IN ('Team Phantasma Community')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Queso') AND sister_team_name IN ('Arena Quesito', 'Estadio Quesito')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Refuse') AND sister_team_name IN ('Team Refuse Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Singularity') AND sister_team_name IN ('Team Singularity')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team THRLL Academy') AND sister_team_name IN ('Team THRLL')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='TeamOrangeGaming') AND sister_team_name IN ('TeamOrangeGaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Nameless') AND sister_team_name IN ('Nameless Randoms', 'Nameless Thieves')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Timeout Esports') AND sister_team_name IN ('Timeout Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ToxicFalcons eSports') AND sister_team_name IN ('ToxicFalcons eSports', 'ToxicFalcons eSports Belgium')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Triumphant Song Gaming') AND sister_team_name IN ('Victory Song Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='UCAM Esports') AND sister_team_name IN ('UCAM Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vikingekrig Esports') AND sister_team_name IN ('Vikingekrig Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='WAP Esports') AND sister_team_name IN ('WAP Esports Academy', 'WAP Esports Female')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='WLGaming Esports') AND sister_team_name IN ('WLGaming Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='We Plash Academy') AND sister_team_name IN ('We Plash Trainee')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='WiLD MultiGaming') AND sister_team_name IN ('WiLD Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wildcard Gaming') AND sister_team_name IN ('Wildcard Aces', 'Wildcard Gaming Black', 'Wildcard Gaming Developmental', 'Wildcard Gaming Red')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wind and Rain') AND sister_team_name IN ('Wind and Rain')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='X6tence') AND sister_team_name IN ('X6tence Academy', 'X6tence Mexico')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='X7 Ascent') AND sister_team_name IN ('X7 Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='XT Esports') AND sister_team_name IN ('XT Gurb Nation')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zenigma') AND sister_team_name IN ('Zenigma Eclipse', 'Zenigma Lunar', 'Zenigma Solar')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zephyr Esport') AND sister_team_name IN ('Zephyr Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zero Tenacity Spears') AND sister_team_name IN ('Zero Tenacity')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zerolag Esports') AND sister_team_name IN ('Zerolag Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zwan Gaming Mexico') AND sister_team_name IN ('Zwan Gaming', 'Zwan Gaming Colombia')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='100 Thieves') AND sister_team_name IN ('100 Thieves Academy', '100 Thieves Challengers', '100 Thieves Next')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='5 Ronin') AND sister_team_name IN ('5 Ronin Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AXIZ') AND sister_team_name IN ('AXIZ Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AXIZ CREST') AND sister_team_name IN ('AXIZ CREST Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Absolute Legends') AND sister_team_name IN ('Absolute Legends CZSK', 'Absolute Legends Netherlands')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Abyss Academy') AND sister_team_name IN ('Abyss Esports White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Albus NoX Luna') AND sister_team_name IN ('Albus NoX Cometa')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Anyone''s Legend') AND sister_team_name IN ('Anyone''s Legend.Young')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Apex Gaming') AND sister_team_name IN ('Apex Pride')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Astralis') AND sister_team_name IN ('Astralis SB', 'Astralis Talent')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Avant Gaming') AND sister_team_name IN ('Avant Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Azules Esports') AND sister_team_name IN ('Azules Esports Academy', 'Azules Esports Fem')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BNK FEARX') AND sister_team_name IN ('BNK FEARX Academy', 'BNK FEARX Youth')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Beyond Gaming') AND sister_team_name IN ('Beyond Gaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Big Gods') AND sister_team_name IN ('Big Gods Jackals')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Big Plays Incorporated') AND sister_team_name IN ('BPI Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Bombers') AND sister_team_name IN ('Bombers Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BrawL eSports') AND sister_team_name IN ('BrawL.NA')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Burning Core Toyama') AND sister_team_name IN ('Burning Core Toyama Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CERBERUS Esports (Vietnamese Team)') AND sister_team_name IN ('Puppies Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CNB e-Sports Club') AND sister_team_name IN ('CNB Infinity', 'CNB Trinity White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CTBC Flying Oyster') AND sister_team_name IN ('CTBC Flying Oyster Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CTRL PLAY') AND sister_team_name IN ('CTRL PLAY Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CTU Pathos') AND sister_team_name IN ('CTU Logos')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cloud9') AND sister_team_name IN ('Cloud9 Academy', 'Cloud9 Amateur', 'Cloud9 Challengers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CompLexity.Black') AND sister_team_name IN ('CompLexity.Red')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Counter Logic Gaming') AND sister_team_name IN ('CLG Academy', 'CLG Black', 'CLG Challengers', 'CLG Faith')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Crest Gaming Act') AND sister_team_name IN ('Crest Gaming Act Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cruzeiro eSports') AND sister_team_name IN ('Cruzeiro Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DN Freecs') AND sister_team_name IN ('DN Freecs Academy', 'DN Freecs Challengers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DRX') AND sister_team_name IN ('DRX Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Deep Cross Gaming') AND sister_team_name IN ('Deep Cross Gaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DetonatioN FocusMe') AND sister_team_name IN ('DetonatioN FocusMe Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dewish Team') AND sister_team_name IN ('Dewish Tnu Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dignitas') AND sister_team_name IN ('Dignitas Academy', 'Dignitas Challengers', 'Dignitas Mirage', 'Team Dignitas EU')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dire Wolves') AND sister_team_name IN ('Dire Cubs')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dplus KIA') AND sister_team_name IN ('Dplus KIA Challengers', 'Dplus KIA Youth')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dragon Army') AND sister_team_name IN ('Dragon Army Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dragon Gate Team') AND sister_team_name IN ('Fish Dive Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='E-Champ Gaming') AND sister_team_name IN ('e-Champ Gaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EDward Gaming') AND sister_team_name IN ('EDward Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Echo Fox') AND sister_team_name IN ('Delta Fox', 'Echo Fox Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Estral Esports') AND sister_team_name IN ('Estral E-Sports Colombia', 'Estral Esports Aurora')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Evil Geniuses.NA') AND sister_team_name IN ('Evil Geniuses Academy', 'Evil Geniuses Challengers', 'Evil Geniuses Prodigies')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Excel Esports') AND sister_team_name IN ('JDXL')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FC Schalke 04 Esports') AND sister_team_name IN ('FC Schalke 04 Evolution')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FENNEL') AND sister_team_name IN ('FENNEL Academy', 'Rascal Jester Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FURIA') AND sister_team_name IN ('FURIA Academy', 'FURIA Youth')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fenerbahçe Esports') AND sister_team_name IN ('Fenerbahçe Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FlyQuest') AND sister_team_name IN ('FLY FAM', 'FlyQuest Academy', 'FlyQuest Challengers', 'FlyQuest NZXT')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fnatic') AND sister_team_name IN ('Fnatic Rising', 'Fnatic TQ')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Frank Esports') AND sister_team_name IN ('Frank Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fukuoka SoftBank HAWKS gaming') AND sister_team_name IN ('Fukuoka SoftBank HAWKS gaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Furious Gaming') AND sister_team_name IN ('Furious Gaming Academy', 'Furious Gaming Argentina', 'Furious Gaming Chile')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='G-Rex') AND sister_team_name IN ('G-Rex Infinite')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='G2 Esports') AND sister_team_name IN ('G2 Arctic', 'G2 Hel', 'G2 Heretics', 'G2 Vodafone')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GC Busan Ascension') AND sister_team_name IN ('GC Busan (2020 Korean Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GIANTX') AND sister_team_name IN ('GIANTX Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Galakticos') AND sister_team_name IN ('Galakticos Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Galatasaray Esports') AND sister_team_name IN ('Galatasaray Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gama Dream') AND sister_team_name IN ('Gama E-Sport Dream')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gambit Esports') AND sister_team_name IN ('Gambit.CIS Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gen.G') AND sister_team_name IN ('Gen.G Global Academy', 'Gen.G Scholars')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Giants Gaming') AND sister_team_name IN ('Vodafone Giants Academy', 'Vodafone Giants White', 'Vodafone Giants.Spain')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Globant Emerald') AND sister_team_name IN ('Globant Emerald Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Golden Guardians') AND sister_team_name IN ('Golden Guardians Academy', 'Golden Guardians Challengers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gravitas') AND sister_team_name IN ('Gravitas Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hanwha Life Esports') AND sister_team_name IN ('Hanwha Life Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hong Kong Attitude') AND sister_team_name IN ('Hong Kong Attitude Mage', 'Hong Kong Attitude Priest')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='INFINITY') AND sister_team_name IN ('INFINITY Female', 'Infinity Esports Academy', 'Infinity Esports Colombia', 'Infinity Esports Costa Rica')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='INTZ') AND sister_team_name IN ('INTZ Academy', 'INTZ Blue')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Immortals') AND sister_team_name IN ('Immortals Academy', 'Immortals Area of Effect', 'Immortals Challengers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Iron Hawks e-Sports') AND sister_team_name IN ('Iron Hawks Ultimate')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Istanbul Wildcats') AND sister_team_name IN ('Istanbul Wildcats Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Isurus') AND sister_team_name IN ('Isurus Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='J Team') AND sister_team_name IN ('J Team 2', 'Taipei Bravo')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KT Rolster') AND sister_team_name IN ('KT Rolster Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KaBuM! Esports') AND sister_team_name IN ('KaBuM! Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Kaos Latin Gamers') AND sister_team_name IN ('Kaos Latin Gamers Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Karmine Corp') AND sister_team_name IN ('Karmine Corp Blue', 'Karmine Corp Blue Stars')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LGD Gaming') AND sister_team_name IN ('VP Game')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LNG Esports') AND sister_team_name IN ('Snake WuDu')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LOUD') AND sister_team_name IN ('LOUD Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LYON (2024 American Team)') AND sister_team_name IN ('LYON Academy', 'Lyon Gaming (2017 Latin America North Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Leviatan') AND sister_team_name IN ('Leviatan Esports Chile')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Liberty') AND sister_team_name IN ('Liberty Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Los Grandes') AND sister_team_name IN ('Los Grandes Academy', 'Los Grandes Rookie', 'Los Grandes Trainee')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lowkey Esports.Vietnam') AND sister_team_name IN ('Lowkey Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MAMMOTH') AND sister_team_name IN ('Mammoth Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MGN Vikings Esports') AND sister_team_name IN ('MGN Vikings Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Machi Esports') AND sister_team_name IN ('MachiX')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Millenium') AND sister_team_name IN ('Millenium Spirit')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Miners') AND sister_team_name IN ('Miners Academy', 'Miners Female', 'Netshoes Miners Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Misfits Gaming') AND sister_team_name IN ('Misfits Premier')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Movistar KOI') AND sister_team_name IN ('Movistar KOI Fénix')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mysterious Monkeys') AND sister_team_name IN ('Ad hoc gaming', 'Ad hoc gaming Gentlemen''s Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Newbee') AND sister_team_name IN ('Newbee Young')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ninjas in Pyjamas.CN') AND sister_team_name IN ('Ji Jie Hao', 'Young Ninjas')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Nongshim RedForce') AND sister_team_name IN ('Nongshim Esports Academy', 'Nongshim RedForce Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='OKSavingsBank BRION') AND sister_team_name IN ('OKSavingsBank BRION Academy', 'OKSavingsBank BRION Challengers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ORDER') AND sister_team_name IN ('ORDER Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Oh My God') AND sister_team_name IN ('Oh My God Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Operation Kino e-Sports') AND sister_team_name IN ('Operation Kino Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Oyun Hizmetleri') AND sister_team_name IN ('Oyun Hizmetleri CILEKLER')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PaiN Gaming') AND sister_team_name IN ('PaiN Gaming Academy', 'PaiN Gaming Female')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RED Canids') AND sister_team_name IN ('RED Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Rare Atom') AND sister_team_name IN ('Rare Atom Period')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Redemption eSports Porto Alegre') AND sister_team_name IN ('Redemption Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Renegades') AND sister_team_name IN ('Renegades: Banditos')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Rensga Esports') AND sister_team_name IN ('Rensga Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Rogue (European Team)') AND sister_team_name IN ('AGO ROGUE', 'Rogue Esports Club', 'Rogue Stars')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Royal Youth') AND sister_team_name IN ('Royal Youth Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SK Gaming') AND sister_team_name IN ('SK Gaming Avarosa')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sengoku Gaming') AND sister_team_name IN ('Sengoku Gaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SeolHaeOne Prince') AND sister_team_name IN ('SeolHaeOne Prince Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Seorabeol Gaming') AND sister_team_name IN ('ESC Shane')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sin Gaming') AND sister_team_name IN ('Sin Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SuperMassive Blaze') AND sister_team_name IN ('SuperMassive Academy', 'SuperMassive Blaze Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='T1') AND sister_team_name IN ('T1 Esports Academy', 'T1 Esports Academy Rookies')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='TSM') AND sister_team_name IN ('TSM Academy', 'TSM Amateur', 'TSM Challengers', 'TSM Darkness')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team AURORA') AND sister_team_name IN ('Team AURORA Academy', 'Team Orora')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Afro') AND sister_team_name IN ('BUFF')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team BDS') AND sister_team_name IN ('Team BDS Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Coast') AND sister_team_name IN ('Team Coast Gold')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Heretics') AND sister_team_name IN ('Los Heretics')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Just') AND sister_team_name IN ('Team Just Challenger', 'Team Just Ice')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Liquid') AND sister_team_name IN ('Team Liquid Challengers', 'Team Liquid First')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Secret Whales') AND sister_team_name IN ('Baby Whales', 'Saigon Secret', 'Team Secret (Vietnamese Team) Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Vitality') AND sister_team_name IN ('Vitality Rising Bees', 'Vitality.Bee', 'Yellow Stripes')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team WE') AND sister_team_name IN ('Mighty Eagle')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Tectonic') AND sister_team_name IN ('Tectonic Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Kings') AND sister_team_name IN ('The Kings Academy', 'The Kings Colombia', 'The Kings Moon')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ThunderTalk Gaming') AND sister_team_name IN ('ThunderTalk Gaming Young')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Top Esports') AND sister_team_name IN ('King of Future', 'Top Esports Challenger')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ultra Prime') AND sister_team_name IN ('Ultra Prime Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Unicorns of Love.CIS') AND sister_team_name IN ('Unicorns of Love Sexy Edition')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='V3 Esports') AND sister_team_name IN ('V3 Esports Academy', 'V3 New Generation')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='VVv Gaming') AND sister_team_name IN ('VVv Gaming Red', 'VVv Gaming White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vivo Keyd Stars') AND sister_team_name IN ('Vivo Keyd Stars Academy', 'Vivo Keyd Stars Ignis')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='West Point Esports Philippines') AND sister_team_name IN ('West Point Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wings of Aurora') AND sister_team_name IN ('Titan Catipay')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='XTEN Esports') AND sister_team_name IN ('XTEN Mexico'))));
-- Removing all new alternate names --
DELETE FROM teams_teamalternatename WHERE id in (SELECT id FROM teams_teamalternatename WHERE (
(team_op_id=(SELECT id FROM teams_team WHERE op='00 Nation') AND alternate_name IN ('00 Nation', '00 Prospects', 'Nordavind', 'Nordavind Black', 'Nordavind Talent', 'Nordavind White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='1. Berliner Esport-Club e.V.') AND alternate_name IN ('1. Berliner Esport-Club e.V.')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='19esports') AND alternate_name IN ('19esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='24 7 Tower Dive') AND alternate_name IN ('24 7 Tower Dive')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='2Kill Gaming') AND alternate_name IN ('2Kill Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='300 (North American Team)') AND alternate_name IN ('300 (North American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='34united e-Sports Club') AND alternate_name IN ('34united e-Sports Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='3D Revolution') AND alternate_name IN ('3D Revolution')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='3v Team') AND alternate_name IN ('3v Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='404 Multigaming e.V.') AND alternate_name IN ('404 Multigaming e.V.')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='42 Gaming') AND alternate_name IN ('42 Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='4Elements Esports') AND alternate_name IN ('4Elements Esports', '4Elements Scuttle Squad')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='4everzenzyg') AND alternate_name IN ('4everzenzyg')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='7REX') AND alternate_name IN ('7REX')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='9z Team') AND alternate_name IN ('9z Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='A One Man Army Prime') AND alternate_name IN ('A One Man Army', 'A One Man Army Prime')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ACE 1') AND alternate_name IN ('ACE 1')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ACTINA PACT') AND alternate_name IN ('ACTINA PACT')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AGD E-Sports') AND alternate_name IN ('AGD E-Sports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AM All-Stars') AND alternate_name IN ('AM All-Stars')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ANON (North American Team)') AND alternate_name IN ('ANON (North American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ANc Legends') AND alternate_name IN ('ANc Legends')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ANc Outplayed') AND alternate_name IN ('ANc Outplayed', 'Outplayed', 'Outplayed Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AOC Gaming') AND alternate_name IN ('AOC Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='APOLLO GAMING Academy') AND alternate_name IN ('APOLLO GAMING Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AS Trenčín esports') AND alternate_name IN ('AS Trenčín esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ASP Esports') AND alternate_name IN ('ASP Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ATR esports Denmark') AND alternate_name IN ('ATR esports Denmark')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AVANGAR') AND alternate_name IN ('AVANGAR')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AVE Axolotl') AND alternate_name IN ('AVE Axolotl', 'Axolotl', 'Axolotl Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AVEZ Esport') AND alternate_name IN ('AVEZ Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AYM Esports') AND alternate_name IN ('AYM Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AZIO eSports') AND alternate_name IN ('AZIO eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AaB Esport') AND alternate_name IN ('AaB Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Abandoned Kittens') AND alternate_name IN ('Abandoned Kittens')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Able Esports') AND alternate_name IN ('Able Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Absolved') AND alternate_name IN ('Absolved', 'Absolved Denmark', 'Absolved Female')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Abyssal Esport Club') AND alternate_name IN ('Abyssal Esport Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AceS GaminG') AND alternate_name IN ('AceS GaminG')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Actions Per Minute') AND alternate_name IN ('Actions Per Minute')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Actions Per Minute Academy') AND alternate_name IN ('Actions Per Minute Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Activit-E') AND alternate_name IN ('Activit-E')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Adive') AND alternate_name IN ('Adive')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Adriatic Wolves') AND alternate_name IN ('Adriatic Wolves')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Adverse') AND alternate_name IN ('Adverse', 'Zen Aïe Tea Refugees', 'ZennIT Refugees')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Aegis (French Team)') AND alternate_name IN ('Aegis (French Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Aegis Flames e-Sports') AND alternate_name IN ('Aegis Flames e-Sports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Aethernum eSports') AND alternate_name IN ('Aethernum eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Aethra Esports Strijders') AND alternate_name IN ('Aethra Esports', 'Aethra Esports Academy', 'Aethra Esports Belgium', 'Aethra Esports Gold', 'Aethra Esports Strijders')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AffNity') AND alternate_name IN ('AffNity')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Afterglow Esports') AND alternate_name IN ('Afterglow Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Aftershock Esports') AND alternate_name IN ('Aftershock Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Aguilas Doradas') AND alternate_name IN ('Aguilas Doradas')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Akademia') AND alternate_name IN ('Akademia')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Akademia Hatiego 2') AND alternate_name IN ('Akademia Hatiego 2')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Akroma') AND alternate_name IN ('Akroma')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Akuma Esports') AND alternate_name IN ('Akuma Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Akuma Scythes') AND alternate_name IN ('Akuma Scythes')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Alice Queen') AND alternate_name IN ('Alice Queen')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AlienTech eSports') AND alternate_name IN ('AlienTech eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AliorBank Team') AND alternate_name IN ('AliorBank Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='All Combo') AND alternate_name IN ('All Combo')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='All for One Gaming') AND alternate_name IN ('All for One Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Alpha Sydney') AND alternate_name IN ('Alpha Sydney')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Alpha7 Esports') AND alternate_name IN ('Alpha7 Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Also Known As') AND alternate_name IN ('Also Known As')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Altay Espor') AND alternate_name IN ('Altay Espor')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Always With Honor (Turkish Team)') AND alternate_name IN ('Always With Honor', 'Always With Honor (Turkish Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ambys Team') AND alternate_name IN ('Ambys Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ancestors eSports') AND alternate_name IN ('Ancestors eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Andromeda Gaming') AND alternate_name IN ('Andromeda Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Angry Bats') AND alternate_name IN ('Angry Bats')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Anima') AND alternate_name IN ('Anima')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ankora Gaming') AND alternate_name IN ('Ankora Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Anorthosis Famagusta Esports') AND alternate_name IN ('Anorthosis Famagusta Esports', 'Anorthosis Famagusta Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Anorthosis Famagusta Esports Revolution') AND alternate_name IN ('Anorthosis Famagusta Esports Academy', 'Anorthosis Famagusta Esports Revolution')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Another Troll Team') AND alternate_name IN ('Another Troll Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Antares Esports') AND alternate_name IN ('Antares Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Anzu Esports Club') AND alternate_name IN ('Anzu Esports Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Anáhuac Esports') AND alternate_name IN ('Anáhuac Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Apex Mission Impossible') AND alternate_name IN ('Apex Flame Horizon', 'Apex Mission Impossible')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Apocalypse e-Sports') AND alternate_name IN ('Apocalypse e-Sports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Aporia') AND alternate_name IN ('Aporia')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Aqualix Esports.NA') AND alternate_name IN ('Aqualix Esports.NA')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Aquatik Esports') AND alternate_name IN ('Aquatik Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Aquinas College') AND alternate_name IN ('Aquinas College')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Arctic Gaming Mexico') AND alternate_name IN ('Arctic Academy', 'Arctic Gaming', 'Arctic Gaming Mexico')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Arctic Kings') AND alternate_name IN ('Arctic Kings', 'Arctic Kings White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Area of Effect Dream') AND alternate_name IN ('Area of Effect Dream')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Area of Effect Soupy Time') AND alternate_name IN ('Area of Effect Soupy Time')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ares Gaming') AND alternate_name IN ('Ares Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Aris Esports') AND alternate_name IN ('Aris Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Arizona State University') AND alternate_name IN ('Arizona State University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Arsenal') AND alternate_name IN ('Arsenal')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ascendance (Turkish Team)') AND alternate_name IN ('Ascendance (Turkish Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Association de Gaming et d''Esport de Mons') AND alternate_name IN ('Association de Gaming et d''Esport de Mons')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Aston eSports') AND alternate_name IN ('Aston eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Astral Authority') AND alternate_name IN ('Astral Authority')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Asura eSports') AND alternate_name IN ('Asura eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Atheris Esports') AND alternate_name IN ('Atheris Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Athletico Esports') AND alternate_name IN ('Athletico Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Atlando Esports') AND alternate_name IN ('Atlando Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Atlas (Italian Team)') AND alternate_name IN ('Atlas (Italian Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Atleta Esport') AND alternate_name IN ('Atleta Esport', 'Atleta Esport Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Atletec') AND alternate_name IN ('Atletec')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Atomic México') AND alternate_name IN ('Atomic México')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Aurelius Esports') AND alternate_name IN ('Aurelius Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Aurora (Belgian Team)') AND alternate_name IN ('Aurora (Belgian Team)', 'Northern Lights')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Australs') AND alternate_name IN ('Australs')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Austrian Force willhaben') AND alternate_name IN ('Austrian Force eSports', 'Austrian Force willhaben')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Auxesis Esports') AND alternate_name IN ('Auxesis Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Auxesis Green') AND alternate_name IN ('Auxesis Green')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Auxesis Red') AND alternate_name IN ('Auxesis Red')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AvaTrade PixelPenny') AND alternate_name IN ('AvaTrade PixelPenny')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Avia Deceptor') AND alternate_name IN ('Avia Deceptor', 'Wszyscy jesteśmy Szczurami')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Aware Gaming') AND alternate_name IN ('Aware Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Away from Normal') AND alternate_name IN ('Away from Normal', 'Away from Normal Yellow')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Awesome') AND alternate_name IN ('Avengers', 'Awesome', 'Awesome (Awesome Spear Academy)', 'Awesome Spear', 'Awesome Spear Academy', 'BeomSAMA', 'BeomSAMA Fan Club', 'Spear Gaming', '바무템제도', '범사마')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BBL Dark Passage') AND alternate_name IN ('BBL Dark Passage', 'Dark Passage', 'Dark Passage Academy', 'Dark Passage White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BCN Squad') AND alternate_name IN ('BCN Squad', 'Origen BCN')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BEAGLE BROTHERS') AND alternate_name IN ('BEAGLE BROTHERS')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BENZO esport') AND alternate_name IN ('BENZO esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BERZLOY') AND alternate_name IN ('BERZLOY')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BISONS ECLUB') AND alternate_name IN ('BISONS ECLUB')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BK ROG Esports') AND alternate_name IN ('BK ROG Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BLACKLIST') AND alternate_name IN ('BLACKLIST')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BOOBA') AND alternate_name IN ('BOOBA')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BPZ') AND alternate_name IN ('BPZ')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BRUTE') AND alternate_name IN ('BRUTE', 'BRUTE Academy', 'BRUTE EVO', 'BRUTE Talents')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BWE Esports') AND alternate_name IN ('BWE Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Baam Esports') AND alternate_name IN ('Baam Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Babos Gaming') AND alternate_name IN ('Babos Gaming', 'Babos Gaming Boys Love')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Baby Buffaloes') AND alternate_name IN ('Baby Buffaloes')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Baby Paradise') AND alternate_name IN ('Baby Paradise')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Back2TheGame') AND alternate_name IN ('Back2TheGame', 'Back2TheGame Outlaws')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ball State University') AND alternate_name IN ('Ball State University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Bandits Gaming') AND alternate_name IN ('Bandits Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Barcelona BG') AND alternate_name IN ('Barcelona BG')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Barcząca Esports') AND alternate_name IN ('Barcząca Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Barrage.NA') AND alternate_name IN ('Barrage (British Team)', 'Barrage Academy', 'Barrage Esports Retirement Home', 'Barrage.NA')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Barça eSports') AND alternate_name IN ('Barça eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Bastille Legacy') AND alternate_name IN ('Bastille Legacy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Bastu Five') AND alternate_name IN ('Bastu Five')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Bawk Bawk') AND alternate_name IN ('Bawk Bawk', 'Lost Draft')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Bay State College') AND alternate_name IN ('Bay State College', 'Bay State College 2', 'Bay State College B')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BeFive') AND alternate_name IN ('BeFive')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BeGenius ESC') AND alternate_name IN ('BeGenius ESC')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Beast Esports') AND alternate_name IN ('Beast Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Beetle Juice') AND alternate_name IN ('Beetle Juice')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Belfast Storm') AND alternate_name IN ('Belfast Storm')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Benefactor''s Revenge') AND alternate_name IN ('Benefactor''s Revenge')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Benelux United') AND alternate_name IN ('Benelux United')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Berlin International Gaming') AND alternate_name IN ('Berlin International Gaming', 'Berlin International Gaming (Female and Non-Binary Team)', 'Berlin International Gaming Chroma')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Bethany Lutheran College') AND alternate_name IN ('Bethany Lutheran College', 'Bethany Lutheran College B')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Beşiktaş.Oyun Hizmetleri') AND alternate_name IN ('Beşiktaş Academy', 'Beşiktaş Esports', 'Beşiktaş.Oyun Hizmetleri')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Bifrost White') AND alternate_name IN ('Bifrost', 'Bifrost White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Big Dog') AND alternate_name IN ('Big Dog')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Big Dragon57') AND alternate_name IN ('Big Dragon57')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Big Duck Energy') AND alternate_name IN ('Big Duck Energy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Big One Gaming') AND alternate_name IN ('Big One Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Black Eagles') AND alternate_name IN ('Black Eagles')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Black Lion') AND alternate_name IN ('Black Lion')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Black Panthers eSports') AND alternate_name IN ('Black Panthers eSports', 'CGG Black Panthers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Black Rock Esports') AND alternate_name IN ('Black Rock Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Blade Edge') AND alternate_name IN ('Blade Edge')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BloodRain-Gaming') AND alternate_name IN ('BloodRain-Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Bloodline Esports') AND alternate_name IN ('Bloodline Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Blue Esports') AND alternate_name IN ('Blue Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Blue Otter') AND alternate_name IN ('Blue Otter')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BlueWhites') AND alternate_name IN ('BlueWhites')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Boavista FC') AND alternate_name IN ('Boavista FC')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Boca Juniors Gaming') AND alternate_name IN ('Boca Juniors Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Bodin E-Sports') AND alternate_name IN ('Bodin Academy', 'Bodin E-Sports', 'Bodin E-Sports Black', 'Bodin E-Sports White', 'Bodin Legacy', 'Bodin Standard', 'Bodin Trainee')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Bogged') AND alternate_name IN ('Bogged')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Boise State University') AND alternate_name IN ('Boise State University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BoostGate Esports') AND alternate_name IN ('BoostGate Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Bootz Gaming') AND alternate_name IN ('Bootz Dark Moon', 'Bootz Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Boutgamers sexy edition') AND alternate_name IN ('Boutgamers sexy edition')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Braves Rising') AND alternate_name IN ('Braves Rising')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Briar Cliff University') AND alternate_name IN ('Briar Cliff University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Bring It On') AND alternate_name IN ('Bring It On')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Broke') AND alternate_name IN ('Broke')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Brussels Guardians Academy') AND alternate_name IN ('Brussels Guardians', 'Brussels Guardians Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Buff Katarina') AND alternate_name IN ('Buff Katarina')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Bulldog Esports') AND alternate_name IN ('Bulldog Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Burger Flippers (Female Team)') AND alternate_name IN ('Burger Flippers (Female Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Bushido Wildcats') AND alternate_name IN ('Bushido Wildcats')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BuzzKill') AND alternate_name IN ('BuzzKill')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CASLA Esports') AND alternate_name IN ('CASLA Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CB Gaming') AND alternate_name IN ('CB Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CBS Esports') AND alternate_name IN ('CBS Esports', 'Cowboy Squad')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CC Club') AND alternate_name IN ('CC Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CCG Esports') AND alternate_name IN ('CCG Esports', 'CCG Futures', 'Horizon Gaming (North American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CCG Glorp') AND alternate_name IN ('CCG Glorp')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CGN Esports') AND alternate_name IN ('CGN Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CITA Kaizen') AND alternate_name IN ('CITA Kaizen', 'Team Kaizen')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CLN Vipers') AND alternate_name IN ('CLN Vipers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CONQUEROR Gaming') AND alternate_name IN ('CONQUEROR Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CORE 128') AND alternate_name IN ('CORE 128')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='COS City Hawk') AND alternate_name IN ('COS City Hawk')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CPLAY') AND alternate_name IN ('CPLAY')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CST Team') AND alternate_name IN ('CST Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Calamity Esports') AND alternate_name IN ('Calamity Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Caldya Esport') AND alternate_name IN ('Caldya Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Campbellsville University') AND alternate_name IN ('Campbellsville University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Campus Party Sparks') AND alternate_name IN ('5 Hydra Esport', 'Campus Party Sparks')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cannot be asked') AND alternate_name IN ('Cannot be asked')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Carleton University') AND alternate_name IN ('Carleton University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Carolina Reapers') AND alternate_name IN ('Carolina Reapers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Carthage Legionnaires') AND alternate_name IN ('Carthage Legionnaires')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Case Esports') AND alternate_name IN ('Case Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Castle Berry') AND alternate_name IN ('Castle Berry')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cattleya Gaming') AND alternate_name IN ('Cattleya Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Celestial Gaming') AND alternate_name IN ('Celestial Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cerberus e-Sports Club') AND alternate_name IN ('Cerberus e-Sports Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ceuta Guardians') AND alternate_name IN ('Ceuta Guardians', 'Heracles Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Challenger Cookie Monsters') AND alternate_name IN ('Challenger Cookie Monsters')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Chaotic Blaze') AND alternate_name IN ('Chaotic Blaze')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Chaotic Fusion') AND alternate_name IN ('Chaotic Fusion')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Chaotic Solar') AND alternate_name IN ('Chaotic Solar')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Charlotte Phoenix') AND alternate_name IN ('Charlotte Phoenix')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Chasing Haze 07') AND alternate_name IN ('Chasing Haze 07')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Chester Gaming Kitten Esports Club') AND alternate_name IN ('Chester Gaming Kitten Esports Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Chi Army') AND alternate_name IN ('Chi Army')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Chienhsin Bear') AND alternate_name IN ('Chienhsin Bear')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Chilli Esport') AND alternate_name IN ('Chilli Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Chilling Cats') AND alternate_name IN ('Angry Bats Academy', 'Chilling Cats')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Chilly Mountain Wolves') AND alternate_name IN ('Chilly Mountain Chipmunks', 'Chilly Mountain Wolves')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Chivas Esports') AND alternate_name IN ('Chivas Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Chong Qing Gaming') AND alternate_name IN ('CCfuture', 'Chong Qing Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Chungnam Juego Esports') AND alternate_name IN ('Chungnam Juego Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cidade Curiosa Esports') AND alternate_name IN ('Cidade Curiosa Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cienciano Esports') AND alternate_name IN ('Cienciano Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Citadel Gaming') AND alternate_name IN ('Citadel Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cleary University') AND alternate_name IN ('Cleary University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Clown Gaming') AND alternate_name IN ('Clown Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Club Deportivo Municipal') AND alternate_name IN ('Club Deportivo Municipal')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cold Hearted') AND alternate_name IN ('Cold Hearted')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Coliseo Dragons') AND alternate_name IN ('Coliseo Dragons')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Colorado State University') AND alternate_name IN ('Colorado State University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Colossal Gaming') AND alternate_name IN ('Colossal Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Columbia College') AND alternate_name IN ('Columbia College')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Comanchero Gaming') AND alternate_name IN ('Comanchero Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Comeback Kid') AND alternate_name IN ('Comeback Kid')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Connect Arena Esports') AND alternate_name IN ('Connect Arena Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Connecting Esports') AND alternate_name IN ('Connecting Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Contingent Esports') AND alternate_name IN ('Contingent Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Converse University') AND alternate_name IN ('Converse University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Convict of Shadows') AND alternate_name IN ('Convict of Shadows')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Conviction') AND alternate_name IN ('ConViction B', 'ConViction Moon', 'ConViction Sun', 'Conviction')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Coopa Troopas') AND alternate_name IN ('Coopa Troopas')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Copenhagen Flames') AND alternate_name IN ('Copenhagen Flames')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Corax Gaming') AND alternate_name IN ('Corax Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Core Dynamic') AND alternate_name IN ('Core Dynamic')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Corinthians Esports') AND alternate_name IN ('Corinthians Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cosa Gamers') AND alternate_name IN ('Cosa Gamers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cosmic Vipers') AND alternate_name IN ('Cosmic Vipers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cosmic Wolf Esports') AND alternate_name IN ('Cosmic Wolf Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Could Be Better') AND alternate_name IN ('Could Be Better')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Coven') AND alternate_name IN ('Coven')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CowBoySquad Imperials Esports') AND alternate_name IN ('CowBoySquad Imperials Esports', 'CowBoySquad Imperials Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cowana Gaming') AND alternate_name IN ('Cowana Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cream Real Betis.EU') AND alternate_name IN ('Cream Esports', 'Cream Esports Mexico', 'Cream Real Betis.EU', 'Cream Real Betis.Mexico')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Crimson Gaming') AND alternate_name IN ('Crimson Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Crusaders') AND alternate_name IN ('Crusaders')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cruzados Esports') AND alternate_name IN ('Cruzados Esports', 'Universidad Católica Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Crvena zvezda Esports') AND alternate_name IN ('Crvena zvezda Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Crypto Esports.CIS') AND alternate_name IN ('Crypto Esports', 'Crypto Esports.CIS')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cryptova') AND alternate_name IN ('Cryptova')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Crystal Cave Gaming Emerald') AND alternate_name IN ('Crystal Cave Gaming Emerald')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cupid Esports') AND alternate_name IN ('Cupid Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Curralzinho Esports') AND alternate_name IN ('Curralzinho Esports', 'Curralzinho Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cyber Gaming Academy') AND alternate_name IN ('Cyber Gaming', 'Cyber Gaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cyber Wolves') AND alternate_name IN ('Cyber Wolves')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cyborg Factory') AND alternate_name IN ('Cyborg Factory')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cyclone') AND alternate_name IN ('Cyclone')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Czas na zasady') AND alternate_name IN ('Czas na zasady')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Córdoba Patrimonio eSports') AND alternate_name IN ('Córdoba Patrimonio eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='D7G Esports Club') AND alternate_name IN ('D7G Esports Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DELTALAND') AND alternate_name IN ('DELTALAND')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DIVIZON') AND alternate_name IN ('DIVIZON')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DJ Team') AND alternate_name IN ('DJ Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DK Crew') AND alternate_name IN ('DK Crew')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DKB XPERION NXT') AND alternate_name IN ('DKB Diamonds', 'DKB XPERION NXT')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DKB XPERION NXT RAW') AND alternate_name IN ('DKB Diamonds RAW', 'DKB XPERION NXT RAW')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DMG Esports') AND alternate_name IN ('DMG Esports', 'DMG Esports Wings', 'Domino esports', 'Domino esports Wings')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DOCISK') AND alternate_name IN ('DOCISK', 'DOCISK AKADEMIA', 'DOCISK Academy', 'DOCISK EMERYCI', 'Dociskacze', 'ESPORT ARENA DOCISK', 'ESPORT ARENA DOCISK II')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DOCISK Hussars') AND alternate_name IN ('DOCISK Hussars')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DP5 Makios') AND alternate_name IN ('DP5 Makios')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DREN Esports') AND alternate_name IN ('DREN Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DSC3V') AND alternate_name IN ('DSC3V', 'Descuydado Aucas Esports', 'Descuydado Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DSYRE') AND alternate_name IN ('DSYRE', 'Dsyre Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DUCKIE GETTERS') AND alternate_name IN ('DUCKIE GETTERS')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Da Dancing Demons') AND alternate_name IN ('Da Dancing Demons')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dango') AND alternate_name IN ('Dango')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dango SB') AND alternate_name IN ('Dango SB')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dare Gaming') AND alternate_name IN ('Dare Black', 'Dare Gaming', 'Dare White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dark Allegiance') AND alternate_name IN ('Dark Allegiance')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dark Crows') AND alternate_name IN ('Dark Crows')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dark Quality') AND alternate_name IN ('Dark Quality')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dark Tigers') AND alternate_name IN ('Dark Tigers', 'Dark Tigers Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dark Zone') AND alternate_name IN ('Dark Zone')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DarkSpawn Gaming') AND alternate_name IN ('DarkSpawn Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DarkZero Dragonsteel') AND alternate_name IN ('DarkZero Dragonsteel', 'Dragonsteel', 'Maryville University', 'Maryville University B')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dawn Esports') AND alternate_name IN ('Dawn Esports', 'Dawn Esports Blaze', 'Dawn Esports Shock')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dawn Esports Quake') AND alternate_name IN ('Dawn Esports Quake')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dawn of Stars') AND alternate_name IN ('Dawn of Stars')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DayDreamers') AND alternate_name IN ('DayDreamers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dead Rabbits Club') AND alternate_name IN ('Dead Rabbits Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dejice') AND alternate_name IN ('Dejice')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Delirious Hellhounds') AND alternate_name IN ('Delirious Hellhounds')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Deliverance Esports Peru') AND alternate_name IN ('Deliverance Esports', 'Deliverance Esports Peru')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Delta Five') AND alternate_name IN ('Delta Five')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Delta Syndicate') AND alternate_name IN ('Delta Syndicate')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Demise') AND alternate_name IN ('Demise')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Demise Academy') AND alternate_name IN ('Demise Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DengKaiLi Game Team') AND alternate_name IN ('DengKaiLi Game Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Denial eSports.East') AND alternate_name IN ('Denial eSports EU', 'Denial eSports.East')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Depor Cali Legends') AND alternate_name IN ('Depor Cali Legends')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Destined For Glory') AND alternate_name IN ('Destined For Glory')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Devils.one Academy') AND alternate_name IN ('Devils.one', 'Devils.one Academy', 'Komputronik Gaming Scouting Grounds', 'Team Kinguin', 'devils.one x Kiedyś Miałem Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Diablo Chairs') AND alternate_name IN ('Diablo Chairs')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Diabolus Esports') AND alternate_name IN ('Diabolus Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Diamant Esports') AND alternate_name IN ('Diamant Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Diamond Doves') AND alternate_name IN ('Diamond Doves')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Digital Paradox') AND alternate_name IN ('Digital Paradox')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dimegio Club') AND alternate_name IN ('Dimegio Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dinka Never Homeless Again') AND alternate_name IN ('Dinka Never Homeless Again')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Direct Rising eSports') AND alternate_name IN ('Direct Rising eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Divernex') AND alternate_name IN ('Divernex')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Diversion Gaming') AND alternate_name IN ('Diversion Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Domino Computer') AND alternate_name IN ('Domino Computer')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Domme Jongens') AND alternate_name IN ('Domme Jongens', 'Domme Jongens Academy', 'Echo Zulu Domme Jongens')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dont Ban Gragas') AND alternate_name IN ('Dont Ban Gragas')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dopamina E-Sport') AND alternate_name IN ('CHICAGO BULAS', 'Dopamina E-Sport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dorado Gaming') AND alternate_name IN ('Dorado Gaming', 'Dorado Gaming Black', 'Dorado Gaming White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Douyin Tony Top') AND alternate_name IN ('Douyin Tony Top')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Doxa Gaming') AND alternate_name IN ('Doxa Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dragons E.C.') AND alternate_name IN ('Dragons E.C.')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dragoon''s Goons') AND alternate_name IN ('Dragoon''s Goons')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dramatik Gaming') AND alternate_name IN ('Dramatik Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dream Catcher') AND alternate_name IN ('Dream Catcher')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dream Catcher Gaming') AND alternate_name IN ('Dream Catcher Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dream Makers') AND alternate_name IN ('Dream Makers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dream Team') AND alternate_name IN ('Dream Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dropz Esports') AND alternate_name IN ('Dropz Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Drury University') AND alternate_name IN ('Drury University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Duma Easta') AND alternate_name IN ('Duma Easta', 'EAST SIDE')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dung Dynasty') AND alternate_name IN ('Dung Dynasty')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dusty') AND alternate_name IN ('Dusty')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dutch Community Team') AND alternate_name IN ('Dutch Community Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dylema Gaming') AND alternate_name IN ('Dylema Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dynamic Elements Aether') AND alternate_name IN ('Dynamic Elements Aether')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dynamo Eclot Talents') AND alternate_name IN ('Dynamo Eclot', 'Dynamo Eclot Academy', 'Dynamo Eclot Talents', 'ECLOT', 'ECLOT Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dynamo Esports') AND alternate_name IN ('Dynamo Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dynasty') AND alternate_name IN ('Dynasty', 'Dynasty Academy', 'New Dynasty')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='E WIE EINFACH E-SPORTS') AND alternate_name IN ('E WIE EINFACH E-SPORTS', 'OP innogy eSport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='E-corp Gaming') AND alternate_name IN ('E-corp Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='E-nsane Gaming') AND alternate_name IN ('E-nsane Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EAS Team ESCA Gaming') AND alternate_name IN ('Dom Spokojnej Starości', 'EAS Team ESCA Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EBRO') AND alternate_name IN ('EBRO')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ECORP') AND alternate_name IN ('ECORP')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EEriness') AND alternate_name IN ('EEriness')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EFIVE Esports') AND alternate_name IN ('EFIVE Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EFS') AND alternate_name IN ('DKJH', 'EFS')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EGN Esports') AND alternate_name IN ('EGN Esports', 'EGN Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EGekko') AND alternate_name IN ('EGekko')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EKO Esports') AND alternate_name IN ('Cyberground Gaming', 'Cyberground Gaming Academy', 'EKO Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EKoVy') AND alternate_name IN ('EKoVy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ELR Gaming') AND alternate_name IN ('ELR Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ELaB x EXP') AND alternate_name IN ('ELaB x EXP', 'Son of Conus')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EMonkeyz') AND alternate_name IN ('EMonkeyz', 'eMonkeyz SD Huesca')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ENCE') AND alternate_name IN ('ENCE')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ENEMI3S') AND alternate_name IN ('ENEMI3S')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ENsure') AND alternate_name IN ('ENsure', 'oow to eum')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EPIC-DUDES') AND alternate_name IN ('EPIC-DUDES')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EQuizers') AND alternate_name IN ('BGA eQuizers', 'Big Aces eSports', 'EQuizers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ERKO Esports') AND alternate_name IN ('ERKO Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ESC Gaming (Italian Team)') AND alternate_name IN ('ESC Gaming (Italian Team)', 'ESC Gaming Sigma')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ESTORM') AND alternate_name IN ('ESTORM')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ESUG Ultimate Five Feeder') AND alternate_name IN ('ESUG Ultimate Five Feeder')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ESport Rhein-Neckar') AND alternate_name IN ('ESport Rhein-Neckar')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ESports Cologne e.V.') AND alternate_name IN ('ESports Cologne e.V.', 'eSports Cologne CBS', 'eSports Cologne GAMERS ONLY')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ESports Nord e.V.') AND alternate_name IN ('ESports Nord e.V.')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ESuba') AND alternate_name IN ('ESuba', 'KIA.eSuba Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EURONICS Gaming') AND alternate_name IN ('EURONICS Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EWolves Ignis') AND alternate_name IN ('EWolves Brazil', 'EWolves Ignis', 'EWolves Lycans')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EXILE esports') AND alternate_name IN ('EXILE esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EXtatus') AND alternate_name IN ('EXtatus')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EYES ON U Europe') AND alternate_name IN ('EYES ON U Europe')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Eanix') AND alternate_name IN ('Eanix')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Earth Revolution Gaming') AND alternate_name IN ('Earth Revolution Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Eesti Rästikud') AND alternate_name IN ('Eesti Rästikud', 'Estonian Vipers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ego Geniuses') AND alternate_name IN ('Ego Geniuses')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Eintracht Frankfurt') AND alternate_name IN ('Eintracht Frankfurt')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Eintracht Spandau') AND alternate_name IN ('Eintracht Spandau')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='El Dafayat Esports') AND alternate_name IN ('El Dafayat Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Element Mystic') AND alternate_name IN ('Element Mystic')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Elementalist') AND alternate_name IN ('Elementalist')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Elementaries Esport Club') AND alternate_name IN ('Elementaries Esport Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Elysium Gaming') AND alternate_name IN ('Elysium Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ember') AND alternate_name IN ('Ember')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ember Foxes') AND alternate_name IN ('Ember Foxes')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Emerald Prisoners') AND alternate_name IN ('Emerald Prisoners')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Emissary Esports') AND alternate_name IN ('Emissary Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Emperor Gaming') AND alternate_name IN ('Emperor Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Emprox') AND alternate_name IN ('Emprox')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Empyreans') AND alternate_name IN ('Empyreans')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Enclave') AND alternate_name IN ('Enclave')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Enix Esports') AND alternate_name IN ('Enix Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Entropiq') AND alternate_name IN ('Entropiq')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Epic Avalanche') AND alternate_name IN ('Epic Avalanche')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Epsilon Esports') AND alternate_name IN ('Epsilon Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Erfolg Esports') AND alternate_name IN ('Bis Esports', 'Erfolg Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Espectro Esports') AND alternate_name IN ('Espectro Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Espergærde eSport') AND alternate_name IN ('Espergærde eSport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Esport Academy') AND alternate_name IN ('Esport Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Esport Empire') AND alternate_name IN ('Esport Empire')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Esport STUBA') AND alternate_name IN ('Esport STUBA')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Esports Academy') AND alternate_name IN ('Esports Academy', 'Piast Gliwice Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Esprit Shōnen') AND alternate_name IN ('Esprit Shōnen', 'MS Company')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Estoril Praia eSports') AND alternate_name IN ('Estoril Praia eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Estrogen Gap') AND alternate_name IN ('Estrogen Gap')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Estúdio XP e-Sports') AND alternate_name IN ('Estúdio XP e-Sports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Et cetera') AND alternate_name IN ('Et cetera')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Eterna') AND alternate_name IN ('Eterna')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Eternal Fire') AND alternate_name IN ('Eternal Fire')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Eternals Gaming') AND alternate_name IN ('Eternals Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ethereal Enigmas') AND alternate_name IN ('Ethereal Enigmas', 'UNIZA Enigmas')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ethernum Esports') AND alternate_name IN ('Ethernum Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Europe Saviors Club') AND alternate_name IN ('Europe Saviors Anonymous', 'Europe Saviors Club', 'Europe Saviors Omega')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ever8 Winners') AND alternate_name IN ('Ever8 Winners', 'Winners')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Evil genius (RTV Team)') AND alternate_name IN ('Evil genius (RTV Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Evolve') AND alternate_name IN ('Evolve')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ex Nihilo') AND alternate_name IN ('Ex Nihilo')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Excess Success') AND alternate_name IN ('Diddi''s Angels', 'Excess Success', 'Turboapes United')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Exeed Poland') AND alternate_name IN ('Exeed', 'Exeed Poland')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Exiled Bears') AND alternate_name IN ('Exiled Bears')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Exilium Gaming') AND alternate_name IN ('Exilium Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Exilium Hunters') AND alternate_name IN ('Exilium Hunters', 'Hunters Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Eyeshield Gaming') AND alternate_name IN ('Eyeshield Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='F-Soul Esports') AND alternate_name IN ('F-Soul Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FALKN') AND alternate_name IN ('FALKN', 'Östersunds FK Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FC Nantes Esports') AND alternate_name IN ('FC Nantes Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FH eSports') AND alternate_name IN ('FH eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FLY5') AND alternate_name IN ('Corax Gaming Club', 'FLY5', 'FLY5 Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FM eSports') AND alternate_name IN ('FM eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FN Esports') AND alternate_name IN ('FN Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FPT Hanoi') AND alternate_name IN ('FPT Hanoi', 'FPT Ho Chi Minh', 'Sleeping Dragon Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FROM ZERO TO HERO') AND alternate_name IN ('FROM ZERO TO HERO')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FS Gaming') AND alternate_name IN ('FS Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FUT Esports') AND alternate_name IN ('FUT Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fact Revolution') AND alternate_name IN ('Fact Revolution')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Faerie Charm (Singaporean Team)') AND alternate_name IN ('Faerie Charm (Singaporean Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Falcon E-Sports') AND alternate_name IN ('Falcon E-Sports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Falcons (Spanish Team)') AND alternate_name IN ('Falcons (Spanish Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Falke Esports') AND alternate_name IN ('Falke Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Falkol') AND alternate_name IN ('5Fox E-Sports Club', 'Falkol', 'Falkol Academy', 'Falkol Storm', 'UFABC Storm')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fallen Gods') AND alternate_name IN ('Fallen Gods')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='False Facade Gaming') AND alternate_name IN ('False Facade Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fantastic Esports') AND alternate_name IN ('Fantastic Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fantasy Gaming') AND alternate_name IN ('Dia Libre', 'Fantasy Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Far East Eagle') AND alternate_name IN ('Far East Eagle')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Farenvehn') AND alternate_name IN ('Farenvehn', 'Geração Estrutura')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fatal Ambition') AND alternate_name IN ('Fatal Ambition')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fatcat''s Fatties') AND alternate_name IN ('Fatcat''s Fatties')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fear x Starforge') AND alternate_name IN ('Cincinnati Fear', 'Fear x Starforge')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Femmes Fatales') AND alternate_name IN ('Femmes Fatales')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fenris eSports Academy Blue') AND alternate_name IN ('Fenris eSports Academy Blue')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fervent Esports') AND alternate_name IN ('Fervent Esports', 'SteelWolves Gaia')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fiction eSports') AND alternate_name IN ('Fiction eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Final Form') AND alternate_name IN ('Final Form')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='First Blood Crusade') AND alternate_name IN ('First Blood Crusade')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fisher College') AND alternate_name IN ('Fisher College')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Five Kings') AND alternate_name IN ('Five Kings')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Flama Esports') AND alternate_name IN ('Flama Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FlameHard') AND alternate_name IN ('FlameHard')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Flamengo MDL') AND alternate_name IN ('Flamengo Academy', 'Flamengo MDL')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Flayn eSports') AND alternate_name IN ('Flayn eSports', 'Flayn eSports CZSK Edition')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Florida Southern College') AND alternate_name IN ('Florida Southern College')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Florida State University') AND alternate_name IN ('Florida State University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fluffy Tail') AND alternate_name IN ('Fluffy Tail')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fly Family') AND alternate_name IN ('Fly Family')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fløng Esports Elite') AND alternate_name IN ('Fløng Esports Elite')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fog Esports') AND alternate_name IN ('Fog Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fonored Hyperion') AND alternate_name IN ('Fonored Hyperion')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Footprint Gaming') AND alternate_name IN ('Footprint Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='For The Win Esports') AND alternate_name IN ('For The Win Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Forger Esports') AND alternate_name IN ('Forger Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Formulation Gaming') AND alternate_name IN ('Formulation Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Forsaken (Polish Team)') AND alternate_name IN ('Forsaken (Polish Team)', 'Maturalni Forsaken')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fourth Wall') AND alternate_name IN ('Fourth Wall')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fox B') AND alternate_name IN ('Fox B')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FoxFire (Turkish Team)') AND alternate_name IN ('FoxFire (Turkish Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fractious eSports') AND alternate_name IN ('Fractious eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Frank Fang Gaming') AND alternate_name IN ('Frank Fang Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fraternitas') AND alternate_name IN ('Fraternitas')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FreePi') AND alternate_name IN ('FreePi')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Freshsterious') AND alternate_name IN ('Freshsterious')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Froggy Five') AND alternate_name IN ('Froggy Five')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FroztFire Team') AND alternate_name IN ('FroztFire Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fruition Esports') AND alternate_name IN ('Fruition Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fuego') AND alternate_name IN ('Fuego')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fugitive Gaming') AND alternate_name IN ('Fugitive Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Full Sense') AND alternate_name IN ('Full Sense')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Full Spectrum') AND alternate_name IN ('Full Spectrum')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fullclear Esports') AND alternate_name IN ('Black wolfs', 'Fullclear Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Furious Five') AND alternate_name IN ('Furious Five')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Future Perfect') AND alternate_name IN ('Future Perfect')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Future Perfect Blue') AND alternate_name IN ('Future Perfect Azure', 'Future Perfect Blue', 'Future Perfect Demacia', 'Future Perfect Ionia', 'Future Perfect Noxus', 'Future Perfect Orange', 'Future Perfect Purple', 'Future Perfect UA', 'Future Perfect Zaun')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fylkir Esports') AND alternate_name IN ('Fylkir Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='G-Pride') AND alternate_name IN ('G-Pride')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GG Call Nash') AND alternate_name IN ('GG Call Nash')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GGEsports') AND alternate_name IN ('GG&amp;Beer', 'GGEsports', 'GGEsports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GLORE') AND alternate_name IN ('GLORE')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GMBLERS Esports') AND alternate_name IN ('GMBLERS Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GOAL') AND alternate_name IN ('GOAL', 'Olympiacos Alimou')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GOEXANIMO') AND alternate_name IN ('GOEXANIMO')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GRP Esports') AND alternate_name IN ('GRP Esports', 'Grypciocraft Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GTZ Esports') AND alternate_name IN ('GTZ Bulls', 'GTZ Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gaia Esports') AND alternate_name IN ('Gaia Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Galaxy Gaming (American Team)') AND alternate_name IN ('Galaxy Gaming (American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Galaxy Racer Esports MENA Male') AND alternate_name IN ('Galaxy Racer Esports EU Female', 'Galaxy Racer Esports EU Male', 'Galaxy Racer Esports MENA Female', 'Galaxy Racer Esports MENA Male', 'Nigma Galaxy Male')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Galions') AND alternate_name IN ('Galions', 'Galions Pearl', 'GamersOrigin', 'GamersOrigin Academy', 'Team GO', 'Team GO Aurora')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Game Coach Academy') AND alternate_name IN ('GCA Alpha', 'GCA Beta', 'GCA BugeoKing', 'GCA Busan', 'GCA STAR', 'Game Coach Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GameWard') AND alternate_name IN ('GameWard', 'GameWard Academy', 'GameWard Astrals')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gamefy') AND alternate_name IN ('Gamefy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GamerLegion') AND alternate_name IN ('GamerLegion')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gamers404') AND alternate_name IN ('Gamers404')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gamespace Mediterranean College Esports') AND alternate_name IN ('Gamespace Mediterranean College Esports', 'Gamespace eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gaming Barcelona') AND alternate_name IN ('Gaming Barcelona')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gaming Team Kravaře') AND alternate_name IN ('Gaming Team Kravaře')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Garden Gaming') AND alternate_name IN ('Garden Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GeekCase eSports') AND alternate_name IN ('GeekCase eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GeekSide Esports') AND alternate_name IN ('GeekSide Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GenZ Gaming (2025 Vietnamese Team)') AND alternate_name IN ('Apex Predator', 'GenZ Gaming (2025 Vietnamese Team)', 'Hanoi Rookies Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Genbu Gaming') AND alternate_name IN ('Genbu Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Genetic Esport') AND alternate_name IN ('Brocodilo Crocodila', 'Genetic Esport', 'Rankers', 'Xin Giải Nhì')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Genetics Gap') AND alternate_name IN ('Genetics Gap')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gentle Hearts Gaming') AND alternate_name IN ('Gentle Hearts Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gentle Mates') AND alternate_name IN ('Gentle Mates')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gentlemen''s Gaming') AND alternate_name IN ('Gentlemen''s Academy', 'Gentlemen''s Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gentside') AND alternate_name IN ('Gentside')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='George Mason University') AND alternate_name IN ('George Mason University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Giants (Spanish Team)') AND alternate_name IN ('Giants (Spanish Team)', 'Giants Gaming Spain', 'Giants Underdoges', 'Vodafone Giants.Spain')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gifted Gaming') AND alternate_name IN ('Gifted Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Glacial Esports') AND alternate_name IN ('Glacial Esports', 'Glacial Red')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Glaive Esports Prime') AND alternate_name IN ('Glaive Esports Prime')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gmae') AND alternate_name IN ('Gmae')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GnG Amazigh') AND alternate_name IN ('GnG Amazigh')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GnG Esports') AND alternate_name IN ('GnG Esports', 'VSlash GnG')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Goat Esports') AND alternate_name IN ('Goat Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='God''s Plan') AND alternate_name IN ('God''s Plan')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Godsent') AND alternate_name IN ('Godsent')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Golden Grubians') AND alternate_name IN ('Golden Grubians')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Golden Lions') AND alternate_name IN ('Golden Lions')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Good Game Esport') AND alternate_name IN ('Good Game Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Goose Gaming') AND alternate_name IN ('Goose Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Goskilla') AND alternate_name IN ('Goskilla')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Grand View University') AND alternate_name IN ('Grand View University', 'Grand View University B')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Granit Gaming') AND alternate_name IN ('Granit Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gravity (2024 North American Team)') AND alternate_name IN ('Gravity (2024 North American Team)', 'Gravity Galaxy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gravity Elite') AND alternate_name IN ('Gravity Elite', 'Project Guardians')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Greek Gorillaz') AND alternate_name IN ('Greek Gorillaz')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Greek Regenesis') AND alternate_name IN ('Greek Regenesis')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Green Dolphin Gaming') AND alternate_name IN ('Green Dolphin Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Grim Ravens') AND alternate_name IN ('Grim Ravens')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Grompcord') AND alternate_name IN ('Grompcord')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Grow uP eSports') AND alternate_name IN ('Grow uP Girls EU', 'Grow uP eSports', 'Stars (LCF Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Guangdong Flying Tigers') AND alternate_name IN ('Guangdong Flying Tigers', 'Nigel''s Last Tiles')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Guarp Gaming') AND alternate_name IN ('Guarp Gaming', 'RATE x Guarp')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Guasones') AND alternate_name IN ('Guasones')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Guerreiras Brownie Vortex') AND alternate_name IN ('Guerreiras Brownie Vortex')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Guinea Pink') AND alternate_name IN ('Guinea Pink', 'Guinea Pink Alpaca')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gunrunners') AND alternate_name IN ('Gunrunners')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='H34T Young Flames') AND alternate_name IN ('H34T Young Flames')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='HANAGUMI KAREN') AND alternate_name IN ('HANAGUMI KAREN')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='HG Esports') AND alternate_name IN ('HG Esports', 'Hell Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='HOU GAMING') AND alternate_name IN ('HOU GAMING')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='HUTECH CHICKEN') AND alternate_name IN ('HUTECH CHICKEN')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='HVFC Bakeca Academy') AND alternate_name IN ('HVFC Bakeca Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hallow Crows') AND alternate_name IN ('Hallow Crows')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hannibal Knights') AND alternate_name IN ('Hannibal Knights')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='HarmoniX Gaming') AND alternate_name IN ('HarmoniX Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Harrisburg University') AND alternate_name IN ('Harrisburg University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Havan Liberty Gaming') AND alternate_name IN ('Havan Liberty Academy', 'Havan Liberty Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Havoc (Danish Team)') AND alternate_name IN ('Havoc (Danish Team)', 'TrainE Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Havoc Gaming') AND alternate_name IN ('Havoc Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Herbalife Real Betis') AND alternate_name IN ('Herbalife Real Betis')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Here For T-Shirt') AND alternate_name IN ('Here For T-Shirt')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Heroes of the Universe E-Sports Brazil') AND alternate_name IN ('Heroes of the Universe E-Sports Brazil')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hertha BSC eSport') AND alternate_name IN ('Hertha BSC eSport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hex Alligators') AND alternate_name IN ('Hex Alligators')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hexagone Esports') AND alternate_name IN ('Hexagone Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='High Tempo Esports (North American Team)') AND alternate_name IN ('High Tempo Esports', 'High Tempo Esports (North American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hillerød eSport') AND alternate_name IN ('Hillerød eSport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hive Athens EC') AND alternate_name IN ('Gaming Hive', 'Hive Athens Academy', 'Hive Athens EC')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hokuto Esports') AND alternate_name IN ('Hokuto Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Holy Knights') AND alternate_name IN ('Holy Knights')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Homyno Pulsia Esport') AND alternate_name IN ('Homyno Pulsia Esport', 'Pulsia Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='HongKongNine') AND alternate_name IN ('HongKongNine')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hooked Esports') AND alternate_name IN ('Hooked Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Howl Esports') AND alternate_name IN ('Howl Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Howling eSports') AND alternate_name IN ('Howling eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Htp eSport Akademie Hannover') AND alternate_name IN ('HNVR Esports', 'Htp eSport Akademie Hannover', 'ROSSMANN Centaurs', 'SK Gaming Prime', 'Team Omniscius H')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Humanoids5') AND alternate_name IN ('Humanoids5')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hurricane of Feathers') AND alternate_name IN ('Hurricane of Feathers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='HuyaTV') AND alternate_name IN ('HUYATV Assemble', 'HUYATV H', 'HUYATV N', 'HUYATV R', 'HUYATV Y', 'HuyaTV')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hybrid Esports') AND alternate_name IN ('Hybrid Esports', 'Hybrid Esports UK')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hydras Esport') AND alternate_name IN ('Hydras Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hyper (Korean Team)') AND alternate_name IN ('Hyper (Korean Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hyper Kings') AND alternate_name IN ('Hyper Kings')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hyper Vortex Esports') AND alternate_name IN ('Hyper Vortex Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hyve Central') AND alternate_name IN ('Hyve Central')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='IDM Pirata') AND alternate_name IN ('IDM Pirata')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='IDomina eSports') AND alternate_name IN ('IDomina eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='IKISEQ Gaming') AND alternate_name IN ('IKISEQ Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='IME Wolves') AND alternate_name IN ('IME Wolves')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='IMPERISHABLE CLAN') AND alternate_name IN ('IMPERISHABLE CLAN')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='IMProve Team') AND alternate_name IN ('IMProve Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='IN Gaming') AND alternate_name IN ('IN Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='INvolute') AND alternate_name IN ('INvolute')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ITS DOOMED') AND alternate_name IN ('ITS DOOMED')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ichor Gaming') AND alternate_name IN ('Ichor Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ici Japon Corp. Esport') AND alternate_name IN ('Ici Japon Corp. Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Icon Esports (Mexican Team)') AND alternate_name IN ('Icon Esports (Mexican Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ilha das Lendas') AND alternate_name IN ('Ilha das Lendas')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Illinois State University') AND alternate_name IN ('Illinois State University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Illinois Wesleyan University') AND alternate_name IN ('Illinois Wesleyan University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Illuminar Gaming') AND alternate_name IN ('Illuminar Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ImPerium Vancuverii') AND alternate_name IN ('ImPerium Vancuverii')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Imaginary Gaming') AND alternate_name IN ('Imaginary Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Imperials') AND alternate_name IN ('Imperials', 'Ο χοντρός και η Παρέα του')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Imperio eSports') AND alternate_name IN ('Imperio eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='InFamouS Esport') AND alternate_name IN ('InFamouS Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='InFerno eSports') AND alternate_name IN ('InFerno eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Inaequalis') AND alternate_name IN ('Inaequalis', 'Inaequalis Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Indictive Esports') AND alternate_name IN ('Indictive Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Infernal Void') AND alternate_name IN ('Infernal Void')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Inferno Esports (Filipino Team)') AND alternate_name IN ('Inferno Esports (Filipino Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Infinity Esports (2015 North American Team)') AND alternate_name IN ('Infinity Esports (2015 North American Team)', 'Monster Kittens')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Infusion') AND alternate_name IN ('Infusion')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Inside Games') AND alternate_name IN ('H3ARTS', 'Inside Games', 'Inside Games Challengers', 'NARCIS')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Inspire eSports') AND alternate_name IN ('Inspire eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Instinct Gaming') AND alternate_name IN ('Instinct Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Intel New Indians') AND alternate_name IN ('Intel New Indians')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Interesting Five') AND alternate_name IN ('Dark Dragons', 'Interesting Five')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Intergalaxy Tigers Gaming') AND alternate_name IN ('Intergalaxy Tigers Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='International Esports Industry Center') AND alternate_name IN ('International Esports Industry Center')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Interstellar Yappers') AND alternate_name IN ('Interstellar Yappers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Intrepid Fox Gaming') AND alternate_name IN ('Intrepid Fox Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Intuition') AND alternate_name IN ('Intuition')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Inventive Esports') AND alternate_name IN ('Inventive Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Invulnerables Esports') AND alternate_name IN ('Invulnerables Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ion Squad') AND alternate_name IN ('Ion Squad', 'Ion Squad Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ionikos Nikaias Esports') AND alternate_name IN ('Ionikos Nikaias Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Iron Wolves') AND alternate_name IN ('Iron Wolves', 'Shanghai Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Issue is Critical') AND alternate_name IN ('Issue is Critical')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Izanagi eSports') AND alternate_name IN ('Izanagi Ignis', 'Izanagi Morrigan', 'Izanagi eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='IziDream') AND alternate_name IN ('IziDream', 'Team Oplon')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Jake''s Kittens') AND alternate_name IN ('Jake''s Kittens')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Janus Panter') AND alternate_name IN ('Janus Esports', 'Janus Panter', 'Janus Vipers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='JingNetGame') AND alternate_name IN ('JingNetGame')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Jlingz Esports') AND alternate_name IN ('Jlingz Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Joblife') AND alternate_name IN ('Joblife')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Join The Force') AND alternate_name IN ('Join The Force')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Jolly Rogers') AND alternate_name IN ('Jolly Rogers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Joseph Hong') AND alternate_name IN ('Joseph Hong')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Juicy Ballers') AND alternate_name IN ('Juicy Ballers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Just Randoms') AND alternate_name IN ('Just Randoms')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Justforfun') AND alternate_name IN ('Justforfun')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Jörmungang') AND alternate_name IN ('Jörmungang')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='K Special Forces') AND alternate_name IN ('K Special Forces')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='K1CK') AND alternate_name IN ('K1CK', 'K1ck Black', 'K1ck Neosurf', 'K1ck eSports Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='K9') AND alternate_name IN ('K9')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KAOS e-sport') AND alternate_name IN ('KAOS e-sport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KATANA (Turkish Team)') AND alternate_name IN ('KATANA (Turkish Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KIT SC SmartWe') AND alternate_name IN ('KIT SC', 'KIT SC SmartWe')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KIT SC White') AND alternate_name IN ('KIT SC White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KIYF eSports Club') AND alternate_name IN ('KIYF eSports Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KODE Gaming') AND alternate_name IN ('KODE Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KOVA Esports') AND alternate_name IN ('KOVA Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KR Reykjavík Esports') AND alternate_name IN ('KR Reykjavík Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KRC Genk Esports') AND alternate_name IN ('KRC Genk Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KRC Genk Esports Talent Team') AND alternate_name IN ('KRC Genk Esports Talent Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KRÜ Esports') AND alternate_name IN ('KRÜ Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KV Mechelen Esports') AND alternate_name IN ('KV Mechelen Esports', 'KV Mechelen Esports Academy', 'KV Mechelen Esports Strijders')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KaBuM! IDM Gaming') AND alternate_name IN ('KaBuM! IDM Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Kaisa Gaming') AND alternate_name IN ('Kaisa Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Kaizen Esports') AND alternate_name IN ('Kaizen Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Kanji Esports') AND alternate_name IN ('Kanji Esports', 'Kanji Esports Echolon')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Kanji Esports Feuer') AND alternate_name IN ('Kanji Esports Feuer', 'Kanji Esports Ion')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Kanji Esports Wasser') AND alternate_name IN ('Kanji Esports Spectre', 'Kanji Esports Wasser')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KappaChungus') AND alternate_name IN ('KappaChungus')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Kapsoura') AND alternate_name IN ('Kapsoura')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Karma Clan Esports') AND alternate_name IN ('Karma Clan Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Karolinerna') AND alternate_name IN ('Karolinerna')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Katastrofa Awionetki') AND alternate_name IN ('Katastrofa Awionetki')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Kaufland Hangry Knights') AND alternate_name IN ('Kaufland Hangry Knights')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Kawaii Kiwis') AND alternate_name IN ('Kawaii Kiwis')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Keep Gaming') AND alternate_name IN ('Keep Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Kelyx''s Grandpa Gamers') AND alternate_name IN ('Kelyx''s Grandpa Gamers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Kenty') AND alternate_name IN ('Kenty')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KeyMedia') AND alternate_name IN ('KeyMedia')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Keyd Warriors') AND alternate_name IN ('Keyd Stars', 'Keyd Warriors', 'Vivo Keyd')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Keypulse Esports') AND alternate_name IN ('Keypulse Esports', 'Varona Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Khore Gaming') AND alternate_name IN ('Khore Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Kiedyś Miałem Fun') AND alternate_name IN ('Kiedyś Miałem Fun')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Killabeez') AND alternate_name IN ('Killabeez')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Kim Esports') AND alternate_name IN ('Kim Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='King of Goats') AND alternate_name IN ('Godlike Goats', 'King of Goats')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Kings of Uganda') AND alternate_name IN ('Kings of Uganda')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Kings of the North') AND alternate_name IN ('Kings of the North')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Klanik Esport') AND alternate_name IN ('Klanik Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KlikTech') AND alternate_name IN ('KlikTech')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KmK eSports') AND alternate_name IN ('KmK eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Kokoro No Senshi') AND alternate_name IN ('Kokoro No Senshi')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Komil and Friends') AND alternate_name IN ('Komil and Friends')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Komodo (North American Team)') AND alternate_name IN ('Komodo (North American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Komputronik H34T') AND alternate_name IN ('Komputronik H34T', 'Together Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Korean Streamer') AND alternate_name IN ('Korean Streamer')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Kubyd''s Syndrome') AND alternate_name IN ('Kubyd''s Syndrome')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Kun Shan Lightning Tiger') AND alternate_name IN ('Kun Shan Lightning Tiger')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Könige der Meere') AND alternate_name IN ('AKA HERO', 'Könige der Meere')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LCVS Fighting') AND alternate_name IN ('LCVS Fighting')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LDLC OL') AND alternate_name IN ('LDLC OL', 'Team-LDLC', 'Tony Parker Adéquat Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LDM Esports') AND alternate_name IN ('LDM Esports', 'LDM Mexico', 'Liga del Mal')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LDN UTD') AND alternate_name IN ('LDN UTD', 'LDN UTD Ice')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LHS Gaming') AND alternate_name IN ('LHS', 'LHS Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LIT Team') AND alternate_name IN ('LIT Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LK Gaming') AND alternate_name IN ('LK Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LODIS (Polish Team)') AND alternate_name IN ('LODIS (Polish Team)', 'LODIS Academy', 'Lodis by Illuminar', 'MattyUSA LODIS', 'Nordis Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LOTUS (Brazilian Team)') AND alternate_name IN ('LOTUS (Brazilian Team)', 'LOTUS Black', 'LOTUS Prime', 'LOTUS Trainee', 'LOTUS White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LUA Gaming') AND alternate_name IN ('LUA Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LUL Esports') AND alternate_name IN ('Bigouinoi', 'ERGOLAVIA 24/7', 'LUL Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Labradoodle 9') AND alternate_name IN ('Labradoodle 9')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LanXiang Gaming') AND alternate_name IN ('LanXiang Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lanomania') AND alternate_name IN ('Lanomania')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LaoPengYou') AND alternate_name IN ('LaoPengYou')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Laranja Mecânica') AND alternate_name IN ('Laranja Mecânica', 'Laranja Mecânica Ignis')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Large (North American Team)') AND alternate_name IN ('Large (North American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Las Divinas') AND alternate_name IN ('Las Divinas')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Last Group') AND alternate_name IN ('Last Group')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Last Minute Airlines') AND alternate_name IN ('Last Minute Airlines')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Last Resistance') AND alternate_name IN ('Last Resistance')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Laughing Coffins') AND alternate_name IN ('Laughing Coffins')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lausanne-Sport Esports') AND alternate_name IN ('Lausanne-Sport Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lazy In Life') AND alternate_name IN ('Lazy In Life')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lechuga Gaming') AND alternate_name IN ('Lechuga Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Legion Gaming (European Team)') AND alternate_name IN ('Legion Gaming (European Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Legion Gaming (Oceanic Team)') AND alternate_name IN ('Legion Gaming (Oceanic Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lenovo Legion Honvéd') AND alternate_name IN ('Lenovo Legion Honvéd')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Levante UD Esports') AND alternate_name IN ('Levante UD Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Level One') AND alternate_name IN ('Level One')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Level Up esports') AND alternate_name IN ('Level Up esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Leviathans') AND alternate_name IN ('Leviathans', 'baltic blasters', 'Губка Боб')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Leões Porto Salvo Esports') AND alternate_name IN ('Leões Porto Salvo Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LiT Esports') AND alternate_name IN ('LiT Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Liberty Zeal Queue') AND alternate_name IN ('Liberty Zeal Queue')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Life Support') AND alternate_name IN ('Life Support')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lille Esport') AND alternate_name IN ('Lille Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LionsCreed Baltics') AND alternate_name IN ('LionsCreed Baltics')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lionscreed') AND alternate_name IN ('Lionscreed')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lionscreed Lionesses') AND alternate_name IN ('Lionscreed Lionesses')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LittleSans') AND alternate_name IN ('LittleSans')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lobstar') AND alternate_name IN ('Lobstar')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Login Esports') AND alternate_name IN ('Login Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='London Esports') AND alternate_name IN ('London Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Looking for ORG (Turkish Team)') AND alternate_name IN ('Looking for ORG (Turkish Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Los Ratones') AND alternate_name IN ('Los Ratones')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Loto Gaming') AND alternate_name IN ('Loto Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lotus (North American Team)') AND alternate_name IN ('5 Seasons', 'Black Lotus', 'Keep Pathing Bot', 'Kurulean''s Kittens', 'Lotus (North American Team)', 'Lotus Exiles')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lotus Bloom') AND alternate_name IN ('Lotus Bloom', 'Lotus Esports (2019 North American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lotus Knights') AND alternate_name IN ('Lotus Knights')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Louisiana State University') AND alternate_name IN ('Louisiana State University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Low Pressur3 Gaming') AND alternate_name IN ('Low Pressur3 Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Low Priority') AND alternate_name IN ('Low Priority')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LowLandLions') AND alternate_name IN ('Defusekids', 'LowLandLions', 'LowLandLions.White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lublin Shore') AND alternate_name IN ('Lublin Shore')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lucent Esports') AND alternate_name IN ('Lucent Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Luminosity Gaming') AND alternate_name IN ('Luminosity Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Luminox Planet') AND alternate_name IN ('Luminox Planet')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lundqvist Lightside') AND alternate_name IN ('Lundqvist Lightside')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lupus Esports') AND alternate_name IN ('Lupus Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Luxor Gaming') AND alternate_name IN ('Luxor Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lycos eSports') AND alternate_name IN ('Lycos eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lynch Esports') AND alternate_name IN ('Lynch Esports', 'Pcific Lynch')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lynx (Oceanic Team)') AND alternate_name IN ('Lynx (Oceanic Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='L’art de la Guerre') AND alternate_name IN ('L’art de la Guerre')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MAD Gaming') AND alternate_name IN ('MAD Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MCon esports') AND alternate_name IN ('MCon esports', 'mCon LG UltraGear', 'mCon esports Rotterdam')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MCon esports Academy') AND alternate_name IN ('MCon esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MD E-sports Club') AND alternate_name IN ('MD E-sports Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MHSC Esport') AND alternate_name IN ('MHSC Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MIBR') AND alternate_name IN ('MIBR')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MINDCAT Esports') AND alternate_name IN ('MINDCAT Apex', 'MINDCAT Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MIRAI (Brazilian Team)') AND alternate_name IN ('MIRAI (Brazilian Team)', 'MIRAI KICKS')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MJ-Esports') AND alternate_name IN ('MJ-Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MNM Gaming') AND alternate_name IN ('MNM Gaming', 'MnM Gaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MOBA ROG') AND alternate_name IN ('MOBA ROG')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MOUZ NXT') AND alternate_name IN ('MOUZ', 'MOUZ NXT', 'mousesports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MTP Esport') AND alternate_name IN ('MGA Esport', 'MTP Esport', 'Rocalys')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MTW Gaming') AND alternate_name IN ('MTW Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MTW St. Pauli') AND alternate_name IN ('MTW Rising', 'MTW St. Pauli')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MY STAR') AND alternate_name IN ('MY STAR')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MYIDOL Esports') AND alternate_name IN ('MYIDOL Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MYP ECLUB') AND alternate_name IN ('MYP E-SPORT', 'MYP ECLUB')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MYinsanity') AND alternate_name IN ('MYinsanity')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Macao Esports') AND alternate_name IN ('Macao Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Macko Academy') AND alternate_name IN ('Macko Academy', 'Macko Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Macro Maniacs') AND alternate_name IN ('Macro Maniacs')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mad Dragon') AND alternate_name IN ('Cougar E-Sport', 'Mad Dragon', 'Taoyuan Cougar E-Sport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mad Revolution Gaming') AND alternate_name IN ('Mad Revolution Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Maelstrom Esports') AND alternate_name IN ('Maelstrom Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Maelstrom Gaming') AND alternate_name IN ('Maelstrom Gaming', 'Storm (North American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Maestro V Esports') AND alternate_name IN ('Maestro V Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Magaza Esports') AND alternate_name IN ('Magaza Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Magna Esports') AND alternate_name IN ('Magna Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Majestic Lions') AND alternate_name IN ('Majestic Lions')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Malvinas Gaming') AND alternate_name IN ('Malvinas Gaming', 'Malvinas Gaming EU', 'Malvinas Rise')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Manguste eSports') AND alternate_name IN ('Manguste eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Maroon Bells') AND alternate_name IN ('Maroon Bells')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Masonic') AND alternate_name IN ('Fortress Esports', 'Masonic')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Master of Chicken Gaming') AND alternate_name IN ('Master of Chicken Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Maturalni Forsaken Academy') AND alternate_name IN ('Forsaken Academy', 'Maturalni Forsaken Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Maverix') AND alternate_name IN ('Maverix')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Max Tigers') AND alternate_name IN ('Max Tigers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mayan Esports') AND alternate_name IN ('Mayan Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Maycam Evolve') AND alternate_name IN ('Maycam Evolve')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Maze (Brazilian Team)') AND alternate_name IN ('Maze (Brazilian Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Maze Gaming') AND alternate_name IN ('Maze Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Medieval Riga') AND alternate_name IN ('Medieval Riga', 'Meds = off')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Melilla Titans') AND alternate_name IN ('Fortune Makers', 'Melilla Fortune', 'Melilla Titans')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Melty eSport Club') AND alternate_name IN ('Melty eSport Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Meme City Esports') AND alternate_name IN ('Meme City Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Meow Gaming Club') AND alternate_name IN ('Meow Gaming Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mercenaries') AND alternate_name IN ('Mercenaries')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Merciless Gaming Academy') AND alternate_name IN ('Merciless Gaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Meta Gaming') AND alternate_name IN ('Meta Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Method2Madness') AND alternate_name IN ('Lotus Gaming (European Team)', 'Method2Madness')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mezexis Esports') AND alternate_name IN ('Mezexis Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mgutis'' Saplings') AND alternate_name IN ('Mgutis'' Saplings')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Miami University') AND alternate_name IN ('Miami University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Michigan State University') AND alternate_name IN ('Michigan State University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mila Gaming') AND alternate_name IN ('Mila Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Milk Esports Whole Milk') AND alternate_name IN ('Milk Esports', 'Milk Esports Whole Milk')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mind Blue eSports') AND alternate_name IN ('Mind Blue eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Minus Three') AND alternate_name IN ('Minus Three')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Miracle (North American Team)') AND alternate_name IN ('Miracle (North American Team)', 'Mirage Sport Électronique')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mirage Alliance') AND alternate_name IN ('Mirage Alliance', 'Mirage Alliance Developmental', 'Omega Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mirage Alliance Baguette') AND alternate_name IN ('Mirage Alliance Baguette')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mirage Elyandra') AND alternate_name IN ('Mirage Elyandra')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mirage Élite') AND alternate_name IN ('Mirage Élite')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Misa Esports') AND alternate_name IN ('Misa Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Misfits (2024 North American Team)') AND alternate_name IN ('Misfits (2024 North American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mkers Academy') AND alternate_name IN ('Mkers', 'Mkers Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Monkey Mafia') AND alternate_name IN ('Monkey Mafia')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Monolith Gaming') AND alternate_name IN ('Monolith Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Monta Club') AND alternate_name IN ('Monta Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Moon Wolf e-Sports') AND alternate_name IN ('Moon Wolf e-Sports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MorningStar Legends') AND alternate_name IN ('MorningStar Legends')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MorningStar White') AND alternate_name IN ('MorningStar White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mortality eSports') AND alternate_name IN ('Mortality eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Motion') AND alternate_name IN ('Motion')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mount Olympus') AND alternate_name IN ('Mount Olympus')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Movistar Optix') AND alternate_name IN ('Movistar Optix')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Munster Rugby Gaming') AND alternate_name IN ('Munster Rugby Gaming', 'Munster Rugby Gaming Academy', 'Phelan Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Murk Esports') AND alternate_name IN ('Murk Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MyRevenge Chile') AND alternate_name IN ('MyRevenge Chile')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Myth Esports') AND alternate_name IN ('Myth Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mythos Gaming') AND alternate_name IN ('Mythos Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mübeccel Espor') AND alternate_name IN ('Mübeccel Espor')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Münster Esports') AND alternate_name IN ('Münster Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NASR eSports') AND alternate_name IN ('NASR eSports', 'NASR eSports Turkey', 'NASR eSports Turkey Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NAT') AND alternate_name IN ('NAT')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NDurance Gaming') AND alternate_name IN ('NDurance Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NEophyte') AND alternate_name IN ('NEophyte')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NGU eSports') AND alternate_name IN ('NGU eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NK Osijek Esport') AND alternate_name IN ('NK Osijek Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NLD eSports') AND alternate_name IN ('NLD eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NOCTA') AND alternate_name IN ('NOCTA')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NONAME (Turkish Team)') AND alternate_name IN ('NONAME (Turkish Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NORD Esports') AND alternate_name IN ('NORD Esports', 'NORD Polaris')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NOVO Esports') AND alternate_name IN ('NOVO Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NOX Esports') AND alternate_name IN ('NOX Esports', 'Obnoxious Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NRAX Esports') AND alternate_name IN ('NRAX Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NVision Esports') AND alternate_name IN ('NVision Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NXT') AND alternate_name IN ('NXT')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NYYRIKKI') AND alternate_name IN ('NYYRIKKI', 'NYYRIKKI Academy', 'NYYRIKKI White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Naguara Team') AND alternate_name IN ('Naguara Mexico', 'Naguara Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Nakrob Mangkorn') AND alternate_name IN ('Nakrob Mangkorn')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Nash Ξquilibrium') AND alternate_name IN ('Nash Ξquilibrium', 'Relic Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Nate.A') AND alternate_name IN ('Nate.A')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Native Gaming') AND alternate_name IN ('Native Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Nativz') AND alternate_name IN ('Nativz')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NeXtPlease! Gaming') AND alternate_name IN ('NeXtPlease! Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Near Airport') AND alternate_name IN ('Near Airport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NecroRaisers') AND alternate_name IN ('NecroRaisers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Neon Esports') AND alternate_name IN ('Neon Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NerdRage') AND alternate_name IN ('NerdRage')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Nerf Galeforce') AND alternate_name IN ('Nerf Galeforce')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Nerv') AND alternate_name IN ('Nerv')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Neurons') AND alternate_name IN ('Neurons')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Never Give Up (Vietnamese Team)') AND alternate_name IN ('Never Give Up', 'Never Give Up (Vietnamese Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='New Era') AND alternate_name IN ('New Era')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NewAges E-Sports') AND alternate_name IN ('NewAges E-Sports', 'Packmiko NewAges E-Sports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Newell''s Esports') AND alternate_name IN ('Newell''s Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Newstar') AND alternate_name IN ('Newstar')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Next Level Esports') AND alternate_name IN ('Next Level Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Nexus KTRL') AND alternate_name IN ('Nexus Gaming (Romanian Team)', 'Nexus KTRL')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Nexus Reapers') AND alternate_name IN ('Nexus Reapers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Nibble Gaming') AND alternate_name IN ('Nibble Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Nightbirds') AND alternate_name IN ('Nightbirds')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Nightblood Gaming') AND alternate_name IN ('Nightblood Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='No Ace') AND alternate_name IN ('No Ace')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='No Name (North American Team)') AND alternate_name IN ('No Name (North American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='No Need Orga') AND alternate_name IN ('NNO Prime', 'NNOwO', 'No Need Orga')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='No Org') AND alternate_name IN ('ANEW Esports', 'No Org')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='No Team') AND alternate_name IN ('No Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='NoFancy') AND alternate_name IN ('NoFancy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Noble Esports') AND alternate_name IN ('Noble Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Nocturnals') AND alternate_name IN ('Nocturnals')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Nocturne Gale') AND alternate_name IN ('Nocturne Gale')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Nocturns Gaming') AND alternate_name IN ('Nocturns Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Noot Noot eSports') AND alternate_name IN ('Noot Noot eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='North Carolina State University') AND alternate_name IN ('North Carolina State University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Northeastern University') AND alternate_name IN ('Northeastern University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Northern Lions Esports') AND alternate_name IN ('Northern Lions Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Northwood University') AND alternate_name IN ('Northwood University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Not Academy Team') AND alternate_name IN ('Not Academy Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Nova eSports (North American Team)') AND alternate_name IN ('Nova eSports (North American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Novasphere Gaming') AND alternate_name IN ('Novasphere Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Now or Never') AND alternate_name IN ('Now or Never')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Nuke Hunters') AND alternate_name IN ('Nuke Hunters')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Nuovo Gaming') AND alternate_name IN ('Nuovo Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ODD Esports') AND alternate_name IN ('ODD Esports', 'ODD Wara')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ODIN Gaming') AND alternate_name IN ('ODIN Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='OFFSET Esports') AND alternate_name IN ('OFFSET Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='OG Esports') AND alternate_name IN ('OG Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='OGC Esports') AND alternate_name IN ('OGC Esports', 'OGC Sigma Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='OKGG White') AND alternate_name IN ('OKGG White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ONE SEVEN EIGHT') AND alternate_name IN ('ONE SEVEN EIGHT')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='OP Gaming') AND alternate_name IN ('OP Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='OP Team') AND alternate_name IN ('OP Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='OQ (North American Team)') AND alternate_name IN ('OQ (North American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ORIGINwp') AND alternate_name IN ('ORIGINwp')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='OZ Gaming') AND alternate_name IN ('OZ Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Oakland University') AND alternate_name IN ('Oakland University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Odivelas Sports Club') AND alternate_name IN ('Odivelas Sports Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='OffLimits') AND alternate_name IN ('OffLimits')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ohio Northern University') AND alternate_name IN ('Ohio Northern University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ohio State University') AND alternate_name IN ('Ohio State University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Oklahoma Christian University') AND alternate_name IN ('Oklahoma Christian University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Old Hunters') AND alternate_name IN ('Old Hunters')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Omerix Esport') AND alternate_name IN ('Omerix Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Once Caldas Esports') AND alternate_name IN ('Once Caldas Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Once Upon A Team') AND alternate_name IN ('Once Upon A Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='One Piece eSports') AND alternate_name IN ('One Piece eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Only Heroes Academia') AND alternate_name IN ('Only Heroes Academia')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='OnlyGame') AND alternate_name IN ('OnlyGame')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Onoda Esports') AND alternate_name IN ('Onoda Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Onyx Ravens') AND alternate_name IN ('Onyx Ravens')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Optical spectrum E-sport') AND alternate_name IN ('Optical spectrum E-sport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Optimization Gaming') AND alternate_name IN ('Optimization Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Optimum Cowboys') AND alternate_name IN ('Arctic Dawn Gaming', 'Optimum Cowboys')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Option 33') AND alternate_name IN ('Option 33')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Orbit Anonymo Esports') AND alternate_name IN ('Gity Meavedronu', 'Meavedron', 'Meavedron Anonymo Master Academy', 'Orbit Anonymo Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ordo Equitum') AND alternate_name IN ('Ordo Equitum')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Orgless') AND alternate_name IN ('Orgless')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Orion Esport') AND alternate_name IN ('Orion Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Osaka') AND alternate_name IN ('Osaka')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Oserv Esport') AND alternate_name IN ('Oserv Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ottawa University') AND alternate_name IN ('Ottawa University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Otter Side') AND alternate_name IN ('Otter Side')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='OuYi Game Team') AND alternate_name IN ('OuYi Game Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Our Last Dance') AND alternate_name IN ('Our Last Dance')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Outlawz') AND alternate_name IN ('Outlawz')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Over Power Gaming Center') AND alternate_name IN ('Fatigue Team', 'Over Power Gaming Center')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='OverGaming') AND alternate_name IN ('OverGaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ownerd e-Sports') AND alternate_name IN ('Ownerd e-Sports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Oxygen Gaming') AND alternate_name IN ('Kumiho Esports', 'Oxygen Gaming', 'Oxygen Kumiho')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Oxygen Valiants') AND alternate_name IN ('Oxygen Valiants', 'Valiants')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='P11 Esports') AND alternate_name IN ('P11 Esports', 'Project11')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PAGLE48') AND alternate_name IN ('PAGLE48', 'Pagle o7')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PANTHERS Gaming') AND alternate_name IN ('PANTHERS Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PCHunter') AND alternate_name IN ('PCHunter')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PCIFIC Espor') AND alternate_name IN ('PCIFIC Espor')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PDK Sideral') AND alternate_name IN ('PDK Sideral')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PDW') AND alternate_name IN ('7more7', '7more7 Black', '7more7 Pompa Team', '7more7 Pompa Team Academy', '7more7 White', 'PDW', 'Pompa Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PENTA 1860') AND alternate_name IN ('PENTA 1860')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PIGSPORTS') AND alternate_name IN ('ESCORT P9', 'ESCORT P9 Academy', 'PIGSPORTS')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PIRTS') AND alternate_name IN ('ESCORT P9 Academy', 'PIRTS')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PRIDE (Polish Team)') AND alternate_name IN ('PRIDE (Polish Team)', 'PRIDE Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PRIDE ESCA Academy') AND alternate_name IN ('PRIDE ESCA Academy', 'Team ESCA Gaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PRIMATE') AND alternate_name IN ('PRIMATE')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PRINCIPALITY') AND alternate_name IN ('PRINCIPALITY')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PRO42') AND alternate_name IN ('PRO42')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PSG Talon Academy') AND alternate_name IN ('PSG Talon Academy', 'TALON Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PSV Esports') AND alternate_name IN ('PSV Esports', 'PSV Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Packa Pappas Kappsäck') AND alternate_name IN ('Packa Pappas Kappsäck')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Packmiko E-Sports') AND alternate_name IN ('Packmiko E-Sports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PainGaming') AND alternate_name IN ('PainGaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Palisade Esports') AND alternate_name IN ('Palisade Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Pampas') AND alternate_name IN ('Pampas')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Panathinaikos AC eSports') AND alternate_name IN ('Panathinaikos AC eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PandaCute') AND alternate_name IN ('PandaCute')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Pandy Pandas') AND alternate_name IN ('Pandy Pandas')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Parakeet Gaming') AND alternate_name IN ('Parakeet Gallaezia', 'Parakeet Gaming', 'ParakeetSaviors')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Paris Saint-Germain eSports') AND alternate_name IN ('Paris Saint-Germain eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Park University') AND alternate_name IN ('Park University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Partizan Esports') AND alternate_name IN ('Partizan Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Partizan Sangal') AND alternate_name IN ('Partizan Sangal')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Pathos') AND alternate_name IN ('Pathos')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Pawn Gaming (Spanish Team)') AND alternate_name IN ('Pawn Gaming (Spanish Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Peach Cats') AND alternate_name IN ('Peach Cats')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Peak Performance X') AND alternate_name IN ('Peak Performance Esports', 'Peak Performance X', 'Peak Performance Y')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Peak Performers (North American Team)') AND alternate_name IN ('Peak Performers (North American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Pee N W''s') AND alternate_name IN ('Pee N W''s')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Pegasus Esports') AND alternate_name IN ('Pegasus Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Pentagon Rejects') AND alternate_name IN ('Pentagon Maze', 'Pentagon Rejects', 'Rejects Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PepeTinkyWinky') AND alternate_name IN ('PepePo', 'PepeTinkyWinky')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Pertinax Esports') AND alternate_name IN ('Bastards Esports', 'Glorious Gaming', 'Glorious Gaming Belgium', 'Pertinax Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Phlox Gaming') AND alternate_name IN ('Phlox Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Phoenix 5') AND alternate_name IN ('Phoenix 5')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Phoenix Esports (Turkish Team)') AND alternate_name IN ('Phoenix Esports (Turkish Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Pick Me Galio') AND alternate_name IN ('Pick Me Galio')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ping is the Problem') AND alternate_name IN ('Ping is the Problem')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Pirates IDV') AND alternate_name IN ('Pirate Dream', 'Pirates IDV')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Piratesports') AND alternate_name IN ('Piratesports', 'Piratesports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Play With Soul') AND alternate_name IN ('Play With Soul')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Playing Ducks') AND alternate_name IN ('Playing Ducks')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Plejehjemmet Kalder') AND alternate_name IN ('Plejehjemmet Kalder')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Polar Ace') AND alternate_name IN ('Polar Ace')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Polar Bears') AND alternate_name IN ('Polar Bears')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Polar Squad Esports') AND alternate_name IN ('Polar Squad Esports', 'Polar Squad Esports Female')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Polaris Gaming') AND alternate_name IN ('Polaris Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Pookie Bears') AND alternate_name IN ('Pookie Bears')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PostFinance Helix') AND alternate_name IN ('PostFinance Helix')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Power Team Sports') AND alternate_name IN ('Power Team Sports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Powned.it') AND alternate_name IN ('Powned.it')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Prime Academy') AND alternate_name IN ('Fire Academy', 'Prime Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Prinfor Esports Club') AND alternate_name IN ('Prinfor Esports Club', 'XD Prinfor', 'XD Prinfor B')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Priority') AND alternate_name IN ('Priority')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Pro Probably') AND alternate_name IN ('Pro Probably')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ProXima Gaming') AND alternate_name IN ('ProXima Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Project Conquerors') AND alternate_name IN ('PCS Taran', 'Project Conquerors')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Project Sinners') AND alternate_name IN ('Project Sinners')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Prosperity Esports') AND alternate_name IN ('Prosperity Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Psykodelic Esports') AND alternate_name IN ('Psykodelic Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Public Enemy') AND alternate_name IN ('Public Enemy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Pulse Star') AND alternate_name IN ('Pulse Gooners', 'Pulse Star', 'Pulse Star Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Purdue University') AND alternate_name IN ('Purdue University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Purdue University Northwest') AND alternate_name IN ('Purdue University Northwest')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Pushing Gaming') AND alternate_name IN ('Pushing Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Pyrsos Esports') AND alternate_name IN ('Pyrsos Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='QLASH Egypt') AND alternate_name IN ('QLASH Egypt', 'QLASH Forge', 'QLASH Forge Academy', 'QLASH MENA', 'QLASH Midnight', 'QLASH Spain', 'Team QLASH Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='QUT Tigers') AND alternate_name IN ('QUT Tigers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='QWER.GG') AND alternate_name IN ('QWER.GG')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Qing Niao Yu Xing Game Team') AND alternate_name IN ('Qing Niao Yu Xing Game Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Qmistry') AND alternate_name IN ('Qmistry')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Quantum Vortex') AND alternate_name IN ('Quantum Vortex')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Quvic E-Sports') AND alternate_name IN ('Quvic E-Sports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='R-SIXTEAM') AND alternate_name IN ('R-SIXTEAM')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='R3volt') AND alternate_name IN ('R3volt')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RAGE') AND alternate_name IN ('RAGE')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RAMS') AND alternate_name IN ('RAMS')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RATE Gaming') AND alternate_name IN ('RATE Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RATZ') AND alternate_name IN ('RATZ', 'Tormenta E-Sports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RAWR ShadowZ Fan Club') AND alternate_name IN ('RAWR ShadowZ Fan Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RBG Esports') AND alternate_name IN ('RBG Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RCSC E-sport') AND alternate_name IN ('RCSC E-sport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='REDPack Esports') AND alternate_name IN ('REDPack Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='REJECT') AND alternate_name IN ('REJECT')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='REViTAL BLACKTRAiNS') AND alternate_name IN ('REViTAL BLACKTRAiNS', 'REViTAL Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RIFT Esports') AND alternate_name IN ('RIFT Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RMD Gaming') AND alternate_name IN ('RMD Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RMIT Redbacks') AND alternate_name IN ('RMIT Redbacks')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ROG Esport') AND alternate_name IN ('ROG Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ROUNDS') AND alternate_name IN ('ROUNDS', 'RoundsGG')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RPG-KINGDOM') AND alternate_name IN ('KINGDOM', 'RPG-KINGDOM')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RQS Esports') AND alternate_name IN ('RQS Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RSC Anderlecht Esports') AND alternate_name IN ('RSC Anderlecht Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RUDE GAME') AND alternate_name IN ('RUDE GAME')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Racoon (Italian Team)') AND alternate_name IN ('Racoon (Italian Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Radiance') AND alternate_name IN ('Radiance')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Raizen Kicks') AND alternate_name IN ('Raizen E-Sports', 'Raizen Jinx', 'Raizen Kicks', 'Tropa Raizen')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Raleigh Black Flame') AND alternate_name IN ('Raleigh Black Flame')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ramboot Club') AND alternate_name IN ('Ramboot Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ramo Awake Gaming') AND alternate_name IN ('Ramo Awake Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Random 5') AND alternate_name IN ('Random 5')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ravioli Ravioli') AND alternate_name IN ('Ravioli Ravioli')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ReDefy Esports') AND alternate_name IN ('ReDefy Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Reapers Gaming (Italian Organisation)') AND alternate_name IN ('Reapers Gaming (Italian Organisation)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Reborn Esport') AND alternate_name IN ('Reborn Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Red Bulls') AND alternate_name IN ('Red Bulls')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Red Eye Esports') AND alternate_name IN ('Red Eye Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Red Rooster Team') AND alternate_name IN ('Red Rooster Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Redemption (North American Team)') AND alternate_name IN ('Redemption (North American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Redemption Arc') AND alternate_name IN ('Redemption Arc')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Reformed Gaming') AND alternate_name IN ('Reformed Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Regnum4games') AND alternate_name IN ('Regnum4games')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Reign (European Team)') AND alternate_name IN ('Reign (European Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Reload Gaming') AND alternate_name IN ('Reload Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Reload eSports') AND alternate_name IN ('Reload eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ReluminateGG') AND alternate_name IN ('ReluminateGG')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Repre Gold') AND alternate_name IN ('Repre Gold')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Resolve Blue') AND alternate_name IN ('Resolve', 'Resolve Academy', 'Resolve Blue', 'Resolve NA')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Respawn Esports') AND alternate_name IN ('Respawn Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Respawned Esports') AND alternate_name IN ('Respawned Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Retric eSports') AND alternate_name IN ('Retric eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Return of the Middlesticks') AND alternate_name IN ('Return of the Middlesticks')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Reveal Multigaming') AND alternate_name IN ('Reveal Multigaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Reven Esports') AND alternate_name IN ('CosVer Esports', 'Reven Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RevenGa Esports') AND alternate_name IN ('RevenGa Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Revenge (British Team)') AND alternate_name IN ('Revenge (British Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Revenger (Chinese Team)') AND alternate_name IN ('Kx.Happy', 'Revenger (Chinese Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Revival (North American Team)') AND alternate_name IN ('Revival (North American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Rex Regalis') AND alternate_name IN ('Rex Regalis')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Rich Gang (Norwegian Team)') AND alternate_name IN ('Rich Gang', 'Rich Gang (Norwegian Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Riddle NO') AND alternate_name IN ('Riddle Esports', 'Riddle Esports Academy', 'Riddle NO')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Rift Rats') AND alternate_name IN ('Rift Rats')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Rigas In Paris') AND alternate_name IN ('Rigas In Paris')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Riptide') AND alternate_name IN ('Riptide')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Rise Gaming') AND alternate_name IN ('Rise Gaming', 'Rise Gaming Female', 'Rise Gaming Ignis')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Risen Esports') AND alternate_name IN ('Risen Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Rising Dawn Esports') AND alternate_name IN ('Rising Dawn Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='River Plate Gaming') AND alternate_name IN ('River Plate Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Roar (Chinese Team)') AND alternate_name IN ('Roar (Chinese Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Robot E-Sports Team') AND alternate_name IN ('Robot E-Sports Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Rock Bottom Esports') AND alternate_name IN ('Rock Bottom Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RockTribeEsports') AND alternate_name IN ('RockTribeEsports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Romulea eSport') AND alternate_name IN ('Romulea eSport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Royal Gamers') AND alternate_name IN ('Royal Gamers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ruddy Esports') AND alternate_name IN ('Ruddy Esports', 'The Ruddy Sack')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Rulers Esports') AND alternate_name IN ('Rulers Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RunAway') AND alternate_name IN ('RunAway')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RusherX Gaming') AND alternate_name IN ('RusherX Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ruzeh Esports') AND alternate_name IN ('Ruzeh Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='S2N Esports Club') AND alternate_name IN ('S2N Esports Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='S2V Esports') AND alternate_name IN ('ASUS ROG Army', 'S2V Esports', 'S2V Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='S8UL Esports') AND alternate_name IN ('Asterisk (South Asian Team)', 'S8UL Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SAIM SE') AND alternate_name IN ('ASUS ROG ELITE', 'SAIM SE')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SAIM SE SuppUp') AND alternate_name IN ('Energypot Wizards', 'SAIM SE SuppUp', 'SuppUp eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SAMCLAN Esports Club') AND alternate_name IN ('SAMCLAN Esports Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SAW (Portuguese Team)') AND alternate_name IN ('SAW (Portuguese Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SDM Tigres') AND alternate_name IN ('SDM Tigres')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SGA (Korean Team)') AND alternate_name IN ('SGA (Korean Team)', 'SGA ADCARRY', 'SGA B1', 'SGA B2', 'SGA BLUE', 'SGA Bundang', 'SGA Busan', 'SGA Freekick', 'SGA GREEN', 'SGA Han', 'SGA Hoon', 'SGA JJ', 'SGA Orange', 'SGA RED', 'SGA STORM', 'SGA Seongnam', 'SGA TT', 'SGA TURTLE', 'SGA Yellow', 'SGA 기모띠', 'SGA 안된다고', 'SGA 우리정글제이스', 'SGA 임')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SHEINOO') AND alternate_name IN ('SHEINOO')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SILENTGAMING') AND alternate_name IN ('SILENTGAMING')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SINNERS Esports') AND alternate_name IN ('SINNERS Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SINS Esports') AND alternate_name IN ('SINS Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SLO REJECTS') AND alternate_name IN ('SLO REJECTS')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SLR') AND alternate_name IN ('SLR')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SLTitans Esports') AND alternate_name IN ('SLTitans Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SN CyberCore Esports') AND alternate_name IN ('CyberCore Esports', 'D1VERSE', 'DREAM CHASERS', 'SN CyberCore Esports', 'THE LABEL')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SNOOZE Esports') AND alternate_name IN ('Rift Sloths', 'SNOOZE Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SOVEJA') AND alternate_name IN ('SOVEJA')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SPGeSports') AND alternate_name IN ('SPGeSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SPIKE Syndicate') AND alternate_name IN ('SPIKE Syndicate')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SQUARE (Korean Team)') AND alternate_name IN ('SQUARE (Korean Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='STAR (Russian Team)') AND alternate_name IN ('STAR (Russian Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='STOPWATCH eSports (Czech Team)') AND alternate_name IN ('STOPWATCH eSports (Czech Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='STRAT Esport') AND alternate_name IN ('STRAT Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='STRAW') AND alternate_name IN ('STRAW')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='STXP') AND alternate_name IN ('STXP')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Saigon Dino') AND alternate_name IN ('DG Esports', 'Dino Thống Nhất', 'Saigon Dino')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Saikyo Makinyan') AND alternate_name IN ('Saikyo Makinyan')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Saint Louis University') AND alternate_name IN ('Saint Louis University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Samsung Morning Stars') AND alternate_name IN ('Samsung Morning Stars')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='San Jose State University') AND alternate_name IN ('San Jose State University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SanHe Gaming') AND alternate_name IN ('SanHe Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sangal Esports') AND alternate_name IN ('Sangal Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sansin Gavin') AND alternate_name IN ('Sansin Gavin')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Santiago Wanderers eSports') AND alternate_name IN ('Santiago Wanderers eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Saprissa Esports') AND alternate_name IN ('Saprissa Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Savage (Latin American Team)') AND alternate_name IN ('Savage (Latin American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Savannah College of Art and Design') AND alternate_name IN ('Savannah College of Art and Design')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Saving OCE') AND alternate_name IN ('Saving OCE')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Scorpio Game') AND alternate_name IN ('Scorpio Game')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Scouting4ProScene') AND alternate_name IN ('Scouting4ProScene')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Se Loco Cachorreira') AND alternate_name IN ('Se Loco Cachorreira')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SeQura ZEST') AND alternate_name IN ('SeQura ZEST', 'ZERØZONE', 'ZEST (Spanish Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sea Dogs') AND alternate_name IN ('Sea Dogs')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SeaDoggos') AND alternate_name IN ('SeaDoggos')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Seattle Ferocity') AND alternate_name IN ('Seattle Ferocity')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sector 7') AND alternate_name IN ('Sector 7')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sector One') AND alternate_name IN ('Sector One', 'Sector One Academy', 'Sector One Black', 'Sector One Fox')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Seed 32') AND alternate_name IN ('Seed 32')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Senshi Esports Club') AND alternate_name IN ('Senshi Esports Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Senshi eSports (Benelux Team)') AND alternate_name IN ('Senshi eSports (Benelux Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sentinels ESC') AND alternate_name IN ('Sentinels ESC')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Seoul Neon') AND alternate_name IN ('Seoul Neon', 'Seoul Rising', 'Vexo eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Seven Dark') AND alternate_name IN ('Seven Dark')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ShaBoingBoing Esports') AND alternate_name IN ('ShaBoingBoing Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Shadow Corp') AND alternate_name IN ('Shadow Academy', 'Shadow Ace', 'Shadow Anyche', 'Shadow Battlica', 'Shadow Battlica Y', 'Shadow Boxing', 'Shadow Cool', 'Shadow Corp', 'Shadow Dawn', 'Shadow Deeplol', 'Shadow Dreamer', 'Shadow EK', 'Shadow ELG', 'Shadow GT', 'Shadow IBJ', 'Shadow LCPMM', 'Shadow LNG', 'Shadow LOG', 'Shadow New', 'Shadow RGS', 'Shadow Rookies', 'Shadow SF', 'Shadow Zero', 'Shadow fOu', 'Team Shadow')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Shadowban') AND alternate_name IN ('Shadowban')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sharks Esports Team') AND alternate_name IN ('Sharks Esports Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sheng Jie Gaming') AND alternate_name IN ('Sheng Jie Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Shih Hsin Meow Meow') AND alternate_name IN ('Shih Hsin Meow Meow')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Shining Stars') AND alternate_name IN ('Shining Stars')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Shock Gaming') AND alternate_name IN ('Shock Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Si Yi Xuan E-Sport') AND alternate_name IN ('Si Yi Xuan E-Sport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sicar Esports') AND alternate_name IN ('Sicar Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sign Us Please') AND alternate_name IN ('Sign Us Please')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Silent Revolution Gaming') AND alternate_name IN ('Silent Revolution Gaming', 'Team Zhonyas Revolution')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Silent Storm Esports') AND alternate_name IN ('Silent Storm Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Silver Prisoners') AND alternate_name IN ('Emerald Prisoners Academy', 'Silver Prisoners')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Silver Wolves') AND alternate_name IN ('Silver Wolves')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Simplicity Esports') AND alternate_name IN ('Simplicity Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Single Target Healing') AND alternate_name IN ('NO AOE DMG', 'Single Target Healing')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Skillcamp') AND alternate_name IN ('Skillcamp')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Skull Cracker') AND alternate_name IN ('Skull Cracker')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Slaughter House') AND alternate_name IN ('Slaughter House')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sleepy Callers') AND alternate_name IN ('Sleepy Callers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SleepyGoose') AND alternate_name IN ('SleepyGoose')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Smoke Tram') AND alternate_name IN ('Smoke Tram', 'Smoke Tram Academy', 'Smoke Tram Wolves')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Snowman Slammers') AND alternate_name IN ('Snowman Slammers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SolaFide Esports') AND alternate_name IN ('SolaFide Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Solary') AND alternate_name IN ('Lunary', 'Solary', 'Solary Academy', 'Solary Legends', 'Team Eclypse')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Solwing Esports') AND alternate_name IN ('Solwing Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sons of Tzu Gaming') AND alternate_name IN ('Sons of Tzu Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Soul''s Heart Esport') AND alternate_name IN ('Soul''s Heart Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sour Savoury') AND alternate_name IN ('Sour Savoury')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Space eSports') AND alternate_name IN ('Space eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Spain5') AND alternate_name IN ('Spain5')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Spandauer Inferno') AND alternate_name IN ('Spandauer Inferno')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Spartans EU') AND alternate_name IN ('Spartans EU')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sparx Esports') AND alternate_name IN ('Sparx Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Spectacled Bears') AND alternate_name IN ('Spectacled Bears')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Spicy Gorillas') AND alternate_name IN ('Spicy Gorillas')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Spinebusters E-Sport') AND alternate_name IN ('ERN ROAR', 'RNL ROAR', 'Spinebusters E-Sport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Spirit Esports') AND alternate_name IN ('Illés Akadémia Spirit', 'Spirit Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Spirit Quartz Gaming') AND alternate_name IN ('Spirit Quartz Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Spirituals') AND alternate_name IN ('Spirituals')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Split Raiders') AND alternate_name IN ('Split Raiders')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Spongecord prime') AND alternate_name IN ('Spongecord prime')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sport Boys Association') AND alternate_name IN ('Sport Boys Association')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sportia Khore') AND alternate_name IN ('Sportia Khore')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sprout (German Team)') AND alternate_name IN ('Aequilibritas E-Sports', 'RULE', 'Sprout (German Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Srdce nehasnou') AND alternate_name IN ('Srdce nehasnou')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='St. Clair College') AND alternate_name IN ('St. Clair College')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Stade Tunisien Esports') AND alternate_name IN ('Stade Tunisien Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Starlan Gaming Club Academy') AND alternate_name IN ('Starlan Gaming Club', 'Starlan Gaming Club Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='State University of New York at Buffalo') AND alternate_name IN ('State University of New York at Buffalo')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Steak Frites') AND alternate_name IN ('Steak Frites')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Stellae Gaming') AND alternate_name IN ('Stellae Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Steve Bakes Cookies') AND alternate_name IN ('Steve Bakes Cookies')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Stone Movistar') AND alternate_name IN ('Stone Movistar')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Storm Games Clan') AND alternate_name IN ('Storm Games Clan')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Storm Teams') AND alternate_name IN ('Storm Teams')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='StormMedia Fajnie Mieć Skład') AND alternate_name IN ('Fajnie Mieć Skład', 'Fajnie Mieć Skład Academy', 'StormMedia Fajnie Mieć Skład')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Stormbringers') AND alternate_name IN ('Stormbringers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Straw Hat Crew') AND alternate_name IN ('Straw Hat Crew')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Striking Vipers Champions') AND alternate_name IN ('Striking Vipers', 'Striking Vipers Champions', 'Striking Vipers Maestros')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Submarino Stars') AND alternate_name IN ('Submarino Stars')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SunSister ReUnion') AND alternate_name IN ('SunSister ReUnion')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Suns Gos Hawk') AND alternate_name IN ('Suns Gos Hawk')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Super Sunshine Fruit Basket Warriors') AND alternate_name IN ('Super Sunshine Fruit Basket Warriors')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SuperNitro1') AND alternate_name IN ('SuperNitro1')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Supernova') AND alternate_name IN ('Dark Matter', 'Super Nova Sentinels', 'Supernova', 'Supernova Comets')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Synthetic Esports') AND alternate_name IN ('Synthetic Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Szata Maga') AND alternate_name IN ('Szata Maga')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Szaty Bobra') AND alternate_name IN ('Szaty Bobra')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Szef 6') AND alternate_name IN ('Szef 6')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='T3H Esports') AND alternate_name IN ('T3H Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='TBA (North American Team)') AND alternate_name IN ('TBA (North American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='TDC Esports') AND alternate_name IN ('TDC Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='TEAM GR1') AND alternate_name IN ('GR1ND', 'TEAM GR1')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='TEAM ORANGE') AND alternate_name IN ('TEAM ORANGE')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='TES (Hong Kong Team)') AND alternate_name IN ('TES (Hong Kong Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='TFK') AND alternate_name IN ('TFK')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='THUNDR Esports') AND alternate_name IN ('THUNDR Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='TKA E-Sports') AND alternate_name IN ('TKA E-Sports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='TNU Eagle') AND alternate_name IN ('TNU Eagle')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='TOOOLS esports') AND alternate_name IN ('TOOOLS esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='TT willhaben') AND alternate_name IN ('TT willhaben')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='TWELVE') AND alternate_name IN ('TWELVE')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='TWOTWOEIGHT') AND alternate_name IN ('Alpha Team', 'TWOTWOEIGHT')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Taco Gaming') AND alternate_name IN ('Taco Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Tactical Esports') AND alternate_name IN ('Tactical Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Tan Chi Sa Gaming') AND alternate_name IN ('Tan Chi Sa Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Tan''i eSports') AND alternate_name IN ('Tan''i eSports', 'Tan''i eSports CZ', 'UnlockTan''i', 'Unlockzar')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Taurus Esports') AND alternate_name IN ('Taurus Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team 7AM') AND alternate_name IN ('Team 7AM', 'Team 7AM Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Amazigh') AND alternate_name IN ('Team Amazigh')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Ambition') AND alternate_name IN ('Team Ambition', 'Team Ambition Black', 'Team Ambition Blaze', 'Team Ambition Red', 'Team Ambition Sussy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Amelia') AND alternate_name IN ('Team Amelia')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Animals') AND alternate_name IN ('Team Animals')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Anomaly Breaker') AND alternate_name IN ('Team Anomaly Breaker')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Arcade') AND alternate_name IN ('Team Arcade')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Ascent') AND alternate_name IN ('Team Ascent')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Atlantis') AND alternate_name IN ('Team Atlantis')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Axelent69') AND alternate_name IN ('Team Axelent69')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team BDS Valkyries') AND alternate_name IN ('Team BDS Valkyries')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Black (Dutch Team)') AND alternate_name IN ('Connecting Esports LYVT', 'Team Black (Dutch Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Brickz') AND alternate_name IN ('Team Brickz')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Charon') AND alternate_name IN ('Team Charon')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Clarity') AND alternate_name IN ('Team Clarity')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Cloud Drake (NASG Team)') AND alternate_name IN ('Team Cloud Drake (NASG Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Coachify') AND alternate_name IN ('Team Coachify')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Confound') AND alternate_name IN ('Team Confound')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team DPD') AND alternate_name IN ('Team DPD')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Death Knights') AND alternate_name IN ('Team Death Knights')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team DeftFox') AND alternate_name IN ('Team DeftFox')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Dizzy') AND alternate_name IN ('Team Dizzy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Du Sud') AND alternate_name IN ('Team Du Sud')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Dynasty') AND alternate_name IN ('Team Dynasty')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team E Turner') AND alternate_name IN ('Team E Turner', 'Team Plink')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team ESCA Gaming') AND alternate_name IN ('Team ESCA Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team EYA X Prestige Esport') AND alternate_name IN ('Elyandra Esport', 'IZI Elyandra', 'Team EYA X Prestige Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team EasyFix Co-Hop') AND alternate_name IN ('Team EasyFix Co-Hop')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Evermeet') AND alternate_name IN ('Team Evermeet')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Falcons') AND alternate_name IN ('Team Falcons')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Fish Taco') AND alternate_name IN ('Team Fish Taco')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Flash.Singapore') AND alternate_name IN ('Team Flash.Singapore', 'Team Flash.Vietnam')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Flux') AND alternate_name IN ('Team Flux')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Forge') AND alternate_name IN ('Team Forge')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Fracture') AND alternate_name IN ('Team Fracture')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Front') AND alternate_name IN ('Team Front')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Frostbite') AND alternate_name IN ('Team Frostbite')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Furca') AND alternate_name IN ('Furca Angels', 'Team Furca')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team GMask') AND alternate_name IN ('Team GMask')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Gates') AND alternate_name IN ('Team Gates')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Genji') AND alternate_name IN ('Team Genji')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Horizon Reapers') AND alternate_name IN ('Team Horizon Reapers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Infamous') AND alternate_name IN ('Team Infamous')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Infernal Drake (NASG Team)') AND alternate_name IN ('Team Infernal Drake (NASG Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Insidious') AND alternate_name IN ('Team Insidious')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team KungFu') AND alternate_name IN ('Team KungFu')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Legion (Benelux Team)') AND alternate_name IN ('Team Legion (Benelux Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Legion (Greek Team)') AND alternate_name IN ('Team Legion (Greek Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team MCES') AND alternate_name IN ('M''AZING', 'MCES Italia', 'MCES Italia Academy', 'Team MCES', 'Team MCES Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Majesty') AND alternate_name IN ('Team Majesty', 'Team Majesty Black', 'Team Majesty Gold')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Meliora') AND alternate_name IN ('Team Meliora')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Mentality') AND alternate_name IN ('Team Mentality')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Moops') AND alternate_name IN ('Team Moops')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Mountain Drake (NASG Team)') AND alternate_name IN ('Team Mountain Drake (NASG Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Mythic') AND alternate_name IN ('Team Mythic')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Nevo') AND alternate_name IN ('Team Nevo')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Ocean Drake (NASG Team)') AND alternate_name IN ('Team Ocean Drake (NASG Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Overclockers UK') AND alternate_name IN ('Team Overclockers UK')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team PHZ') AND alternate_name IN ('Team PHZ')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Paradox') AND alternate_name IN ('Team Paradox')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Pending') AND alternate_name IN ('Team Pending')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Phantasma') AND alternate_name IN ('Game Changers', 'Team Phantasma', 'Team Phantasma Community')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Pique Sel') AND alternate_name IN ('Team Pique Sel')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Plague') AND alternate_name IN ('Team Plague')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Queso') AND alternate_name IN ('Arena Quesito', 'Estadio Quesito', 'Team Queso')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team RM') AND alternate_name IN ('Team RM')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team ROCK') AND alternate_name IN ('Team ROCK')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Rapid') AND alternate_name IN ('Team Rapid')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Refuse') AND alternate_name IN ('Team Refuse')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Riverside') AND alternate_name IN ('Team Riverside')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team SalsaLoL') AND alternate_name IN ('Team SalsaLoL')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Same Mordeczki') AND alternate_name IN ('Team Same Mordeczki')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Sampi') AND alternate_name IN ('Team Sampi')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Singularity') AND alternate_name IN ('Team Singularity')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team THRLL Academy') AND alternate_name IN ('Team THRLL', 'Team THRLL Academy', 'Team THRLL Academy Twente', 'Team THRLL Academy Youth')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Tony Top') AND alternate_name IN ('Gödel Gamers', 'Team Tony Top', 'Tiktok Tony Top')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team UNiTY') AND alternate_name IN ('Team UNiTY')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Universe') AND alternate_name IN ('Team Universe')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Valiant') AND alternate_name IN ('Team Valiant')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team WeForge') AND alternate_name IN ('Team WeForge')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team YOLO') AND alternate_name IN ('Team YOLO')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Zan') AND alternate_name IN ('Team Zan')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Zoose') AND alternate_name IN ('Team Zoose')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team xo') AND alternate_name IN ('Team xo')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='TeamOrangeGaming') AND alternate_name IN ('TeamOrangeGaming', 'TeamOrangeGaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Teamless Revenge') AND alternate_name IN ('Teamless Revenge')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Tempered Fate') AND alternate_name IN ('Tempered Fate')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Tempest Gaming') AND alternate_name IN ('Tempest Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Tempo Storm') AND alternate_name IN ('Tempo Storm')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Agency') AND alternate_name IN ('Team Echo Zulu', 'Team Echo Zulu Tribe', 'The Agency')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Boys Attorneys at Law') AND alternate_name IN ('The Boys Attorneys at Law')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Cheese Chasers') AND alternate_name IN ('The Cheese Chasers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Dog King Neru') AND alternate_name IN ('Neru Esports Club', 'The Dog King Neru')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Expendables') AND alternate_name IN ('Old Players (North American Team)', 'The Expendables')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Final Tribe') AND alternate_name IN ('The Final Tribe')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Forbidden Five') AND alternate_name IN ('The Forbidden Five')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Gulls Esports') AND alternate_name IN ('The Gulls Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Krusty Crew') AND alternate_name IN ('The Krusty Crew')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Last Dance') AND alternate_name IN ('The Last Dance')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Last Monk') AND alternate_name IN ('The Last Monk', 'eScribas Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The League of Extraordinary Monsters') AND alternate_name IN ('The League of Extraordinary Monsters')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Longest Yard') AND alternate_name IN ('The Longest Yard')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Nameless') AND alternate_name IN ('Nameless Randoms', 'Nameless Thieves', 'The Nameless')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Northern Front') AND alternate_name IN ('The Northern Front')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Pack') AND alternate_name IN ('The Pack')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Plan') AND alternate_name IN ('Neronity', 'Team Nerotec', 'The Plan')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The RED') AND alternate_name IN ('The RED')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Secret Club') AND alternate_name IN ('The Secret Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Spawn Esports') AND alternate_name IN ('The Spawn Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Tower') AND alternate_name IN ('The Tower')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Third Party') AND alternate_name IN ('Third Party')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ThunderFlash') AND alternate_name IN ('ThunderFlash')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ThunderoBot Gaming') AND alternate_name IN ('ThunderoBot Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Tick Trick and Duck') AND alternate_name IN ('Tick Trick and Duck')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Timeforce') AND alternate_name IN ('Timeforce')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Timeout Esports') AND alternate_name IN ('Timeout Esports', 'Timeout Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Tindastóll') AND alternate_name IN ('Tindastóll')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='To The Arena') AND alternate_name IN ('To The Arena')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Tomorrow Esports') AND alternate_name IN ('Tomorrow Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Tongtex Suns') AND alternate_name IN ('Tongtex Suns')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Top Dog Gaming') AND alternate_name IN ('Top Dog Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='TopHard Esports') AND alternate_name IN ('TopHard Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ToxicFalcons eSports') AND alternate_name IN ('ToxicFalcons eSports', 'ToxicFalcons eSports Belgium')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='TrainHard eSport') AND alternate_name IN ('TrainHard eSport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Trance''s Tyrants') AND alternate_name IN ('Trance''s Tyrants')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Trinity (Thai Team)') AND alternate_name IN ('Trinity (Thai Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Triple Esports') AND alternate_name IN ('Triple Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Triumphant Song Gaming') AND alternate_name IN ('Triumphant Song Gaming', 'Victory Song Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Tundra Gaming') AND alternate_name IN ('Tundra Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Turing eSports') AND alternate_name IN ('Turing eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Twisted Minds') AND alternate_name IN ('Twisted Minds')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Two-eyed Monsters') AND alternate_name IN ('Two-eyed Monsters')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Tồ Gaming') AND alternate_name IN ('Tồ Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='U4RIA Nerium') AND alternate_name IN ('U4RIA Nerium')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='UCAM Esports') AND alternate_name IN ('Penguins', 'UCAM Esports', 'UCAM Esports Academy', 'UCAM Esports Club', 'UCAM Esports Club Academy', 'UCAM Penguins', 'UCAM Tokiers', 'UCAM Tokiers Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='UCXD') AND alternate_name IN ('UCXD')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ULF Esports') AND alternate_name IN ('ULF Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='UQ Union') AND alternate_name IN ('UQ Union')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='UTM Esports') AND alternate_name IN ('Maximal', 'UTM Esports', 'Ultimate')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='UTS Esports') AND alternate_name IN ('UTS Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ukrainian Glory Team') AND alternate_name IN ('Ukrainian Glory Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Umbra Collective') AND alternate_name IN ('Umbra Collective')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Umbra Divinus Gaming') AND alternate_name IN ('Umbra Divinus Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Undead Gaming') AND alternate_name IN ('Undead Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Underworld Esports') AND alternate_name IN ('Underworld Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Unfazed Esport') AND alternate_name IN ('Unfazed Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='UniQ Esports Club') AND alternate_name IN ('UniQ Esports Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Universae Instituto FP') AND alternate_name IN ('Universae Instituto FP')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Universitario Esports') AND alternate_name IN ('Cremas Esports', 'Universitario Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of British Columbia') AND alternate_name IN ('University of British Columbia')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of California Berkeley') AND alternate_name IN ('University of California Berkeley')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of California Irvine') AND alternate_name IN ('University of California Irvine', 'University of California Irvine B')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of California Riverside') AND alternate_name IN ('University of California Riverside')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of California San Diego') AND alternate_name IN ('University of California San Diego')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of Colorado Boulder') AND alternate_name IN ('University of Colorado Boulder')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of Health Sciences and Pharmacy in St. Louis') AND alternate_name IN ('University of Health Sciences and Pharmacy in St. Louis')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of Illinois at Urbana-Champaign') AND alternate_name IN ('University of Illinois at Urbana-Champaign')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of Michigan') AND alternate_name IN ('University of Michigan')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of Minnesota Twin Cities') AND alternate_name IN ('University of Minnesota Twin Cities')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of Mississippi') AND alternate_name IN ('University of Mississippi')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of North America') AND alternate_name IN ('University of North America')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of Ottawa') AND alternate_name IN ('University of Ottawa')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of South Florida') AND alternate_name IN ('University of South Florida')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of Southern California') AND alternate_name IN ('University of Southern California')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of St. Thomas') AND alternate_name IN ('University of St. Thomas')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of St. Trevor') AND alternate_name IN ('University of St. Trevor')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of Texas at Austin') AND alternate_name IN ('University of Texas at Austin')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of Texas at Dallas') AND alternate_name IN ('University of Texas at Dallas')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of Toronto') AND alternate_name IN ('University of Toronto')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of Toronto Scarborough') AND alternate_name IN ('University of Toronto Scarborough')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of Waterloo') AND alternate_name IN ('University of Waterloo')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='University of Western Ontario') AND alternate_name IN ('University of Western Ontario')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Unknowns Gamers') AND alternate_name IN ('Unknowns Gamers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Upper Echelon') AND alternate_name IN ('Upper Echelon')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Upper Five Flying Kittens') AND alternate_name IN ('Upper Five', 'Upper Five Flying Kittens')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='VARREL YOUTH') AND alternate_name IN ('VARREL YOUTH')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='VAULT') AND alternate_name IN ('VAULT')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='VC Gaming') AND alternate_name IN ('VC Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='VININE') AND alternate_name IN ('VININE')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='VIRUS (Greek Team)') AND alternate_name IN ('VIRUS (Greek Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='VIS eSports') AND alternate_name IN ('VIS eSports', 'ViS Lions'' Den')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='VITA (Icelandic Team)') AND alternate_name IN ('TobeAnnounced', 'VITA (Icelandic Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Val 2.0 Valkyrie') AND alternate_name IN ('Val 2.0 Valkyrie')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Valhalla Vikings') AND alternate_name IN ('Valhalla Vikings')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Valiance') AND alternate_name IN ('CR4ZY', 'Valiance')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Valkiria Esports') AND alternate_name IN ('Valkiria Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Valkiria''s Vikings') AND alternate_name IN ('Valkiria''s Vikings', 'Vikings of the Rift')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Valorous') AND alternate_name IN ('Valorous')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Valyrian Dragons') AND alternate_name IN ('Valyrian Dragons')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vancouver Impact') AND alternate_name IN ('Vancouver Impact')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vandals Esports') AND alternate_name IN ('Vandals Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vanir') AND alternate_name IN ('Vanir')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vanung Lion') AND alternate_name IN ('Vanung Lion')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vasco E-Sports') AND alternate_name IN ('Vasco E-Sports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vector Gaming') AND alternate_name IN ('Vector Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vegas Inferno') AND alternate_name IN ('Vegas Inferno')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Veni Vidi Vici (Spanish Team)') AND alternate_name IN ('3V', 'Dogs of War', 'Veni Vidi Vici (Spanish Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Veni eSports') AND alternate_name IN ('Veni eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Venomcrest Esports') AND alternate_name IN ('Venomcrest Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ventus Esports') AND alternate_name IN ('Ventus Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Venus (Turkish Team)') AND alternate_name IN ('Venus (Turkish Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Venus Gaming') AND alternate_name IN ('Venus Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Verdant') AND alternate_name IN ('Verdant')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Verity Esports') AND alternate_name IN ('Verity Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='VfB eSports') AND alternate_name IN ('VfB eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ViV Esport') AND alternate_name IN ('ViV Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Victorious Demons') AND alternate_name IN ('Victorious Demons')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Victorious Gaming') AND alternate_name IN ('Victorious Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='VietSun Esports') AND alternate_name IN ('APOLLO GAMING', 'VietSun Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vigilantes') AND alternate_name IN ('Protecting Guardians', 'Vigilantes')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vigilantes Talent') AND alternate_name IN ('Vigilantes Talent')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Viking Esports (Norwegian Team)') AND alternate_name IN ('Viking Esports (Norwegian Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vikingekrig Esports') AND alternate_name IN ('Vikingekrig Academy', 'Vikingekrig Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Villarreal QLASH') AND alternate_name IN ('Villarreal QLASH')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Viperio') AND alternate_name IN ('Viperio')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vipers') AND alternate_name IN ('Vipers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vipers Inc') AND alternate_name IN ('Vipers Inc')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Virginia Polytechnic Institute and State University') AND alternate_name IN ('Virginia Polytechnic Institute and State University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Virtual Reality Game') AND alternate_name IN ('Virtual Reality Game')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Virtuoso Gaming') AND alternate_name IN ('Team GBK', 'Virtuoso Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Visual Perception') AND alternate_name IN ('Visual Perception')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Void Gaming Phenomenon') AND alternate_name IN ('Void Gaming', 'Void Gaming Phenomenon')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vortex (North American Team)') AND alternate_name IN ('Final Five', 'Vortex (North American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vortex Five') AND alternate_name IN ('Vortex Five')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vortex Gaming (Latin American Team)') AND alternate_name IN ('Vortex Gaming (Latin American Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vortex Team') AND alternate_name IN ('Vortex Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vyral') AND alternate_name IN ('Vyral')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='WANG DYNASTY') AND alternate_name IN ('WANG DYNASTY')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='WANG TOWN') AND alternate_name IN ('WANG TOWN')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='WAP Esports') AND alternate_name IN ('WAP Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='WAVE Esports') AND alternate_name IN ('WAVE Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='WLG Female Stars') AND alternate_name IN ('WLG Female Stars')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='WLGaming Esports') AND alternate_name IN ('Future Perfect WLGaming', 'WLGaming Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='WP Gaming') AND alternate_name IN ('WP Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='WR Builds Flame Horizon') AND alternate_name IN ('WR Builds Flame Horizon')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='WYDream') AND alternate_name IN ('WYDream', 'Wan Yoo')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='WaY (Korean Team)') AND alternate_name IN ('WaY (Korean Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Waia Snikt') AND alternate_name IN ('Waia Snikt')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wang''s Revenge') AND alternate_name IN ('Wang''s Revenge')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wangting') AND alternate_name IN ('Wangting')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='WannaBeWithYou') AND alternate_name IN ('WannaBeWithYou')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='War Legion Esports') AND alternate_name IN ('War Legion Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='WarKidZ E-Sports') AND alternate_name IN ('WarKidZ E-Sports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wardens') AND alternate_name IN ('Wardens')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Warthox Esport') AND alternate_name IN ('Warthox Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wazabi Gaming') AND alternate_name IN ('Wazabi Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='We Plash Academy') AND alternate_name IN ('We Plash Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='We Talent') AND alternate_name IN ('We Talent')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='WeSports') AND alternate_name IN ('WeSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Weber State University') AND alternate_name IN ('Weber State University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Webidoo Gaming') AND alternate_name IN ('Webidoo Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='WhereAreyouFrom') AND alternate_name IN ('WhereAreyouFrom')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='White Dragons') AND alternate_name IN ('White Dragons')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='WiLD MultiGaming') AND alternate_name IN ('WiLD Academy', 'WiLD MultiGaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wichita Wolves') AND alternate_name IN ('Wichita Wolves')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wicked Gaming') AND alternate_name IN ('Wicked Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wild Jaguars') AND alternate_name IN ('Wild Jaguars')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wild Panthers Esports') AND alternate_name IN ('Panther Stars Esports', 'Wild Panthers Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wild West Bandits') AND alternate_name IN ('Wild West Bandits')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wildcard Gaming') AND alternate_name IN ('Wildcard Aces', 'Wildcard Gaming', 'Wildcard Gaming Black', 'Wildcard Gaming Developmental', 'Wildcard Gaming Red')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wina Krzycha') AND alternate_name IN ('Internaziomale', 'Wina Krzycha')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wind and Rain') AND alternate_name IN ('Wind and Rain')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Windstorm Gaming') AND alternate_name IN ('Windstorm Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Winston King of Amateur') AND alternate_name IN ('Winston King of Amateur')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Winthrop University') AND alternate_name IN ('Winthrop University', 'Winthrop University B')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wisła Płock eSports') AND alternate_name IN ('Wisła Płock eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wizard esports') AND alternate_name IN ('Wizard esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wizards') AND alternate_name IN ('Wizards', 'Wizards e-Sports Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wolf Club Esports') AND alternate_name IN ('Supay Gaming', 'Wolf Club Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wonder Stag e-Sports') AND alternate_name IN ('Wonder Stag e-Sports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='World Class Empyreans') AND alternate_name IN ('World Class Empyreans')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wortex Gaming') AND alternate_name IN ('Wortex Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wulf Pack') AND alternate_name IN ('Wulf Pack')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wygers Argentina') AND alternate_name IN ('Wygers Argentina')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wygers Colombia') AND alternate_name IN ('Wygers Colombia')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='X25 Esports') AND alternate_name IN ('X25 Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='X6tence') AND alternate_name IN ('X6tence', 'X6tence Academy', 'X6tence Mexico')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='X7 Ascent') AND alternate_name IN ('X7 Ascent', 'X7 Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='XAL Esports') AND alternate_name IN ('XAL Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='XO Esports') AND alternate_name IN ('XO Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='XT Esports') AND alternate_name IN ('XT Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='XV eSports') AND alternate_name IN ('Tropa XV', 'XV eSports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='XY Esports') AND alternate_name IN ('XY Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='XYZ (Korean Team)') AND alternate_name IN ('XYZ (Korean Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Xibalbá Esports') AND alternate_name IN ('PÊEK Gaming', 'Xibalbá Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Xoldiers') AND alternate_name IN ('LEX Esports', 'Xoldiers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Xora Esports') AND alternate_name IN ('Xora Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='XtremeDominators') AND alternate_name IN ('XtremeDominators')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Y so E-Sports') AND alternate_name IN ('Y so E-Sports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='YDN Esports') AND alternate_name IN ('YDN Devils', 'YDN Esports', 'YDN Gamers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Yalla Esport') AND alternate_name IN ('Yalla Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Yang Dae Pal Korean BBQ Restaurant') AND alternate_name IN ('Yang Dae Pal Korean BBQ Restaurant')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Yang Yang Gaming') AND alternate_name IN ('Yang Yang Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='YeaH! Gaming') AND alternate_name IN ('YeaH! Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='York University') AND alternate_name IN ('York University')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='YouCantStopMe') AND alternate_name IN ('YouCantStopMe')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Young Buffalo') AND alternate_name IN ('Young Buffalo')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Young Buffalos') AND alternate_name IN ('Water Buffalos Unleashed', 'Young Buffalos')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Youth Warriors') AND alternate_name IN ('Youth Warriors')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Yumisu Invicta') AND alternate_name IN ('XPG Invicta', 'Yumisu Invicta')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Yutoru') AND alternate_name IN ('Yutoru', 'Yutoru Berserkers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Z10 ESHARK') AND alternate_name IN ('Z10 ESHARK', 'Zero Tenacity')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ZETA') AND alternate_name IN ('Rebels Gaming', 'ZETA', 'Zeta Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ZTR Gaming') AND alternate_name IN ('ZTR Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zeeman') AND alternate_name IN ('Zeeman')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zen Esports') AND alternate_name IN ('Zen Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zena Esports Portugal') AND alternate_name IN ('Zena Esports', 'Zena Esports Portugal')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zenigma') AND alternate_name IN ('Des Moines DMG', 'Zenigma', 'Zenigma Eclipse', 'Zenigma Lunar', 'Zenigma Solar')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ZennIT') AND alternate_name IN ('ZennIT')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zenshi Gaming') AND alternate_name IN ('Zenshi Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ZentaX Esports') AND alternate_name IN ('ZentaX Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zephyr Esport') AND alternate_name IN ('Zephyr Esport')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zerance') AND alternate_name IN ('Zerance')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zerance Bloom') AND alternate_name IN ('Zerance Bloom')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zero Six PowerSpike') AND alternate_name IN ('TestTeam1234', 'Zero Six PowerSpike')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zero Tenacity Spears') AND alternate_name IN ('Zero Tenacity Academy', 'Zero Tenacity Spears')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ZeroSeven Gera') AND alternate_name IN ('ZeroSeven Gera')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ZeroZone Gaming') AND alternate_name IN ('ZeroZone Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zerolag Esports') AND alternate_name IN ('Here To Win It', 'Zerolag Esports', 'Zerolag Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zeta Team') AND alternate_name IN ('Zeta Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zeu5 Esports') AND alternate_name IN ('Zeu5 Bogota', 'Zeu5 Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zeus Kralik') AND alternate_name IN ('Zeus Kralik')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zodiac Esports') AND alternate_name IN ('Zodiac Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zoltak Legion') AND alternate_name IN ('Zoltak Legion')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zooby''s Kittens') AND alternate_name IN ('Zooby''s Kittens')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zoos Gaming') AND alternate_name IN ('ANEW Academy', 'ANEW Blaze', 'ANEW Dawn', 'ANEW Esports', 'ANEW Hope', 'ANEW Rising', 'Zoos Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zwan Gaming Mexico') AND alternate_name IN ('Zwan Gaming', 'Zwan Gaming Colombia', 'Zwan Gaming Mexico')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Zylant Esports') AND alternate_name IN ('Zylant Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Žalgiris Esports') AND alternate_name IN ('Žalgiris Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='정글 격리해제') AND alternate_name IN ('정글 격리해제', '정글은 격리중')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='100 Thieves') AND alternate_name IN ('100 Thieves Academy', '100 Thieves Challengers', '100 Thieves Next')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='5 Ronin') AND alternate_name IN ('5 Ronin Academy', 'Bursaspor Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AXIZ') AND alternate_name IN ('AXIZ Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='AXIZ CREST') AND alternate_name IN ('AXIZ CREST Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Absolute Legends') AND alternate_name IN ('Absolute Legends CZSK', 'Absolute Legends Netherlands', 'HEET')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Alienware Arena') AND alternate_name IN ('Team Alienware')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Antic Esports') AND alternate_name IN ('Pentanet.GG Rise')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Anyone''s Legend') AND alternate_name IN ('Anyone''s Legend.Young', 'Rogue Warriors Shark')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Apex Gaming') AND alternate_name IN ('Apex Pride')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Astralis') AND alternate_name IN ('Astralis SB', 'Astralis Talent', 'Origen BCN', 'Origen SB')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Asura (Korean Team)') AND alternate_name IN ('Drabbit')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Avant Gaming') AND alternate_name IN ('Avant Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Azules Esports') AND alternate_name IN ('Azules Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BNK FEARX') AND alternate_name IN ('BNK FEARX Academy', 'BNK FEARX Youth', 'FearX Academy', 'FearX Youth', 'GC Busan SANDBOX', 'Liiv SANDBOX Academy', 'Liiv SANDBOX Academy 1Team', 'Liiv SANDBOX Academy 2Team', 'Liiv SANDBOX Academy Online', 'Liiv SANDBOX Academy Online A', 'Liiv SANDBOX Academy Online B', 'Liiv SANDBOX Youth', 'SANDBOX Gaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Beyond Gaming') AND alternate_name IN ('Beyond Gaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Big Gods') AND alternate_name IN ('Big Gods Jackals')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Bombers') AND alternate_name IN ('Bombers Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='BrawL eSports') AND alternate_name IN ('BrawL.NA')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Burning Core Toyama') AND alternate_name IN ('Burning Core Academy', 'Burning Core Toyama Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CERBERUS Esports (Vietnamese Team)') AND alternate_name IN ('CERBERUS Esports Academy', 'Puppies Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CNB e-Sports Club') AND alternate_name IN ('CNB Infinity')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CTBC Flying Oyster') AND alternate_name IN ('CTBC Flying Oyster Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CTRL PLAY') AND alternate_name IN ('CTRL PLAY Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cloud9') AND alternate_name IN ('Cloud9 Academy', 'Cloud9 Amateur', 'Cloud9 Challengers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='CompLexity.Black') AND alternate_name IN ('CompLexity.Red')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Counter Logic Gaming') AND alternate_name IN ('CLG Academy', 'CLG Black', 'CLG Challengers', 'CLG Faith')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Crest Gaming Act') AND alternate_name IN ('Crest Gaming Act Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Cruzeiro eSports') AND alternate_name IN ('Cruzeiro Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DAN Gaming') AND alternate_name IN ('AcFun e-Sports Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DN Freecs') AND alternate_name IN ('Afreeca Freecs Academy', 'Afreeca Freecs Academy A', 'Afreeca Freecs Academy B', 'Afreeca Freecs Rookie', 'Afreeca Freecs Youth', 'DN Freecs Academy', 'DN Freecs Challengers', 'Kwangdong Freecs Academy', 'Kwangdong Freecs Academy B', 'Kwangdong Freecs Challengers', 'Kwangdong Freecs Youth', 'Kwangdong Rookie', 'Kwangdong Samdasoo', 'Kwangdong Vita 500', '광동 옥수수수염차', '광동헛개차', '광동헛개파워')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DRX') AND alternate_name IN ('DRX Academy', 'DRX Academy 1', 'DRX Academy 2', 'DRX Academy A', 'DRX Academy B', 'DRX Challenge', 'DRX Enjoy', 'DRX Online', 'DRX Rookie', 'DRX Shinhan Bank', 'Team BearMax')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DeToNator (Southeast Asian Team)') AND alternate_name IN ('SEA Serpents')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Deep Cross Gaming') AND alternate_name IN ('Deep Cross Gaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='DetonatioN FocusMe') AND alternate_name IN ('DetonatioN FocusMe Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dewish Team') AND alternate_name IN ('Dewish Tnu Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dignitas') AND alternate_name IN ('Clutch Gaming Academy', 'Dignitas Academy', 'Dignitas Challengers', 'Team Dignitas EU')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dire Wolves') AND alternate_name IN ('Dire Cubs')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dplus KIA') AND alternate_name IN ('DAMWON Game Academy', 'DAMWON Game Academy A', 'DAMWON Game Academy B', 'DAMWON Game Academy H', 'DAMWON Game Academy J', 'DAMWON Game Academy K', 'DAMWON Game Academy L', 'DAMWON Game Academy W', 'DAMWON Gaming Academy', 'DGA Modesty', 'DWG KIA Academy', 'DWG KIA Youth', 'Dplus KIA Challengers', 'Dplus KIA Youth', 'GC Busan DGA', 'Gyeonggi GEA J', 'Gyeonggi GEA L', 'MiraGe Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dragon Army') AND alternate_name IN ('Dragon Army Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Dragon Gate Team') AND alternate_name IN ('Fish Dive Team')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='E-Champ Gaming') AND alternate_name IN ('e-Champ Gaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='EDward Gaming') AND alternate_name IN ('EDward Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Echo Fox') AND alternate_name IN ('Delta Fox', 'Echo Fox Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Energy Pacemaker.All') AND alternate_name IN ('Energy Pacemaker.The One')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Estral Esports') AND alternate_name IN ('Estral E-Sports Colombia', 'Estral Esports Aurora')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Evil Geniuses.NA') AND alternate_name IN ('Evil Geniuses Academy', 'Evil Geniuses Challengers', 'Evil Geniuses Prodigies')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Excel Esports') AND alternate_name IN ('BT Excel', 'Excel UK', 'JDXL')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FC Schalke 04 Esports') AND alternate_name IN ('FC Schalke 04 Evolution')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FENNEL') AND alternate_name IN ('FENNEL Academy', 'Rascal Jester Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FURIA') AND alternate_name IN ('FURIA Academy', 'FURIA Trainee', 'FURIA Youth')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fenerbahçe Esports') AND alternate_name IN ('Fenerbahçe Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fluxo W7M') AND alternate_name IN ('Fluxo Academy', 'W7m esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='FlyQuest') AND alternate_name IN ('FLY FAM', 'FlyQuest Academy', 'FlyQuest Challengers', 'FlyQuest NZXT')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fnatic') AND alternate_name IN ('Fnatic Rising', 'Fnatic TQ')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Frank Esports') AND alternate_name IN ('Frank Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Fukuoka SoftBank HAWKS gaming') AND alternate_name IN ('Fukuoka SoftBank HAWKS gaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Furious Gaming') AND alternate_name IN ('Furious Gaming Academy', 'Furious Gaming Argentina', 'Furious Gaming Chile')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='G-Rex') AND alternate_name IN ('G-Rex Infinite')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='G2 Esports') AND alternate_name IN ('Arctic Gaming', 'G2 Arctic', 'G2 Hel', 'G2 Heretics', 'G2 Vodafone')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GC Busan Ascension') AND alternate_name IN ('GC Busan (2020 Korean Team)', 'Rising SuperStar Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='GIANTX') AND alternate_name IN ('GIANTX Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Galakticos') AND alternate_name IN ('Galakticos Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Galatasaray Esports') AND alternate_name IN ('Galatasaray Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gama Dream') AND alternate_name IN ('Gama E-Sport Dream')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gen.G') AND alternate_name IN ('GGA (Korean Team)', 'GGA Pro', 'Gen.G Academy', 'Gen.G Academy 2', 'Gen.G Academy 3', 'Gen.G Global Academy', 'Gen.G Online', 'Gen.G Scholars')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Genius Esports') AND alternate_name IN ('GFDI Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Giants Gaming') AND alternate_name IN ('Giants Gaming Spain', 'Giants Underdoges', 'Vodafone Giants Academy', 'Vodafone Giants White', 'Vodafone Giants.Spain')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Globant Emerald') AND alternate_name IN ('Globant Emerald Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Golden Guardians') AND alternate_name IN ('Golden Guardians Academy', 'Golden Guardians Challengers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Gravitas') AND alternate_name IN ('Gravitas Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hanwha Life Esports') AND alternate_name IN ('7th heaven X', 'Hanwha Life Esports Academy', 'ROX COOL', 'Smash It Down', '배밥수빡고')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Hong Kong Attitude') AND alternate_name IN ('Hong Kong Attitude Mage', 'Hong Kong Attitude Priest')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='INFINITY') AND alternate_name IN ('Infinity Esports Academy', 'Infinity Esports Colombia', 'Infinity Esports Costa Rica')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='INTZ') AND alternate_name IN ('INTZ Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Immortals') AND alternate_name IN ('AOE Esports', 'AOE Gold', 'Area of Effect Brady', 'Area of Effect Cope', 'Area of Effect Cows', 'Area of Effect Ginger Turmeric', 'Area of Effect Need Her', 'Area of Effect Not Zoos', 'Area of Effect Pump', 'Area of Effect Randoms', 'Area of Effect Vice', 'Area of Effect Will''s Kittens', 'Ginger Turmeric', 'Immortals Academy', 'Immortals Area of Effect', 'Immortals Challengers', 'OpTic Gaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Imperium') AND alternate_name IN ('Krispy Kreme Crew')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Impunity') AND alternate_name IN ('Alternative Gaming')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Istanbul Wildcats') AND alternate_name IN ('HWA Gaming Academy', 'Istanbul Wildcats Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Isurus') AND alternate_name IN ('Isurus Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='J Team') AND alternate_name IN ('J Team 2', 'Taipei Bravo')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KT Rolster') AND alternate_name IN ('KT Rolster Academy', 'KT Rolster Academy A')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='KaBuM! Esports') AND alternate_name IN ('KaBuM! Academy', 'KaBuM! Ilha das Lendas')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Kaos Latin Gamers') AND alternate_name IN ('Kaos Latin Gamers Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Karmine Corp') AND alternate_name IN ('Kameto Corp', 'Karmine Corp Blue', 'Karmine Corp Blue Stars')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LGD Gaming') AND alternate_name IN ('VP Game')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LNG Esports') AND alternate_name IN ('Snake WuDu', 'WuDu')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LOUD') AND alternate_name IN ('LOUD Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='LYON (2024 American Team)') AND alternate_name IN ('LYON Academy', 'Lyon Gaming (2017 Latin America North Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Leviatan') AND alternate_name IN ('Leviatan Esports Chile')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Liberty') AND alternate_name IN ('Liberty Academy', 'Vorax Academy', 'Vorax Liberty Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Los Grandes') AND alternate_name IN ('Flamengo Academy', 'Flamengo Los Grandes Academy', 'Los Grandes Academy', 'Los Grandes Trainee')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Lowkey Esports.Vietnam') AND alternate_name IN ('Lowkey Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MAMMOTH') AND alternate_name IN ('Mammoth Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='MGN Vikings Esports') AND alternate_name IN ('MGN Vikings Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Machi Esports') AND alternate_name IN ('MachiX')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Millenium') AND alternate_name IN ('Millenium Spirit')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Miners') AND alternate_name IN ('Miners Academy', 'Miners Female', 'Netshoes Miners Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Misfits Gaming') AND alternate_name IN ('Misfits Premier', 'Renegades: Banditos')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Movistar KOI') AND alternate_name IN ('MAD Lions Academy', 'MAD Lions E.C.', 'MAD Lions E.C. Mexico', 'MAD Lions KOI Female', 'MAD Lions Madrid', 'Movistar KOI Fénix', 'Movistar Riders', 'Movistar Riders Academy', 'Movistar Riders Blue', 'Splyce Vipers')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Mysterious Monkeys') AND alternate_name IN ('Ad hoc gaming', 'Ad hoc gaming Gentlemen''s Club')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Newbee') AND alternate_name IN ('Newbee Young')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ninjas in Pyjamas.CN') AND alternate_name IN ('Ji Jie Hao', 'V5 87', 'Young Ninjas')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Nongshim RedForce') AND alternate_name IN ('ESA KOREA', 'Korea E-Sports Academy', 'Nongshim Esports Academy', 'Nongshim RedForce Academy', 'Nongshim RedForce Academy 2', 'Nongshim RedForce Academy ESA', 'Nongshim RedForce Academy ESA 2', 'Nongshim RedForce Trainee', 'Team Dynamics Academy', 'Team ESA')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='OKSavingsBank BRION') AND alternate_name IN ('BRION Academy', 'BRION Challengers', 'BRION Rookies', 'Brion Blade Academy', 'Fredit BRION Academy', 'Fredit BRION Academy A', 'Fredit BRION Academy B', 'Fredit BRION MPP', 'Fredit BRION Rookies', 'OKSavingsBank BRION Academy', 'OKSavingsBank BRION Academy Online', 'OKSavingsBank BRION Challengers', 'hyFresh Blade', 'hyFresh Blade Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ORDER') AND alternate_name IN ('ORDER Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Oh My God') AND alternate_name IN ('Oh My God Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Original Gaming') AND alternate_name IN ('Umi Esports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Oyun Hizmetleri') AND alternate_name IN ('Oyun Hizmetleri CILEKLER')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PENTAGRAM') AND alternate_name IN ('KINGDOM', 'Rampage Quintet')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PSG Talon') AND alternate_name IN ('TALON (Hong Kong Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='PaiN Gaming') AND alternate_name IN ('PaiN Gaming Academy', 'PaiN Gaming Female')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='RED Canids') AND alternate_name IN ('RED Academy', 'RED Canids B')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Rare Atom') AND alternate_name IN ('Rare Atom Period', 'Vici Esports', 'Vici Gaming Potential')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Redemption eSports Porto Alegre') AND alternate_name IN ('Redemption Academy', 'Redemption eSports POA B')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Remo Brave e-Sports') AND alternate_name IN ('Brave e-Sports')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Renegades') AND alternate_name IN ('Misfits (North American Team)', 'Renegades: Banditos')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Rensga Esports') AND alternate_name IN ('Rensga Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Rogue (European Team)') AND alternate_name IN ('AGO ROGUE', 'KOI Academy', 'KOI Amethyst', 'Rogue Esports Club', 'Rogue Stars')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Royal Youth') AND alternate_name IN ('Royal Youth Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SK Gaming') AND alternate_name IN ('SK Gaming Avarosa')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sengoku Gaming') AND alternate_name IN ('QT DIG', 'Sengoku Gaming Academy', 'Sengoku Gaming Legends')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SeolHaeOne Prince') AND alternate_name IN ('Stardust (Korean Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Seorabeol Gaming') AND alternate_name IN ('ESC Shane')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Simplicity Gaming') AND alternate_name IN ('Simplicity Gaming Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Sin Gaming') AND alternate_name IN ('Sin Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='SuperMassive Blaze') AND alternate_name IN ('SuperMassive Academy', 'SuperMassive Blaze Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='T1') AND alternate_name IN ('T1 Academy', 'T1 Academy Rookies Trainee', 'T1 Challengers', 'T1 Esports Academy', 'T1 Esports Academy Rookies', 'T1 Rookies')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='TSM') AND alternate_name IN ('TSM Academy', 'TSM Amateur', 'TSM Challengers', 'TSM Darkness')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team AURORA') AND alternate_name IN ('Team AURORA Academy', 'Team Orora')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Afro') AND alternate_name IN ('BUFF')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team BDS') AND alternate_name IN ('Team BDS Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Coast') AND alternate_name IN ('Team Coast Gold')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Heretics') AND alternate_name IN ('Los Heretics')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Imagine') AND alternate_name IN ('Magnetic', 'Odyssey Gaming', 'TSM Darkness')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Just') AND alternate_name IN ('Team Just Challenger', 'Team Just Ice')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Liquid') AND alternate_name IN ('Team Liquid Challengers', 'Team Liquid First')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Secret Whales') AND alternate_name IN ('Baby Whales', 'Saigon Secret', 'Team Secret (Vietnamese Team) Academy', 'Team Whales Academy', 'Team X (Vietnamese Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team Vitality') AND alternate_name IN ('Vitality French Bees', 'Vitality Rising Bees', 'Vitality.Bee', 'Yellow Stripes')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Team WE') AND alternate_name IN ('Mighty Eagle')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Tectonic') AND alternate_name IN ('Tainted Minds Blue', 'Tectonic Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='The Kings') AND alternate_name IN ('The Kings Academy', 'The Kings Moon')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='ThunderTalk Gaming') AND alternate_name IN ('Dominus Esports Young', 'SinoDragon Prince', 'ThunderTalk Gaming Young')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Top Esports') AND alternate_name IN ('King of Future', 'Top Esports Challenger')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Ultra Prime') AND alternate_name IN ('EStar Young', 'Ultra Prime Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Unicorns of Love.CIS') AND alternate_name IN ('Unicorns of Love Sexy Edition')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='V Gaming') AND alternate_name IN ('Adonis eSports (Vietnamese 2020 Team)')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='V3 Esports') AND alternate_name IN ('V3 Esports Academy', 'V3 New Generation')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='VVv Gaming') AND alternate_name IN ('VVv Gaming Red', 'VVv Gaming White')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Vivo Keyd Stars') AND alternate_name IN ('Vivo Keyd Stars Academy', 'Vivo Keyd Stars Ignis')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Weibo Gaming') AND alternate_name IN ('Suning-S')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='West Point Esports Philippines') AND alternate_name IN ('West Point Esports Academy')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Wings of Aurora') AND alternate_name IN ('Titan Catipay')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='XTEN Esports') AND alternate_name IN ('Exceltec E-Sports', 'XTEN Mexico')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Xenics Storm') AND alternate_name IN ('Tempest')) OR
(team_op_id=(SELECT id FROM teams_team WHERE op='Young Boss') AND alternate_name IN ('Tatoo'))));
-- Downdating teams --
UPDATE teams_team SET highest_level='Primary' WHERE op='3BL Esports';
UPDATE teams_team SET highest_level='Primary' WHERE op='5 Ronin';
UPDATE teams_team SET highest_level='Primary' WHERE op='ALTERNATE aTTaX';
UPDATE teams_team SET highest_level='Primary' WHERE op='ANT Gaming';
UPDATE teams_team SET highest_level='Primary' WHERE op='ATLAS eSports Team';
UPDATE teams_team SET highest_level='Primary' WHERE op='Aces High Esports Club';
UPDATE teams_team SET highest_level='Primary' WHERE op='Against All authority';
UPDATE teams_team SET highest_level='Primary' WHERE op='Albus NoX Luna';
UPDATE teams_team SET highest_level='Primary' WHERE op='Alienware Arena';
UPDATE teams_team SET highest_level='Primary' WHERE op='Alienware TOP';
UPDATE teams_team SET highest_level='Primary' WHERE op='All Gamers';
UPDATE teams_team SET highest_level='Primary' WHERE op='Armoured Brothers';
UPDATE teams_team SET highest_level='Primary' WHERE op='Asura (Korean Team)';
UPDATE teams_team SET highest_level='Primary' WHERE op='Axis Empire';
UPDATE teams_team SET highest_level='Primary' WHERE op='Bencheados';
UPDATE teams_team SET highest_level='Primary' WHERE op='Big Plays Incorporated';
UPDATE teams_team SET highest_level='Primary' WHERE op='Burning Core Toyama';
UPDATE teams_team SET highest_level='Primary' WHERE op='CILEKLER';
UPDATE teams_team SET highest_level='Primary' WHERE op='COGnitive Gaming';
UPDATE teams_team SET highest_level='Primary' WHERE op='CTU Pathos';
UPDATE teams_team SET highest_level='Primary' WHERE op='Coscu Army';
UPDATE teams_team SET highest_level='Primary' WHERE op='DS Gaming';
UPDATE teams_team SET highest_level='Primary' WHERE op='Dark Horse';
UPDATE teams_team SET came_from=NULL WHERE op='DeToNator (Southeast Asian Team)';
UPDATE teams_team SET highest_level='Primary' WHERE op='Deep Cross Gaming';
UPDATE teams_team SET highest_level='Primary' WHERE op='Dexterity Team';
UPDATE teams_team SET highest_level='Primary' WHERE op='Different Dimension';
UPDATE teams_team SET highest_level='Primary' WHERE op='Dragons Esports';
UPDATE teams_team SET highest_level='Primary' WHERE op='E-Champ Gaming';
UPDATE teams_team SET highest_level='Primary' WHERE op='E9Sports';
UPDATE teams_team SET highest_level='Primary' WHERE op='Eclipse Gaming (Latin American Team)';
UPDATE teams_team SET highest_level='Primary' WHERE op='FC Schalke 04 Esports';
UPDATE teams_team SET highest_level='Primary' WHERE op='Feint Gaming';
UPDATE teams_team SET highest_level='Primary' WHERE op='Fox Gaming';
UPDATE teams_team SET highest_level='Primary' WHERE op='Frank Esports';
UPDATE teams_team SET highest_level='Primary' WHERE op='FrostFire (North American Team)';
UPDATE teams_team SET highest_level='Primary' WHERE op='Galakticos';
UPDATE teams_team SET highest_level='Primary' WHERE op='Gama Dream';
UPDATE teams_team SET highest_level='Primary' WHERE op='Geekay Esports';
UPDATE teams_team SET highest_level='Primary' WHERE op='Ground Zero Gaming';
UPDATE teams_team SET highest_level='Primary' WHERE op='HELL PIGS';
UPDATE teams_team SET highest_level='Primary' WHERE op='Hafnet eSports';
UPDATE teams_team SET highest_level='Primary' WHERE op='Hungkuang Falcon';
UPDATE teams_team SET highest_level='Primary' WHERE op='Istanbul Wildcats';
UPDATE teams_team SET highest_level='Primary' WHERE op='Karont3 e-Sports Club';
UPDATE teams_team SET highest_level='Primary' WHERE op='Kiedys Mialem Team';
UPDATE teams_team SET highest_level='Primary' WHERE op='LinGan e-Sports';
UPDATE teams_team SET highest_level='Primary' WHERE op='Los Grandes';
UPDATE teams_team SET highest_level='Primary' WHERE op='Mad Kings';
UPDATE teams_team SET highest_level='Primary' WHERE op='MiaoJing';
UPDATE teams_team SET highest_level='Primary' WHERE op='Millenium';
UPDATE teams_team SET highest_level='Primary' WHERE op='Moss Seven Club';
UPDATE teams_team SET highest_level='Primary' WHERE op='NumberOne Esports';
UPDATE teams_team SET highest_level='Primary' WHERE op='Olympus Gaming';
UPDATE teams_team SET highest_level='Primary' WHERE op='One More Esports';
UPDATE teams_team SET highest_level='Primary' WHERE op='Operation Kino e-Sports';
UPDATE teams_team SET highest_level='Primary' WHERE op='OverMinds';
UPDATE teams_team SET highest_level='Primary' WHERE op='Oyun Hizmetleri';
UPDATE teams_team SET highest_level='Primary' WHERE op='P3P eSports';
UPDATE teams_team SET becomes=NULL, came_from='Talon Esports' WHERE op='PSG Talon';
UPDATE teams_team SET highest_level='Primary' WHERE op='People''s Red Wolf Gaming';
UPDATE teams_team SET highest_level='Primary' WHERE op='RA''AD';
UPDATE teams_team SET highest_level='Primary' WHERE op='Rebirth eSports';
UPDATE teams_team SET highest_level='Primary' WHERE op='Saint Gaming';
UPDATE teams_team SET highest_level='Primary' WHERE op='Seven Wars e-Sports';
UPDATE teams_team SET highest_level='Primary' WHERE op='Shadow Cream';
UPDATE teams_team SET highest_level='Primary' WHERE op='ShowTime';
UPDATE teams_team SET highest_level='Primary' WHERE op='Shu Dai Xiong Gaming';
UPDATE teams_team SET highest_level='Primary' WHERE op='Simplicity Gaming';
UPDATE teams_team SET highest_level='Primary' WHERE op='Team Cappadocia';
UPDATE teams_team SET highest_level='Primary' WHERE op='Team Genesis';
UPDATE teams_team SET highest_level='Primary' WHERE op='Team Occupy';
UPDATE teams_team SET highest_level='Primary' WHERE op='Team Pinnacle';
UPDATE teams_team SET highest_level='Primary' WHERE op='ThunderBot SPARTA';
UPDATE teams_team SET highest_level='Primary' WHERE op='Tricked Esport';
UPDATE teams_team SET highest_level='Primary' WHERE op='Twareg Esports';
UPDATE teams_team SET highest_level='Primary' WHERE op='TyLoo';
UPDATE teams_team SET highest_level='Primary' WHERE op='Uppercut esports';
UPDATE teams_team SET highest_level='Primary' WHERE op='Victorious Ace';
UPDATE teams_team SET highest_level='Primary' WHERE op='West Point Esports Philippines';
UPDATE teams_team SET highest_level='Primary' WHERE op='Xenics Blast';
UPDATE teams_team SET highest_level='Primary' WHERE op='ZONE eSports';
UPDATE teams_team SET highest_level='Primary' WHERE op='Zenith Esports';
-- Removing new teams --
DELETE FROM teams_team WHERE op in (
'00 Nation',
'1. Berliner Esport-Club e.V.',
'19esports',
'24 7 Tower Dive',
'2Kill Gaming',
'300 (North American Team)',
'34united e-Sports Club',
'3D Revolution',
'3v Team',
'404 Multigaming e.V.',
'42 Gaming',
'4Elements Esports',
'4everzenzyg',
'7REX',
'9z Team',
'A One Man Army Prime',
'ACE 1',
'ACTINA PACT',
'AGD E-Sports',
'AM All-Stars',
'ANON (North American Team)',
'ANc Legends',
'ANc Outplayed',
'AOC Gaming',
'APOLLO GAMING Academy',
'AS Trenčín esports',
'ASP Esports',
'ATR esports Denmark',
'AVANGAR',
'AVE Axolotl',
'AVEZ Esport',
'AYM Esports',
'AZIO eSports',
'AaB Esport',
'Abandoned Kittens',
'Able Esports',
'Absolved',
'Abyssal Esport Club',
'AceS GaminG',
'Actions Per Minute',
'Actions Per Minute Academy',
'Activit-E',
'Adive',
'Adriatic Wolves',
'Adverse',
'Aegis (French Team)',
'Aegis Flames e-Sports',
'Aethernum eSports',
'Aethra Esports Strijders',
'AffNity',
'Afterglow Esports',
'Aftershock Esports',
'Aguilas Doradas',
'Akademia',
'Akademia Hatiego 2',
'Akroma',
'Akuma Esports',
'Akuma Scythes',
'Alice Queen',
'AlienTech eSports',
'AliorBank Team',
'All Combo',
'All for One Gaming',
'Alpha Sydney',
'Alpha7 Esports',
'Also Known As',
'Altay Espor',
'Always With Honor (Turkish Team)',
'Ambys Team',
'Ancestors eSports',
'Andromeda Gaming',
'Angry Bats',
'Anima',
'Ankora Gaming',
'Anorthosis Famagusta Esports',
'Anorthosis Famagusta Esports Revolution',
'Another Troll Team',
'Antares Esports',
'Anzu Esports Club',
'Anáhuac Esports',
'Apex Mission Impossible',
'Apocalypse e-Sports',
'Aporia',
'Aqualix Esports.NA',
'Aquatik Esports',
'Aquinas College',
'Arctic Gaming Mexico',
'Arctic Kings',
'Area of Effect Dream',
'Area of Effect Soupy Time',
'Ares Gaming',
'Aris Esports',
'Arizona State University',
'Arsenal',
'Ascendance (Turkish Team)',
'Association de Gaming et d''Esport de Mons',
'Aston eSports',
'Astral Authority',
'Asura eSports',
'Atheris Esports',
'Athletico Esports',
'Atlando Esports',
'Atlas (Italian Team)',
'Atleta Esport',
'Atletec',
'Atomic México',
'Aurelius Esports',
'Aurora (Belgian Team)',
'Australs',
'Austrian Force willhaben',
'Auxesis Esports',
'Auxesis Green',
'Auxesis Red',
'AvaTrade PixelPenny',
'Avia Deceptor',
'Aware Gaming',
'Away from Normal',
'Awesome',
'BBL Dark Passage',
'BCN Squad',
'BEAGLE BROTHERS',
'BENZO esport',
'BERZLOY',
'BISONS ECLUB',
'BK ROG Esports',
'BLACKLIST',
'BOOBA',
'BPZ',
'BRUTE',
'BWE Esports',
'Baam Esports',
'Babos Gaming',
'Baby Buffaloes',
'Baby Paradise',
'Back2TheGame',
'Ball State University',
'Bandits Gaming',
'Barcelona BG',
'Barcząca Esports',
'Barrage.NA',
'Barça eSports',
'Bastille Legacy',
'Bastu Five',
'Bawk Bawk',
'Bay State College',
'BeFive',
'BeGenius ESC',
'Beast Esports',
'Beetle Juice',
'Belfast Storm',
'Benefactor''s Revenge',
'Benelux United',
'Berlin International Gaming',
'Bethany Lutheran College',
'Beşiktaş.Oyun Hizmetleri',
'Bifrost White',
'Big Dog',
'Big Dragon57',
'Big Duck Energy',
'Big One Gaming',
'Black Eagles',
'Black Lion',
'Black Panthers eSports',
'Black Rock Esports',
'Blade Edge',
'BloodRain-Gaming',
'Bloodline Esports',
'Blue Esports',
'Blue Otter',
'BlueWhites',
'Boavista FC',
'Boca Juniors Gaming',
'Bodin E-Sports',
'Bogged',
'Boise State University',
'BoostGate Esports',
'Bootz Gaming',
'Boutgamers sexy edition',
'Braves Rising',
'Briar Cliff University',
'Bring It On',
'Broke',
'Brussels Guardians Academy',
'Buff Katarina',
'Bulldog Esports',
'Burger Flippers (Female Team)',
'Bushido Wildcats',
'BuzzKill',
'CASLA Esports',
'CB Gaming',
'CBS Esports',
'CC Club',
'CCG Esports',
'CCG Glorp',
'CGN Esports',
'CITA Kaizen',
'CLN Vipers',
'CONQUEROR Gaming',
'CORE 128',
'COS City Hawk',
'CPLAY',
'CST Team',
'Calamity Esports',
'Caldya Esport',
'Campbellsville University',
'Campus Party Sparks',
'Cannot be asked',
'Carleton University',
'Carolina Reapers',
'Carthage Legionnaires',
'Case Esports',
'Castle Berry',
'Cattleya Gaming',
'Celestial Gaming',
'Cerberus e-Sports Club',
'Ceuta Guardians',
'Challenger Cookie Monsters',
'Chaotic Blaze',
'Chaotic Fusion',
'Chaotic Solar',
'Charlotte Phoenix',
'Chasing Haze 07',
'Chester Gaming Kitten Esports Club',
'Chi Army',
'Chienhsin Bear',
'Chilli Esport',
'Chilling Cats',
'Chilly Mountain Wolves',
'Chivas Esports',
'Chong Qing Gaming',
'Chungnam Juego Esports',
'Cidade Curiosa Esports',
'Cienciano Esports',
'Citadel Gaming',
'Cleary University',
'Clown Gaming',
'Club Deportivo Municipal',
'Cold Hearted',
'Coliseo Dragons',
'Colorado State University',
'Colossal Gaming',
'Columbia College',
'Comanchero Gaming',
'Comeback Kid',
'Connect Arena Esports',
'Connecting Esports',
'Contingent Esports',
'Converse University',
'Convict of Shadows',
'Conviction',
'Coopa Troopas',
'Copenhagen Flames',
'Corax Gaming',
'Core Dynamic',
'Corinthians Esports',
'Cosa Gamers',
'Cosmic Vipers',
'Cosmic Wolf Esports',
'Could Be Better',
'Coven',
'CowBoySquad Imperials Esports',
'Cowana Gaming',
'Cream Real Betis.EU',
'Crimson Gaming',
'Crusaders',
'Cruzados Esports',
'Crvena zvezda Esports',
'Crypto Esports.CIS',
'Cryptova',
'Crystal Cave Gaming Emerald',
'Cupid Esports',
'Curralzinho Esports',
'Cyber Gaming Academy',
'Cyber Wolves',
'Cyborg Factory',
'Cyclone',
'Czas na zasady',
'Córdoba Patrimonio eSports',
'D7G Esports Club',
'DELTALAND',
'DIVIZON',
'DJ Team',
'DK Crew',
'DKB XPERION NXT',
'DKB XPERION NXT RAW',
'DMG Esports',
'DOCISK',
'DOCISK Hussars',
'DP5 Makios',
'DREN Esports',
'DSC3V',
'DSYRE',
'DUCKIE GETTERS',
'Da Dancing Demons',
'Dango',
'Dango SB',
'Dare Gaming',
'Dark Allegiance',
'Dark Crows',
'Dark Quality',
'Dark Tigers',
'Dark Zone',
'DarkSpawn Gaming',
'DarkZero Dragonsteel',
'Dawn Esports',
'Dawn Esports Quake',
'Dawn of Stars',
'DayDreamers',
'Dead Rabbits Club',
'Dejice',
'Delirious Hellhounds',
'Deliverance Esports Peru',
'Delta Five',
'Delta Syndicate',
'Demise',
'Demise Academy',
'DengKaiLi Game Team',
'Denial eSports.East',
'Depor Cali Legends',
'Destined For Glory',
'Devils.one Academy',
'Diablo Chairs',
'Diabolus Esports',
'Diamant Esports',
'Diamond Doves',
'Digital Paradox',
'Dimegio Club',
'Dinka Never Homeless Again',
'Direct Rising eSports',
'Divernex',
'Diversion Gaming',
'Domino Computer',
'Domme Jongens',
'Dont Ban Gragas',
'Dopamina E-Sport',
'Dorado Gaming',
'Douyin Tony Top',
'Doxa Gaming',
'Dragons E.C.',
'Dragoon''s Goons',
'Dramatik Gaming',
'Dream Catcher',
'Dream Catcher Gaming',
'Dream Makers',
'Dream Team',
'Dropz Esports',
'Drury University',
'Duma Easta',
'Dung Dynasty',
'Dusty',
'Dutch Community Team',
'Dylema Gaming',
'Dynamic Elements Aether',
'Dynamo Eclot Talents',
'Dynamo Esports',
'Dynasty',
'E WIE EINFACH E-SPORTS',
'E-corp Gaming',
'E-nsane Gaming',
'EAS Team ESCA Gaming',
'EBRO',
'ECORP',
'EEriness',
'EFIVE Esports',
'EFS',
'EGN Esports',
'EGekko',
'EKO Esports',
'EKoVy',
'ELR Gaming',
'ELaB x EXP',
'EMonkeyz',
'ENCE',
'ENEMI3S',
'ENsure',
'EPIC-DUDES',
'EQuizers',
'ERKO Esports',
'ESC Gaming (Italian Team)',
'ESTORM',
'ESUG Ultimate Five Feeder',
'ESport Rhein-Neckar',
'ESports Cologne e.V.',
'ESports Nord e.V.',
'ESuba',
'EURONICS Gaming',
'EWolves Ignis',
'EXILE esports',
'EXtatus',
'EYES ON U Europe',
'Eanix',
'Earth Revolution Gaming',
'Eesti Rästikud',
'Ego Geniuses',
'Eintracht Frankfurt',
'Eintracht Spandau',
'El Dafayat Esports',
'Element Mystic',
'Elementalist',
'Elementaries Esport Club',
'Elysium Gaming',
'Ember',
'Ember Foxes',
'Emerald Prisoners',
'Emissary Esports',
'Emperor Gaming',
'Emprox',
'Empyreans',
'Enclave',
'Enix Esports',
'Entropiq',
'Epic Avalanche',
'Epsilon Esports',
'Erfolg Esports',
'Espectro Esports',
'Espergærde eSport',
'Esport Academy',
'Esport Empire',
'Esport STUBA',
'Esports Academy',
'Esprit Shōnen',
'Estoril Praia eSports',
'Estrogen Gap',
'Estúdio XP e-Sports',
'Et cetera',
'Eterna',
'Eternal Fire',
'Eternals Gaming',
'Ethereal Enigmas',
'Ethernum Esports',
'Europe Saviors Club',
'Ever8 Winners',
'Evil genius (RTV Team)',
'Evolve',
'Ex Nihilo',
'Excess Success',
'Exeed Poland',
'Exiled Bears',
'Exilium Gaming',
'Exilium Hunters',
'Eyeshield Gaming',
'F-Soul Esports',
'FALKN',
'FC Nantes Esports',
'FH eSports',
'FLY5',
'FM eSports',
'FN Esports',
'FPT Hanoi',
'FROM ZERO TO HERO',
'FS Gaming',
'FUT Esports',
'Fact Revolution',
'Faerie Charm (Singaporean Team)',
'Falcon E-Sports',
'Falcons (Spanish Team)',
'Falke Esports',
'Falkol',
'Fallen Gods',
'False Facade Gaming',
'Fantastic Esports',
'Fantasy Gaming',
'Far East Eagle',
'Farenvehn',
'Fatal Ambition',
'Fatcat''s Fatties',
'Fear x Starforge',
'Femmes Fatales',
'Fenris eSports Academy Blue',
'Fervent Esports',
'Fiction eSports',
'Final Form',
'First Blood Crusade',
'Fisher College',
'Five Kings',
'Flama Esports',
'FlameHard',
'Flamengo MDL',
'Flayn eSports',
'Florida Southern College',
'Florida State University',
'Fluffy Tail',
'Fly Family',
'Fløng Esports Elite',
'Fog Esports',
'Fonored Hyperion',
'Footprint Gaming',
'For The Win Esports',
'Forger Esports',
'Formulation Gaming',
'Forsaken (Polish Team)',
'Fourth Wall',
'Fox B',
'FoxFire (Turkish Team)',
'Fractious eSports',
'Frank Fang Gaming',
'Fraternitas',
'FreePi',
'Freshsterious',
'Froggy Five',
'FroztFire Team',
'Fruition Esports',
'Fuego',
'Fugitive Gaming',
'Full Sense',
'Full Spectrum',
'Fullclear Esports',
'Furious Five',
'Future Perfect',
'Future Perfect Blue',
'Fylkir Esports',
'G-Pride',
'GG Call Nash',
'GGEsports',
'GLORE',
'GMBLERS Esports',
'GOAL',
'GOEXANIMO',
'GRP Esports',
'GTZ Esports',
'Gaia Esports',
'Galaxy Gaming (American Team)',
'Galaxy Racer Esports MENA Male',
'Galions',
'Game Coach Academy',
'GameWard',
'Gamefy',
'GamerLegion',
'Gamers404',
'Gamespace Mediterranean College Esports',
'Gaming Barcelona',
'Gaming Team Kravaře',
'Garden Gaming',
'GeekCase eSports',
'GeekSide Esports',
'GenZ Gaming (2025 Vietnamese Team)',
'Genbu Gaming',
'Genetic Esport',
'Genetics Gap',
'Gentle Hearts Gaming',
'Gentle Mates',
'Gentlemen''s Gaming',
'Gentside',
'George Mason University',
'Giants (Spanish Team)',
'Gifted Gaming',
'Glacial Esports',
'Glaive Esports Prime',
'Gmae',
'GnG Amazigh',
'GnG Esports',
'Goat Esports',
'God''s Plan',
'Godsent',
'Golden Grubians',
'Golden Lions',
'Good Game Esport',
'Goose Gaming',
'Goskilla',
'Grand View University',
'Granit Gaming',
'Gravity (2024 North American Team)',
'Gravity Elite',
'Greek Gorillaz',
'Greek Regenesis',
'Green Dolphin Gaming',
'Grim Ravens',
'Grompcord',
'Grow uP eSports',
'Guangdong Flying Tigers',
'Guarp Gaming',
'Guasones',
'Guerreiras Brownie Vortex',
'Guinea Pink',
'Gunrunners',
'H34T Young Flames',
'HANAGUMI KAREN',
'HG Esports',
'HOU GAMING',
'HUTECH CHICKEN',
'HVFC Bakeca Academy',
'Hallow Crows',
'Hannibal Knights',
'HarmoniX Gaming',
'Harrisburg University',
'Havan Liberty Gaming',
'Havoc (Danish Team)',
'Havoc Gaming',
'Herbalife Real Betis',
'Here For T-Shirt',
'Heroes of the Universe E-Sports Brazil',
'Hertha BSC eSport',
'Hex Alligators',
'Hexagone Esports',
'High Tempo Esports (North American Team)',
'Hillerød eSport',
'Hive Athens EC',
'Hokuto Esports',
'Holy Knights',
'Homyno Pulsia Esport',
'HongKongNine',
'Hooked Esports',
'Howl Esports',
'Howling eSports',
'Htp eSport Akademie Hannover',
'Humanoids5',
'Hurricane of Feathers',
'HuyaTV',
'Hybrid Esports',
'Hydras Esport',
'Hyper (Korean Team)',
'Hyper Kings',
'Hyper Vortex Esports',
'Hyve Central',
'IDM Pirata',
'IDomina eSports',
'IKISEQ Gaming',
'IME Wolves',
'IMPERISHABLE CLAN',
'IMProve Team',
'IN Gaming',
'INvolute',
'ITS DOOMED',
'Ichor Gaming',
'Ici Japon Corp. Esport',
'Icon Esports (Mexican Team)',
'Ilha das Lendas',
'Illinois State University',
'Illinois Wesleyan University',
'Illuminar Gaming',
'ImPerium Vancuverii',
'Imaginary Gaming',
'Imperials',
'Imperio eSports',
'InFamouS Esport',
'InFerno eSports',
'Inaequalis',
'Indictive Esports',
'Infernal Void',
'Inferno Esports (Filipino Team)',
'Infinity Esports (2015 North American Team)',
'Infusion',
'Inside Games',
'Inspire eSports',
'Instinct Gaming',
'Intel New Indians',
'Interesting Five',
'Intergalaxy Tigers Gaming',
'International Esports Industry Center',
'Interstellar Yappers',
'Intrepid Fox Gaming',
'Intuition',
'Inventive Esports',
'Invulnerables Esports',
'Ion Squad',
'Ionikos Nikaias Esports',
'Iron Wolves',
'Issue is Critical',
'Izanagi eSports',
'IziDream',
'Jake''s Kittens',
'Janus Panter',
'JingNetGame',
'Jlingz Esports',
'Joblife',
'Join The Force',
'Jolly Rogers',
'Joseph Hong',
'Juicy Ballers',
'Just Randoms',
'Justforfun',
'Jörmungang',
'K Special Forces',
'K1CK',
'K9',
'KAOS e-sport',
'KATANA (Turkish Team)',
'KIT SC SmartWe',
'KIT SC White',
'KIYF eSports Club',
'KODE Gaming',
'KOVA Esports',
'KR Reykjavík Esports',
'KRC Genk Esports',
'KRC Genk Esports Talent Team',
'KRÜ Esports',
'KV Mechelen Esports',
'KaBuM! IDM Gaming',
'Kaisa Gaming',
'Kaizen Esports',
'Kanji Esports',
'Kanji Esports Feuer',
'Kanji Esports Wasser',
'KappaChungus',
'Kapsoura',
'Karma Clan Esports',
'Karolinerna',
'Katastrofa Awionetki',
'Kaufland Hangry Knights',
'Kawaii Kiwis',
'Keep Gaming',
'Kelyx''s Grandpa Gamers',
'Kenty',
'KeyMedia',
'Keyd Warriors',
'Keypulse Esports',
'Khore Gaming',
'Kiedyś Miałem Fun',
'Killabeez',
'Kim Esports',
'King of Goats',
'Kings of Uganda',
'Kings of the North',
'Klanik Esport',
'KlikTech',
'KmK eSports',
'Kokoro No Senshi',
'Komil and Friends',
'Komodo (North American Team)',
'Komputronik H34T',
'Korean Streamer',
'Kubyd''s Syndrome',
'Kun Shan Lightning Tiger',
'Könige der Meere',
'LCVS Fighting',
'LDLC OL',
'LDM Esports',
'LDN UTD',
'LHS Gaming',
'LIT Team',
'LK Gaming',
'LODIS (Polish Team)',
'LOTUS (Brazilian Team)',
'LUA Gaming',
'LUL Esports',
'Labradoodle 9',
'LanXiang Gaming',
'Lanomania',
'LaoPengYou',
'Laranja Mecânica',
'Large (North American Team)',
'Las Divinas',
'Last Group',
'Last Minute Airlines',
'Last Resistance',
'Laughing Coffins',
'Lausanne-Sport Esports',
'Lazy In Life',
'Lechuga Gaming',
'Legion Gaming (European Team)',
'Legion Gaming (Oceanic Team)',
'Lenovo Legion Honvéd',
'Levante UD Esports',
'Level One',
'Level Up esports',
'Leviathans',
'Leões Porto Salvo Esports',
'LiT Esports',
'Liberty Zeal Queue',
'Life Support',
'Lille Esport',
'LionsCreed Baltics',
'Lionscreed',
'Lionscreed Lionesses',
'LittleSans',
'Lobstar',
'Login Esports',
'London Esports',
'Looking for ORG (Turkish Team)',
'Los Ratones',
'Loto Gaming',
'Lotus (North American Team)',
'Lotus Bloom',
'Lotus Knights',
'Louisiana State University',
'Low Pressur3 Gaming',
'Low Priority',
'LowLandLions',
'Lublin Shore',
'Lucent Esports',
'Luminosity Gaming',
'Luminox Planet',
'Lundqvist Lightside',
'Lupus Esports',
'Luxor Gaming',
'Lycos eSports',
'Lynch Esports',
'Lynx (Oceanic Team)',
'L’art de la Guerre',
'MAD Gaming',
'MCon esports',
'MCon esports Academy',
'MD E-sports Club',
'MHSC Esport',
'MIBR',
'MINDCAT Esports',
'MIRAI (Brazilian Team)',
'MJ-Esports',
'MNM Gaming',
'MOBA ROG',
'MOUZ NXT',
'MTP Esport',
'MTW Gaming',
'MTW St. Pauli',
'MY STAR',
'MYIDOL Esports',
'MYP ECLUB',
'MYinsanity',
'Macao Esports',
'Macko Academy',
'Macro Maniacs',
'Mad Dragon',
'Mad Revolution Gaming',
'Maelstrom Esports',
'Maelstrom Gaming',
'Maestro V Esports',
'Magaza Esports',
'Magna Esports',
'Majestic Lions',
'Malvinas Gaming',
'Manguste eSports',
'Maroon Bells',
'Masonic',
'Master of Chicken Gaming',
'Maturalni Forsaken Academy',
'Maverix',
'Max Tigers',
'Mayan Esports',
'Maycam Evolve',
'Maze (Brazilian Team)',
'Maze Gaming',
'Medieval Riga',
'Melilla Titans',
'Melty eSport Club',
'Meme City Esports',
'Meow Gaming Club',
'Mercenaries',
'Merciless Gaming Academy',
'Meta Gaming',
'Method2Madness',
'Mezexis Esports',
'Mgutis'' Saplings',
'Miami University',
'Michigan State University',
'Mila Gaming',
'Milk Esports Whole Milk',
'Mind Blue eSports',
'Minus Three',
'Miracle (North American Team)',
'Mirage Alliance',
'Mirage Alliance Baguette',
'Mirage Elyandra',
'Mirage Élite',
'Misa Esports',
'Misfits (2024 North American Team)',
'Mkers Academy',
'Monkey Mafia',
'Monolith Gaming',
'Monta Club',
'Moon Wolf e-Sports',
'MorningStar Legends',
'MorningStar White',
'Mortality eSports',
'Motion',
'Mount Olympus',
'Movistar Optix',
'Munster Rugby Gaming',
'Murk Esports',
'MyRevenge Chile',
'Myth Esports',
'Mythos Gaming',
'Mübeccel Espor',
'Münster Esports',
'NASR eSports',
'NAT',
'NDurance Gaming',
'NEophyte',
'NGU eSports',
'NK Osijek Esport',
'NLD eSports',
'NOCTA',
'NONAME (Turkish Team)',
'NORD Esports',
'NOVO Esports',
'NOX Esports',
'NRAX Esports',
'NVision Esports',
'NXT',
'NYYRIKKI',
'Naguara Team',
'Nakrob Mangkorn',
'Nash Ξquilibrium',
'Nate.A',
'Native Gaming',
'Nativz',
'NeXtPlease! Gaming',
'Near Airport',
'NecroRaisers',
'Neon Esports',
'NerdRage',
'Nerf Galeforce',
'Nerv',
'Neurons',
'Never Give Up (Vietnamese Team)',
'New Era',
'NewAges E-Sports',
'Newell''s Esports',
'Newstar',
'Next Level Esports',
'Nexus KTRL',
'Nexus Reapers',
'Nibble Gaming',
'Nightbirds',
'Nightblood Gaming',
'No Ace',
'No Name (North American Team)',
'No Need Orga',
'No Org',
'No Team',
'NoFancy',
'Noble Esports',
'Nocturnals',
'Nocturne Gale',
'Nocturns Gaming',
'Noot Noot eSports',
'North Carolina State University',
'Northeastern University',
'Northern Lions Esports',
'Northwood University',
'Not Academy Team',
'Nova eSports (North American Team)',
'Novasphere Gaming',
'Now or Never',
'Nuke Hunters',
'Nuovo Gaming',
'ODD Esports',
'ODIN Gaming',
'OFFSET Esports',
'OG Esports',
'OGC Esports',
'OKGG White',
'ONE SEVEN EIGHT',
'OP Gaming',
'OP Team',
'OQ (North American Team)',
'ORIGINwp',
'OZ Gaming',
'Oakland University',
'Odivelas Sports Club',
'OffLimits',
'Ohio Northern University',
'Ohio State University',
'Oklahoma Christian University',
'Old Hunters',
'Omerix Esport',
'Once Caldas Esports',
'Once Upon A Team',
'One Piece eSports',
'Only Heroes Academia',
'OnlyGame',
'Onoda Esports',
'Onyx Ravens',
'Optical spectrum E-sport',
'Optimization Gaming',
'Optimum Cowboys',
'Option 33',
'Orbit Anonymo Esports',
'Ordo Equitum',
'Orgless',
'Orion Esport',
'Osaka',
'Oserv Esport',
'Ottawa University',
'Otter Side',
'OuYi Game Team',
'Our Last Dance',
'Outlawz',
'Over Power Gaming Center',
'OverGaming',
'Ownerd e-Sports',
'Oxygen Gaming',
'Oxygen Valiants',
'P11 Esports',
'PAGLE48',
'PANTHERS Gaming',
'PCHunter',
'PCIFIC Espor',
'PDK Sideral',
'PDW',
'PENTA 1860',
'PIGSPORTS',
'PIRTS',
'PRIDE (Polish Team)',
'PRIDE ESCA Academy',
'PRIMATE',
'PRINCIPALITY',
'PRO42',
'PSG Talon Academy',
'PSV Esports',
'Packa Pappas Kappsäck',
'Packmiko E-Sports',
'PainGaming',
'Palisade Esports',
'Pampas',
'Panathinaikos AC eSports',
'PandaCute',
'Pandy Pandas',
'Parakeet Gaming',
'Paris Saint-Germain eSports',
'Park University',
'Partizan Esports',
'Partizan Sangal',
'Pathos',
'Pawn Gaming (Spanish Team)',
'Peach Cats',
'Peak Performance X',
'Peak Performers (North American Team)',
'Pee N W''s',
'Pegasus Esports',
'Pentagon Rejects',
'PepeTinkyWinky',
'Pertinax Esports',
'Phlox Gaming',
'Phoenix 5',
'Phoenix Esports (Turkish Team)',
'Pick Me Galio',
'Ping is the Problem',
'Pirates IDV',
'Piratesports',
'Play With Soul',
'Playing Ducks',
'Plejehjemmet Kalder',
'Polar Ace',
'Polar Bears',
'Polar Squad Esports',
'Polaris Gaming',
'Pookie Bears',
'PostFinance Helix',
'Power Team Sports',
'Powned.it',
'Prime Academy',
'Prinfor Esports Club',
'Priority',
'Pro Probably',
'ProXima Gaming',
'Project Conquerors',
'Project Sinners',
'Prosperity Esports',
'Psykodelic Esports',
'Public Enemy',
'Pulse Star',
'Purdue University',
'Purdue University Northwest',
'Pushing Gaming',
'Pyrsos Esports',
'QLASH Egypt',
'QUT Tigers',
'QWER.GG',
'Qing Niao Yu Xing Game Team',
'Qmistry',
'Quantum Vortex',
'Quvic E-Sports',
'R-SIXTEAM',
'R3volt',
'RAGE',
'RAMS',
'RATE Gaming',
'RATZ',
'RAWR ShadowZ Fan Club',
'RBG Esports',
'RCSC E-sport',
'REDPack Esports',
'REJECT',
'REViTAL BLACKTRAiNS',
'RIFT Esports',
'RMD Gaming',
'RMIT Redbacks',
'ROG Esport',
'ROUNDS',
'RPG-KINGDOM',
'RQS Esports',
'RSC Anderlecht Esports',
'RUDE GAME',
'Racoon (Italian Team)',
'Radiance',
'Raizen Kicks',
'Raleigh Black Flame',
'Ramboot Club',
'Ramo Awake Gaming',
'Random 5',
'Ravioli Ravioli',
'ReDefy Esports',
'Reapers Gaming (Italian Organisation)',
'Reborn Esport',
'Red Bulls',
'Red Eye Esports',
'Red Rooster Team',
'Redemption (North American Team)',
'Redemption Arc',
'Reformed Gaming',
'Regnum4games',
'Reign (European Team)',
'Reload Gaming',
'Reload eSports',
'ReluminateGG',
'Repre Gold',
'Resolve Blue',
'Respawn Esports',
'Respawned Esports',
'Retric eSports',
'Return of the Middlesticks',
'Reveal Multigaming',
'Reven Esports',
'RevenGa Esports',
'Revenge (British Team)',
'Revenger (Chinese Team)',
'Revival (North American Team)',
'Rex Regalis',
'Rich Gang (Norwegian Team)',
'Riddle NO',
'Rift Rats',
'Rigas In Paris',
'Riptide',
'Rise Gaming',
'Risen Esports',
'Rising Dawn Esports',
'River Plate Gaming',
'Roar (Chinese Team)',
'Robot E-Sports Team',
'Rock Bottom Esports',
'RockTribeEsports',
'Romulea eSport',
'Royal Gamers',
'Ruddy Esports',
'Rulers Esports',
'RunAway',
'RusherX Gaming',
'Ruzeh Esports',
'S2N Esports Club',
'S2V Esports',
'S8UL Esports',
'SAIM SE',
'SAIM SE SuppUp',
'SAMCLAN Esports Club',
'SAW (Portuguese Team)',
'SDM Tigres',
'SGA (Korean Team)',
'SHEINOO',
'SILENTGAMING',
'SINNERS Esports',
'SINS Esports',
'SLO REJECTS',
'SLR',
'SLTitans Esports',
'SN CyberCore Esports',
'SNOOZE Esports',
'SOVEJA',
'SPGeSports',
'SPIKE Syndicate',
'SQUARE (Korean Team)',
'STAR (Russian Team)',
'STOPWATCH eSports (Czech Team)',
'STRAT Esport',
'STRAW',
'STXP',
'Saigon Dino',
'Saikyo Makinyan',
'Saint Louis University',
'Samsung Morning Stars',
'San Jose State University',
'SanHe Gaming',
'Sangal Esports',
'Sansin Gavin',
'Santiago Wanderers eSports',
'Saprissa Esports',
'Savage (Latin American Team)',
'Savannah College of Art and Design',
'Saving OCE',
'Scorpio Game',
'Scouting4ProScene',
'Se Loco Cachorreira',
'SeQura ZEST',
'Sea Dogs',
'SeaDoggos',
'Seattle Ferocity',
'Sector 7',
'Sector One',
'Seed 32',
'Senshi Esports Club',
'Senshi eSports (Benelux Team)',
'Sentinels ESC',
'Seoul Neon',
'Seven Dark',
'ShaBoingBoing Esports',
'Shadow Corp',
'Shadowban',
'Sharks Esports Team',
'Sheng Jie Gaming',
'Shih Hsin Meow Meow',
'Shining Stars',
'Shock Gaming',
'Si Yi Xuan E-Sport',
'Sicar Esports',
'Sign Us Please',
'Silent Revolution Gaming',
'Silent Storm Esports',
'Silver Prisoners',
'Silver Wolves',
'Simplicity Esports',
'Single Target Healing',
'Skillcamp',
'Skull Cracker',
'Slaughter House',
'Sleepy Callers',
'SleepyGoose',
'Smoke Tram',
'Snowman Slammers',
'SolaFide Esports',
'Solary',
'Solwing Esports',
'Sons of Tzu Gaming',
'Soul''s Heart Esport',
'Sour Savoury',
'Space eSports',
'Spain5',
'Spandauer Inferno',
'Spartans EU',
'Sparx Esports',
'Spectacled Bears',
'Spicy Gorillas',
'Spinebusters E-Sport',
'Spirit Esports',
'Spirit Quartz Gaming',
'Spirituals',
'Split Raiders',
'Spongecord prime',
'Sport Boys Association',
'Sportia Khore',
'Sprout (German Team)',
'Srdce nehasnou',
'St. Clair College',
'Stade Tunisien Esports',
'Starlan Gaming Club Academy',
'State University of New York at Buffalo',
'Steak Frites',
'Stellae Gaming',
'Steve Bakes Cookies',
'Stone Movistar',
'Storm Games Clan',
'Storm Teams',
'StormMedia Fajnie Mieć Skład',
'Stormbringers',
'Straw Hat Crew',
'Striking Vipers Champions',
'Submarino Stars',
'SunSister ReUnion',
'Suns Gos Hawk',
'Super Sunshine Fruit Basket Warriors',
'SuperNitro1',
'Supernova',
'Synthetic Esports',
'Szata Maga',
'Szaty Bobra',
'Szef 6',
'T3H Esports',
'TBA (North American Team)',
'TDC Esports',
'TEAM GR1',
'TEAM ORANGE',
'TES (Hong Kong Team)',
'TFK',
'THUNDR Esports',
'TKA E-Sports',
'TNU Eagle',
'TOOOLS esports',
'TT willhaben',
'TWELVE',
'TWOTWOEIGHT',
'Taco Gaming',
'Tactical Esports',
'Tan Chi Sa Gaming',
'Tan''i eSports',
'Taurus Esports',
'Team 7AM',
'Team Amazigh',
'Team Ambition',
'Team Amelia',
'Team Animals',
'Team Anomaly Breaker',
'Team Arcade',
'Team Ascent',
'Team Atlantis',
'Team Axelent69',
'Team BDS Valkyries',
'Team Black (Dutch Team)',
'Team Brickz',
'Team Charon',
'Team Clarity',
'Team Cloud Drake (NASG Team)',
'Team Coachify',
'Team Confound',
'Team DPD',
'Team Death Knights',
'Team DeftFox',
'Team Dizzy',
'Team Du Sud',
'Team Dynasty',
'Team E Turner',
'Team ESCA Gaming',
'Team EYA X Prestige Esport',
'Team EasyFix Co-Hop',
'Team Evermeet',
'Team Falcons',
'Team Fish Taco',
'Team Flash.Singapore',
'Team Flux',
'Team Forge',
'Team Fracture',
'Team Front',
'Team Frostbite',
'Team Furca',
'Team GMask',
'Team Gates',
'Team Genji',
'Team Horizon Reapers',
'Team Infamous',
'Team Infernal Drake (NASG Team)',
'Team Insidious',
'Team KungFu',
'Team Legion (Benelux Team)',
'Team Legion (Greek Team)',
'Team MCES',
'Team Majesty',
'Team Meliora',
'Team Mentality',
'Team Moops',
'Team Mountain Drake (NASG Team)',
'Team Mythic',
'Team Nevo',
'Team Ocean Drake (NASG Team)',
'Team Overclockers UK',
'Team PHZ',
'Team Paradox',
'Team Pending',
'Team Phantasma',
'Team Pique Sel',
'Team Plague',
'Team Queso',
'Team RM',
'Team ROCK',
'Team Rapid',
'Team Refuse',
'Team Riverside',
'Team SalsaLoL',
'Team Same Mordeczki',
'Team Sampi',
'Team Singularity',
'Team THRLL Academy',
'Team Tony Top',
'Team UNiTY',
'Team Universe',
'Team Valiant',
'Team WeForge',
'Team YOLO',
'Team Zan',
'Team Zoose',
'Team xo',
'TeamOrangeGaming',
'Teamless Revenge',
'Tempered Fate',
'Tempest Gaming',
'Tempo Storm',
'The Agency',
'The Boys Attorneys at Law',
'The Cheese Chasers',
'The Dog King Neru',
'The Expendables',
'The Final Tribe',
'The Forbidden Five',
'The Gulls Esports',
'The Krusty Crew',
'The Last Dance',
'The Last Monk',
'The League of Extraordinary Monsters',
'The Longest Yard',
'The Nameless',
'The Northern Front',
'The Pack',
'The Plan',
'The RED',
'The Secret Club',
'The Spawn Esports',
'The Tower',
'Third Party',
'ThunderFlash',
'ThunderoBot Gaming',
'Tick Trick and Duck',
'Timeforce',
'Timeout Esports',
'Tindastóll',
'To The Arena',
'Tomorrow Esports',
'Tongtex Suns',
'Top Dog Gaming',
'TopHard Esports',
'ToxicFalcons eSports',
'TrainHard eSport',
'Trance''s Tyrants',
'Trinity (Thai Team)',
'Triple Esports',
'Triumphant Song Gaming',
'Tundra Gaming',
'Turing eSports',
'Twisted Minds',
'Two-eyed Monsters',
'Tồ Gaming',
'U4RIA Nerium',
'UCAM Esports',
'UCXD',
'ULF Esports',
'UQ Union',
'UTM Esports',
'UTS Esports',
'Ukrainian Glory Team',
'Umbra Collective',
'Umbra Divinus Gaming',
'Undead Gaming',
'Underworld Esports',
'Unfazed Esport',
'UniQ Esports Club',
'Universae Instituto FP',
'Universitario Esports',
'University of British Columbia',
'University of California Berkeley',
'University of California Irvine',
'University of California Riverside',
'University of California San Diego',
'University of Colorado Boulder',
'University of Health Sciences and Pharmacy in St. Louis',
'University of Illinois at Urbana-Champaign',
'University of Michigan',
'University of Minnesota Twin Cities',
'University of Mississippi',
'University of North America',
'University of Ottawa',
'University of South Florida',
'University of Southern California',
'University of St. Thomas',
'University of St. Trevor',
'University of Texas at Austin',
'University of Texas at Dallas',
'University of Toronto',
'University of Toronto Scarborough',
'University of Waterloo',
'University of Western Ontario',
'Unknowns Gamers',
'Upper Echelon',
'Upper Five Flying Kittens',
'VARREL YOUTH',
'VAULT',
'VC Gaming',
'VININE',
'VIRUS (Greek Team)',
'VIS eSports',
'VITA (Icelandic Team)',
'Val 2.0 Valkyrie',
'Valhalla Vikings',
'Valiance',
'Valkiria Esports',
'Valkiria''s Vikings',
'Valorous',
'Valyrian Dragons',
'Vancouver Impact',
'Vandals Esports',
'Vanir',
'Vanung Lion',
'Vasco E-Sports',
'Vector Gaming',
'Vegas Inferno',
'Veni Vidi Vici (Spanish Team)',
'Veni eSports',
'Venomcrest Esports',
'Ventus Esports',
'Venus (Turkish Team)',
'Venus Gaming',
'Verdant',
'Verity Esports',
'VfB eSports',
'ViV Esport',
'Victorious Demons',
'Victorious Gaming',
'VietSun Esports',
'Vigilantes',
'Vigilantes Talent',
'Viking Esports (Norwegian Team)',
'Vikingekrig Esports',
'Villarreal QLASH',
'Viperio',
'Vipers',
'Vipers Inc',
'Virginia Polytechnic Institute and State University',
'Virtual Reality Game',
'Virtuoso Gaming',
'Visual Perception',
'Void Gaming Phenomenon',
'Vortex (North American Team)',
'Vortex Five',
'Vortex Gaming (Latin American Team)',
'Vortex Team',
'Vyral',
'WANG DYNASTY',
'WANG TOWN',
'WAP Esports',
'WAVE Esports',
'WLG Female Stars',
'WLGaming Esports',
'WP Gaming',
'WR Builds Flame Horizon',
'WYDream',
'WaY (Korean Team)',
'Waia Snikt',
'Wang''s Revenge',
'Wangting',
'WannaBeWithYou',
'War Legion Esports',
'WarKidZ E-Sports',
'Wardens',
'Warthox Esport',
'Wazabi Gaming',
'We Plash Academy',
'We Talent',
'WeSports',
'Weber State University',
'Webidoo Gaming',
'WhereAreyouFrom',
'White Dragons',
'WiLD MultiGaming',
'Wichita Wolves',
'Wicked Gaming',
'Wild Jaguars',
'Wild Panthers Esports',
'Wild West Bandits',
'Wildcard Gaming',
'Wina Krzycha',
'Wind and Rain',
'Windstorm Gaming',
'Winston King of Amateur',
'Winthrop University',
'Wisła Płock eSports',
'Wizard esports',
'Wizards',
'Wolf Club Esports',
'Wonder Stag e-Sports',
'World Class Empyreans',
'Wortex Gaming',
'Wulf Pack',
'Wygers Argentina',
'Wygers Colombia',
'X25 Esports',
'X6tence',
'X7 Ascent',
'XAL Esports',
'XO Esports',
'XT Esports',
'XV eSports',
'XY Esports',
'XYZ (Korean Team)',
'Xibalbá Esports',
'Xoldiers',
'Xora Esports',
'XtremeDominators',
'Y so E-Sports',
'YDN Esports',
'Yalla Esport',
'Yang Dae Pal Korean BBQ Restaurant',
'Yang Yang Gaming',
'YeaH! Gaming',
'York University',
'YouCantStopMe',
'Young Buffalo',
'Young Buffalos',
'Youth Warriors',
'Yumisu Invicta',
'Yutoru',
'Z10 ESHARK',
'ZETA',
'ZTR Gaming',
'Zeeman',
'Zen Esports',
'Zena Esports Portugal',
'Zenigma',
'ZennIT',
'Zenshi Gaming',
'ZentaX Esports',
'Zephyr Esport',
'Zerance',
'Zerance Bloom',
'Zero Six PowerSpike',
'Zero Tenacity Spears',
'ZeroSeven Gera',
'ZeroZone Gaming',
'Zerolag Esports',
'Zeta Team',
'Zeu5 Esports',
'Zeus Kralik',
'Zodiac Esports',
'Zoltak Legion',
'Zooby''s Kittens',
'Zoos Gaming',
'Zwan Gaming Mexico',
'Zylant Esports',
'Žalgiris Esports',
'정글 격리해제'
);
COMMIT;