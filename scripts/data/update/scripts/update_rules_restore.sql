BEGIN;
-- Restore metadata --
DELETE FROM meta_dataupdate WHERE id in (SELECT id FROM meta_dataupdate WHERE app='rules' ORDER BY date DESC LIMIT 1);
-- Reactivate teams --
UPDATE rules_rule SET active=TRUE WHERE key in (
'Friends Forever Gaming',
'SEM9',
'Team Curse',
'FearX',
'Kwangdong Freecs',
'Lyon Gaming (2013 Latin American Team)',
'PSG Talon',
'Rascal Jester',
'Movistar R7',
'Team Whales',
'Vikings Esports (2023 Vietnamese Team)',
'Estral Esports',
'Fluxo',
'Vivo Keyd',
'Team Secret (Vietnamese Team)',
'Six Karma',
'Team oNe eSports',
'DG Esports',
'Mineski',
'GamingGear.eu',
'MAD Lions KOI',
'Team Empire (Malaysian Team)',
'Curse Academy',
'Azules Esports',
'SEM9 WPE',
'Isurus',
'ISC Pro Team',
'Royal Youth'
);
-- Delete all new valid players --
DELETE FROM rules_rule_valid_players WHERE id in (SELECT id FROM rules_rule_valid_players WHERE (
(rule_id=(SELECT id FROM rules_rule WHERE key='BNK FEARX') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Execute', 'Dove', 'Ten10', 'Willer', 'Meaning', 'Career', 'Kael (Kim Jin-hong)', 'Lonely (Han Gyu-joon)', 'Ryan', 'Raptor (Jeon Eo-jin)', 'HamBak', 'Daystar', 'Punch', 'Hollow', 'OnFleek', 'Route', 'Prove (Son Min-hyeong)', 'Clear (Song Hyeon-min)', 'FATE (Yoo Su-hyeok)', 'Prince (Lee Chae-hwan)', 'Soboro', 'Summit', 'Wizer', 'SoaR', 'Leo (Han Gyeo-re)', 'GorillA', 'Ghost (Jang Yong-jun)', 'Duro', 'Burdol', 'Ice (Yoon Sang-hoon)', 'Hipo', 'Hype (Byeon Jeong-hyeon)', 'Effort', 'VicLa', 'Joker (Cho Jae-eup)', 'Hena', 'Howling', 'Croco', 'Diable', 'Crush', 'Clozer', 'Teddy', 'Envyy', 'Sanghyeon', 'Bonnie', 'Kellin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Bren Esports') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Aimed', 'Dani (Phillex Bulanadi)', 'Marsh', 'Sayonara', 'Kanji'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='DN Freecs') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('CvMax', 'Hoit', 'Lancer', 'Kuro', 'Ellim', 'Hoon (Lee Jang-hoon)', 'Dread (Lee Jin-hyeok)', 'Keine', 'Fly (Song Yong-jun)', 'Taeyoon', 'Rynder', 'Kiin', 'Test Sup', 'Cuzz', 'Pyosik', 'Bull', 'DuDu (Lee Dong-ju)', 'Leaper', 'Minit', 'Untara', 'SeongHwan', 'Mowgli', 'Jun (Yoon Se-jun)', 'Andil', 'Aiming', 'Ikssu', 'Mickey (Son Young-min)', 'Lindarang', 'Life', 'Moham', 'Ucal', 'SSUN (Kim Tae-yang)', 'Spirit', 'Savila', 'TusiN', 'Berserker (Kim Min-cheol)', 'Citrus', 'Lira', 'Ssol', 'Bang', 'FATE (Yoo Su-hyeok)', 'YoungJae', 'Kramer', 'DDoiV', 'Summit', 'Proud', 'IlllIma', 'Slayer (Kim Jin-young)', 'Sangyoon', 'Leo (Han Gyeo-re)', 'MapSSi', 'SnowFlower', 'Mystic', 'Pungyeon', 'Ben', 'MaRin', 'Lehends', 'Teddy', 'BuLLDoG (Lee Tae-young)', 'Jelly (Son Ho-gyeong)', 'Quantum (Son Jeong-hwan)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Disguised') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('EXyu', 'Abbedagge', 'Castle (Cho Hyeon-seong)', 'Huhi', 'ScaryJerry'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Fluxo W7M') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Marvin', 'Hauz', 'JoJo (Gabriel Dzelme)', 'Trigo (Matheus Trigo)', 'Hidan', 'Kiari', 'Kojima', 'Shini', 'Drakehero', 'Guigs', 'Scamber', 'Disamis', 'Fuuu', 'Tay', 'Brance', 'Sting', 'Forlin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Isurus Estral') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Leza', 'Emp', 'Snaker', 'Takeover', 'Badmilk', 'Lesmart', 'Megajp', 'Grell', 'Mireu', 'Gaeng', 'Kindless', 'Bvoy', 'Dinamox', 'KinGi', 'Genthix', 'Zeicro', 'Oddielan', 'Jirall', 'Archer (Lee Keun-hee)', 'Chelitw', 'LiquidDiego', 'Shadow (Facundo Cuello)', 'Ackerman (Gabriel Aparicio)', 'Newbie', 'Style (Ignacio Pezoa)', 'NerzhuL', 'Seiya', 'Pride (Franco Sanzana)', 'Fear (Joel Reyna)', 'Bugi', 'Naryt', 'Burdol', 'Bola', 'Flare (Franco Pombo)', 'Gavotto', 'Zelt', 'Nipphu', 'Pan (Andres Bonilla)', 'Zothve', 'Seize', 'Acce', 'Prophuth', 'Wardz', 'Clatos', 'Hans SamD', 'Buggax', 'Demy', 'Mightybear', 'Shu Hari', 'Josedeodo', 'Slow', 'Kirito (Nicolás Olavarría)', 'Aquasonic', 'Froststrike', 'Cody', 'Loopy', 'Kaze (Lucas Fe)', 'QQMore', 'Gastruks', 'Mia', 'ADD', 'WARANGELUS', 'Poss', 'Zerito', 'MANTARRAYA', 'Tierwulf', 'KouZZe', 'Follow', 'Lyg', 'Jelly (Son Ho-gyeong)', 'OnFleek'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='LYON (2024 American Team)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Acce', 'Stray (Roberto Guallichico)', 'WhiteLotus', 'Hika', 'Leza', 'Kice', 'Kraki', 'Choisix', 'Tulz', 'Renyu', 'Arce', 'Buggax', 'Meaning', 'Snaker', 'SoHwan', 'Nobody (Nicolás Ale)', 'SPOOKY (Miroslav Gochev)', 'Keine', 'Shu Hari', 'Cepted', 'Licorice', 'Grell', 'Xypherz', 'Mireu', 'Josedeodo', 'Uri', 'Slow', 'Genthix', 'Lava', 'Daiky', 'Ophelia', 'Baula', 'Zeicro', 'Oddielan', 'Jirall', 'Maplestreet', 'Ray', 'Cody', 'Limitationss', 'Shadow (Facundo Cuello)', 'Thyak', 'Summit', 'NerzhuL', 'Seiya', 'WARANGELUS', 'Manu', 'MarioMe', 'ChinX', 'Porky (Gerardo Cuamea)', 'Mataz', 'Aloned', 'Lyonz', 'Dimitry', 'Hena', 'Enga', 'Mir (Park Mi-reu)', 'Bong (Cho Bo-woong)', 'Legion (Jorge Valencia)', 'Ceo', 'Saint (Kang Sung-in)', 'Dodo', 'IgnaVilu', '5kid', 'H4ckerv2', 'OnFleek'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='MGN Vikings Esports') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Arrietty', 'Henli', 'Hinn', 'OPG1', 'Taki (Đinh Anh Tài)', 'Blazes', 'XuHao', 'Meliodas (Hoàng Tiến Nhật)', 'Gury', 'Aomine', 'Kati', 'Ren', 'Fireblade', 'Naul', 'Calm (Đinh Trọng Quyết)', 'YT', 'Light (Nguyễn Đức Minh)', 'BeanJ', 'H3', 'SiuLoong', 'Kairi', 'Penguin (Nguyễn Đăng Khoa)', 'Palette', 'Sty1e', 'Vit (Lê Hoài An)', 'Shogun (Nguyễn Văn Huy)', 'Zeros', 'Hani', 'Bigkoro', 'CBL', 'Pampy', 'Jad', 'Tomrio', 'Beeone', 'Ribell', 'Hasmed', 'Richard I', 'Osas', 'Eragon (Nguyễn Ngọc Huy)', 'Zin', 'Kratos', 'Shinie', 'Nanaue (Phùng Đức Tài)', 'Froggy', 'SofM', 'Coated', 'Venus', 'Bie', 'Pun', 'Slay', 'Qeo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Movistar KOI') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Nisbeth', 'Supa', 'Carzzy', 'Xerxe', 'Wunder', 'Sander', 'Orome', 'Shad0w', 'Sencux', 'Mikyx', 'Odoamne', 'Elyoya', 'Fresskowy', 'Kold', 'Chomi', 'UNF0RGIVEN', 'Jojopyun', 'Alvaro (Álvaro Fernández)', 'Hylissang', 'Hobbler', 'Kobbe', 'Myrwn', 'Tore', 'Kasing', 'Kaiser', 'Nisqy', 'Suppa', 'Vizicsacsi', 'Chasy', 'Julaxe', 'RKR', 'Armut', 'Humanoid'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='TALON (Hong Kong Team)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Burry', 'Wen (Syu Nai-Wun)', 'Doggo', 'ChiCh1', 'Zkai', 'TNS', 'Kongyue', 'Bay', 'Betty', 'Gori', 'Woody', 'Uniboy', 'Candy (Kim Seung-ju)', 'Kaiwing', 'River (Kim Dong-woo)', 'Tank', 'Xin (Ye Shang-Hsin)', 'Karsa', 'Juhan', 'JunJia', 'Hanabi (Su Chia-Hsiang)', 'Azhi', 'FoFo', 'Unified', 'Dee', 'Husha', 'Maple (Huang Yi-Tang)', 'Wako'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Team Secret Whales') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Arrietty', 'Dove', 'Clear (Trịnh Ngọc Anh Tuấn)', 'XuHao', 'Pake', 'Skewed', 'Aomine', 'Eagle', 'BeanJ', 'Killerqueen', 'Yado', 'Sorn', 'Ikaros (Lư Chấn Hưng)', 'SiuLoong', 'Kairi', 'Hani', 'DNK', 'Cacon', 'CBL', 'Pampy', 'Taurus', 'Kit', 'Aress', 'Hiro02', 'Steller', 'Jerry (Nguyễn Tiến Duy)', 'Zin', 'Heaven (Quách Đăng Phi)', 'KemKen', 'Boong', 'Coated', 'Zica', 'Akeno', 'Bie', 'Slayder', 'Jcom', 'Gloryy', 'Tsu', 'Hankay', 'Sparda', 'Taki (Đinh Anh Tài)', 'Hari', 'Potm', 'Blazes', 'Yusah', 'Claws', 'Celebrity', 'Hieu3', 'Harky', 'Hizto', 'Shine (Tôn Nguyễn Phi Long)', 'Kazuto', 'Milano', 'Warrior (Nguyễn Phú Thanh)', 'RonOP', 'Calm (Đinh Trọng Quyết)', 'Artemis (Trần Quốc Hưng)', 'H3', 'Pain (Lê Quốc Anh)', 'Palette', 'Penguin (Nguyễn Đăng Khoa)', 'Simon (Dương Thanh Hoà)', 'Vit (Lê Hoài An)', 'C7N', 'Dire', 'Hasmed', 'Bisbo', 'Warzone', 'Sounda', 'Kratos', 'Qiang', 'Venus', 'Bun', 'BaRoiBeo', 'Yin', 'Artifact', 'Eddie', 'Elio'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='225') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hexflash', 'Zhovy', 'Doraemon (Joshua Wong)', 'Styx (Samuel Blanchard)', 'SHAKa (Yang Zhen-Yu)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='5t5') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('OvO', 'Xinsheng', 'Cyku', 'Fishone'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='9God') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Woodon', 'Gabn', 'Yojin', 'Sovereign (Alexander Folley)', 'Reufury', 'VENDRICK'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Balder') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yoshino', 'Playcool', 'Draktharr', 'Soraaa', 'Ouzi'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Beluga') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mxx', 'Taeyoon', 'Karis', 'Vampire', 'TENG', 'Stay (Guo Yi-Yang)', 'BuLuKaKa', 'Tianzhen'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Cadence') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Woodon', 'Reufury', 'VENDRICK', '9God', 'Gabn', 'Sovereign (Alexander Folley)', 'Yojin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Caliste') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Vladi', 'Yike', 'Canna', 'Targamas'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Carlsen') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Flakked', 'Stend', 'Sheo', 'Kamiloo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Casting') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('YoungJae', 'Zinie', 'PerfecT (Lee Seung-min)', 'Pyosik', 'Bdd', 'Deft', 'BeryL', 'Paduck', 'Peter (Jeong Yoon-su)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Charlotte (Xue Le-Hui)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Flying', 'Yan (Deng Guo-Ce)', 'Starfire', 'Banye'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='ChinX') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Seiya', 'Buggax', 'IgnaVilu', '5kid', 'Mir (Park Mi-reu)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Claws') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kazuto', 'Dove', 'RonOP', 'Artemis (Trần Quốc Hưng)', 'Hasmed', 'Hieu3', 'Sounda', 'C7N'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Climber') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Shaoye', 'Sasi (Yan Rui)', 'Ycx', 'Xqw', 'Mitsuki'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Cloud (Moon Hyeon-ho)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Smash (Sin Geum-jae)', 'Gumayusi', 'Vincenzo (Ha Seung-min)', 'Poby', 'Oner', 'Haetae'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Courage (Jeon Hyun-min)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('FATE (Yoo Su-hyeok)', 'Gaeng', 'Evi', 'Marble'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Czajek') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Naak Nako', 'Carzzy', 'Hylissang', 'Lyncas'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Diable') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Clear (Song Hyeon-min)', 'VicLa', 'Raptor (Jeon Eo-jin)', 'Daystar', 'Soboro', 'Bonnie', 'Envyy', 'Career', 'Kellin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Dire') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hizto', 'Taki (Đinh Anh Tài)', 'Hiro02', 'Steller', 'Eddie'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Evewin') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kurak', 'Leemas', 'Thien', 'Fighto', 'Shernfire'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Fishone') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('OvO', 'Xinsheng', 'Cyku', '5t5'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Forlin') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Trigo (Matheus Trigo)', 'Shini', 'Kiari', 'Scamber', 'Fuuu'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Gabn') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Woodon', 'Yojin', 'Sovereign (Alexander Folley)', 'Reufury', 'VENDRICK', '9God'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Glfs') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Vampire', 'Neny', 'ZUIAN', 'YSKM', 'Ahn'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='GuanGuan') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Abyss (Lin Po-Reng)', 'HotPot', 'Cheng9', 'NuL1', 'Kerry'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Guapi') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mfis', 'Shinki', 'M0chi', 'Katsurii'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Haetae') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Smash (Sin Geum-jae)', 'Gumayusi', 'Vincenzo (Ha Seung-min)', 'Poby', 'Oner', 'Cloud (Moon Hyeon-ho)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='HeiYue') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Coten', 'XBY', 'Xiaoka', 'Sunlight (Jin Zi-Yang)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Heru') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Liangchen', 'Monki', 'Baiye', 'Xiaoxia'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hizto') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Dire', 'Taki (Đinh Anh Tài)', 'Hiro02', 'Steller', 'Eddie'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='HotPot') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Abyss (Lin Po-Reng)', 'Cheng9', 'GuanGuan', 'NuL1', 'Kerry'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Iyy') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zhiqiuyi', 'SYWJJ', 'Yomiya', 'Sorrow (Li De-Ming)', 'Mentality (Wei Guan-Zhen)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Jcom') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hiro02', 'Yusah', 'Aress', 'Warrior (Nguyễn Phú Thanh)', 'Pain (Lê Quốc Anh)', 'Aomine', 'Taki (Đinh Anh Tài)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Juice') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tangyuan', 'Zdz', 'Huanfeng', 'Ming (Shi Sen-Ming)', 'Geju', 'XBY', 'Wei (Yan Yang-Wei)', 'Xzz'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Jungoat') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Ranchen', 'Yuanyue', 'Ljun', 'Xiaohanbao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kamiloo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Flakked', 'Stend', 'Sheo', 'Carlsen'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kazuto') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Dove', 'RonOP', 'Artemis (Trần Quốc Hưng)', 'Hasmed', 'Claws', 'Hieu3', 'Sounda', 'C7N'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kemish') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Duro', 'Chovy', 'About', 'Kiin', 'Canyon'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kerry') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Abyss (Lin Po-Reng)', 'HotPot', 'Cheng9', 'GuanGuan', 'NuL1'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Lancer') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Quantum (Son Jeong-hwan)', 'Pungyeon', 'Slayer (Kim Jin-young)', 'DDoiV'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='LazyFeel') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Rich (Lee Jae-won)', 'Frog (Lee Min-hoi)', 'Sponge', 'Ucal', 'Pleata', 'Teddy', 'Andil', 'Kyeahoo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Leandrinn') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('MicaO', 'Cavalo', 'Levizin', 'Makes', 'Pilot (Elvis Vergara)', 'Drakehero'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Leaper') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Cuzz', 'Andil', 'BuLLDoG (Lee Tae-young)', 'Quantum (Son Jeong-hwan)', 'DuDu (Lee Dong-ju)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Leigg') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yummy', 'PO8', 'Darwin', 'Erha', 'XLiang'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Levizin') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('MicaO', 'Cavalo', 'Makes', 'Leandrinn', 'Pilot (Elvis Vergara)', 'Drakehero'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Liangchen') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Junhao', 'Monki', 'Xiaoxia', 'Heru', 'Baiye', 'Yxl'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Loki (Lee Sang-min)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Vulcan (Philippe Laflamme)', 'Thanatos (Park Seung-gyu)', 'Zven', 'Blaber'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Lqh') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaorui', 'TheHank', 'Yxl', 'Luoyiyu'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='M0chi') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mfis', 'Shinki', 'Guapi', 'Katsurii'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Maple Syrup') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Chirp', 'Hoopa', 'Prey (Xu Jia-Hao)', 'Findo', 'Tomasino (Tomas Silva Pereira)', 'Nox1'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Marvin') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Guigs', 'Hidan', 'Drakehero', 'Fuuu'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Mentality (Wei Guan-Zhen)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zhiqiuyi', 'Iyy', 'SYWJJ', 'Yomiya', 'Sorrow (Li De-Ming)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Mihile') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('DnDn', 'Calix (Syun Hyun-bin)', 'GuGer', 'Callme', 'Vital', 'Sylvie', 'Jiwoo', 'Fisher (Lee Jeong-tae)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Morttheus') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kisee', 'Disamis', 'Boal', 'Trymbi'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Mun') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Ganks', 'Jauny', 'Vahvel', 'Nobody (Nicolás Ale)', 'Beenie'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Mxx') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Beluga', 'TENG', 'Stay (Guo Yi-Yang)', 'BuLuKaKa'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Nanaue (Phùng Đức Tài)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kati', 'Bie', 'Gury', 'Shogun (Nguyễn Văn Huy)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Neadz') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Leza', 'ZOEN (Enzo Ganino)', 'Grell', 'Trigger (Kim Eui-joo)', 'TopLop'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ninefog') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Chips (Gong Jia-Hao)', 'Nuo', 'WuNai', 'Cc (Yan Cheng-Chao)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Nuo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Chips (Gong Jia-Hao)', 'Ninefog', 'WuNai', 'Cc (Yan Cheng-Chao)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='OvO') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xinsheng', 'Cyku', 'Fishone', '5t5'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='PO8') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yummy', 'Darwin', 'Erha', 'Leigg', 'XLiang'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Pain (Lê Quốc Anh)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hiro02', 'Jcom', 'Yusah', 'Warrior (Nguyễn Phú Thanh)', 'Aress', 'Aomine', 'Taki (Đinh Anh Tài)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Pool') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Wangxiao', 'JiaQi', 'Naiyou', 'Niket'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Prey (Xu Jia-Hao)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Chirp', 'Tomasino (Tomas Silva Pereira)', 'Nox1', 'Hoopa', 'Findo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Pungyeon') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Pyosik', 'DDoiV', 'Berserker (Kim Min-cheol)', 'Life', 'Lancer', 'Slayer (Kim Jin-young)', 'BuLLDoG (Lee Tae-young)', 'Quantum (Son Jeong-hwan)', 'DuDu (Lee Dong-ju)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='RYue') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Relhia', 'Lilv', '1116', 'Cha9', 'Kongyue'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ranchen') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yuanyue', 'Ljun', 'Xiaohanbao', 'Jungoat'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Rineko') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Voice', 'Praedyth', 'Gunkrab', 'Goodo', '4ever'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Rooster') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Grizzly', 'Zeka (Kim Geon-woo)', 'Viper (Park Do-hyeon)', 'Delight'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='SYWJJ') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zhiqiuyi', 'Iyy', 'Yomiya', 'Sorrow (Li De-Ming)', 'Mentality (Wei Guan-Zhen)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Saber (Song Dai-Lin)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Junhao', 'Rosielove', '1Jiang', 'Wako'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Saint (Kang Sung-in)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Licorice', 'Lyonz', 'Hena', 'Oddielan'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='ScaryJerry') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Castle (Cho Hyeon-seong)', 'Abbedagge', 'Huhi', 'EXyu'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='SiuLoong') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kratos', 'Kati', 'Dove', 'Artemis (Trần Quốc Hưng)', 'Hasmed', 'Hieu3', 'Gury', 'Sounda', 'Shogun (Nguyễn Văn Huy)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Siwoo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Aiming', 'Rich (Lee Jae-won)', 'BeryL', 'Kiin', 'Lucid (Choi Yong-hyeok)', 'ShowMaker', 'Zeus', 'Morgan'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='SkewMond') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hans Sama', 'Labrov', 'Caps', 'BrokenBlade'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Slayer (Kim Jin-young)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Lancer', 'Pungyeon', 'Quantum (Son Jeong-hwan)', 'DDoiV'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Smash (Sin Geum-jae)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Doran (Choi Hyeon-joon)', 'Gumayusi', 'Keria', 'Faker', 'Vincenzo (Ha Seung-min)', 'Poby', 'Haetae', 'Cloud (Moon Hyeon-ho)', 'Oner'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Sounda') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kazuto', 'Dove', 'RonOP', 'Artemis (Trần Quốc Hưng)', 'Hasmed', 'SiuLoong', 'Claws', 'Hieu3', 'C7N'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Sovereign (Alexander Folley)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Woodon', 'Gabn', 'Yojin', 'Reufury', 'VENDRICK', '9God'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Srtty') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Keine', 'Isles', 'Sheiden', 'Tomo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Steller') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hizto', 'Dire', 'Hiro02', 'Eddie', 'Taki (Đinh Anh Tài)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Stend') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Flakked', 'Sheo', 'Carlsen', 'Kamiloo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Sunlight (Jin Zi-Yang)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Coten', 'HeiYue', 'XBY', 'Xiaoka'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='TT (Trần Quốc Thanh)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yume (Châu Kim Bảo)', 'Richard I', 'Tahahy', 'Slowz', 'Meliodas (Hoàng Tiến Nhật)', 'Pun'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Tahahy') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yume (Châu Kim Bảo)', 'Richard I', 'Meliodas (Hoàng Tiến Nhật)', 'TT (Trần Quốc Thanh)', 'Slowz', 'Pun'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Tatu (Pedro Seixas)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Ayu (Andrey Saraiva)', 'JoJo (Gabriel Dzelme)', 'Tutsz', 'Guigo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='TheHank') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Lqh', 'Xiaorui', 'Yxl', 'Luoyiyu'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Tomio') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Bvoy', 'Insanity', 'Zeyzal', 'Bugi', 'FakeGod'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='VENDRICK') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Woodon', 'Gabn', 'Yojin', 'Sovereign (Alexander Folley)', 'Reufury', '9God'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Van (Kim Seung-hoo)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Washidai', 'Eugeo', 'Ino', 'Ssol'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Vincenzo (Ha Seung-min)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Smash (Sin Geum-jae)', 'Gumayusi', 'Poby', 'Oner', 'Haetae', 'Cloud (Moon Hyeon-ho)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Warrior (Nguyễn Phú Thanh)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hiro02', 'Jcom', 'Yusah', 'Aress', 'Pain (Lê Quốc Anh)', 'Aomine', 'Taki (Đinh Anh Tài)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Xiaocaobao') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('KaKAO', 'Langx', 'Nayuki', 'Yge', 'Puff (Ding Wang)', 'Babo', 'Eisley', 'Wind (Chen Guo-Feng)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Xiaoka') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Coten', 'HeiYue', 'XBY', 'Sunlight (Jin Zi-Yang)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Xiaorui') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Lqh', 'TheHank', 'Yxl', 'Luoyiyu'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Xinsheng') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('OvO', 'Cyku', 'Fishone', '5t5'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ycx') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Shaoye', 'Sasi (Yan Rui)', 'Climber', 'Xqw', 'Mitsuki'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Yojin') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Woodon', 'Gabn', 'Sovereign (Alexander Folley)', 'Reufury', 'VENDRICK', '9God'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Yomiya') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zhiqiuyi', 'Iyy', 'SYWJJ', 'Sorrow (Li De-Ming)', 'Mentality (Wei Guan-Zhen)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Yume (Châu Kim Bảo)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Richard I', 'Meliodas (Hoàng Tiến Nhật)', 'TT (Trần Quốc Thanh)', 'Slowz', 'Tahahy', 'Pun'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Yummy') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('PO8', 'Darwin', 'Erha', 'Leigg', 'XLiang'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='ZUIAN') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('YSKM', 'Vampire', 'Ahn', 'Glfs', 'Neny'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Zinie') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Casting', 'YoungJae', 'Paduck', 'Peter (Jeong Yoon-su)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Worlds 2024 Participant') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Doran (Choi Hyeon-joon)', 'Supa', 'Zika', 'BrokenBlade', 'Canyon', 'Tarzan (Lee Seung-yong)', 'Oner', 'Bwipo', 'Kuri', 'Impact', 'Noah (Oh Hyeon-taek)', 'Faker', 'Levi', 'Kiin', '369', 'Busio', 'Zeus', 'Xun', 'Elyoya', 'Knight (Zhuo Ding)', 'TitaN', 'Creme', 'Fresskowy', 'Keria', 'Hang', 'Viper (Park Do-hyeon)', 'Caps', 'Oscarinin', 'Wizer', 'JunJia', 'Azhi', 'CarioK', 'Xiaohu', 'Kingen', 'Bin (Chen Ze-Bin)', 'Jun (Yoon Se-jun)', 'Maple (Huang Yi-Tang)', 'Yeon (Sean Sung)', 'Elk', 'DyNquedo', 'Breathe', 'Humanoid', 'Aiming', 'Scout', 'Quad', 'Emo', 'CoreJJ', 'Moham', 'Meiko', 'Wei (Yan Yang-Wei)', 'Tian', 'Massu', 'Gumayusi', 'Betty', 'Weiwei', 'ShowMaker', 'Woody', 'Mikyx', 'Chovy', 'Delight', 'Kiaya', 'GALA', 'Crisp', 'Yike', 'Alvaro (Álvaro Fernández)', 'EasyLove', 'JackeyLove', 'ON', 'APA (Eain Stearns)', 'Peanut', 'Myrwn', 'UmTi', 'Peyz', 'Hans Sama', 'Lehends', 'Lucid (Choi Yong-hyeok)', 'Inspired', 'Zeka (Kim Geon-woo)', 'Razork', 'Light (Wang Guang-Yu)', 'Elio'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='100 Thieves') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tomo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='AXIZ CREST') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Van (Kim Seung-hoo)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Antic Esports') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Incursio', 'Raes', 'Destiny (Mitchell Shaw)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Anyone''s Legend') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Flandre', 'Ale', 'Ljun', 'Ranchen', 'Tarzan (Lee Seung-yong)', 'Jungoat'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Axis Empire') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mexi', 'Shiromine', 'Ribena'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Bilibili Gaming') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Liangchen', 'Monki', 'TheHank', 'Heru', 'Wei (Yan Yang-Wei)', 'Luoyiyu', 'Lqh', 'Xiaorui'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='CERBERUS Esports (Vietnamese Team)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yume (Châu Kim Bảo)', 'Meliodas (Hoàng Tiến Nhật)', 'TT (Trần Quốc Thanh)', 'Tahahy'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='CTBC Flying Oyster') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Doggo', 'Driver', 'HongQ', 'Kaiwing', 'JunJia'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Chiefs Esports Club') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Leemas', 'Luon', 'JimieN'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Cloud9') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Thanatos (Park Seung-gyu)', 'Loki (Lee Sang-min)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='DRX') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Rich (Lee Jae-won)', 'LazyFeel', 'Ucal', 'Andil'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Deep Cross Gaming') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Feng (Chen Chun-Feng)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='DetonatioN FocusMe') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kakkun', 'Guwon'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Dignitas') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Srtty', 'Keine', 'Licorice', 'Spica', 'Sheiden', 'Zven'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Dire Wolves') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Guapi', 'M0chi', 'Chungy', 'Meifan'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Dplus KIA') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Siwoo', 'Moham'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='EDward Gaming') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zdz', 'Xiaohao', 'Angel (Xiang Tao)', 'Wink', 'Cryin', 'Assum'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='FENNEL') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Scottlyk', 'Ninja', 'Nap', 'Challenger', 'ApaMEN', 'Kinatu', 'Rascal', 'Meron', 'Yuki (Yuki Takahashi)', 'Cogcog', 'Ino', 'Corn (Hong Jae-hee)', 'Inu', 'Fanxy', 'Rkp', 'Alleycat', 'Lillebelt', 'Secret (Park Ki-sun)', 'Albis (Shuhei Yamaguchi)', 'Rainbrain', 'Hollis', 'ViviD', 'Wyvern', 'Nagi', 'HW4NG', 'Arfoad', 'ISeNN', 'Zerost', 'GalB', 'Aripo', 'Atyamomo', 'Lavie', 'NoA (Shunya Honda)', 'Pinnnk', 'Art'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='FURIA') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zzk (Kwon Hee-won)', 'Guigo', 'Wiz', 'JoJo (Gabriel Dzelme)', 'Tatu (Pedro Seixas)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='FURY Global') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Maple Syrup', 'Prey (Xu Jia-Hao)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='FlyQuest') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Quad'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Fnatic') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mikyx'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Frank Esports') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Wako'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Fukuoka SoftBank HAWKS gaming') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('FATE (Yoo Su-hyeok)', 'Courage (Jeon Hyun-min)', 'Gaeng'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='FunPlus Phoenix') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zhiqiuyi', 'Bat (Gao Jun)', 'Zdz', 'Iyy', 'Shad0w', 'Yomiya', 'Mentality (Wei Guan-Zhen)', 'Sheer', 'SYWJJ', 'Jwei'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='G2 Esports') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('SkewMond', 'Labrov'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='GAM Esports') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Aress', 'Artemis (Trần Quốc Hưng)', 'Neo (Toàn Trần)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='GIANTX') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Noah (Oh Hyeon-taek)', 'Lot', 'Closer (Can Çelik)', 'Jun (Yoon Se-jun)', 'Juhan', 'Th3Antonio'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Gen.G') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kemish', 'Duro', 'About'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Gravity (North American Team)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tsatsulow', 'Jaximus', 'Cris', 'Fabbbyyy', 'OneBadBrad', 'Mabrey', 'Rhux'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ground Zero Gaming') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Evewin', 'Fighto', 'Kurak'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='HELL PIGS') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Abyss (Lin Po-Reng)', 'Cheng9', 'HotPot', 'GuanGuan', 'NuL1', 'Kerry'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hanwha Life Esports') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Rooster', 'Zeus'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='INFINITY') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Leza', 'Grell', 'TopLop', 'Trigger (Kim Eui-joo)', 'Nia (Woo Jun-sung)', 'Neadz'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='ION Global Esports') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Styx (Samuel Blanchard)', 'SHAKa (Yang Zhen-Yu)', '225'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Invictus Gaming') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('GALA', 'Vampire', 'Jiejie', 'Glfs', 'ZUIAN', 'Meiko'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='JD Gaming') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Scout', 'Xun', 'Peyz', 'Ale'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='KT Rolster') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('YoungJae', 'Zinie', 'Casting', 'Deokdam', 'Paduck', 'Peter (Jeong Yoon-su)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kanga Esports') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Cadence', 'VENDRICK', '9God', 'Gabn', 'Sovereign (Alexander Folley)', 'Yojin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kaos Latin Gamers') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xypherz', 'Koughi', 'Feitan', 'N N', 'Tyr', 'Cody'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Karmine Corp') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Caliste', 'Yike'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='LGD Gaming') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Sasi (Yan Rui)', 'Nuo', 'Cc (Yan Cheng-Chao)', 'Ycx', 'Ninefog', 'Climber', 'Mitsuki', 'WuNai'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='LNG Esports') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('OvO', 'Xinsheng', 'Cyku', 'Photic', 'Haichao', '5t5', 'Zhuo', 'Fishone'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='LOUD') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Winsome', 'Wiz'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Leviatan') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Nobody (Nicolás Ale)', 'Mun', 'Vahvel', 'Beenie', 'Ceo', 'SCARY (Artur Queiroz)', 'Zothve', 'Cody', 'ProDelta'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Liberty') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Levizin', 'Leandrinn'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Liyab Esports') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Noel (Noel Cruz)', 'Nickstah', 'Kulit', 'Sepi', 'Yume (Danyll Jann Balisi)', 'CED', 'Snoy', 'Zensho', 'Jjun'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Los Grandes') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Takeshi', 'Prb', 'Brucer', 'Panj', 'Vitin', 'Lactea', 'PbO', 'KLOWNY', 'SkyBart', 'VVvert', '4LaN', 'Marfz', 'Ryuzaki'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Lowkey Esports.Vietnam') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('SunSieu', 'Sya', 'Kriss', 'QTV', 'Secr3t', 'Sergh', 'Sofs', 'Heaven (Quách Đăng Phi)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='MAMMOTH') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Rineko', '4ever', 'Praedyth', 'Gunkrab'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='MGN Blue Esports') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('TQ', 'Phuc1', 'VIN (Trần Hoài Vinh)', 'Sparda'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='NASR eSports Turkey') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Dumbledoge', 'BrokenBlade', 'Pulse (Ali Aybirdi)', 'Malrang', 'GBM', 'Sevi', 'Anduril', 'Cepted', 'HolyPhoenix', 'Abbedagge', 'Cyeol', 'Saw (Salih Çağrı Okşak)', 'Madlifeonur', 'Meshade', 'FabFabulous', 'SIKINTI321', '24 (Seyfi Onat Aytemiz)', 'Pilot (Na Woo-hyung)', 'Typhoon (Tayfun Gümüş)', 'Awaremei', 'Closer (Can Çelik)', 'Dellal', 'Copy Catt', 'Freeze', 'Rhemio', 'Helo', 'Beplush', 'Jeyrus', 'Tolerant', 'Matilda', 'Armut'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ninjas in Pyjamas.CN') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Leave', 'Leyan', 'Neny', 'Doinb'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Nongshim RedForce') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kingen', 'Lehends', 'Mihile', 'Fisher (Lee Jeong-tae)', 'GIDEON'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='OKSavingsBank BRION') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hype (Byeon Jeong-hyeon)', 'YoungJae', 'HamBak', 'Clozer', 'Bull'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Oh My God') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hery', 'Moham', 'Heng', 'Charlotte (Xue Le-Hui)', 'Tianzhen', 'Starfire'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Rare Atom') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaohao', 'Jwei'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Rogue (European Team)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Execute', 'Patrik', 'Adam (Adam Maanane)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Royal Never Give Up') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zdz', 'Huanfeng', 'Niket', 'Xiaoka', 'JiaQi', 'Geju', 'Sunlight (Jin Zi-Yang)', 'XBY', 'Coten', 'Iwandy', 'HeiYue', 'Juice'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='SK Gaming') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('RKR', 'Luon', 'Loopy', 'Rahel'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Shopify Rebellion') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Contractz', 'Fudge', 'Tomio', 'Palafox'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='T1') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Doran (Choi Hyeon-joon)', 'Vincenzo (Ha Seung-min)', 'Haetae', 'Cloud (Moon Hyeon-ho)', 'Smash (Sin Geum-jae)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Team BDS') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Parus', '113', 'Irrelevant'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Team Bliss') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kevy', 'Aladoric'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Team Flash.Vietnam') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Playcool', 'Balder', 'Ouzi'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Team Heretics') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Carlsen', 'Sheo', 'Kamiloo', 'Stend'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Team Liquid') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Cop', 'Lapaka', 'Nyjacky', 'Bunny FuFuu', 'Voyboy', 'FlashInTheNight', 'Edward', 'Jaximus', 'Elementz', 'LiQuiD112', 'Westrice', 'Zekent', 'Crumbz', 'Rhux', 'SYDTKO', 'Saintvicious'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Team Ultra Vires') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Inspirro'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Team Vitality') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Czajek', 'Naak Nako'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Team WE') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Monki', 'LP', 'Mxx', 'Vampire', 'Taeyoon', 'Able', 'Karis', 'Mark (Ling Xu)', 'Tianzhen', 'Beluga'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='ThunderTalk Gaming') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('SeTab', 'Feather'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Top Esports') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kanavi', 'Crisp', 'Pool'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ultra Prime') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Junhao', 'Saber (Song Dai-Lin)', 'Niket', 'Qingtian', '1Jiang', 'Wako'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Vivo Keyd Stars') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Takeshi', 'Zirigui', 'Leko', 'Emperor (Kim Jin-hyun)', 'EsA', 'Turtle (Gabriel Peixoto)', 'Robo', 'SuNo', 'Juzo', 'Morttheus', 'Mumus100', 'Revolta', 'Minerva', 'Professor', 'Tay', 'Nappon', 'Zantins', 'BrTT', 'Yang (Felipe Zhao)', 'Verfix', 'DayDream', 'NOsFerus', 'Drop (Matheus Herdy)', 'Boal', 'Trymbi', 'Hidan', 'Tockers', 'Kisee', 'Klaus', 'Mylon', 'Laba', 'Zuao', 'Caos (Jonas Vriesman)', 'Jockster', 'Winged', 'Sarkis', 'Baiano', 'Loop (Caio Almeida)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Weibo Gaming') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Breathe', 'Hang', 'PO8', 'Leigg', 'Yummy', 'Darwin', 'Erha', 'Tarzan (Lee Seung-yong)', 'XLiang'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='West Point Esports Philippines') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Lezar', 'Keres', '1116', 'Felia', 'Yjy', 'RYue', 'Shiromine', 'Kongyue', 'Clayx', 'N0name', 'QaspieL', 'Lilv', 'Fiya', 'Arashi', 'Axin', 'XieDoDo', 'Kirino'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='1116') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Relhia', 'RYue', 'Lilv', 'Cha9'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='113') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Nuc', 'Parus', 'Irrelevant', 'Ice (Yoon Sang-hoon)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='1Jiang') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Junhao', 'Wako', 'Saber (Song Dai-Lin)', 'Rosielove'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='1xn') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('SeTab'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='369') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Crisp'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='4ever') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Rineko', 'Voice', 'Gunkrab', 'Praedyth'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='5kid') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('IgnaVilu', 'Buggax', 'Mir (Park Mi-reu)', 'ChinX'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='665') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Feng (Chen Chun-Feng)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Abbedagge') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Castle (Cho Hyeon-seong)', 'EXyu', 'ScaryJerry'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Able') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('LP', 'FoFo', 'Wayward', 'Mark (Ling Xu)', 'Heng', 'Yanxiang'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='About') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kiin', 'Canyon', 'Kemish', 'Chovy', 'Duro'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Abyss (Lin Po-Reng)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Cheng9', 'HotPot', 'GuanGuan', 'NuL1', 'Kerry'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ackerman (Gabriel Aparicio)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mireu', 'Burdol'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Adam (Adam Maanane)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Malrang', 'Execute', 'Patrik', 'Larssen'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ahn') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Vampire', 'Glfs', 'ZUIAN'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Aiming') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('BeryL', 'Siwoo', 'Moham'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Aki (Mao An)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Leave', 'Leyan', 'Neny', 'Doinb'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Aladoric') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Haeri'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ale') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Peyz', 'Scout', 'MISSING', 'Croco', 'Hope (Wang Jie)', 'Shanks', 'Xun', 'Kael (Kim Jin-hong)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Alvaro (Álvaro Fernández)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Jojopyun'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Andil') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Rich (Lee Jae-won)', 'Leaper', 'LazyFeel', 'Sponge', 'Ucal', 'Teddy'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Angel (Xiang Tao)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zdz', 'Xiaohao', 'Wink', 'Assum', 'Tianzhen', 'Hery'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Aomine') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Pain (Lê Quốc Anh)', 'Warrior (Nguyễn Phú Thanh)', 'Taki (Đinh Anh Tài)', 'Hiro02', 'Jcom', 'Yusah', 'Aress'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Aress') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kiaya', 'Draktharr', 'Emo', 'Pain (Lê Quốc Anh)', 'Warrior (Nguyễn Phú Thanh)', 'Levi', 'Artemis (Trần Quốc Hưng)', 'Pun', 'Jcom', 'EasyLove', 'Puddin', 'Aomine', 'Elio'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Aria (Lee Ga-eul)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kakkun', 'Guwon'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Artemis (Trần Quốc Hưng)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Emo', 'Kazuto', 'Dove', 'Levi', 'EasyLove', 'Hasmed', 'SiuLoong', 'Aress', 'Claws', 'Sounda', 'Elio'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Assum') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zdz', 'Xiaohao', 'Angel (Xiang Tao)', 'Wink', 'Jwei'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ayu (Andrey Saraiva)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zzk (Kwon Hee-won)', 'Guigo', 'Wiz', 'JoJo (Gabriel Dzelme)', 'Tatu (Pedro Seixas)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Azhi') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Karsa', 'FoFo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Babo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('KaKAO', 'Langx', 'Puff (Ding Wang)', 'Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Baiye') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Heru', 'Liangchen', 'Monki'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Banye') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Starfire', 'Flying', 'Yan (Deng Guo-Ce)', 'Charlotte (Xue Le-Hui)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Baolan') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Smlz', 'Xiyang', 'Haoye'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Bat (Gao Jun)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Shad0w', 'Sheer', 'Sorrow (Li De-Ming)', 'Care', 'Jwei'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Bdd') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Casting', 'Deokdam', 'VicLa', 'ShowMaker'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Beenie') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mun', 'Vahvel', 'Jauny', 'Nobody (Nicolás Ale)', 'Ganks'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Beichuan') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('SeTab', 'Feather'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Berserker (Kim Min-cheol)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Gumayusi', 'Pungyeon', 'Pyosik', 'Viper (Park Do-hyeon)', 'Thanatos (Park Seung-gyu)', 'Life', 'Teddy', 'Jiwoo', 'BuLLDoG (Lee Tae-young)', 'DuDu (Lee Dong-ju)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='BeryL') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Aiming', 'Siwoo', 'Casting', 'Lucid (Choi Yong-hyeok)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Betty') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('FoFo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Bie') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Gury', 'Nanaue (Phùng Đức Tài)', 'Shogun (Nguyễn Văn Huy)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='BioPanther') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Leemas', 'Luon', 'Mir (Park Mi-reu)', 'JimieN'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Blaber') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Thanatos (Park Seung-gyu)', 'Loki (Lee Sang-min)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Boal') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kisee', 'Disamis', 'Trymbi', 'Morttheus'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Bonnie') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Daystar', 'Diable', 'Soboro', 'Envyy', 'Career', 'Kellin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='BrTT') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('SuperCleber', 'Seize', 'Sanghyeon', 'Envy (Bruno Farias)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Breathe') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tian', 'Hang', 'Light (Wang Guang-Yu)', 'XBear'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='BrokenBlade') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Labrov', 'SkewMond'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='BuLLDoG (Lee Tae-young)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Leaper', 'Pungyeon', 'Pyosik', 'Berserker (Kim Min-cheol)', 'Life'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='BuLuKaKa') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Beluga', 'Mxx'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Buggax') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('IgnaVilu', '5kid', 'Mir (Park Mi-reu)', 'ChinX'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Bugi') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tomio'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Bull') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hype (Byeon Jeong-hyeon)', 'HamBak', 'Pollu', 'Clozer', 'Morgan'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Burdol') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Snaker', 'Josedeodo', 'Mireu', 'Ackerman (Gabriel Aparicio)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Busio') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Quad'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Bvoy') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Contractz', 'Fudge', 'Tomio', 'Palafox'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Bwipo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Quad'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Calix (Syun Hyun-bin)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Vital', 'GuGer', 'Mihile', 'Fisher (Lee Jeong-tae)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Callme') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('GuGer', 'Mihile', 'Fisher (Lee Jeong-tae)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Canna') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Caliste', 'Yike'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Canyon') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Pyosik', 'Kemish', 'Sylvie', 'Duro', 'Ruler', 'Oner', 'Peanut', 'About'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Caps') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Labrov', 'SkewMond'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Care') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Bat (Gao Jun)', 'Zdz', 'Shad0w', 'Sheer', 'TheNiu', 'Sorrow (Li De-Ming)', 'Jwei'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Career') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Diable', 'Soboro', 'Envyy', 'Bonnie', 'Kellin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Carzzy') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Czajek', 'Naak Nako'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Castle (Cho Hyeon-seong)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('ScaryJerry', 'Abbedagge', 'Huhi', 'EXyu'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Cavalo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Levizin', 'Leandrinn'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Cc (Yan Cheng-Chao)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Chips (Gong Jia-Hao)', 'Nuo', 'WuNai', 'Ninefog'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ceo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Keine', 'SCARY (Artur Queiroz)', 'Zothve', 'Cody', 'ProDelta'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ceos') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('SCARY (Artur Queiroz)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Cha9') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('RYue', 'Lilv', '1116', 'Kongyue'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Cheng9') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Abyss (Lin Po-Reng)', 'HotPot', 'GuanGuan', 'Kerry'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Chips (Gong Jia-Hao)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Cc (Yan Cheng-Chao)', 'Nuo', 'WuNai', 'Ninefog'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Chirp') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Prey (Xu Jia-Hao)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Chovy') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('VicLa', 'ShowMaker', 'Kemish', 'Duro', 'About'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Chungy') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mfis', 'Shinki', 'Guapi', 'Meifan', 'Katsurii', 'M0chi'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Clear (Song Hyeon-min)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('VicLa', 'Raptor (Jeon Eo-jin)', 'Diable', 'Duro', 'Kellin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Closer (Can Çelik)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Jackies', 'Jun (Yoon Se-jun)', 'Noah (Oh Hyeon-taek)', 'Lot'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Clozer') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hype (Byeon Jeong-hyeon)', 'Raptor (Jeon Eo-jin)', 'Pollu', 'Bull', 'Duro', 'Morgan'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Cody') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Ceo', 'SCARY (Artur Queiroz)', 'ProDelta'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Contractz') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Bvoy', 'Fudge', 'Zeyzal'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Coten') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('HeiYue', 'XBY', 'Xiaoka', 'Sunlight (Jin Zi-Yang)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Creme') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kanavi', 'Crisp'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Crisp') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kanavi', '369', 'JackeyLove', 'XBear', 'Tarzan (Lee Seung-yong)', 'Creme'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Croco') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Ale'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Cryin') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Solokill', 'Jiejie', 'Leave'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Cryscata') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Feng (Chen Chun-Feng)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Cube (Dai Yi)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Monki', 'Vampire', 'Karis', 'Taeyoon', 'Tianzhen', 'Hery'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Cuzz') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Leaper', 'Deokdam'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Cyku') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('OvO', 'Xinsheng', 'Fishone', '5t5'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='DDoiV') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('FATE (Yoo Su-hyeok)', 'YoungJae', 'Pungyeon', 'Lancer', 'Slayer (Kim Jin-young)', 'Quantum (Son Jeong-hwan)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Damage') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yupps'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Darwin') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('PO8', 'Leigg', 'Yummy', 'Erha', 'XLiang'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Daystar') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Diable', 'Soboro', 'Envyy', 'Bonnie', 'Kellin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Deft') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Casting'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Delight') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Grizzly', 'Keria', 'Pollu', 'Zeus', 'Rooster', 'Way (Han Gil)', 'Kellin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Deokdam') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zdz', 'PerfecT (Lee Seung-min)', 'Bdd', 'TheNiu', 'Cuzz', 'Way (Han Gil)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Destiny (Mitchell Shaw)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Incursio', 'Dragku', 'Foreigner', 'Zorenous'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Dimitry') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Seiya', 'Buggax', 'Mir (Park Mi-reu)', 'ChinX'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Disamis') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kisee', 'Boal', 'Trymbi', 'Morttheus'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='DnDn') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('GuGer', 'Mihile', 'Fisher (Lee Jeong-tae)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Doggo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Niket', 'Qingtian', 'Driver', 'Rest', 'HongQ', 'JunJia'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Doinb') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Aki (Mao An)', 'Ppgod', 'Leave', 'Shanji'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Doraemon (Joshua Wong)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Styx (Samuel Blanchard)', 'SHAKa (Yang Zhen-Yu)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Doran (Choi Hyeon-joon)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Faker', 'Smash (Sin Geum-jae)', 'Oner'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Dove') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kazuto', 'RonOP', 'Artemis (Trần Quốc Hưng)', 'Hasmed', 'SiuLoong', 'Claws', 'Hieu3', 'Sounda', 'C7N'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Dragku') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Incursio', 'Destiny (Mitchell Shaw)', 'Foreigner'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Drakehero') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Marvin', 'Levizin', 'Leandrinn', 'Fuuu', 'Hidan', 'Guigs'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Draktharr') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Playcool', 'Taki (Đinh Anh Tài)', 'Balder', 'Aress', 'Ouzi'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Driver') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Shunn', 'SwordArt', 'Doggo', 'Gori', 'Karsa', 'HongQ', 'Kaiwing', 'JunJia'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='DuDu (Lee Dong-ju)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Leaper', 'Pungyeon', 'Pyosik', 'Berserker (Kim Min-cheol)', 'Life'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Duro') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Clear (Song Hyeon-min)', 'Execute', 'Raptor (Jeon Eo-jin)', 'Hena', 'Kiin', 'Canyon', 'Kemish', 'Clozer', 'Ruler', 'Chovy', 'About'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='EXyu') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Castle (Cho Hyeon-seong)', 'Abbedagge', 'Huhi', 'ScaryJerry'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='EasyLove') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Aress', 'Artemis (Trần Quốc Hưng)', 'Neo (Toàn Trần)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Eddie') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Steller', 'Hizto', 'Dire'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Eisley') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Elio') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Aress', 'Artemis (Trần Quốc Hưng)', 'Neo (Toàn Trần)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Elk') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Wei (Yan Yang-Wei)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Elyoya') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Jojopyun'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Emo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Aress', 'Artemis (Trần Quốc Hưng)', 'Neo (Toàn Trần)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Envy (Bruno Farias)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('BrTT'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Envyy') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('FATE (Yoo Su-hyeok)', 'Daystar', 'Soboro', 'Diable', 'Bonnie', 'Career', 'Kellin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Erha') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('PO8', 'Leigg', 'Yummy', 'Darwin', 'XLiang'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Eugeo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Van (Kim Seung-hoo)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Evi') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('FATE (Yoo Su-hyeok)', 'Courage (Jeon Hyun-min)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Execute') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Raptor (Jeon Eo-jin)', 'Patrik', 'Larssen', 'Adam (Adam Maanane)', 'Malrang', 'Duro'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Eyla') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('FBI', 'Tomo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='FATE (Yoo Su-hyeok)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('YoungJae', 'Courage (Jeon Hyun-min)', 'DDoiV', 'Karis', 'Pollu', 'Morgan', 'Gaeng', 'Pullbae', 'Evi', 'Envyy', 'Samver', 'Marble'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='FBI') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('River (Kim Dong-woo)', 'Sniper', 'Eyla', 'Quid'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='FakeGod') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tomio'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Faker') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('ShowMaker', 'Doran (Choi Hyeon-joon)', 'VicLa', 'Smash (Sin Geum-jae)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Feather') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('SeTab', 'QiuQiu (Zhang Ming)', 'Ucal', 'HOYA', 'Beichuan'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Feng (Chen Chun-Feng)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Orca (Kuo Cheng-Han)', 'Taco (Fan Zhao-Fu)', '665', 'Cryscata'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Fighto') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Evewin', 'Thien', 'Shernfire', 'Kurak'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Findo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Prey (Xu Jia-Hao)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Fisher (Lee Jeong-tae)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('DnDn', 'Calix (Syun Hyun-bin)', 'Kingen', 'Lehends', 'GuGer', 'Mihile', 'Callme', 'Vital', 'Sylvie', 'Jiwoo', 'GIDEON'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Flakked') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Carlsen', 'Sheo', 'Kamiloo', 'Stend'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Flandre') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Shanks', 'Hope (Wang Jie)', 'Tarzan (Lee Seung-yong)', 'Kael (Kim Jin-hong)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Flying') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Starfire', 'Charlotte (Xue Le-Hui)', 'Banye'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='FoFo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('LP', 'Azhi', 'Betty', 'Able', 'Mark (Ling Xu)', 'Woody', 'Yanxiang', 'Karsa'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Foreigner') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Raes', 'Zorenous', 'Destiny (Mitchell Shaw)', 'Dragku', 'Incursio'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Frog (Lee Min-hoi)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Paduck', 'LazyFeel'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Fudge') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zeyzal', 'Bvoy', 'Contractz', 'Palafox'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Fuuu') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Shini', 'Marvin', 'Hidan', 'Trigo (Matheus Trigo)', 'Forlin', 'Drakehero', 'Guigs'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='GALA') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Rookie', 'Jiejie', 'TheShy', 'Meiko'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='GIDEON') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Jiwoo', 'Kingen', 'Lehends', 'Fisher (Lee Jeong-tae)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Gaeng') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Marble', 'FATE (Yoo Su-hyeok)', 'Courage (Jeon Hyun-min)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ganks') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Vahvel', 'Nobody (Nicolás Ale)', 'Beenie', 'Mun'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Gavotto') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Loopy'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Geju') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Ming (Shi Sen-Ming)', 'Huanfeng', 'XBY', 'Juice'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Godtone') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Abyss (Lin Po-Reng)', 'Cheng9', 'HotPot', 'GuanGuan', 'NuL1', 'Kerry'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Goodo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Rineko', 'Voice', 'Praedyth', 'Gunkrab'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Gori') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('HongQ', 'Driver'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Grell') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('TopLop', 'Nia (Woo Jun-sung)', 'Neadz', 'ZOEN (Enzo Ganino)', 'Trigger (Kim Eui-joo)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Grizzly') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Rooster', 'Delight'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='GuGer') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('DnDn', 'Calix (Syun Hyun-bin)', 'Mihile', 'Callme', 'Vital', 'Sylvie', 'Jiwoo', 'Fisher (Lee Jeong-tae)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Guigo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Ayu (Andrey Saraiva)', 'Tatu (Pedro Seixas)', 'Tutsz'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Guigs') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hidan', 'Drakehero', 'Marvin', 'Fuuu'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Gumayusi') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Vincenzo (Ha Seung-min)', 'Berserker (Kim Min-cheol)', 'Haetae', 'Cloud (Moon Hyeon-ho)', 'Smash (Sin Geum-jae)', 'Jiwoo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Gunkrab') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Goodo', 'Rineko', 'Voice', '4ever'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Gury') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('SiuLoong', 'Bie', 'Nanaue (Phùng Đức Tài)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Guwon') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('RayFarky', 'Aria (Lee Ga-eul)', 'Kakkun', 'Harp', 'Milan'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='H4cker') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Niket', 'Qingtian'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Luon') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('BioPanther', 'ISMA', 'Nisqy', 'Mir (Park Mi-reu)', 'JimieN', 'Rahel', 'Leemas', 'Irrelevant'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='HOYA') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('SeTab', 'Feather'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Haeri') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kevy', 'Aladoric'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Haichao') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zhuo', 'Weiwei', 'Zika', 'Photic'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='HamBak') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Pollu', 'Morgan', 'Clozer', 'Bull'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hang') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tian', 'Breathe', 'Xiaohu', 'Light (Wang Guang-Yu)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hans Sama') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Labrov', 'SkewMond'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Haoye') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mole', 'Smlz', 'Baolan', 'Xiyang'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Harp') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kakkun', 'Guwon'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hasmed') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kazuto', 'Dove', 'RonOP', 'Artemis (Trần Quốc Hưng)', 'SiuLoong', 'Claws', 'C7N', 'Sounda', 'Hieu3'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hauz') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('SCARY (Artur Queiroz)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hena') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Lyonz', 'Licorice', 'Saint (Kang Sung-in)', 'Duro', 'Oddielan'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Heng') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Starry', 'LP', 'Able', 'Moham', 'Linfeng', 'Mark (Ling Xu)', 'Hery'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hery') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Starry', 'Angel (Xiang Tao)', 'Ppgod', 'Moham', 'Linfeng', 'Heng', 'Cube (Dai Yi)', 'Xiaofang', 'Tianzhen'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hexflash') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Styx (Samuel Blanchard)', 'SHAKa (Yang Zhen-Yu)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hidan') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Guigs', 'Drakehero', 'Marvin', 'Fuuu'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hieu3') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kazuto', 'Dove', 'Hasmed', 'SiuLoong', 'Claws', 'Sounda', 'C7N'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hiro02') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hizto', 'Dire', 'Warrior (Nguyễn Phú Thanh)', 'Jcom', 'Pain (Lê Quốc Anh)', 'Steller', 'Aomine'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='HongQ') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Shunn', 'Doggo', 'Driver', 'Gori', 'Rest', 'Kaiwing', 'Karsa', 'SwordArt', 'JunJia'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hoopa') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Prey (Xu Jia-Hao)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hope (Wang Jie)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Flandre', 'Ale'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Huanfeng') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tangyuan', 'Zdz', 'Ming (Shi Sen-Ming)', 'Geju', 'XBY', 'Wei (Yan Yang-Wei)', 'Xzz', 'Juice'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Huhi') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('ScaryJerry', 'Castle (Cho Hyeon-seong)', 'EXyu'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Humanoid') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mikyx'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hylissang') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Czajek', 'Naak Nako'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hype (Byeon Jeong-hyeon)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Pollu', 'Morgan', 'Clozer', 'Bull'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='ISMA') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Luon', 'Rahel', 'JNX', 'RKR', 'Loopy'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ice (Yoon Sang-hoon)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Parus', '113', 'Irrelevant'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='IgNar') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Juhan', 'Th3Antonio'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='IgnaVilu') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mir (Park Mi-reu)', 'Seiya', 'Buggax', '5kid', 'ChinX'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Incursio') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Dragku', 'Destiny (Mitchell Shaw)', 'Foreigner', 'Zorenous'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ino') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Van (Kim Seung-hoo)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Insanity') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tomio'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Inspired') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Quad'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Irrelevant') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('113', 'Rahel', 'Parus', 'Ice (Yoon Sang-hoon)', 'Luon', 'Nuc'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Isles') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Srtty', 'Keine', 'Licorice', 'Spica', 'Sheiden', 'Jensen'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Iwandy') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Huanfeng', 'Ming (Shi Sen-Ming)', 'Geju', 'XBY', 'Juice'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='JNX') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('ISMA', 'RKR', 'Loopy', 'Rahel'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='JackeyLove') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kanavi', 'Crisp'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Jackies') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Noah (Oh Hyeon-taek)', 'Lot', 'Closer (Can Çelik)', 'Jun (Yoon Se-jun)', 'Juhan', 'Th3Antonio'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Jauny') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Vahvel', 'Beenie', 'Mun'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Jensen') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Spica', 'Isles'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='JiaQi') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tangyuan', 'Xiaoxu', 'Milkyway', 'Lele (Dang Bo-Lin)', 'Pool'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Jiejie') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('TheShy', 'GALA', 'Wink', 'Cryin', 'Rookie'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='JimieN') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('BioPanther', 'Mir (Park Mi-reu)', 'Leemas', 'Luon', 'Wako'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Jiwoo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Gumayusi', 'Viper (Park Do-hyeon)', 'Kingen', 'Lehends', 'Berserker (Kim Min-cheol)', 'GuGer', 'Mihile', 'Teddy', 'Fisher (Lee Jeong-tae)', 'GIDEON'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='JoJo (Gabriel Dzelme)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zzk (Kwon Hee-won)', 'Wiz', 'Ayu (Andrey Saraiva)', 'Tatu (Pedro Seixas)', 'Tutsz'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Jojopyun') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Supa', 'Thanatos (Park Seung-gyu)', 'Alvaro (Álvaro Fernández)', 'Elyoya', 'Myrwn'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Josedeodo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mireu', 'Burdol'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Sasi (Yan Rui)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Shaoye', 'Ycx', 'Climber', 'Xqw', 'Mitsuki'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Juhan') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Jackies', 'Patrik', 'IgNar', 'Th3Antonio'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Jun (Yoon Se-jun)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Jackies', 'Lot', 'Closer (Can Çelik)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='JunJia') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Doggo', 'Driver', 'Rest', 'HongQ', 'Kaiwing'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Junhao') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Saber (Song Dai-Lin)', 'Liangchen', 'Rosielove', '1Jiang', 'Wako'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Jwei') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Bat (Gao Jun)', 'Xiaohao', 'VicLa', 'Shad0w', 'Sheer', 'Xiaoxu', 'Assum', 'Sorrow (Li De-Ming)', 'Care'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='KaKAO') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao', 'Langx', 'Puff (Ding Wang)', 'Babo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Sanghyeon') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('BrTT'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kael (Kim Jin-hong)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tarzan (Lee Seung-yong)', 'Flandre', 'Ale'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kaiwing') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Driver', 'Rest', 'Wako', 'HongQ', 'JunJia'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kakkun') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('RayFarky', 'Aria (Lee Ga-eul)', 'Guwon', 'Harp', 'Milan'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kanavi') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('JackeyLove', 'Crisp', 'Creme'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Karis') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Monki', 'FATE (Yoo Su-hyeok)', 'Vampire', 'Taeyoon', 'Cube (Dai Yi)', 'Tianzhen', 'Beluga'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Karsa') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Azhi', 'FoFo', 'Driver', 'Woody', 'HongQ'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kati') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('SiuLoong', 'Nanaue (Phùng Đức Tài)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Katsurii') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Guapi', 'M0chi', 'Chungy', 'Meifan'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kaze (Lucas Fe)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Loopy'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Keine') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Srtty', 'Tomo', 'Lyonz', 'Summit', 'Ceo', 'Isles', 'Sheiden', 'Oddielan'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kellin') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Keria', 'Clear (Song Hyeon-min)', 'VicLa', 'Raptor (Jeon Eo-jin)', 'Delight', 'Pollu', 'Daystar', 'Moham', 'Soboro', 'Diable', 'Way (Han Gil)', 'Career', 'Envyy', 'Bonnie'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Keria') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Pollu', 'Smash (Sin Geum-jae)', 'Way (Han Gil)', 'Delight', 'Kellin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kevy') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Haeri'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kiari') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Shini', 'Forlin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kiaya') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Aress', 'Neo (Toàn Trần)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kiin') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Rich (Lee Jae-won)', 'Kemish', 'Siwoo', 'Morgan', 'Duro', 'About'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kingen') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Lehends', 'Moham', 'Sylvie', 'Jiwoo', 'Fisher (Lee Jeong-tae)', 'GIDEON'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kisee') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Disamis', 'Boal', 'Trymbi', 'Morttheus'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Knight (Zhuo Ding)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Wei (Yan Yang-Wei)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kongyue') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Relhia', 'RYue', 'Cha9'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kratos') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('SiuLoong'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kurak') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Thien', 'Shernfire', 'Leemas', 'Evewin', 'Fighto'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kyeahoo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('LazyFeel'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='LP') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('FoFo', 'Able', 'Wayward', 'Mark (Ling Xu)', 'Heng'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Labrov') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hans Sama', 'SkewMond', 'Caps', 'BrokenBlade'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Langx') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('KaKAO', 'Xiaocaobao', 'Puff (Ding Wang)', 'Babo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Larssen') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Execute', 'Adam (Adam Maanane)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Leave') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Aki (Mao An)', 'Ppgod', 'Neny', 'Wink', 'Cryin', 'Shanji', 'Doinb'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Leemas') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('BioPanther', 'Kurak', 'Mir (Park Mi-reu)', 'JimieN', 'Evewin', 'Luon'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Lehends') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kingen', 'Sylvie', 'Jiwoo', 'Fisher (Lee Jeong-tae)', 'GIDEON'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Lele (Dang Bo-Lin)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Milkyway', 'JiaQi', 'Niket', 'Xiaoxu'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Levi') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Aress', 'Artemis (Trần Quốc Hưng)', 'Neo (Toàn Trần)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Leyan') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Aki (Mao An)', 'Photic', 'Shanji'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Leza') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('TopLop', 'Nia (Woo Jun-sung)', 'Neadz', 'ZOEN (Enzo Ganino)', 'Trigger (Kim Eui-joo)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Licorice') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Lyonz', 'Spica', 'Hena', 'Saint (Kang Sung-in)', 'Isles', 'Oddielan'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Life') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zdz', 'Pungyeon', 'Pyosik', 'Berserker (Kim Min-cheol)', 'TheNiu', 'BuLLDoG (Lee Tae-young)', 'DuDu (Lee Dong-ju)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Light (Wang Guang-Yu)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tian', 'Hang', 'Breathe', 'XBear'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Lilv') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Relhia', 'RYue', 'Cha9', '1116'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Linfeng') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Heng', 'Moham', 'Hery'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Lira') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Srtty', 'Keine', 'Tomo', 'Isles', 'Sheiden'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ljun') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Ranchen', 'Yuanyue', 'Xiaohanbao', 'Jungoat'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Loopy') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('ISMA', 'Kaze (Lucas Fe)', 'Gavotto', 'Rahel', 'Pan (Andres Bonilla)', 'JNX', 'RKR', 'OnFleek'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Lot') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Jackies', 'Closer (Can Çelik)', 'Jun (Yoon Se-jun)', 'Noah (Oh Hyeon-taek)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Lucid (Choi Yong-hyeok)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('BeryL', 'Siwoo', 'Moham'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Luoyiyu') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Lqh', 'TheHank', 'Yxl', 'Xiaorui'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Lyncas') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Czajek', 'Naak Nako'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Lyonz') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Saint (Kang Sung-in)', 'Keine', 'Hena', 'Licorice'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='MISSING') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Scout', 'Xun', 'Peyz', 'Ale'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Makes') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Levizin', 'Leandrinn'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Malrang') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('SCARY (Artur Queiroz)', 'Execute', 'Patrik', 'Adam (Adam Maanane)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Marble') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('FATE (Yoo Su-hyeok)', 'Courage (Jeon Hyun-min)', 'Gaeng'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Mark (Ling Xu)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('LP', 'FoFo', 'Able', 'Heng', 'Yanxiang'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Massu') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Quad'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Meech') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tomo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Meifan') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mfis', 'Chungy', 'Guapi', 'Katsurii', 'M0chi'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Meiko') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Rookie', 'TheShy', 'GALA'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Meliodas (Hoàng Tiến Nhật)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('TT (Trần Quốc Thanh)', 'Slowz', 'Yume (Châu Kim Bảo)', 'Richard I', 'Tahahy'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Mfis') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Guapi', 'M0chi', 'Chungy', 'Meifan'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='MicaO') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Levizin', 'Leandrinn'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Mikyx') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Razork', 'Oscarinin', 'Humanoid', 'Upset'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Milan') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('RayFarky', 'Kakkun', 'Guwon'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Milkyway') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tangyuan', 'Zdz', 'Niket', 'JiaQi', 'Xiaoxu', 'TheNiu', 'Lele (Dang Bo-Lin)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ming (Shi Sen-Ming)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zdz', 'Huanfeng', 'Geju', 'XBY', 'Xzz', 'Juice'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Mir (Park Mi-reu)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('BioPanther', 'JimieN', 'Leemas', 'Seiya', 'Buggax', 'Luon', 'IgnaVilu', '5kid', 'ChinX'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Mireu') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Josedeodo', 'Ackerman (Gabriel Aparicio)', 'Snaker', 'Burdol'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Mitsuki') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Shaoye', 'Sasi (Yan Rui)', 'Ycx', 'Climber', 'Xqw'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Moham') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Aiming', 'Starry', 'Kingen', 'Lucid (Choi Yong-hyeok)', 'ShowMaker', 'Linfeng', 'Heng', 'Hery', 'Kellin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Mole') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Smlz', 'Xiyang', 'Haoye'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Monki') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Liangchen', 'Xiaoxia', 'Taeyoon', 'Karis', 'Heru', 'Cube (Dai Yi)', 'Tianzhen', 'Baiye'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Morgan') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Rich (Lee Jae-won)', 'Hype (Byeon Jeong-hyeon)', 'FATE (Yoo Su-hyeok)', 'YoungJae', 'HamBak', 'Kiin', 'Zeus', 'Siwoo', 'Clozer', 'Bull'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Moyashi') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Jett', 'Ellim', 'Kinatu'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Myrwn') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Jojopyun'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Naak Nako') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Czajek', 'Hylissang', 'Lyncas', 'Carzzy'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Naiyou') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Pool'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Nayuki') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Neny') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Aki (Mao An)', 'Vampire', 'Ppgod', 'Glfs', 'ZUIAN', 'Shanji', 'Leave'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Neo (Toàn Trần)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kiaya', 'Emo', 'Levi', 'EasyLove', 'Elio'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Netuno') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('SCARY (Artur Queiroz)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Nia (Woo Jun-sung)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Leza', 'Grell', 'TopLop', 'ZOEN (Enzo Ganino)', 'Trigger (Kim Eui-joo)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Niket') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tangyuan', 'H4cker', 'Doggo', 'Xiaoxu', 'Milkyway', 'Yuekai', 'Lele (Dang Bo-Lin)', 'Pool'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='NinjaKiwi') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yupps'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Nisqy') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Luon', 'Rahel'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Noah (Oh Hyeon-taek)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Jackies', 'Lot', 'Closer (Can Çelik)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Nobody (Nicolás Ale)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Ganks', 'Vahvel', 'Beenie', 'Mun'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Nogo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('TQ', 'Phuc1', 'VIN (Trần Hoài Vinh)', 'Sparda'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Nox1') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Prey (Xu Jia-Hao)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='NuL1') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Abyss (Lin Po-Reng)', 'HotPot', 'GuanGuan', 'Kerry'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Nuc') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Parus', '113', 'Irrelevant'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='ON') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Wei (Yan Yang-Wei)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Oddielan') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Saint (Kang Sung-in)', 'Keine', 'Hena', 'Licorice'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='OnFleek') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Loopy'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Oner') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Doran (Choi Hyeon-joon)', 'Pyosik', 'Vincenzo (Ha Seung-min)', 'Haetae', 'Canyon', 'Cloud (Moon Hyeon-ho)', 'Smash (Sin Geum-jae)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='C7N') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kazuto', 'Dove', 'RonOP', 'Hasmed', 'Claws', 'Sounda', 'Hieu3'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Orca (Kuo Cheng-Han)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Feng (Chen Chun-Feng)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Oscarinin') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mikyx', 'Upset'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ouzi') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yoshino', 'Draktharr', 'Balder', 'Soraaa'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Paduck') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('YoungJae', 'Zinie', 'Frog (Lee Min-hoi)', 'Casting', 'Sponge', 'Pleata', 'Teddy', 'Peter (Jeong Yoon-su)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Palafox') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Bvoy', 'Fudge', 'Zeyzal'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Pan (Andres Bonilla)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Loopy'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Parus') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Nuc', '113', 'Irrelevant', 'Ice (Yoon Sang-hoon)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Patrik') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Execute', 'Adam (Adam Maanane)', 'Malrang', 'Juhan', 'Th3Antonio'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Paz') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yuhi', 'Ellim', 'Kinatu'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Peanut') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Canyon', 'Oner', 'Pyosik', 'Zeus'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='PerfecT (Lee Seung-min)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Casting', 'Deokdam'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Peter (Jeong Yoon-su)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Casting', 'YoungJae', 'Zinie', 'Paduck'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Peyz') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Scout', 'MISSING', 'Xun', 'Ale'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Photic') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Haichao', 'Leyan', 'Weiwei', 'Zika'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Phuc1') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Sparda', 'VIN (Trần Hoài Vinh)', 'Rigel (Đào Văn Tuấn)', 'Sty1e', 'Nogo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Pilot (Elvis Vergara)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Levizin', 'Leandrinn'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Playcool') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yoshino', 'Draktharr', 'Balder', 'Soraaa'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Pleata') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Paduck', 'LazyFeel'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Poby') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Smash (Sin Geum-jae)', 'Vincenzo (Ha Seung-min)', 'Haetae', 'Cloud (Moon Hyeon-ho)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Pollu') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hype (Byeon Jeong-hyeon)', 'Keria', 'YoungJae', 'FATE (Yoo Su-hyeok)', 'HamBak', 'Way (Han Gil)', 'Clozer', 'Bull', 'Delight', 'Kellin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ppgod') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hery', 'Neny', 'Doinb', 'Tianzhen', 'Leave'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Praedyth') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Goodo', 'Rineko', 'Voice', '4ever'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Pretender') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Wako'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='ProDelta') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Cody', 'Ceo', 'SCARY (Artur Queiroz)', 'Zothve'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Puddin') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Aress', 'Taki (Đinh Anh Tài)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Puff (Ding Wang)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('KaKAO', 'Langx', 'Xiaocaobao', 'Babo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Pullbae') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('YoungJae', 'FATE (Yoo Su-hyeok)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Pun') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('TT (Trần Quốc Thanh)', 'Taki (Đinh Anh Tài)', 'Yume (Châu Kim Bảo)', 'Tahahy', 'Aress'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Pyosik') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Pungyeon', 'Casting', 'Berserker (Kim Min-cheol)', 'Life', 'Canyon', 'Sylvie', 'BuLLDoG (Lee Tae-young)', 'Oner', 'Peanut', 'DuDu (Lee Dong-ju)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Qingtian') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yuekai', 'Doggo', 'H4cker'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='QiuQiu (Zhang Ming)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Feather'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Quad') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Massu', 'Inspired', 'Busio', 'Bwipo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Quantum (Son Jeong-hwan)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Leaper', 'Pungyeon', 'DDoiV', 'Lancer', 'Slayer (Kim Jin-young)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Quid') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('FBI', 'Tomo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Raes') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Incursio', 'Foreigner', 'Zorenous'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Rahel') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('RKR', 'ISMA', 'Nisqy', 'Irrelevant', 'JNX', 'Luon', 'Loopy'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Raina') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tol2', 'HowLa', 'Jool', 'Charley'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Raptor (Jeon Eo-jin)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Clear (Song Hyeon-min)', 'VicLa', 'Execute', 'Diable', 'Clozer', 'Duro', 'Kellin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='RayFarky') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kakkun', 'Guwon', 'Milan'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Razork') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mikyx'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='RKR') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('ISMA', 'Loopy', 'JNX', 'Rahel'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Relhia') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Lilv', '1116', 'Kongyue'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Rest') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('HongQ', 'Doggo', 'JunJia', 'Kaiwing'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Reufury') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('VENDRICK', '9God', 'Gabn', 'Sovereign (Alexander Folley)', 'Yojin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Rich (Lee Jae-won)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('LazyFeel', 'Sponge', 'Kiin', 'Zeus', 'Ucal', 'Siwoo', 'Teddy', 'Andil', 'Morgan'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Richard I') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yume (Châu Kim Bảo)', 'Meliodas (Hoàng Tiến Nhật)', 'TT (Trần Quốc Thanh)', 'Tahahy'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Rigel (Đào Văn Tuấn)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('TQ', 'Phuc1', 'VIN (Trần Hoài Vinh)', 'Sparda'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='River (Kim Dong-woo)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('FBI', 'Tomo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Robo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Winsome', 'Wiz'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='RonOP') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kazuto', 'Dove', 'Hasmed', 'Claws', 'Sounda', 'C7N'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Rookie') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Jiejie', 'Meiko', 'GALA'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Rosielove') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Junhao', 'Saber (Song Dai-Lin)', '1Jiang', 'Wako'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Route') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Winsome', 'Wiz'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ruler') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Duro', 'Canyon'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='SHAKa (Yang Zhen-Yu)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Doraemon (Joshua Wong)', 'Styx (Samuel Blanchard)', 'Hexflash', 'Zhovy'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Samver') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('YoungJae', 'FATE (Yoo Su-hyeok)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Scamber') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Trigo (Matheus Trigo)', 'Shini', 'Forlin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='SCARY (Artur Queiroz)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Netuno', 'Hauz', 'Ceo', 'Ceos', 'Zothve', 'Malrang', 'Cody', 'ProDelta'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Scout') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Peyz', 'MISSING', 'Xun', 'Ale'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='SeTab') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Feather', 'Beichuan', 'HOYA', '1xn'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Seiya') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('IgnaVilu', 'Mir (Park Mi-reu)', 'ChinX'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Seize') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('BrTT'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Shad0w') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Bat (Gao Jun)', 'Sheer', 'Sorrow (Li De-Ming)', 'Care', 'Jwei'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Shanji') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Leave', 'Leyan', 'Neny', 'Doinb'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Shanks') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tarzan (Lee Seung-yong)', 'Flandre', 'Ale'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Shaoye') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Sasi (Yan Rui)', 'Ycx', 'Climber', 'Xqw', 'Mitsuki'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Sheer') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Bat (Gao Jun)', 'Shad0w', 'Sorrow (Li De-Ming)', 'Care', 'Jwei'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Sheiden') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Srtty', 'Isles', 'Tomo', 'Keine'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Sheo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Carlsen', 'Flakked', 'Kamiloo', 'Stend'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Shernfire') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Evewin', 'Fighto', 'Kurak'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Shini') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Scamber', 'Fuuu', 'Trigo (Matheus Trigo)', 'Kiari', 'Forlin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Shinki') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Guapi', 'M0chi', 'Chungy'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Shogun (Nguyễn Văn Huy)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('SiuLoong', 'Bie', 'Nanaue (Phùng Đức Tài)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='ShowMaker') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('VicLa', 'Faker', 'Bdd', 'Moham', 'Siwoo', 'Chovy'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Shunn') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('HongQ', 'Driver'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Slowz') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yume (Châu Kim Bảo)', 'Meliodas (Hoàng Tiến Nhật)', 'TT (Trần Quốc Thanh)', 'Tahahy'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Smlz') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mole', 'Baolan', 'Haoye'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Snaker') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mireu', 'Burdol'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Sniper') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('FBI', 'Tomo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Soboro') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Daystar', 'Diable', 'Career', 'Envyy', 'Bonnie', 'Kellin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Solokill') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Wink', 'Cryin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Soraaa') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Playcool', 'Balder', 'Ouzi'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Sorrow (Li De-Ming)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zhiqiuyi', 'Bat (Gao Jun)', 'Iyy', 'Shad0w', 'Yomiya', 'Mentality (Wei Guan-Zhen)', 'Sheer', 'SYWJJ', 'Care', 'Jwei'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Sparda') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Phuc1', 'TQ', 'VIN (Trần Hoài Vinh)', 'Rigel (Đào Văn Tuấn)', 'Sty1e', 'Nogo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Spica') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Licorice', 'Isles', 'Jensen'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Sponge') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Rich (Lee Jae-won)', 'LazyFeel', 'Ucal', 'Andil', 'Paduck'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ssol') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Van (Kim Seung-hoo)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Starfire') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Flying', 'Charlotte (Xue Le-Hui)', 'Banye'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Starry') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tianzhen', 'Heng', 'Moham', 'Hery'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Stay (Guo Yi-Yang)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Beluga', 'Mxx'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Sty1e') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('TQ', 'Phuc1', 'VIN (Trần Hoài Vinh)', 'Sparda'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Styx (Samuel Blanchard)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Doraemon (Joshua Wong)', 'Hexflash', 'SHAKa (Yang Zhen-Yu)', 'Zhovy'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Summit') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Keine'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Supa') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Jojopyun'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='SuperCleber') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('BrTT'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='SwordArt') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('HongQ', 'Driver'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Sylvie') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Pyosik', 'Lehends', 'Kingen', 'GuGer', 'Mihile', 'Canyon', 'Fisher (Lee Jeong-tae)', 'Oner'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='TENG') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Beluga', 'Mxx'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='TQ') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Sparda', 'VIN (Trần Hoài Vinh)', 'Rigel (Đào Văn Tuấn)', 'Sty1e', 'Nogo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Taco (Fan Zhao-Fu)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Feng (Chen Chun-Feng)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Taeyoon') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Monki', 'Vampire', 'Karis', 'Cube (Dai Yi)', 'Tianzhen', 'Beluga'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Taki (Đinh Anh Tài)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Draktharr', 'Hizto', 'Dire', 'Warrior (Nguyễn Phú Thanh)', 'Puddin', 'Pun', 'Jcom', 'Pain (Lê Quốc Anh)', 'Steller', 'Aomine'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Tangyuan') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zdz', 'Huanfeng', 'Niket', 'JiaQi', 'Geju', 'XBY', 'Milkyway', 'Xzz', 'Juice'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Targamas') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Caliste', 'Yike'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Tarzan (Lee Seung-yong)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Flandre', 'Xiaohu', 'Crisp', 'Shanks', 'XBear', 'Kael (Kim Jin-hong)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Teddy') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Rich (Lee Jae-won)', 'LazyFeel', 'Viper (Park Do-hyeon)', 'Berserker (Kim Min-cheol)', 'Ucal', 'Jiwoo', 'Andil', 'Paduck'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Th3Antonio') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Jackies', 'IgNar', 'Juhan', 'Patrik'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Thanatos (Park Seung-gyu)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Vulcan (Philippe Laflamme)', 'Berserker (Kim Min-cheol)', 'Loki (Lee Sang-min)', 'Jojopyun', 'Zven', 'Blaber'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='TheNiu') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Life', 'Deokdam', 'Milkyway', 'Xiaolaohu', 'Care'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='TheShy') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Jiejie', 'Meiko', 'GALA'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Thien') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Evewin', 'Fighto', 'Kurak'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Tian') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Breathe', 'Hang', 'Xiaohu', 'Light (Wang Guang-Yu)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Tianzhen') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Starry', 'Monki', 'Angel (Xiang Tao)', 'Vampire', 'Taeyoon', 'Karis', 'Ppgod', 'Cube (Dai Yi)', 'Beluga', 'Hery'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Tinowns') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Winsome', 'Wiz'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Tomasino (Tomas Silva Pereira)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Prey (Xu Jia-Hao)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Tomo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Sniper', 'Srtty', 'Keine', 'River (Kim Dong-woo)', 'Eyla', 'Meech', 'Sheiden', 'Quid'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='TopLop') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Leza', 'Grell', 'Trigger (Kim Eui-joo)', 'Nia (Woo Jun-sung)', 'ZOEN (Enzo Ganino)', 'Neadz'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Trigger (Kim Eui-joo)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Leza', 'Grell', 'TopLop', 'Nia (Woo Jun-sung)', 'ZOEN (Enzo Ganino)', 'Neadz'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Trigo (Matheus Trigo)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Shini', 'Forlin', 'Fuuu', 'Scamber'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Trymbi') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kisee', 'Disamis', 'Boal', 'Morttheus'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Tutsz') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tatu (Pedro Seixas)', 'Zzk (Kwon Hee-won)', 'JoJo (Gabriel Dzelme)', 'Guigo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ucal') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Rich (Lee Jae-won)', 'LazyFeel', 'Sponge', 'Feather', 'Teddy', 'Andil'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Upset') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mikyx', 'Oscarinin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Vulcan (Philippe Laflamme)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Thanatos (Park Seung-gyu)', 'Loki (Lee Sang-min)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Vahvel') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mun', 'Beenie', 'Jauny', 'Nobody (Nicolás Ale)', 'Ganks'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Vampire') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Taeyoon', 'Karis', 'Beluga', 'Glfs', 'Neny', 'ZUIAN', 'YSKM', 'Cube (Dai Yi)', 'Tianzhen', 'Ahn'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='VicLa') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaohao', 'Clear (Song Hyeon-min)', 'Raptor (Jeon Eo-jin)', 'Bdd', 'Faker', 'Diable', 'ShowMaker', 'Chovy', 'Jwei', 'Kellin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='VIN (Trần Hoài Vinh)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Sparda', 'Phuc1', 'TQ', 'Rigel (Đào Văn Tuấn)', 'Sty1e', 'Nogo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Viper (Park Do-hyeon)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Berserker (Kim Min-cheol)', 'Zeus', 'Rooster', 'Teddy', 'Jiwoo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Vital') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('GuGer', 'Calix (Syun Hyun-bin)', 'Mihile', 'Fisher (Lee Jeong-tae)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Vladi') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Caliste', 'Yike'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Voice') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Rineko', '4ever', 'Gunkrab', 'Praedyth', 'Goodo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Wako') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Junhao', 'Saber (Song Dai-Lin)', 'Rosielove', '1Jiang', 'Pretender', 'JimieN', 'Kaiwing'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Wangxiao') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Pool'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Washidai') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Van (Kim Seung-hoo)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Way (Han Gil)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Keria', 'Pollu', 'Deokdam', 'Delight', 'Kellin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Wayward') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('LP', 'Yanxiang', 'Able'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Wei (Yan Yang-Wei)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zdz', 'Huanfeng', 'Juice', 'Xun', 'ON', 'Elk', 'Knight (Zhuo Ding)', 'Xzz'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Weiwei') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Haichao', 'Photic', 'Zhuo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Wind (Chen Guo-Feng)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Wink') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Zdz', 'Xiaohao', 'Angel (Xiang Tao)', 'Solokill', 'Jiejie', 'Assum', 'Leave'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Winsome') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tinowns', 'Robo', 'Route', 'Wiz'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Wiz') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Winsome', 'Zzk (Kwon Hee-won)', 'Tinowns', 'JoJo (Gabriel Dzelme)', 'Ayu (Andrey Saraiva)', 'Robo', 'Route'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Woodon') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('VENDRICK', '9God', 'Gabn', 'Sovereign (Alexander Folley)', 'Yojin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Woody') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Karsa', 'FoFo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='WuNai') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Chips (Gong Jia-Hao)', 'Nuo', 'Cc (Yan Cheng-Chao)', 'Ninefog'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='XBY') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Huanfeng', 'Xiaoka', 'Ming (Shi Sen-Ming)', 'Geju', 'Sunlight (Jin Zi-Yang)', 'Coten', 'HeiYue', 'Juice'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='XBear') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tarzan (Lee Seung-yong)', 'Crisp', 'Breathe', 'Light (Wang Guang-Yu)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='XLiang') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('PO8', 'Leigg', 'Yummy', 'Darwin', 'Erha'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Xiaofang') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hery'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Xiaohanbao') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Ranchen', 'Ljun', 'Jungoat'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Xiaohao') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Angel (Xiang Tao)', 'VicLa', 'Xiaoxu', 'Wink', 'Assum', 'Jwei'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Xiaohu') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tian', 'Tarzan (Lee Seung-yong)', 'Hang'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Xiaolaohu') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('TheNiu', 'Zdz'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Xiaoxia') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Heru', 'Liangchen', 'Monki'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Xiaoxu') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaohao', 'Niket', 'JiaQi', 'Milkyway', 'Lele (Dang Bo-Lin)', 'Jwei'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Xiyang') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mole', 'Baolan', 'Haoye'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Xqw') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Shaoye', 'Sasi (Yan Rui)', 'Ycx', 'Climber', 'Mitsuki'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Xun') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Scout', 'MISSING', 'Peyz', 'Ale', 'Wei (Yan Yang-Wei)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Xzz') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tangyuan', 'Zdz', 'Huanfeng', 'Ming (Shi Sen-Ming)', 'Geju', 'XBY', 'Wei (Yan Yang-Wei)', 'Juice'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='YSKM') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Vampire', 'Glfs', 'ZUIAN'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Yampi') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yupps'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Yan (Deng Guo-Ce)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Charlotte (Xue Le-Hui)', 'Banye'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Yanxiang') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mark (Ling Xu)', 'Able', 'FoFo', 'Wayward'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Yike') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Vladi', 'Targamas', 'Caliste', 'Canna'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Yoshino') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Playcool', 'Balder', 'Ouzi'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='YoungJae') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('FATE (Yoo Su-hyeok)', 'Zinie', 'DDoiV', 'Casting', 'Pollu', 'Pullbae', 'Paduck', 'Samver', 'Morgan', 'Peter (Jeong Yoon-su)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Yuanyue') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Ranchen', 'Ljun', 'Jungoat'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Yuekai') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Niket', 'Qingtian'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Yupps') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yampi', 'Damage', 'NinjaKiwi'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Yusah') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Warrior (Nguyễn Phú Thanh)', 'Pain (Lê Quốc Anh)', 'Jcom', 'Aomine'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Yxl') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Liangchen', 'TheHank', 'Luoyiyu', 'Lqh', 'Xiaorui'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Yge') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='ZOEN (Enzo Ganino)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Leza', 'Grell', 'TopLop', 'Trigger (Kim Eui-joo)', 'Nia (Woo Jun-sung)', 'Neadz'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Zdz') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tangyuan', 'Angel (Xiang Tao)', 'Huanfeng', 'Ming (Shi Sen-Ming)', 'Life', 'Deokdam', 'Wink', 'Xiaolaohu', 'Milkyway', 'Wei (Yan Yang-Wei)', 'Assum', 'Xzz', 'Care', 'Juice'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Zeka (Kim Geon-woo)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Rooster', 'Zeus'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Zeus') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Rich (Lee Jae-won)', 'Viper (Park Do-hyeon)', 'Delight', 'Siwoo', 'Zeka (Kim Geon-woo)', 'Morgan', 'Peanut'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Zeyzal') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Contractz', 'Fudge', 'Tomio', 'Palafox'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Zhiqiuyi') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Iyy', 'Yomiya', 'Mentality (Wei Guan-Zhen)', 'SYWJJ', 'Sorrow (Li De-Ming)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Zhovy') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Styx (Samuel Blanchard)', 'SHAKa (Yang Zhen-Yu)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Zhuo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Haichao', 'Weiwei', 'Zika'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Zika') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Haichao', 'Photic', 'Zhuo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Zorenous') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Incursio', 'Raes', 'Destiny (Mitchell Shaw)', 'Foreigner'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Zothve') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Ceo', 'SCARY (Artur Queiroz)', 'ProDelta'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Zven') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Thanatos (Park Seung-gyu)', 'Loki (Lee Sang-min)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Zzk (Kwon Hee-won)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Ayu (Andrey Saraiva)', 'JoJo (Gabriel Dzelme)', 'Tutsz', 'Wiz'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Bot') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Marvin', 'Leandrinn', 'Morttheus', 'VIN (Trần Hoài Vinh)', 'Siwoo', 'Kakkun', 'HeiYue', 'Xiaorui', 'Banye', 'LazyFeel', 'VENDRICK', 'Pain (Lê Quốc Anh)', 'Chips (Gong Jia-Hao)', 'Slayer (Kim Jin-young)', 'Way (Han Gil)', 'Balder', 'Yojin', 'Fishone', 'Leaper', 'Caliste', 'Lyonz', 'Dimitry', 'Diable', 'Smash (Sin Geum-jae)', 'ScaryJerry'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Jungle') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Levizin', 'Jungoat', 'Iyy', 'Hizto', 'Courage (Jeon Hyun-min)', 'Kazuto', '9God', 'Climber', 'Tatu (Pedro Seixas)', 'Jiwoo', 'Kaiwing', 'Delight', 'Cadence', 'Vincenzo (Ha Seung-min)', 'Leigg', 'Glfs', 'SkewMond', 'Summit', '5t5', 'Evewin', 'Iwandy', 'Morgan', 'Sounda', 'RYue', 'ChinX', 'Mxx', 'Reufury', 'Tomio', 'Van (Kim Seung-hoo)', 'Jcom', 'HotPot', 'Xzz', 'M0chi'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Mid') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('TT (Trần Quốc Thanh)', 'Mentality (Wei Guan-Zhen)', 'Xiaocaobao', 'Claws', 'Zinie', 'Xiaoka', 'Guapi', 'Ninefog', 'Zeus', 'Kemish', 'Heru', 'Ranchen', 'Viper (Park Do-hyeon)', 'Dire', 'Loki (Lee Sang-min)', 'Kamiloo', 'Sovereign (Alexander Folley)', 'Saber (Song Dai-Lin)', 'Czajek', 'Raes', 'Pungyeon', 'Yummy', 'Saint (Kang Sung-in)', 'Ceo', 'Charlotte (Xue Le-Hui)', 'Neadz'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Support') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yomiya', 'TheHank', 'TopLop', 'Yume (Châu Kim Bảo)', 'Godtone', 'OvO', 'Ycx', 'Sunlight (Jin Zi-Yang)', 'Tahahy', 'SiuLoong', 'Erha', 'Rich (Lee Jae-won)', 'Cadence', 'Mun', '225', 'Vital', 'Tangyuan', 'Voice', 'Stend', 'Cloud (Moon Hyeon-ho)', 'Gabn', 'Teddy', 'Kerry', 'Gemini'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Top') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xinsheng', 'Maple Syrup', 'Chungy', 'Rineko', 'Nuo', 'Mihile', 'Lancer', 'Siwoo', 'SYWJJ', 'Keine', 'Casting', 'Warrior (Nguyễn Phú Thanh)', 'Berserker (Kim Min-cheol)', 'ZUIAN', 'GuanGuan', 'Forlin', 'Pool', 'Liangchen', '225', 'Haetae', 'Rooster', 'Steller', 'RYue', 'Srtty', 'Nanaue (Phùng Đức Tài)', 'PO8', 'Prey (Xu Jia-Hao)', 'Carlsen', 'Meifan', 'Lqh', 'Beluga', 'Juice', 'Kellin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Algeria') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xenogan'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Argentina') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('ScaryJerry'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Australia') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Evewin', 'Getback', 'Maple Syrup', '225'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Brazil') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Marvin', 'Levizin', 'Leandrinn', 'Morttheus', 'Tatu (Pedro Seixas)', 'Redentor', 'Forlin'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Canada') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Tomio'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Chile') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Neadz'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='China') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xinsheng', 'Yomiya', 'Rineko', 'Mentality (Wei Guan-Zhen)', 'TheHank', 'Nuo', 'Xiaocaobao', 'HeiYue', 'Xiaorui', 'Jungoat', 'OvO', 'Iyy', 'Xiaoka', 'Ycx', 'Sunlight (Jin Zi-Yang)', '9God', 'Ninefog', 'ZUIAN', 'Climber', 'Ranchen', 'Pool', 'Liangchen', 'Leigg', 'Glfs', '5t5', 'Fishone', 'Saber (Song Dai-Lin)', 'Mxx', 'PO8', 'Prey (Xu Jia-Hao)', 'Yummy', 'Charlotte (Xue Le-Hui)', 'Lqh', 'Beluga', 'Juice'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Denmark') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Carlsen'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='France') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kamiloo', 'SkewMond', 'Stend'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hong Kong') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('SYWJJ', 'Cadence'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Lithuania') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Toaster'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Mexico') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('ChinX', 'Mun'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Morocco') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Nuc'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='New Zealand') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Gabn', 'VENDRICK', 'Guapi'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Poland') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Czajek'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Saudi Arabia') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Selson'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='South Korea') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Mihile', 'Lancer', 'Siwoo', 'Courage (Jeon Hyun-min)', 'Zinie', 'Casting', 'Heru', 'Kemish', 'Vincenzo (Ha Seung-min)', 'Haetae', 'Loki (Lee Sang-min)', 'Slayer (Kim Jin-young)', 'Rooster', 'Sounda', 'Leaper', 'Pungyeon', 'Diable', 'Van (Kim Seung-hoo)', 'Cloud (Moon Hyeon-ho)', 'Smash (Sin Geum-jae)', 'Saint (Kang Sung-in)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Taiwan') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('HotPot', 'GuanGuan', 'RYue', 'Kerry'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Turkey') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hypnos'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='United States') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Srtty', 'Young (Young Choi)', 'Fiji'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Vietnam') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Kisee', 'LazyFeel', 'Hizto', 'Nanaue (Phùng Đức Tài)', 'Kazuto', 'Claws', 'TT (Trần Quốc Thanh)', 'Warrior (Nguyễn Phú Thanh)', 'Dire', 'Jcom', 'Yume (Châu Kim Bảo)', 'Balder', 'Tahahy', 'SiuLoong', 'Pain (Lê Quốc Anh)', 'Steller'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Worlds Finalist') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xun', 'ON', 'Elk', 'Wei (Yan Yang-Wei)', 'Knight (Zhuo Ding)')))));
-- Downdate rules --
UPDATE rules_rule SET key='Cariok' WHERE key='CarioK';
UPDATE rules_rule SET key='Exakick' WHERE key='3XA';
UPDATE rules_rule SET key='Frostyy' WHERE key='Frosty (José Eduardo)';
UPDATE rules_rule SET key='HH (Lee Hyun-ho)' WHERE key='Luon';
UPDATE rules_rule SET key='JieJie' WHERE key='Jiejie';
UPDATE rules_rule SET key='Jojo (Gabriel Dzelme)' WHERE key='JoJo (Gabriel Dzelme)';
UPDATE rules_rule SET key='Juejuezi' WHERE key='Sasi (Yan Rui)';
UPDATE rules_rule SET key='Kabbie' WHERE key='Sanghyeon';
UPDATE rules_rule SET key='Me' WHERE key='Lucius';
UPDATE rules_rule SET key='Oddie' WHERE key='Oddielan';
UPDATE rules_rule SET key='Optimus' WHERE key='C7N';
UPDATE rules_rule SET key='Piloto' WHERE key='Pilot (Elvis Vergara)';
UPDATE rules_rule SET key='Reble' WHERE key='Kice';
UPDATE rules_rule SET key='Reeker' WHERE key='RKR';
UPDATE rules_rule SET key='SMILEY (Ludvig Granquist)' WHERE key='Smiley (Ludvig Granquist)';
UPDATE rules_rule SET key='Scary (Artur Queiroz)' WHERE key='SCARY (Artur Queiroz)';
UPDATE rules_rule SET key='Steel' WHERE key='Wuming (Wang Xin)';
UPDATE rules_rule SET key='VULCAN (Philippe Laflamme)' WHERE key='Vulcan (Philippe Laflamme)';
UPDATE rules_rule SET key='Vince (Trần Hoài Vinh)' WHERE key='VIN (Trần Hoài Vinh)';
UPDATE rules_rule SET key='Yzi' WHERE key='Yge';
-- Remove new rules --
DELETE FROM rules_rule WHERE key in (
'BNK FEARX',
'Bren Esports',
'DN Freecs',
'Disguised',
'Fluxo W7M',
'Isurus Estral',
'LYON (2024 American Team)',
'MGN Vikings Esports',
'Movistar KOI',
'TALON (Hong Kong Team)',
'Team Secret Whales',
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
'Fishone',
'Forlin',
'Gabn',
'Glfs',
'GuanGuan',
'Guapi',
'Haetae',
'HeiYue',
'Heru',
'Hizto',
'HotPot',
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
'Yume (Châu Kim Bảo)',
'Yummy',
'ZUIAN',
'Zinie',
'Worlds 2024 Participant'
);
COMMIT;