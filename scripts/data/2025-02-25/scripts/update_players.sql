BEGIN;
-- Update metadata --
INSERT INTO meta_dataupdate (date, app) VALUES ('2025-02-25', 'players');
-- Adding new players --
INSERT INTO players_player (display_name, real_name, age, country, residency) VALUES
('225', 'Jesse Fiebig', NULL, 'Australia', 'Asia Pacific'),
('5t5', 'Zeng Jun', NULL, 'China', 'China'),
('9God', 'Frank Fei', NULL, 'China', 'Asia Pacific'),
('Balder', 'Nguyễn Văn Thông', NULL, 'Vietnam', 'Asia Pacific'),
('Beluga', 'Wang Shao-Hua', NULL, 'China', 'China'),
('Cadence', 'Hugo Chang', NULL, 'Hong Kong', 'Asia Pacific'),
('Caliste', 'Caliste Henry-Hennebert', 18, '', 'EMEA'),
('Carlsen', 'Carl&amp;nbsp;Ulsted Carlsen', 19, 'Denmark', 'EMEA'),
('Casting', 'Shin Min-je', 21, 'South Korea', 'Korea'),
('Charlotte (Xue Le-Hui)', 'Xue Le-Hui', NULL, 'China', 'China'),
('ChinX', 'Sergio Perez', NULL, 'Mexico', 'Americas'),
('Claws', 'Cao Nhựt Vi', NULL, 'Vietnam', 'Asia Pacific'),
('Climber', 'Wu Hong-Tao', 20, 'China', 'China'),
('Cloud (Moon Hyeon-ho)', 'Moon Hyeon-ho', 17, 'South Korea', 'Korea'),
('Courage (Jeon Hyun-min)', 'Jeon Hyun-min', 19, 'South Korea', 'Korea'),
('Czajek', 'Mateusz Czajka', 21, 'Poland', 'EMEA'),
('Diable', 'Nam Dae-geun', 17, 'South Korea', 'Korea'),
('Dire', 'Trần Duy Đức', 18, 'Vietnam', 'Asia Pacific'),
('Evewin', 'Jakeb Schneider', NULL, 'Australia', 'Asia Pacific'),
('Fiji', 'James Thomas Carlisle', 23, 'United States', 'Americas'),
('Fishone', 'Yu Yi', NULL, 'China', 'China'),
('Forlin', 'Leonardo Pereira', 20, 'Brazil', 'Americas'),
('Gabn', 'Alexander West-Clement', NULL, 'New Zealand', 'Asia Pacific'),
('Getback', 'Jarod Tucker', NULL, 'Australia', 'Americas'),
('Glfs', 'Li Hao', NULL, 'China', 'China'),
('GuanGuan', 'Chen Chih-Yuan', 21, 'Taiwan', 'Asia Pacific'),
('Guapi', 'Brian Yu', NULL, 'New Zealand', 'Asia Pacific'),
('Haetae', 'Sim Su-hyeon', 18, 'South Korea', 'Korea'),
('HeiYue', 'Xiong Cheng-Gang', NULL, 'China', 'China'),
('Heru', 'Kim Min-seong', 18, 'South Korea', 'Korea'),
('Hizto', 'Lê Văn Hoàng Hải', 17, 'Vietnam', 'Asia Pacific'),
('HotPot', 'Shih Yi-Chieh', 22, 'Taiwan', 'Asia Pacific'),
('Hypnos', 'Kaan Turhan', 23, 'Turkey', 'EMEA'),
('Iyy', 'Ma Chen-Shuo', NULL, 'China', 'China'),
('Jcom', 'Lại Đức Tín', NULL, 'Vietnam', 'Asia Pacific'),
('Juice', 'Zhou Lin', NULL, 'China', 'China'),
('Jungoat', 'Lan De-Rong', NULL, 'China', 'China'),
('Kamiloo', 'Kamil Haudegond', 19, 'France', 'EMEA'),
('Kazuto', 'Đỗ Minh Thuận', NULL, 'Vietnam', 'Asia Pacific'),
('Kemish', 'Kim Si-hoon', 19, 'South Korea', 'Korea'),
('Kerry', 'Chung Jui-Wen', 22, 'Taiwan', 'Asia Pacific'),
('Lancer', 'Han Jeong-heum', 20, 'South Korea', 'Korea'),
('LazyFeel', 'Trần Bảo Minh', 17, 'Vietnam', 'Asia Pacific'),
('Leandrinn', 'Leandro Zaneta', 20, 'Brazil', 'Americas'),
('Leaper', 'Choi Gi-myeong', 24, 'South Korea', 'Korea'),
('Leigg', 'Jin Lei', NULL, 'China', 'China'),
('Levizin', 'Levi Adoniram Moura Pedutti', 21, 'Brazil', 'Americas'),
('Liangchen', 'Zhang Liang-Chen', NULL, 'China', 'China'),
('Loki (Lee Sang-min)', 'Lee Sang-min', 19, 'South Korea', 'Korea'),
('Lqh', 'Li Qing-Hua', NULL, 'China', 'China'),
('M0chi', 'Henry Wang', NULL, '', 'Asia Pacific'),
('Maple Syrup', 'Patrick Henchey', NULL, 'Australia', 'Asia Pacific'),
('Marvin', 'Vinicius de Souza', 19, 'Brazil', 'Americas'),
('Mentality (Wei Guan-Zhen)', 'Wei Guan-Zhen', NULL, 'China', 'China'),
('Mihile', 'Baek Sang-hwi', 21, 'South Korea', 'Korea'),
('Morttheus', 'Matheus Motta', 22, 'Brazil', 'Americas'),
('Mun', 'Lucio&amp;nbsp;Alejandro Pineda', 22, 'Mexico', 'Americas'),
('Mxx', 'Qi Zhi-Hong', NULL, 'China', 'China'),
('Nanaue (Phùng Đức Tài)', 'Phùng Đức Tài', 18, 'Vietnam', 'Asia Pacific'),
('Neadz', 'Esteban&amp;nbsp;Fernando San Martín Durán', 20, 'Chile', 'Americas'),
('Ninefog', 'Ni Hao-Jie', NULL, 'China', 'China'),
('Nuo', 'Wei Jia-Nuo', NULL, 'China', 'China'),
('OvO', 'Zhang Jia-Hao', NULL, 'China', 'China'),
('PO8', 'Zou Jun', NULL, 'China', 'China'),
('Pain (Lê Quốc Anh)', 'Lê Quốc Anh', 19, 'Vietnam', 'Asia Pacific'),
('Pool', 'Fu Zhan-Hao', NULL, 'China', 'China'),
('Prey (Xu Jia-Hao)', 'Xu Jia-Hao', NULL, 'China', 'China'),
('Pungyeon', 'Lee Jong-hyuk', 20, 'South Korea', 'Korea'),
('RYue', 'Chen Ching-Yueh', 21, 'Taiwan', 'Asia Pacific'),
('Ranchen', 'Fang Cheng', NULL, 'China', 'China'),
('Rineko', 'Liu Qi-Zhang', NULL, 'China', 'China'),
('Rooster', 'Shin Yun-hwan', 19, 'South Korea', 'Korea'),
('SYWJJ', 'Or Wing Chit', 18, 'Hong Kong', 'Asia Pacific'),
('Saber (Song Dai-Lin)', 'Song Dai-Lin', NULL, 'China', 'China'),
('Saint (Kang Sung-in)', 'Kang Sung-in', 20, 'South Korea', 'Korea'),
('ScaryJerry', 'Jeremiah Leathe', 22, 'Argentina', 'Americas'),
('SiuLoong', 'Nguyễn Hoàng Lam', 19, 'Vietnam', 'Asia Pacific'),
('Siwoo', 'Jeon Si-woo', 17, 'South Korea', 'Korea'),
('SkewMond', 'Rudy Semaan', 20, 'France', 'EMEA'),
('Slayer (Kim Jin-young)', 'Kim Jin-young', 21, 'South Korea', 'Korea'),
('Smash (Sin Geum-jae)', 'Sin Geum-jae', 18, 'South Korea', 'Korea'),
('Sounda', 'Kong In-hyuk', 21, 'South Korea', 'Korea'),
('Sovereign (Alexander Folley)', 'Alexander Folley', NULL, '', 'Asia Pacific'),
('Srtty', 'Jett&amp;nbsp;Michael Joye', 23, 'United States', 'Americas'),
('Steller', 'Lê Quang Bình', 18, 'Vietnam', 'Asia Pacific'),
('Stend', 'Paul Lardin', 23, 'France', 'EMEA'),
('Sunlight (Jin Zi-Yang)', 'Jin Zi-Yang', NULL, 'China', 'China'),
('TT (Trần Quốc Thanh)', 'Trần Quốc Thanh', 22, 'Vietnam', 'Asia Pacific'),
('Tahahy', 'Trần Hoàng Huy', 22, 'Vietnam', 'Asia Pacific'),
('Tatu (Pedro Seixas)', 'Pedro Seixas', 18, 'Brazil', 'Americas'),
('TheHank', 'Xu Hai-Han', NULL, 'China', 'China'),
('Toaster', 'Augustas Ruplys', 27, 'Lithuania', 'EMEA'),
('Tomio', 'Tomio&amp;nbsp;Phanlith Chan', 21, 'Canada', 'Americas'),
('VENDRICK', 'Jakib Isherwood', NULL, 'New Zealand', 'Asia Pacific'),
('Van (Kim Seung-hoo)', 'Kim Seung-hoo', 21, 'South Korea', 'Korea'),
('Vincenzo (Ha Seung-min)', 'Ha Seung-min', 20, 'South Korea', 'Korea'),
('Warrior (Nguyễn Phú Thanh)', 'Nguyễn Phú Thạnh', NULL, 'Vietnam', 'Asia Pacific'),
('Xiaocaobao', 'Liang Jian', 22, 'China', 'China'),
('Xiaoka', 'Luo Ji-Yong', NULL, 'China', 'China'),
('Xiaorui', 'Niu Xiao-Rui', NULL, 'China', 'China'),
('Xinsheng', 'Ding Xin-Sheng', NULL, 'China', 'China'),
('Ycx', 'Zhao Wen-Hao', 24, 'China', 'China'),
('Yojin', 'Natasak Srikusalanukul', NULL, '', 'Asia Pacific'),
('Yomiya', 'Yao Ying-Cheng', NULL, 'China', 'China'),
('Young (Young Choi)', 'Young&amp;nbsp;Ho Choi', NULL, 'United States', 'Americas'),
('Yume (Châu Kim Bảo)', 'Châu Kim Bảo', NULL, 'Vietnam', 'Asia Pacific'),
('Yummy', 'Yang Zi-Fan', NULL, 'China', 'China'),
('ZUIAN', 'Cheng Zi-Hao', NULL, 'China', 'China'),
('Zinie', 'Yoo Baek-jin', 19, 'South Korea', 'Korea');
-- Updating players --
UPDATE players_player SET age=22, display_name='24 (Seyfi Onat Aytemiz)' WHERE display_name='24';
UPDATE players_player SET display_name='404 (Zhi Choong Sheng)' WHERE display_name='404';
UPDATE players_player SET display_name='Alfred (Alfredo González)' WHERE display_name='Alfred';
UPDATE players_player SET display_name='AnnieBot' WHERE display_name='Annie Bot';
UPDATE players_player SET age=20, display_name='Oleg (Oleg Karkachev)' WHERE display_name='Antik';
UPDATE players_player SET age=29, display_name='Sask' WHERE display_name='Assassin';
UPDATE players_player SET age=28, display_name='Astra (Eduard Fritz)' WHERE display_name='Astra';
UPDATE players_player SET display_name='Maximillion' WHERE display_name='Balta129';
UPDATE players_player SET display_name='Bipolar (Ramsay Lochhead Devaraj)' WHERE display_name='Bipolar';
UPDATE players_player SET display_name='Dispel' WHERE display_name='Blessing';
UPDATE players_player SET display_name='Bon0' WHERE display_name='BonO (Kim Gi-beom)';
UPDATE players_player SET display_name='CarioK', residency='Americas' WHERE display_name='Cariok';
UPDATE players_player SET display_name='Colin' WHERE display_name='CoLiN';
UPDATE players_player SET age=30, display_name='Crimson (Mert Koçak)' WHERE display_name='Crimson';
UPDATE players_player SET display_name='Crowdy' WHERE display_name='Crowno';
UPDATE players_player SET display_name='Dani (Phillex Bulanadi)' WHERE display_name='Dani';
UPDATE players_player SET age=21, display_name='Deant9', residency='Asia Pacific' WHERE display_name='Deant';
UPDATE players_player SET display_name='Don Cholo (Sergio Salas)' WHERE display_name='Don Cholo';
UPDATE players_player SET display_name='Endless (Xu Hao)' WHERE display_name='Endless';
UPDATE players_player SET age=21, display_name='3XA' WHERE display_name='Exakick';
UPDATE players_player SET age=33, display_name='Fzzf' WHERE display_name='FZZF';
UPDATE players_player SET age=20, display_name='Frosty (José Eduardo)', real_name='José&amp;nbsp;Eduardo Leal Pacheco', residency='Americas' WHERE display_name='Frostyy';
UPDATE players_player SET age=20, display_name='Grave' WHERE display_name='Gravepast';
UPDATE players_player SET display_name='Luon' WHERE display_name='HH (Lee Hyun-ho)';
UPDATE players_player SET display_name='Fate (Peng Jun-Jie)' WHERE display_name='Heal (Peng Jun-Jie)';
UPDATE players_player SET age=28, display_name='ICON' WHERE display_name='Icon';
UPDATE players_player SET age=26, display_name='JACTROLL' WHERE display_name='Jactroll';
UPDATE players_player SET age=23, display_name='Jiejie' WHERE display_name='JieJie';
UPDATE players_player SET age=26, display_name='JoJo (Gabriel Dzelme)', residency='Americas' WHERE display_name='Jojo (Gabriel Dzelme)';
UPDATE players_player SET display_name='Sasi (Yan Rui)' WHERE display_name='Juejuezi';
UPDATE players_player SET age=24, display_name='KL (So Ka Lung)' WHERE display_name='KL';
UPDATE players_player SET age=23, display_name='Sanghyeon' WHERE display_name='Kabbie';
UPDATE players_player SET age=24, display_name='Kagame (Yap Li Aw)', residency='Asia Pacific' WHERE display_name='Kagame';
UPDATE players_player SET display_name='Kite (Kim Yong-yeon)' WHERE display_name='Kite';
UPDATE players_player SET display_name='Krastymel', residency='Americas' WHERE display_name='Krastyel';
UPDATE players_player SET age=25, display_name='M1lo', residency='Asia Pacific' WHERE display_name='Kuroko (Trần Tuấn Anh)';
UPDATE players_player SET display_name='Kino' WHERE display_name='LanPeiFang';
UPDATE players_player SET age=27, display_name='Last (Jeong Young-seok)' WHERE display_name='Last';
UPDATE players_player SET age=24, display_name='MAXI', real_name='Magnus Stenz Kristensen' WHERE display_name='Maxi';
UPDATE players_player SET display_name='Lucius' WHERE display_name='Me';
UPDATE players_player SET age=24, display_name='Moesakr' WHERE display_name='Molto';
UPDATE players_player SET age=29, display_name='Mushroom (Zhang Xiao-Fu)' WHERE display_name='Mushroom';
UPDATE players_player SET display_name='NL (Hsiung Wen-An)' WHERE display_name='NL';
UPDATE players_player SET age=27, display_name='Oddielan', residency='Americas' WHERE display_name='Oddie';
UPDATE players_player SET age=31, display_name='Omni (Thomas Trinh Dung)' WHERE display_name='Omni';
UPDATE players_player SET display_name='Only (Jordan Middleton)', residency='Oceania' WHERE display_name='Only';
UPDATE players_player SET age=28, display_name='C7N', residency='Asia Pacific' WHERE display_name='Optimus';
UPDATE players_player SET age=26, display_name='SkyBart', residency='Americas' WHERE display_name='Ouroboy';
UPDATE players_player SET display_name='OverT1me' WHERE display_name='Over T1me';
UPDATE players_player SET display_name='Ozgur (Can Özgür Kara)' WHERE display_name='Ozgur';
UPDATE players_player SET age=29, display_name='Doggy' WHERE display_name='Ozora';
UPDATE players_player SET display_name='Ptt', residency='EMEA' WHERE display_name='Pepiinero';
UPDATE players_player SET age=24, display_name='Hespo' WHERE display_name='Peraxy';
UPDATE players_player SET age=25, display_name='Pilot (Elvis Vergara)', residency='Americas' WHERE display_name='Piloto';
UPDATE players_player SET age=27, display_name='PrettyGRE', residency='EMEA' WHERE display_name='Pretty';
UPDATE players_player SET display_name='QingSi' WHERE display_name='Qingsi';
UPDATE players_player SET display_name='Aqiu' WHERE display_name='QiuQiu (Liang Jian)';
UPDATE players_player SET age=23, display_name='Henli', residency='Asia Pacific' WHERE display_name='Rby';
UPDATE players_player SET age=28, display_name='ReM (Lee Hyeon-seo)' WHERE display_name='ReM';
UPDATE players_player SET age=23, display_name='Kice' WHERE display_name='Reble';
UPDATE players_player SET age=23, display_name='RKR' WHERE display_name='Reeker';
UPDATE players_player SET display_name='REV' WHERE display_name='Revenge (Mohannad Alrashdi)';
UPDATE players_player SET age=22, display_name='Rise (Zhang Sheng)' WHERE display_name='Rise';
UPDATE players_player SET age=26, display_name='Smiley (Ludvig Granquist)' WHERE display_name='SMILEY (Ludvig Granquist)';
UPDATE players_player SET display_name='Motive' WHERE display_name='SUP (Cho Se-hee)';
UPDATE players_player SET age=19, display_name='Hamin', real_name='Trần Nguyễn Anh Khoa', residency='Asia Pacific' WHERE display_name='Sabo (Trần Nguyễn Anh Khoa)';
UPDATE players_player SET display_name='SCARY (Artur Queiroz)', residency='Americas' WHERE display_name='Scary (Artur Queiroz)';
UPDATE players_player SET age=32, display_name='Sheep (Jamie Gallagher)' WHERE display_name='Sheep';
UPDATE players_player SET display_name='Sigma (Brent de Laet)' WHERE display_name='Sigma';
UPDATE players_player SET age=24, display_name='Wuming (Wang Xin)' WHERE display_name='Steel';
UPDATE players_player SET display_name='Sâyn (Aleš Gall)' WHERE display_name='Sâyn';
UPDATE players_player SET age=30, display_name='Turtle (Gabriel Peixoto)', residency='Americas' WHERE display_name='Turtle';
UPDATE players_player SET age=22, display_name='Tomoe', real_name='Nguyễn Quốc Mạnh', residency='Asia Pacific' WHERE display_name='Usopp (Nguyễn Quốc Mạnh)';
UPDATE players_player SET display_name='Vulcan (Philippe Laflamme)', residency='Americas' WHERE display_name='VULCAN (Philippe Laflamme)';
UPDATE players_player SET display_name='Value (Ross Luppino)' WHERE display_name='Value';
UPDATE players_player SET age=30, display_name='Vas1lii' WHERE display_name='Vasilii';
UPDATE players_player SET display_name='Vergil (Wang Hai-Han)' WHERE display_name='Vergil';
UPDATE players_player SET display_name='VIN (Trần Hoài Vinh)', residency='Asia Pacific' WHERE display_name='Vince (Trần Hoài Vinh)';
UPDATE players_player SET age=31, display_name='Wall (Son Chang-hoon)' WHERE display_name='Wall';
UPDATE players_player SET age=32, display_name='Wx' WHERE display_name='WeiXiao';
UPDATE players_player SET display_name='Wet' WHERE display_name='Winner (Woo Joo-sung)';
UPDATE players_player SET age=30, display_name='Xiaoweixiao' WHERE display_name='XiaoWeiXiao';
UPDATE players_player SET display_name='Alley' WHERE display_name='Xiaoyu (Zhou Yu)';
UPDATE players_player SET display_name='Yume (Danyll Jann Balisi)' WHERE display_name='Yume';
UPDATE players_player SET age=24, display_name='Yuri (Cha Hee-min)' WHERE display_name='Yuri';
UPDATE players_player SET age=22, display_name='Yge' WHERE display_name='Yzi';
UPDATE players_player SET age=22, display_name='ZekaS', real_name='César Berteli França', residency='Americas' WHERE display_name='Zecas';
UPDATE players_player SET age=20, display_name='Zkai', residency='Asia Pacific' WHERE display_name='Zka1';
-- Inserting all new alternate names --
INSERT INTO players_playeralternatename (alternate_name, player_name_id) VALUES
('225', (SELECT id FROM players_player WHERE display_name='225')),
('5t5', (SELECT id FROM players_player WHERE display_name='5t5')),
('9God', (SELECT id FROM players_player WHERE display_name='9God')),
('Balder', (SELECT id FROM players_player WHERE display_name='Balder')),
('Beluga', (SELECT id FROM players_player WHERE display_name='Beluga')),
('Cadence', (SELECT id FROM players_player WHERE display_name='Cadence')),
('Caliste', (SELECT id FROM players_player WHERE display_name='Caliste')),
('Carlsen', (SELECT id FROM players_player WHERE display_name='Carlsen')),
('Casting', (SELECT id FROM players_player WHERE display_name='Casting')),
('Charlotte (Xue Le-Hui)', (SELECT id FROM players_player WHERE display_name='Charlotte (Xue Le-Hui)')),
('ChinX', (SELECT id FROM players_player WHERE display_name='ChinX')),
('Claws', (SELECT id FROM players_player WHERE display_name='Claws')),
('Climber', (SELECT id FROM players_player WHERE display_name='Climber')),
('Cloud (Moon Hyeon-ho)', (SELECT id FROM players_player WHERE display_name='Cloud (Moon Hyeon-ho)')),
('Courage (Jeon Hyun-min)', (SELECT id FROM players_player WHERE display_name='Courage (Jeon Hyun-min)')),
('Czajek', (SELECT id FROM players_player WHERE display_name='Czajek')),
('Diable', (SELECT id FROM players_player WHERE display_name='Diable')),
('Dire', (SELECT id FROM players_player WHERE display_name='Dire')),
('Evewin', (SELECT id FROM players_player WHERE display_name='Evewin')),
('Fiji', (SELECT id FROM players_player WHERE display_name='Fiji')),
('Fishone', (SELECT id FROM players_player WHERE display_name='Fishone')),
('Forlin', (SELECT id FROM players_player WHERE display_name='Forlin')),
('Gabn', (SELECT id FROM players_player WHERE display_name='Gabn')),
('Getback', (SELECT id FROM players_player WHERE display_name='Getback')),
('Glfs', (SELECT id FROM players_player WHERE display_name='Glfs')),
('GuanGuan', (SELECT id FROM players_player WHERE display_name='GuanGuan')),
('Guapi', (SELECT id FROM players_player WHERE display_name='Guapi')),
('Haetae', (SELECT id FROM players_player WHERE display_name='Haetae')),
('HeiYue', (SELECT id FROM players_player WHERE display_name='HeiYue')),
('Heru', (SELECT id FROM players_player WHERE display_name='Heru')),
('Hizto', (SELECT id FROM players_player WHERE display_name='Hizto')),
('HotPot', (SELECT id FROM players_player WHERE display_name='HotPot')),
('Hypnos', (SELECT id FROM players_player WHERE display_name='Hypnos')),
('Iyy', (SELECT id FROM players_player WHERE display_name='Iyy')),
('Jcom', (SELECT id FROM players_player WHERE display_name='Jcom')),
('Juice', (SELECT id FROM players_player WHERE display_name='Juice')),
('Dante (Lan De-Rong)', (SELECT id FROM players_player WHERE display_name='Jungoat')),
('Kamiloo', (SELECT id FROM players_player WHERE display_name='Kamiloo')),
('Kazuto', (SELECT id FROM players_player WHERE display_name='Kazuto')),
('Kemish', (SELECT id FROM players_player WHERE display_name='Kemish')),
('Kerry', (SELECT id FROM players_player WHERE display_name='Kerry')),
('Lancer', (SELECT id FROM players_player WHERE display_name='Lancer')),
('LazyFeel', (SELECT id FROM players_player WHERE display_name='LazyFeel')),
('Leandrinn', (SELECT id FROM players_player WHERE display_name='Leandrinn')),
('Leaper', (SELECT id FROM players_player WHERE display_name='Leaper')),
('Leigg', (SELECT id FROM players_player WHERE display_name='Leigg')),
('Levizin', (SELECT id FROM players_player WHERE display_name='Levizin')),
('Liangchen', (SELECT id FROM players_player WHERE display_name='Liangchen')),
('Loki (Lee Sang-min)', (SELECT id FROM players_player WHERE display_name='Loki (Lee Sang-min)')),
('Lqh', (SELECT id FROM players_player WHERE display_name='Lqh')),
('M0chi', (SELECT id FROM players_player WHERE display_name='M0chi')),
('Maple Syrup', (SELECT id FROM players_player WHERE display_name='Maple Syrup')),
('Marvin', (SELECT id FROM players_player WHERE display_name='Marvin')),
('Mentality (Wei Guan-Zhen)', (SELECT id FROM players_player WHERE display_name='Mentality (Wei Guan-Zhen)')),
('Mihile', (SELECT id FROM players_player WHERE display_name='Mihile')),
('Morttheus', (SELECT id FROM players_player WHERE display_name='Morttheus')),
('Mun', (SELECT id FROM players_player WHERE display_name='Mun')),
('Mxx', (SELECT id FROM players_player WHERE display_name='Mxx')),
('Nanaue (Phùng Đức Tài)', (SELECT id FROM players_player WHERE display_name='Nanaue (Phùng Đức Tài)')),
('Neadz', (SELECT id FROM players_player WHERE display_name='Neadz')),
('Ninefog', (SELECT id FROM players_player WHERE display_name='Ninefog')),
('Nuo', (SELECT id FROM players_player WHERE display_name='Nuo')),
('OvO', (SELECT id FROM players_player WHERE display_name='OvO')),
('PO8', (SELECT id FROM players_player WHERE display_name='PO8')),
('Pain5', (SELECT id FROM players_player WHERE display_name='Pain (Lê Quốc Anh)')),
('Pool', (SELECT id FROM players_player WHERE display_name='Pool')),
('Prey (Xu Jia-Hao)', (SELECT id FROM players_player WHERE display_name='Prey (Xu Jia-Hao)')),
('Pungyeon', (SELECT id FROM players_player WHERE display_name='Pungyeon')),
('RYue', (SELECT id FROM players_player WHERE display_name='RYue')),
('Ranchen', (SELECT id FROM players_player WHERE display_name='Ranchen')),
('Rineko', (SELECT id FROM players_player WHERE display_name='Rineko')),
('Rooster', (SELECT id FROM players_player WHERE display_name='Rooster')),
('SYWJJ', (SELECT id FROM players_player WHERE display_name='SYWJJ')),
('Saber (Song Dai-Lin)', (SELECT id FROM players_player WHERE display_name='Saber (Song Dai-Lin)')),
('Saint (Kang Sung-in)', (SELECT id FROM players_player WHERE display_name='Saint (Kang Sung-in)')),
('ScaryJerry', (SELECT id FROM players_player WHERE display_name='ScaryJerry')),
('SiuLoong', (SELECT id FROM players_player WHERE display_name='SiuLoong')),
('Siwoo', (SELECT id FROM players_player WHERE display_name='Siwoo')),
('SkewMond', (SELECT id FROM players_player WHERE display_name='SkewMond')),
('Slayer (Kim Jin-young)', (SELECT id FROM players_player WHERE display_name='Slayer (Kim Jin-young)')),
('Smash (Sin Geum-jae)', (SELECT id FROM players_player WHERE display_name='Smash (Sin Geum-jae)')),
('Sounda', (SELECT id FROM players_player WHERE display_name='Sounda')),
('Sovereign (Alexander Folley)', (SELECT id FROM players_player WHERE display_name='Sovereign (Alexander Folley)')),
('Srtty', (SELECT id FROM players_player WHERE display_name='Srtty')),
('Steller', (SELECT id FROM players_player WHERE display_name='Steller')),
('Stend', (SELECT id FROM players_player WHERE display_name='Stend')),
('Sunlight (Jin Zi-Yang)', (SELECT id FROM players_player WHERE display_name='Sunlight (Jin Zi-Yang)')),
('TT789', (SELECT id FROM players_player WHERE display_name='TT (Trần Quốc Thanh)')),
('Tahahy', (SELECT id FROM players_player WHERE display_name='Tahahy')),
('Tatu (Pedro Seixas)', (SELECT id FROM players_player WHERE display_name='Tatu (Pedro Seixas)')),
('TheHank', (SELECT id FROM players_player WHERE display_name='TheHank')),
('Toaster', (SELECT id FROM players_player WHERE display_name='Toaster')),
('Tomio', (SELECT id FROM players_player WHERE display_name='Tomio')),
('VENDRICK', (SELECT id FROM players_player WHERE display_name='VENDRICK')),
('Van (Kim Seung-hoo)', (SELECT id FROM players_player WHERE display_name='Van (Kim Seung-hoo)')),
('Vincenzo (Ha Seung-min)', (SELECT id FROM players_player WHERE display_name='Vincenzo (Ha Seung-min)')),
('Warri0r', (SELECT id FROM players_player WHERE display_name='Warrior (Nguyễn Phú Thanh)')),
('Xiaocaoba0', (SELECT id FROM players_player WHERE display_name='Xiaocaobao')),
('Xiaocaobao', (SELECT id FROM players_player WHERE display_name='Xiaocaobao')),
('Xiaoka', (SELECT id FROM players_player WHERE display_name='Xiaoka')),
('Xiaorui', (SELECT id FROM players_player WHERE display_name='Xiaorui')),
('Xinsheng', (SELECT id FROM players_player WHERE display_name='Xinsheng')),
('Ycx', (SELECT id FROM players_player WHERE display_name='Ycx')),
('Yojin', (SELECT id FROM players_player WHERE display_name='Yojin')),
('Yomiya', (SELECT id FROM players_player WHERE display_name='Yomiya')),
('Young (Young Choi)', (SELECT id FROM players_player WHERE display_name='Young (Young Choi)')),
('Yume (Châu Kim Bảo)', (SELECT id FROM players_player WHERE display_name='Yume (Châu Kim Bảo)')),
('Yummy', (SELECT id FROM players_player WHERE display_name='Yummy')),
('ZUIAN', (SELECT id FROM players_player WHERE display_name='ZUIAN')),
('Zinie', (SELECT id FROM players_player WHERE display_name='Zinie')),
('24 (Seyfi Onat Aytemiz)', (SELECT id FROM players_player WHERE display_name='24 (Seyfi Onat Aytemiz)')),
('404 (Zhi Choong Sheng)', (SELECT id FROM players_player WHERE display_name='404 (Zhi Choong Sheng)')),
('Alfred (Alfredo González)', (SELECT id FROM players_player WHERE display_name='Alfred (Alfredo González)')),
('Astra (Eduard Fritz)', (SELECT id FROM players_player WHERE display_name='Astra (Eduard Fritz)')),
('Bipolar (Ramsay Lochhead Devaraj)', (SELECT id FROM players_player WHERE display_name='Bipolar (Ramsay Lochhead Devaraj)')),
('CarioK', (SELECT id FROM players_player WHERE display_name='CarioK')),
('Colin', (SELECT id FROM players_player WHERE display_name='Colin')),
('Crimson (Mert Koçak)', (SELECT id FROM players_player WHERE display_name='Crimson (Mert Koçak)')),
('Don Cholo (Sergio Salas)', (SELECT id FROM players_player WHERE display_name='Don Cholo (Sergio Salas)')),
('Endless (Xu Hao)', (SELECT id FROM players_player WHERE display_name='Endless (Xu Hao)')),
('Fzzf', (SELECT id FROM players_player WHERE display_name='Fzzf')),
('Luon', (SELECT id FROM players_player WHERE display_name='Luon')),
('ICON', (SELECT id FROM players_player WHERE display_name='ICON')),
('JACTROLL', (SELECT id FROM players_player WHERE display_name='JACTROLL')),
('Jiejie', (SELECT id FROM players_player WHERE display_name='Jiejie')),
('JoJo (Gabriel Dzelme)', (SELECT id FROM players_player WHERE display_name='JoJo (Gabriel Dzelme)')),
('Sasi (Yan Rui)', (SELECT id FROM players_player WHERE display_name='Sasi (Yan Rui)')),
('KL (So Ka Lung)', (SELECT id FROM players_player WHERE display_name='KL (So Ka Lung)')),
('Kagame (Yap Li Aw)', (SELECT id FROM players_player WHERE display_name='Kagame (Yap Li Aw)')),
('Kite (Kim Yong-yeon)', (SELECT id FROM players_player WHERE display_name='Kite (Kim Yong-yeon)')),
('Last (Jeong Young-seok)', (SELECT id FROM players_player WHERE display_name='Last (Jeong Young-seok)')),
('MAXI', (SELECT id FROM players_player WHERE display_name='MAXI')),
('Mushroom (Zhang Xiao-Fu)', (SELECT id FROM players_player WHERE display_name='Mushroom (Zhang Xiao-Fu)')),
('NL (Hsiung Wen-An)', (SELECT id FROM players_player WHERE display_name='NL (Hsiung Wen-An)')),
('Oddielan', (SELECT id FROM players_player WHERE display_name='Oddielan')),
('Omni (Thomas Trinh Dung)', (SELECT id FROM players_player WHERE display_name='Omni (Thomas Trinh Dung)')),
('Only (Jordan Middleton)', (SELECT id FROM players_player WHERE display_name='Only (Jordan Middleton)')),
('Ozgur (Can Özgür Kara)', (SELECT id FROM players_player WHERE display_name='Ozgur (Can Özgür Kara)')),
('PePiiNeRO', (SELECT id FROM players_player WHERE display_name='Ptt')),
('RBY', (SELECT id FROM players_player WHERE display_name='Henli')),
('ReM (Lee Hyeon-seo)', (SELECT id FROM players_player WHERE display_name='ReM (Lee Hyeon-seo)')),
('RKR', (SELECT id FROM players_player WHERE display_name='RKR')),
('Rise (Zhang Sheng)', (SELECT id FROM players_player WHERE display_name='Rise (Zhang Sheng)')),
('Smiley (Ludvig Granquist)', (SELECT id FROM players_player WHERE display_name='Smiley (Ludvig Granquist)')),
('XDSMILEY', (SELECT id FROM players_player WHERE display_name='Smiley (Ludvig Granquist)')),
('SCARY (Artur Queiroz)', (SELECT id FROM players_player WHERE display_name='SCARY (Artur Queiroz)')),
('Sheep (Jamie Gallagher)', (SELECT id FROM players_player WHERE display_name='Sheep (Jamie Gallagher)')),
('Sigma (Brent de Laet)', (SELECT id FROM players_player WHERE display_name='Sigma (Brent de Laet)')),
('Sâyn (Aleš Gall)', (SELECT id FROM players_player WHERE display_name='Sâyn (Aleš Gall)')),
('Turtle (Gabriel Peixoto)', (SELECT id FROM players_player WHERE display_name='Turtle (Gabriel Peixoto)')),
('Vulcan (Philippe Laflamme)', (SELECT id FROM players_player WHERE display_name='Vulcan (Philippe Laflamme)')),
('Value (Ross Luppino)', (SELECT id FROM players_player WHERE display_name='Value (Ross Luppino)')),
('Vergil (Wang Hai-Han)', (SELECT id FROM players_player WHERE display_name='Vergil (Wang Hai-Han)')),
('VIN (Trần Hoài Vinh)', (SELECT id FROM players_player WHERE display_name='VIN (Trần Hoài Vinh)')),
('Wall (Son Chang-hoon)', (SELECT id FROM players_player WHERE display_name='Wall (Son Chang-hoon)')),
('Weixiao', (SELECT id FROM players_player WHERE display_name='Wx')),
('Xiaoweixiao', (SELECT id FROM players_player WHERE display_name='Xiaoweixiao')),
('Yume (Danyll Jann Balisi)', (SELECT id FROM players_player WHERE display_name='Yume (Danyll Jann Balisi)')),
('Yuri (Cha Hee-min)', (SELECT id FROM players_player WHERE display_name='Yuri (Cha Hee-min)'));
COMMIT;