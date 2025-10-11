BEGIN;
-- Update metadata --
INSERT INTO meta_dataupdate (date, app) VALUES ('2025-09-16', 'players');
-- Adding new players --
INSERT INTO players_player (display_name, real_name, age, country, residency) VALUES
('Bejjaniii', 'Gerardo&amp;nbsp;Andres Leon Bijani', 25, 'Venezuela', 'Americas'),
('Boukada', 'Mehdi Lahlou', 22, 'France', 'EMEA'),
('Cruise', 'Cruise June S. Tilos', 24, 'Philippines', 'Asia Pacific'),
('Curty', 'Pedro Curty', 18, 'Brazil', 'Americas'),
('DARKWINGS', 'Isaac Chou', 25, '', 'Americas'),
('DOOM', 'Raí Yamada', 20, 'Brazil', 'Americas'),
('Dioge (Diogenes Barbosa)', 'Diogenes Barbosa Bispo', 23, 'Brazil', 'Americas'),
('Fready', 'Thaikōe Chon', NULL, 'Thailand', 'Asia Pacific'),
('Gakgos', 'İbrahim Samet Bulut', 17, 'Turkey', 'EMEA'),
('Gryffinn', 'Johnson Le', 18, 'United States', 'Americas'),
('Infi', 'Aakash Shandilya', NULL, 'India', 'Asia Pacific'),
('It Yummy', 'Phumiphat Boonta', 22, 'Thailand', 'Asia Pacific'),
('Kat Bot', 'Akshaj Shenoy', NULL, 'India', 'Asia Pacific'),
('Keduii', 'Tim Willers', 24, 'Germany', 'EMEA'),
('Lotus (Mihir Ranjan)', 'Mihir Ranjan', NULL, 'India', 'Asia Pacific'),
('Mago', 'Jean&amp;nbsp;Carlo Dias', 21, 'Brazil', 'Americas'),
('Nackbkk', 'Pakorn Chantarakomol', NULL, 'Thailand', 'Asia Pacific'),
('Nervarien', 'Damian Ziaja', NULL, 'Poland', 'EMEA'),
('Neulguri', 'Chirapat Eyesong', 25, 'Thailand', 'Asia Pacific'),
('NicoThePico', 'Nicholas Korsgård', 33, 'Norway', 'Europe'),
('Parukia', 'Wang Ping-Yang', 18, 'China', 'China'),
('Pillow (Nutthanon Bumrungchawkasem)', 'Nutthanon Wkasem Bumrungchawkasem', 28, 'Thailand', 'Asia Pacific'),
('Rabelo', 'Guilherme Rabelo Muniz', 21, 'Brazil', 'Americas'),
('SPOILER', 'Meher Mchirghi', 22, 'Tunisia', 'EMEA'),
('Smash (Shin Geum-jae)', 'Shin Geum-jae', 19, 'South Korea', 'Korea'),
('Thayger', 'Francisco Mazo Sánchez', 23, 'Spain', 'EMEA'),
('Tibbers', 'Thomas Hulton', NULL, 'Argentina', 'LAS'),
('TurtleGG', 'Cristóbal Barra', NULL, 'Chile', 'LAS'),
('Yuuji', 'Ganbat Ulziidelger', 22, 'Mongolia', 'EMEA'),
('Zamudo', 'Frankie Lin', 21, 'Canada', 'Americas');
-- Updating players --
UPDATE players_player SET age=25, display_name='Alex (Chen Yu-Ming)' WHERE display_name='Alex';
UPDATE players_player SET age=29, display_name='Bacon (Andre Culham)', residency='Asia Pacific' WHERE display_name='Andre (Andre Culham)';
UPDATE players_player SET age=31, display_name='Beni (Ryohei Tsuji)' WHERE display_name='Beni';
UPDATE players_player SET age=26, display_name='Himmel', residency='Asia Pacific' WHERE display_name='Blazes';
UPDATE players_player SET age=24, display_name='Chosen (Yunus Baş)' WHERE display_name='Chosen';
UPDATE players_player SET age=21, display_name='Bojji (Lê Văn Dự)', residency='Asia Pacific' WHERE display_name='Dante (Lê Văn Dự)';
UPDATE players_player SET age=22, display_name='EN' WHERE display_name='EnHoa';
UPDATE players_player SET age=29, display_name='Jaeger (Lennart Warkus)' WHERE display_name='Jaeger';
UPDATE players_player SET display_name='JT (Liang Shi-Hui)' WHERE display_name='Jingtian';
UPDATE players_player SET age=25, display_name='Thorfin', residency='Asia Pacific' WHERE display_name='K1thy1';
UPDATE players_player SET age=26, display_name='Krastyel' WHERE display_name='Krastymel';
UPDATE players_player SET age=20, display_name='Kratos (Ngô Đức Khánh)', residency='Asia Pacific' WHERE display_name='Kratos';
UPDATE players_player SET display_name='Lago (Lee Tae-woon)' WHERE display_name='Lago';
UPDATE players_player SET display_name='Echo (Liu Jun)' WHERE display_name='Ljun';
UPDATE players_player SET age=26, display_name='Lost (Lawrence Hui)' WHERE display_name='Lost';
UPDATE players_player SET age=23, display_name='M G (Lee Ji-hoon)' WHERE display_name='MG (Lee Ji-hoon)';
UPDATE players_player SET display_name='Mai (Wei Hong-Xiang)' WHERE display_name='Mai';
UPDATE players_player SET age=25, display_name='Cynthia', residency='Asia Pacific' WHERE display_name='Murier';
UPDATE players_player SET age=24, display_name='Mako (Okan Öztopaç)' WHERE display_name='Pako';
UPDATE players_player SET display_name='Rcg' WHERE display_name='Ranchen';
UPDATE players_player SET age=20, display_name='AisyL', residency='Asia Pacific' WHERE display_name='Richard I';
UPDATE players_player SET display_name='Ripper (Park Jae-hyun)' WHERE display_name='Ripper';
UPDATE players_player SET age=22, display_name='Ryuk (Võ Hoàng Lê Khang)' WHERE display_name='Ryuk';
UPDATE players_player SET age=26, display_name='Shawi' WHERE display_name='ShawiKatami';
UPDATE players_player SET age=23, display_name='LDK', residency='Asia Pacific' WHERE display_name='Sjw';
UPDATE players_player SET age=25, display_name='Beumchan Lee' WHERE display_name='Something';
UPDATE players_player SET age=22, display_name='Tomrio' WHERE display_name='TomRio';
UPDATE players_player SET age=22, display_name='Winner (Woo Joo-sung)' WHERE display_name='Wet';
-- Inserting all new alternate names --
INSERT INTO players_playeralternatename (alternate_name, player_name_id)
SELECT v.alt, p.id
FROM players_player p
JOIN (
    VALUES
        ('Yayo', 'Bejjaniii'),
('Boukada', 'Boukada'),
('Cruise', 'Cruise'),
('Curty', 'Curty'),
('DARKWINGS', 'DARKWINGS'),
('DOOM', 'DOOM'),
('Dioge (Diogenes Barbosa)', 'Dioge (Diogenes Barbosa)'),
('Fready', 'Fready'),
('Gakgos', 'Gakgos'),
('Gryffinn', 'Gryffinn'),
('Infi', 'Infi'),
('It Yummy', 'It Yummy'),
('Katarina Bot', 'Kat Bot'),
('Keduii', 'Keduii'),
('Lotus (Mihir Ranjan)', 'Lotus (Mihir Ranjan)'),
('Mago', 'Mago'),
('Nackbkk', 'Nackbkk'),
('Hrabia Nervarien', 'Nervarien'),
('Neulnnyr', 'Neulguri'),
('NicoThePico', 'NicoThePico'),
('Parukia', 'Parukia'),
('Pillow (Nutthanon Bumrungchawkasem)', 'Pillow (Nutthanon Bumrungchawkasem)'),
('Rabelo', 'Rabelo'),
('Man like spoiler', 'SPOILER'),
('Smash (Shin Geum-jae)', 'Smash (Shin Geum-jae)'),
('Thayger', 'Thayger'),
('Tibbers', 'Tibbers'),
('Tortugacrack', 'TurtleGG'),
('Yuuji', 'Yuuji'),
('Zamudo', 'Zamudo'),
('Alex (Chen Yu-Ming)', 'Alex (Chen Yu-Ming)'),
('Beni (Ryohei Tsuji)', 'Beni (Ryohei Tsuji)'),
('BlazeS', 'Himmel'),
('Chosen (Yunus Baş)', 'Chosen (Yunus Baş)'),
('JingTian', 'JT (Liang Shi-Hui)'),
('K1THY1', 'Thorfin'),
('Kratos (Ngô Đức Khánh)', 'Kratos (Ngô Đức Khánh)'),
('Lago (Lee Tae-woon)', 'Lago (Lee Tae-woon)'),
('Ljun', 'Echo (Liu Jun)'),
('Lost (Lawrence Hui)', 'Lost (Lawrence Hui)'),
('Mai (Wei Hong-Xiang)', 'Mai (Wei Hong-Xiang)'),
('Ripper (Park Jae-hyun)', 'Ripper (Park Jae-hyun)'),
('Ryuk (Võ Hoàng Lê Khang)', 'Ryuk (Võ Hoàng Lê Khang)')
) AS v(alt, display_name)
  ON p.display_name = v.display_name;
COMMIT;