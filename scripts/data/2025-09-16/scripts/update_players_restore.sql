BEGIN;
-- Restore metadata --
DELETE FROM meta_dataupdate WHERE id in (SELECT id FROM meta_dataupdate WHERE app='players' ORDER BY date DESC LIMIT 1);
-- Removing all new alternate names --
DELETE FROM players_playeralternatename pa
USING players_player p,
     (VALUES
        ('Bejjaniii','Yayo'),
('Boukada','Boukada'),
('Cruise','Cruise'),
('Curty','Curty'),
('DARKWINGS','DARKWINGS'),
('DOOM','DOOM'),
('Dioge (Diogenes Barbosa)','Dioge (Diogenes Barbosa)'),
('Fready','Fready'),
('Gakgos','Gakgos'),
('Gryffinn','Gryffinn'),
('Infi','Infi'),
('It Yummy','It Yummy'),
('Kat Bot','Katarina Bot'),
('Keduii','Keduii'),
('Lotus (Mihir Ranjan)','Lotus (Mihir Ranjan)'),
('Mago','Mago'),
('Nackbkk','Nackbkk'),
('Nervarien','Hrabia Nervarien'),
('Neulguri','Neulnnyr'),
('NicoThePico','NicoThePico'),
('Parukia','Parukia'),
('Pillow (Nutthanon Bumrungchawkasem)','Pillow (Nutthanon Bumrungchawkasem)'),
('Rabelo','Rabelo'),
('SPOILER','Man like spoiler'),
('Smash (Shin Geum-jae)','Smash (Shin Geum-jae)'),
('Thayger','Thayger'),
('Tibbers','Tibbers'),
('TurtleGG','Tortugacrack'),
('Yuuji','Yuuji'),
('Zamudo','Zamudo'),
('Alex (Chen Yu-Ming)','Alex (Chen Yu-Ming)'),
('Beni (Ryohei Tsuji)','Beni (Ryohei Tsuji)'),
('Himmel','BlazeS'),
('Chosen (Yunus Baş)','Chosen (Yunus Baş)'),
('JT (Liang Shi-Hui)','JingTian'),
('Thorfin','K1THY1'),
('Kratos (Ngô Đức Khánh)','Kratos (Ngô Đức Khánh)'),
('Lago (Lee Tae-woon)','Lago (Lee Tae-woon)'),
('Echo (Liu Jun)','Ljun'),
('Lost (Lawrence Hui)','Lost (Lawrence Hui)'),
('Mai (Wei Hong-Xiang)','Mai (Wei Hong-Xiang)'),
('Ripper (Park Jae-hyun)','Ripper (Park Jae-hyun)'),
('Ryuk (Võ Hoàng Lê Khang)','Ryuk (Võ Hoàng Lê Khang)')
     ) AS v(display_name, alt)
WHERE pa.alternate_name = v.alt
  AND p.display_name = v.display_name
  AND pa.player_name_id = p.id;
-- Downdating players --
UPDATE players_player SET age=24, display_name='Alex' WHERE display_name='Alex (Chen Yu-Ming)';
UPDATE players_player SET age=NULL, display_name='Andre (Andre Culham)', residency='SEA' WHERE display_name='Bacon (Andre Culham)';
UPDATE players_player SET age=30, display_name='Beni' WHERE display_name='Beni (Ryohei Tsuji)';
UPDATE players_player SET age=25, display_name='Blazes', residency='Vietnam' WHERE display_name='Himmel';
UPDATE players_player SET age=23, display_name='Chosen' WHERE display_name='Chosen (Yunus Baş)';
UPDATE players_player SET age=NULL, display_name='Dante (Lê Văn Dự)', residency='Vietnam' WHERE display_name='Bojji (Lê Văn Dự)';
UPDATE players_player SET age=21, display_name='EnHoa' WHERE display_name='EN';
UPDATE players_player SET age=27, display_name='Jaeger' WHERE display_name='Jaeger (Lennart Warkus)';
UPDATE players_player SET display_name='Jingtian' WHERE display_name='JT (Liang Shi-Hui)';
UPDATE players_player SET age=24, display_name='K1thy1', residency='Vietnam' WHERE display_name='Thorfin';
UPDATE players_player SET age=25, display_name='Krastymel' WHERE display_name='Krastyel';
UPDATE players_player SET age=NULL, display_name='Kratos', residency='Vietnam' WHERE display_name='Kratos (Ngô Đức Khánh)';
UPDATE players_player SET display_name='Lago' WHERE display_name='Lago (Lee Tae-woon)';
UPDATE players_player SET display_name='Ljun' WHERE display_name='Echo (Liu Jun)';
UPDATE players_player SET age=25, display_name='Lost' WHERE display_name='Lost (Lawrence Hui)';
UPDATE players_player SET age=21, display_name='MG (Lee Ji-hoon)' WHERE display_name='M G (Lee Ji-hoon)';
UPDATE players_player SET display_name='Mai' WHERE display_name='Mai (Wei Hong-Xiang)';
UPDATE players_player SET age=24, display_name='Murier', residency='PCS' WHERE display_name='Cynthia';
UPDATE players_player SET age=22, display_name='Pako' WHERE display_name='Mako (Okan Öztopaç)';
UPDATE players_player SET display_name='Ranchen' WHERE display_name='Rcg';
UPDATE players_player SET age=NULL, display_name='Richard I', residency='Vietnam' WHERE display_name='AisyL';
UPDATE players_player SET display_name='Ripper' WHERE display_name='Ripper (Park Jae-hyun)';
UPDATE players_player SET age=20, display_name='Ryuk' WHERE display_name='Ryuk (Võ Hoàng Lê Khang)';
UPDATE players_player SET age=25, display_name='ShawiKatami' WHERE display_name='Shawi';
UPDATE players_player SET age=22, display_name='Sjw', residency='Vietnam' WHERE display_name='LDK';
UPDATE players_player SET age=24, display_name='Something' WHERE display_name='Beumchan Lee';
UPDATE players_player SET age=21, display_name='TomRio' WHERE display_name='Tomrio';
UPDATE players_player SET age=21, display_name='Wet' WHERE display_name='Winner (Woo Joo-sung)';
-- Removing new players --
DELETE FROM players_player WHERE display_name in (
'Bejjaniii',
'Boukada',
'Cruise',
'Curty',
'DARKWINGS',
'DOOM',
'Dioge (Diogenes Barbosa)',
'Fready',
'Gakgos',
'Gryffinn',
'Infi',
'It Yummy',
'Kat Bot',
'Keduii',
'Lotus (Mihir Ranjan)',
'Mago',
'Nackbkk',
'Nervarien',
'Neulguri',
'NicoThePico',
'Parukia',
'Pillow (Nutthanon Bumrungchawkasem)',
'Rabelo',
'SPOILER',
'Smash (Shin Geum-jae)',
'Thayger',
'Tibbers',
'TurtleGG',
'Yuuji',
'Zamudo'
);
COMMIT;