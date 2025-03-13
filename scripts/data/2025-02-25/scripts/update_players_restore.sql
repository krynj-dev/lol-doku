BEGIN;
-- Restore metadata --
DELETE FROM meta_dataupdate WHERE id in (SELECT id FROM meta_dataupdate WHERE app='players' ORDER BY date DESC LIMIT 1);
-- Removing all new alternate names --
DELETE FROM players_playeralternatename WHERE id in (SELECT id FROM players_playeralternatename WHERE (
(player_name_id=(SELECT id FROM players_player WHERE display_name='225') AND alternate_name IN ('225')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='5t5') AND alternate_name IN ('5t5')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='9God') AND alternate_name IN ('9God')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Balder') AND alternate_name IN ('Balder')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Beluga') AND alternate_name IN ('Beluga')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Cadence') AND alternate_name IN ('Cadence')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Caliste') AND alternate_name IN ('Caliste')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Carlsen') AND alternate_name IN ('Carlsen')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Casting') AND alternate_name IN ('Casting')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Charlotte (Xue Le-Hui)') AND alternate_name IN ('Charlotte (Xue Le-Hui)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='ChinX') AND alternate_name IN ('ChinX')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Claws') AND alternate_name IN ('Claws')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Climber') AND alternate_name IN ('Climber')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Cloud (Moon Hyeon-ho)') AND alternate_name IN ('Cloud (Moon Hyeon-ho)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Courage (Jeon Hyun-min)') AND alternate_name IN ('Courage (Jeon Hyun-min)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Czajek') AND alternate_name IN ('Czajek')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Diable') AND alternate_name IN ('Diable')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Dire') AND alternate_name IN ('Dire')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Evewin') AND alternate_name IN ('Evewin')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Fiji') AND alternate_name IN ('Fiji')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Fishone') AND alternate_name IN ('Fishone')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Forlin') AND alternate_name IN ('Forlin')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Gabn') AND alternate_name IN ('Gabn')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Getback') AND alternate_name IN ('Getback')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Glfs') AND alternate_name IN ('Glfs')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='GuanGuan') AND alternate_name IN ('GuanGuan')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Guapi') AND alternate_name IN ('Guapi')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Haetae') AND alternate_name IN ('Haetae')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='HeiYue') AND alternate_name IN ('HeiYue')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Heru') AND alternate_name IN ('Heru')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Hizto') AND alternate_name IN ('Hizto')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='HotPot') AND alternate_name IN ('HotPot')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Hypnos') AND alternate_name IN ('Hypnos')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Iyy') AND alternate_name IN ('Iyy')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Jcom') AND alternate_name IN ('Jcom')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Juice') AND alternate_name IN ('Juice')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Jungoat') AND alternate_name IN ('Dante (Lan De-Rong)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Kamiloo') AND alternate_name IN ('Kamiloo')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Kazuto') AND alternate_name IN ('Kazuto')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Kemish') AND alternate_name IN ('Kemish')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Kerry') AND alternate_name IN ('Kerry')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Lancer') AND alternate_name IN ('Lancer')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='LazyFeel') AND alternate_name IN ('LazyFeel')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Leandrinn') AND alternate_name IN ('Leandrinn')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Leaper') AND alternate_name IN ('Leaper')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Leigg') AND alternate_name IN ('Leigg')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Levizin') AND alternate_name IN ('Levizin')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Liangchen') AND alternate_name IN ('Liangchen')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Loki (Lee Sang-min)') AND alternate_name IN ('Loki (Lee Sang-min)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Lqh') AND alternate_name IN ('Lqh')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='M0chi') AND alternate_name IN ('M0chi')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Maple Syrup') AND alternate_name IN ('Maple Syrup')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Marvin') AND alternate_name IN ('Marvin')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Mentality (Wei Guan-Zhen)') AND alternate_name IN ('Mentality (Wei Guan-Zhen)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Mihile') AND alternate_name IN ('Mihile')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Morttheus') AND alternate_name IN ('Morttheus')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Mun') AND alternate_name IN ('Mun')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Mxx') AND alternate_name IN ('Mxx')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Nanaue (Phùng Đức Tài)') AND alternate_name IN ('Nanaue (Phùng Đức Tài)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Neadz') AND alternate_name IN ('Neadz')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Ninefog') AND alternate_name IN ('Ninefog')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Nuo') AND alternate_name IN ('Nuo')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='OvO') AND alternate_name IN ('OvO')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='PO8') AND alternate_name IN ('PO8')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Pain (Lê Quốc Anh)') AND alternate_name IN ('Pain5')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Pool') AND alternate_name IN ('Pool')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Prey (Xu Jia-Hao)') AND alternate_name IN ('Prey (Xu Jia-Hao)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Pungyeon') AND alternate_name IN ('Pungyeon')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='RYue') AND alternate_name IN ('RYue')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Ranchen') AND alternate_name IN ('Ranchen')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Rineko') AND alternate_name IN ('Rineko')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Rooster') AND alternate_name IN ('Rooster')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='SYWJJ') AND alternate_name IN ('SYWJJ')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Saber (Song Dai-Lin)') AND alternate_name IN ('Saber (Song Dai-Lin)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Saint (Kang Sung-in)') AND alternate_name IN ('Saint (Kang Sung-in)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='ScaryJerry') AND alternate_name IN ('ScaryJerry')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='SiuLoong') AND alternate_name IN ('SiuLoong')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Siwoo') AND alternate_name IN ('Siwoo')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='SkewMond') AND alternate_name IN ('SkewMond')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Slayer (Kim Jin-young)') AND alternate_name IN ('Slayer (Kim Jin-young)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Smash (Sin Geum-jae)') AND alternate_name IN ('Smash (Sin Geum-jae)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Sounda') AND alternate_name IN ('Sounda')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Sovereign (Alexander Folley)') AND alternate_name IN ('Sovereign (Alexander Folley)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Srtty') AND alternate_name IN ('Srtty')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Steller') AND alternate_name IN ('Steller')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Stend') AND alternate_name IN ('Stend')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Sunlight (Jin Zi-Yang)') AND alternate_name IN ('Sunlight (Jin Zi-Yang)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='TT (Trần Quốc Thanh)') AND alternate_name IN ('TT789')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Tahahy') AND alternate_name IN ('Tahahy')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Tatu (Pedro Seixas)') AND alternate_name IN ('Tatu (Pedro Seixas)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='TheHank') AND alternate_name IN ('TheHank')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Toaster') AND alternate_name IN ('Toaster')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Tomio') AND alternate_name IN ('Tomio')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='VENDRICK') AND alternate_name IN ('VENDRICK')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Van (Kim Seung-hoo)') AND alternate_name IN ('Van (Kim Seung-hoo)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Vincenzo (Ha Seung-min)') AND alternate_name IN ('Vincenzo (Ha Seung-min)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Warrior (Nguyễn Phú Thanh)') AND alternate_name IN ('Warri0r')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Xiaocaobao') AND alternate_name IN ('Xiaocaoba0', 'Xiaocaobao')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Xiaoka') AND alternate_name IN ('Xiaoka')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Xiaorui') AND alternate_name IN ('Xiaorui')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Xinsheng') AND alternate_name IN ('Xinsheng')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Ycx') AND alternate_name IN ('Ycx')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Yojin') AND alternate_name IN ('Yojin')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Yomiya') AND alternate_name IN ('Yomiya')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Young (Young Choi)') AND alternate_name IN ('Young (Young Choi)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Yume (Châu Kim Bảo)') AND alternate_name IN ('Yume (Châu Kim Bảo)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Yummy') AND alternate_name IN ('Yummy')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='ZUIAN') AND alternate_name IN ('ZUIAN')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Zinie') AND alternate_name IN ('Zinie')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='24 (Seyfi Onat Aytemiz)') AND alternate_name IN ('24 (Seyfi Onat Aytemiz)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='404 (Zhi Choong Sheng)') AND alternate_name IN ('404 (Zhi Choong Sheng)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Alfred (Alfredo González)') AND alternate_name IN ('Alfred (Alfredo González)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Astra (Eduard Fritz)') AND alternate_name IN ('Astra (Eduard Fritz)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Bipolar (Ramsay Lochhead Devaraj)') AND alternate_name IN ('Bipolar (Ramsay Lochhead Devaraj)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='CarioK') AND alternate_name IN ('CarioK')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Colin') AND alternate_name IN ('Colin')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Crimson (Mert Koçak)') AND alternate_name IN ('Crimson (Mert Koçak)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Don Cholo (Sergio Salas)') AND alternate_name IN ('Don Cholo (Sergio Salas)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Endless (Xu Hao)') AND alternate_name IN ('Endless (Xu Hao)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Fzzf') AND alternate_name IN ('Fzzf')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Luon') AND alternate_name IN ('Luon')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='ICON') AND alternate_name IN ('ICON')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='JACTROLL') AND alternate_name IN ('JACTROLL')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Jiejie') AND alternate_name IN ('Jiejie')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='JoJo (Gabriel Dzelme)') AND alternate_name IN ('JoJo (Gabriel Dzelme)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Sasi (Yan Rui)') AND alternate_name IN ('Sasi (Yan Rui)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='KL (So Ka Lung)') AND alternate_name IN ('KL (So Ka Lung)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Kagame (Yap Li Aw)') AND alternate_name IN ('Kagame (Yap Li Aw)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Kite (Kim Yong-yeon)') AND alternate_name IN ('Kite (Kim Yong-yeon)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Last (Jeong Young-seok)') AND alternate_name IN ('Last (Jeong Young-seok)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='MAXI') AND alternate_name IN ('MAXI')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Mushroom (Zhang Xiao-Fu)') AND alternate_name IN ('Mushroom (Zhang Xiao-Fu)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='NL (Hsiung Wen-An)') AND alternate_name IN ('NL (Hsiung Wen-An)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Oddielan') AND alternate_name IN ('Oddielan')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Omni (Thomas Trinh Dung)') AND alternate_name IN ('Omni (Thomas Trinh Dung)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Only (Jordan Middleton)') AND alternate_name IN ('Only (Jordan Middleton)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Ozgur (Can Özgür Kara)') AND alternate_name IN ('Ozgur (Can Özgür Kara)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Ptt') AND alternate_name IN ('PePiiNeRO')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Henli') AND alternate_name IN ('RBY')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='ReM (Lee Hyeon-seo)') AND alternate_name IN ('ReM (Lee Hyeon-seo)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='RKR') AND alternate_name IN ('RKR')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Rise (Zhang Sheng)') AND alternate_name IN ('Rise (Zhang Sheng)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Smiley (Ludvig Granquist)') AND alternate_name IN ('Smiley (Ludvig Granquist)', 'XDSMILEY')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='SCARY (Artur Queiroz)') AND alternate_name IN ('SCARY (Artur Queiroz)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Sheep (Jamie Gallagher)') AND alternate_name IN ('Sheep (Jamie Gallagher)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Sigma (Brent de Laet)') AND alternate_name IN ('Sigma (Brent de Laet)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Sâyn (Aleš Gall)') AND alternate_name IN ('Sâyn (Aleš Gall)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Turtle (Gabriel Peixoto)') AND alternate_name IN ('Turtle (Gabriel Peixoto)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Vulcan (Philippe Laflamme)') AND alternate_name IN ('Vulcan (Philippe Laflamme)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Value (Ross Luppino)') AND alternate_name IN ('Value (Ross Luppino)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Vergil (Wang Hai-Han)') AND alternate_name IN ('Vergil (Wang Hai-Han)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='VIN (Trần Hoài Vinh)') AND alternate_name IN ('VIN (Trần Hoài Vinh)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Wall (Son Chang-hoon)') AND alternate_name IN ('Wall (Son Chang-hoon)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Wx') AND alternate_name IN ('Weixiao')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Xiaoweixiao') AND alternate_name IN ('Xiaoweixiao')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Yume (Danyll Jann Balisi)') AND alternate_name IN ('Yume (Danyll Jann Balisi)')) OR
(player_name_id=(SELECT id FROM players_player WHERE display_name='Yuri (Cha Hee-min)') AND alternate_name IN ('Yuri (Cha Hee-min)'))));
-- Downdating players --
UPDATE players_player SET age=21, display_name='24' WHERE display_name='24 (Seyfi Onat Aytemiz)';
UPDATE players_player SET display_name='404' WHERE display_name='404 (Zhi Choong Sheng)';
UPDATE players_player SET display_name='Alfred' WHERE display_name='Alfred (Alfredo González)';
UPDATE players_player SET display_name='Annie Bot' WHERE display_name='AnnieBot';
UPDATE players_player SET age=NULL, display_name='Antik' WHERE display_name='Oleg (Oleg Karkachev)';
UPDATE players_player SET age=28, display_name='Assassin' WHERE display_name='Sask';
UPDATE players_player SET age=27, display_name='Astra' WHERE display_name='Astra (Eduard Fritz)';
UPDATE players_player SET display_name='Balta129' WHERE display_name='Maximillion';
UPDATE players_player SET display_name='Bipolar' WHERE display_name='Bipolar (Ramsay Lochhead Devaraj)';
UPDATE players_player SET display_name='Blessing' WHERE display_name='Dispel';
UPDATE players_player SET display_name='BonO (Kim Gi-beom)' WHERE display_name='Bon0';
UPDATE players_player SET display_name='Cariok', residency='Brazil' WHERE display_name='CarioK';
UPDATE players_player SET display_name='CoLiN' WHERE display_name='Colin';
UPDATE players_player SET age=29, display_name='Crimson' WHERE display_name='Crimson (Mert Koçak)';
UPDATE players_player SET display_name='Crowno' WHERE display_name='Crowdy';
UPDATE players_player SET display_name='Dani' WHERE display_name='Dani (Phillex Bulanadi)';
UPDATE players_player SET age=20, display_name='Deant', residency='PCS' WHERE display_name='Deant9';
UPDATE players_player SET display_name='Don Cholo' WHERE display_name='Don Cholo (Sergio Salas)';
UPDATE players_player SET display_name='Endless' WHERE display_name='Endless (Xu Hao)';
UPDATE players_player SET age=20, display_name='Exakick' WHERE display_name='3XA';
UPDATE players_player SET age=32, display_name='FZZF' WHERE display_name='Fzzf';
UPDATE players_player SET age=19, display_name='Frostyy', real_name='José Eduardo Leal Pacheco', residency='Brazil' WHERE display_name='Frosty (José Eduardo)';
UPDATE players_player SET age=19, display_name='Gravepast' WHERE display_name='Grave';
UPDATE players_player SET display_name='HH (Lee Hyun-ho)' WHERE display_name='Luon';
UPDATE players_player SET display_name='Heal (Peng Jun-Jie)' WHERE display_name='Fate (Peng Jun-Jie)';
UPDATE players_player SET age=27, display_name='Icon' WHERE display_name='ICON';
UPDATE players_player SET age=25, display_name='Jactroll' WHERE display_name='JACTROLL';
UPDATE players_player SET age=22, display_name='JieJie' WHERE display_name='Jiejie';
UPDATE players_player SET age=25, display_name='Jojo (Gabriel Dzelme)', residency='Brazil' WHERE display_name='JoJo (Gabriel Dzelme)';
UPDATE players_player SET display_name='Juejuezi' WHERE display_name='Sasi (Yan Rui)';
UPDATE players_player SET age=23, display_name='KL' WHERE display_name='KL (So Ka Lung)';
UPDATE players_player SET age=22, display_name='Kabbie' WHERE display_name='Sanghyeon';
UPDATE players_player SET age=23, display_name='Kagame', residency='PCS' WHERE display_name='Kagame (Yap Li Aw)';
UPDATE players_player SET display_name='Kite' WHERE display_name='Kite (Kim Yong-yeon)';
UPDATE players_player SET display_name='Krastyel', residency='Brazil' WHERE display_name='Krastymel';
UPDATE players_player SET age=24, display_name='Kuroko (Trần Tuấn Anh)', residency='Vietnam' WHERE display_name='M1lo';
UPDATE players_player SET display_name='LanPeiFang' WHERE display_name='Kino';
UPDATE players_player SET age=26, display_name='Last' WHERE display_name='Last (Jeong Young-seok)';
UPDATE players_player SET age=23, display_name='Maxi', real_name='Magnus Kristensen' WHERE display_name='MAXI';
UPDATE players_player SET display_name='Me' WHERE display_name='Lucius';
UPDATE players_player SET age=23, display_name='Molto' WHERE display_name='Moesakr';
UPDATE players_player SET age=28, display_name='Mushroom' WHERE display_name='Mushroom (Zhang Xiao-Fu)';
UPDATE players_player SET display_name='NL' WHERE display_name='NL (Hsiung Wen-An)';
UPDATE players_player SET age=26, display_name='Oddie', residency='Latin America' WHERE display_name='Oddielan';
UPDATE players_player SET age=30, display_name='Omni' WHERE display_name='Omni (Thomas Trinh Dung)';
UPDATE players_player SET display_name='Only', residency='Asia Pacific' WHERE display_name='Only (Jordan Middleton)';
UPDATE players_player SET age=27, display_name='Optimus', residency='Vietnam' WHERE display_name='C7N';
UPDATE players_player SET age=NULL, display_name='Ouroboy', residency='Brazil' WHERE display_name='SkyBart';
UPDATE players_player SET display_name='Over T1me' WHERE display_name='OverT1me';
UPDATE players_player SET display_name='Ozgur' WHERE display_name='Ozgur (Can Özgür Kara)';
UPDATE players_player SET age=28, display_name='Ozora' WHERE display_name='Doggy';
UPDATE players_player SET display_name='Pepiinero', residency='Europe' WHERE display_name='Ptt';
UPDATE players_player SET age=23, display_name='Peraxy' WHERE display_name='Hespo';
UPDATE players_player SET age=24, display_name='Piloto', residency='Brazil' WHERE display_name='Pilot (Elvis Vergara)';
UPDATE players_player SET age=26, display_name='Pretty', residency='North America' WHERE display_name='PrettyGRE';
UPDATE players_player SET display_name='Qingsi' WHERE display_name='QingSi';
UPDATE players_player SET display_name='QiuQiu (Liang Jian)' WHERE display_name='Aqiu';
UPDATE players_player SET age=22, display_name='Rby', residency='Vietnam' WHERE display_name='Henli';
UPDATE players_player SET age=27, display_name='ReM' WHERE display_name='ReM (Lee Hyeon-seo)';
UPDATE players_player SET age=22, display_name='Reble' WHERE display_name='Kice';
UPDATE players_player SET age=22, display_name='Reeker' WHERE display_name='RKR';
UPDATE players_player SET display_name='Revenge (Mohannad Alrashdi)' WHERE display_name='REV';
UPDATE players_player SET age=21, display_name='Rise' WHERE display_name='Rise (Zhang Sheng)';
UPDATE players_player SET age=25, display_name='SMILEY (Ludvig Granquist)' WHERE display_name='Smiley (Ludvig Granquist)';
UPDATE players_player SET display_name='SUP (Cho Se-hee)' WHERE display_name='Motive';
UPDATE players_player SET age=18, display_name='Sabo (Trần Nguyễn Anh Khoa)', real_name='', residency='Vietnam' WHERE display_name='Hamin';
UPDATE players_player SET display_name='Scary (Artur Queiroz)', residency='Brazil' WHERE display_name='SCARY (Artur Queiroz)';
UPDATE players_player SET age=31, display_name='Sheep' WHERE display_name='Sheep (Jamie Gallagher)';
UPDATE players_player SET display_name='Sigma' WHERE display_name='Sigma (Brent de Laet)';
UPDATE players_player SET age=23, display_name='Steel' WHERE display_name='Wuming (Wang Xin)';
UPDATE players_player SET display_name='Sâyn' WHERE display_name='Sâyn (Aleš Gall)';
UPDATE players_player SET age=29, display_name='Turtle', residency='Brazil' WHERE display_name='Turtle (Gabriel Peixoto)';
UPDATE players_player SET age=21, display_name='Usopp (Nguyễn Quốc Mạnh)', real_name='', residency='Vietnam' WHERE display_name='Tomoe';
UPDATE players_player SET display_name='VULCAN (Philippe Laflamme)', residency='North America' WHERE display_name='Vulcan (Philippe Laflamme)';
UPDATE players_player SET display_name='Value' WHERE display_name='Value (Ross Luppino)';
UPDATE players_player SET age=29, display_name='Vasilii' WHERE display_name='Vas1lii';
UPDATE players_player SET display_name='Vergil' WHERE display_name='Vergil (Wang Hai-Han)';
UPDATE players_player SET display_name='Vince (Trần Hoài Vinh)', residency='Vietnam' WHERE display_name='VIN (Trần Hoài Vinh)';
UPDATE players_player SET age=NULL, display_name='Wall' WHERE display_name='Wall (Son Chang-hoon)';
UPDATE players_player SET age=31, display_name='WeiXiao' WHERE display_name='Wx';
UPDATE players_player SET display_name='Winner (Woo Joo-sung)' WHERE display_name='Wet';
UPDATE players_player SET age=29, display_name='XiaoWeiXiao' WHERE display_name='Xiaoweixiao';
UPDATE players_player SET display_name='Xiaoyu (Zhou Yu)' WHERE display_name='Alley';
UPDATE players_player SET display_name='Yume' WHERE display_name='Yume (Danyll Jann Balisi)';
UPDATE players_player SET age=23, display_name='Yuri' WHERE display_name='Yuri (Cha Hee-min)';
UPDATE players_player SET age=21, display_name='Yzi' WHERE display_name='Yge';
UPDATE players_player SET age=21, display_name='Zecas', real_name='César Berteli', residency='Brazil' WHERE display_name='ZekaS';
UPDATE players_player SET age=19, display_name='Zka1', residency='PCS' WHERE display_name='Zkai';
-- Removing new players --
DELETE FROM players_player WHERE display_name in (
'225',
'5t5',
'9God',
'Balder',
'Beluga',
'Cadence',
'Caliste',
'Carlsen',
'Casting',
'Charlotte (Xue Le-Hui)',
'ChinX',
'Claws',
'Climber',
'Cloud (Moon Hyeon-ho)',
'Courage (Jeon Hyun-min)',
'Czajek',
'Diable',
'Dire',
'Evewin',
'Fiji',
'Fishone',
'Forlin',
'Gabn',
'Getback',
'Glfs',
'GuanGuan',
'Guapi',
'Haetae',
'HeiYue',
'Heru',
'Hizto',
'HotPot',
'Hypnos',
'Iyy',
'Jcom',
'Juice',
'Jungoat',
'Kamiloo',
'Kazuto',
'Kemish',
'Kerry',
'Lancer',
'LazyFeel',
'Leandrinn',
'Leaper',
'Leigg',
'Levizin',
'Liangchen',
'Loki (Lee Sang-min)',
'Lqh',
'M0chi',
'Maple Syrup',
'Marvin',
'Mentality (Wei Guan-Zhen)',
'Mihile',
'Morttheus',
'Mun',
'Mxx',
'Nanaue (Phùng Đức Tài)',
'Neadz',
'Ninefog',
'Nuo',
'OvO',
'PO8',
'Pain (Lê Quốc Anh)',
'Pool',
'Prey (Xu Jia-Hao)',
'Pungyeon',
'RYue',
'Ranchen',
'Rineko',
'Rooster',
'SYWJJ',
'Saber (Song Dai-Lin)',
'Saint (Kang Sung-in)',
'ScaryJerry',
'SiuLoong',
'Siwoo',
'SkewMond',
'Slayer (Kim Jin-young)',
'Smash (Sin Geum-jae)',
'Sounda',
'Sovereign (Alexander Folley)',
'Srtty',
'Steller',
'Stend',
'Sunlight (Jin Zi-Yang)',
'TT (Trần Quốc Thanh)',
'Tahahy',
'Tatu (Pedro Seixas)',
'TheHank',
'Toaster',
'Tomio',
'VENDRICK',
'Van (Kim Seung-hoo)',
'Vincenzo (Ha Seung-min)',
'Warrior (Nguyễn Phú Thanh)',
'Xiaocaobao',
'Xiaoka',
'Xiaorui',
'Xinsheng',
'Ycx',
'Yojin',
'Yomiya',
'Young (Young Choi)',
'Yume (Châu Kim Bảo)',
'Yummy',
'ZUIAN',
'Zinie'
);
COMMIT;