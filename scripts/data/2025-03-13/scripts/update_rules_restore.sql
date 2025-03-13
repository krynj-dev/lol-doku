BEGIN;
-- Restore metadata --
DELETE FROM meta_dataupdate WHERE id in (SELECT id FROM meta_dataupdate WHERE app='rules' ORDER BY date DESC LIMIT 1);
-- Reactivate teams --
UPDATE rules_rule SET active=TRUE WHERE key in (
'Winterfox'
);
-- Delete all new valid players --
DELETE FROM rules_rule_valid_players WHERE id in (SELECT id FROM rules_rule_valid_players WHERE (
(rule_id=(SELECT id FROM rules_rule WHERE key='Evil Geniuses.NA') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Ken (Kenneth Tang)', 'ROBERTxLEE', 'ShorterACE', 'Inspired', 'Impact', 'Armao', 'Thinkcard', 'Shacker', 'Vulcan (Philippe Laflamme)', 'Eyla', 'Flaresz', 'Yellowpete', 'Ssumday', 'Innox', 'Snoopeh', 'Kaori', 'FBI', 'Yolo (Jang Hyeon-su)', 'Svenskeren', 'UNF0RGIVEN', 'Altec', 'Danny (Kyle Sakamaki)', 'Bang', 'IgNar', 'Avalon', 'Gleeb', 'Kumo', 'Jojopyun', 'Zeyzal', 'Deftly', 'Huni', 'Pobelter', 'Wickd', 'Ryoma', 'Goldenglue', 'Krepo', 'Helios (Shin Dong-jin)', 'Froggen', 'Revenge (Mohamed Kaddoura)', 'Contractz', 'Jiizuke', 'Paragon', 'Sheiden'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Fiji') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Risk (Thanawat Bualuang)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Getback') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Katsurii', 'Udysof', 'Pabu', 'Raise', 'Corporal', 'Totoro (Eun Jong-seop)', 'Praedyth', 'Rogue (Jake Sharwood)', 'Anderu', 'BioPanther', 'Souli'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Guns') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Shadow (Abderrahmen Smati)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hypnos') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Ruvelius', 'XnS', 'Noki', 'On1', 'Kebap', 'COldMemo', 'Unmngeable', 'Skewer', 'LVS', 'SPARKLE', 'UNZY', 'EL (Jeon Seong-hyeon)', 'ShawiKatami', 'Tatum'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Toaster') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('FORG1VEN', 'Hybrid (Glenn Doornenbal)', 'PowerOfEvil', 'Amazing (Maurice Stückenschneider)', 'SOAZ'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Young (Young Choi)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Licorice', 'River (Kim Dong-woo)', 'Stixxay', 'Huhi', 'Gori'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='5 Ronin') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hypnos'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Antic Esports') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Getback'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Astralis') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Toaster'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Dire Wolves') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Getback'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Galakticos') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hypnos'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Golden Guardians') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Young (Young Choi)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='J Team') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('RYue'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ultra Prime') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Young Miracles') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Amazing (Maurice Stückenschneider)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Toaster'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Anderu') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Getback'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='BaRoiBeo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yoshino', 'Slowz', 'Hiro02', 'Taki (Đinh Anh Tài)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='BioPanther') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Getback'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Bruce') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('RYue'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='C7N') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('TomRio', 'Gury', 'Jane', 'Qiang'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='COldMemo') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hypnos'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Corporal') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Getback'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='EL (Jeon Seong-hyeon)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hypnos'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Enso') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('RYue'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='FORG1VEN') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Toaster'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Famingjia') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Gori') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Young (Young Choi)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Gury') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('C7N', 'TomRio', 'Jane', 'Qiang'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='H4cker') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Heng') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hery') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hiro02') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yoshino', 'Slowz', 'BaRoiBeo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Huhi') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Young (Young Choi)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Hybrid (Glenn Doornenbal)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Toaster'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Insulator') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Irma') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Jane') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('C7N', 'Gury', 'TomRio', 'Qiang'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Katsurii') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Getback'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ke') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Kebap') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hypnos'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='LVS') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hypnos'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Lauva') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('RYue'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Licorice') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Young (Young Choi)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Long') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('RYue'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Miaoniu') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Minji') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('RYue'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Noki') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hypnos'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='On1') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hypnos'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Pabu') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Getback'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='PowerOfEvil') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Toaster'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Pqy') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Praedyth') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Getback'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Qiang') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('C7N', 'Gury', 'TomRio', 'Jane'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Qingtian') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='RYue') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Enso', 'Bruce', 'Minji', 'Long', 'Lauva'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Raise') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Getback'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Risk (Thanawat Bualuang)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Fiji'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='River (Kim Dong-woo)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Young (Young Choi)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Rogue (Jake Sharwood)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Getback'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Ruvelius') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hypnos'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='SOAZ') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Toaster'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='SPARKLE') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hypnos'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Shadow (Abderrahmen Smati)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Guns'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='ShawiKatami') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hypnos'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='ShiauC') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Skewer') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hypnos'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Slowz') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yoshino', 'Hiro02', 'BaRoiBeo', 'Taki (Đinh Anh Tài)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Smlz') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Souli') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Getback'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Stixxay') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Young (Young Choi)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Taki (Đinh Anh Tài)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Yoshino', 'Slowz', 'BaRoiBeo'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Tatum') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hypnos'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='TomRio') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('C7N', 'Gury', 'Jane', 'Qiang'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Totoro (Eun Jong-seop)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Getback'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='UNZY') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hypnos'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Udysof') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Getback'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Unmngeable') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hypnos'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Whisper (Zhang Yun-Hua)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='XPeke') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Toaster'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Xiaocaobao') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Ke', 'Heng', 'Zs', 'Irma', 'Pqy', 'Smlz', 'Insulator', 'Miaoniu', 'Qingtian', 'Yekai', 'ShiauC', 'H4cker', 'Famingjia', 'Xing (Liu Jia-Xing)', 'Hery', 'Whisper (Zhang Yun-Hua)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Xing (Liu Jia-Xing)') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='XnS') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hypnos'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Yekai') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Yoshino') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hiro02', 'Slowz', 'BaRoiBeo', 'Taki (Đinh Anh Tài)'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Zs') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Xiaocaobao'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Bot') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Hypnos', 'Toaster'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Jungle') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Fiji', 'Jane'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Mid') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Young (Young Choi)', 'Getback'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Support') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Qiang', 'Guns'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Top') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Gury', 'Slowz'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='France') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Caliste'))) OR
(rule_id=(SELECT id FROM rules_rule WHERE key='Tunisia') AND player_id IN (SELECT id FROM players_player WHERE display_name IN ('Guns')))));
-- Downdate rules --
UPDATE rules_rule SET key='ISC Pro Team' WHERE key='Bren Esports';
UPDATE rules_rule SET key='Bisbo' WHERE key='Biob';
UPDATE rules_rule SET key='Bunn' WHERE key='Seebulabu';
UPDATE rules_rule SET key='M1lo' WHERE key='Kuroko1';
UPDATE rules_rule SET key='Nogo' WHERE key='Zzeta';
UPDATE rules_rule SET key='Pain (Lê Quốc Anh)' WHERE key='Pain5';
UPDATE rules_rule SET key='Sanji (Tô Hoàng Đăng Phương)' WHERE key='Dipi';
UPDATE rules_rule SET key='Seraph' WHERE key='SERAPH';
UPDATE rules_rule SET key='Tomrio' WHERE key='TomRio';
UPDATE rules_rule SET key='VIN (Trần Hoài Vinh)' WHERE key='Vin (Trần Hoài Vinh)';
-- Remove new rules --
DELETE FROM rules_rule WHERE key in (
'Evil Geniuses.NA',
'Fiji',
'Getback',
'Guns',
'Hypnos',
'Toaster',
'Young (Young Choi)'
);
COMMIT;