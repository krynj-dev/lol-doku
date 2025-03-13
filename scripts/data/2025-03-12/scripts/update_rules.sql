BEGIN;
-- Update metadata --
INSERT INTO meta_dataupdate (date, app) VALUES ('2025-03-12', 'rules');
-- Adding new rules --
INSERT INTO rules_rule (key, rule_type) VALUES
;
-- Updating rules --
UPDATE rules_rule SET key='24 (Seyfi Onat Aytemiz)' WHERE key='24';
UPDATE rules_rule SET key='404 (Zhi Choong Sheng)' WHERE key='404';
UPDATE rules_rule SET key='Alfred (Alfredo González)' WHERE key='Alfred';
UPDATE rules_rule SET key='AnnieBot' WHERE key='Annie Bot';
UPDATE rules_rule SET key='Oleg (Oleg Karkachev)' WHERE key='Antik';
UPDATE rules_rule SET key='Sask' WHERE key='Assassin';
UPDATE rules_rule SET key='Astra (Eduard Fritz)' WHERE key='Astra';
UPDATE rules_rule SET key='Maximillion' WHERE key='Balta129';
UPDATE rules_rule SET key='Bipolar (Ramsay Lochhead Devaraj)' WHERE key='Bipolar';
UPDATE rules_rule SET key='Dispel' WHERE key='Blessing';
UPDATE rules_rule SET key='Bon0' WHERE key='BonO (Kim Gi-beom)';
UPDATE rules_rule SET key='Colin' WHERE key='CoLiN';
UPDATE rules_rule SET key='Crimson (Mert Koçak)' WHERE key='Crimson';
UPDATE rules_rule SET key='Crowdy' WHERE key='Crowno';
UPDATE rules_rule SET key='Dani (Phillex Bulanadi)' WHERE key='Dani';
UPDATE rules_rule SET key='Deant9' WHERE key='Deant';
UPDATE rules_rule SET key='Don Cholo (Sergio Salas)' WHERE key='Don Cholo';
UPDATE rules_rule SET key='Endless (Xu Hao)' WHERE key='Endless';
UPDATE rules_rule SET key='Fzzf' WHERE key='FZZF';
UPDATE rules_rule SET key='Grave' WHERE key='Gravepast';
UPDATE rules_rule SET key='Fate (Peng Jun-Jie)' WHERE key='Heal (Peng Jun-Jie)';
UPDATE rules_rule SET key='ICON' WHERE key='Icon';
UPDATE rules_rule SET key='JACTROLL' WHERE key='Jactroll';
UPDATE rules_rule SET key='KL (So Ka Lung)' WHERE key='KL';
UPDATE rules_rule SET key='Kagame (Yap Li Aw)' WHERE key='Kagame';
UPDATE rules_rule SET key='Kite (Kim Yong-yeon)' WHERE key='Kite';
UPDATE rules_rule SET key='Krastymel' WHERE key='Krastyel';
UPDATE rules_rule SET key='M1lo' WHERE key='Kuroko (Trần Tuấn Anh)';
UPDATE rules_rule SET key='Kino' WHERE key='LanPeiFang';
UPDATE rules_rule SET key='Last (Jeong Young-seok)' WHERE key='Last';
UPDATE rules_rule SET key='MAXI' WHERE key='Maxi';
UPDATE rules_rule SET key='Moesakr' WHERE key='Molto';
UPDATE rules_rule SET key='Mushroom (Zhang Xiao-Fu)' WHERE key='Mushroom';
UPDATE rules_rule SET key='NL (Hsiung Wen-An)' WHERE key='NL';
UPDATE rules_rule SET key='Omni (Thomas Trinh Dung)' WHERE key='Omni';
UPDATE rules_rule SET key='Only (Jordan Middleton)' WHERE key='Only';
UPDATE rules_rule SET key='SkyBart' WHERE key='Ouroboy';
UPDATE rules_rule SET key='OverT1me' WHERE key='Over T1me';
UPDATE rules_rule SET key='Ozgur (Can Özgür Kara)' WHERE key='Ozgur';
UPDATE rules_rule SET key='Doggy' WHERE key='Ozora';
UPDATE rules_rule SET key='Ptt' WHERE key='Pepiinero';
UPDATE rules_rule SET key='Hespo' WHERE key='Peraxy';
UPDATE rules_rule SET key='PrettyGRE' WHERE key='Pretty';
UPDATE rules_rule SET key='QingSi' WHERE key='Qingsi';
UPDATE rules_rule SET key='Aqiu' WHERE key='QiuQiu (Liang Jian)';
UPDATE rules_rule SET key='Henli' WHERE key='Rby';
UPDATE rules_rule SET key='ReM (Lee Hyeon-seo)' WHERE key='ReM';
UPDATE rules_rule SET key='REV' WHERE key='Revenge (Mohannad Alrashdi)';
UPDATE rules_rule SET key='Rise (Zhang Sheng)' WHERE key='Rise';
UPDATE rules_rule SET key='Motive' WHERE key='SUP (Cho Se-hee)';
UPDATE rules_rule SET key='Hamin' WHERE key='Sabo (Trần Nguyễn Anh Khoa)';
UPDATE rules_rule SET key='Sheep (Jamie Gallagher)' WHERE key='Sheep';
UPDATE rules_rule SET key='Sigma (Brent de Laet)' WHERE key='Sigma';
UPDATE rules_rule SET key='Sâyn (Aleš Gall)' WHERE key='Sâyn';
UPDATE rules_rule SET key='Turtle (Gabriel Peixoto)' WHERE key='Turtle';
UPDATE rules_rule SET key='Tomoe' WHERE key='Usopp (Nguyễn Quốc Mạnh)';
UPDATE rules_rule SET key='Value (Ross Luppino)' WHERE key='Value';
UPDATE rules_rule SET key='Vas1lii' WHERE key='Vasilii';
UPDATE rules_rule SET key='Vergil (Wang Hai-Han)' WHERE key='Vergil';
UPDATE rules_rule SET key='Wall (Son Chang-hoon)' WHERE key='Wall';
UPDATE rules_rule SET key='Wx' WHERE key='WeiXiao';
UPDATE rules_rule SET key='Wet' WHERE key='Winner (Woo Joo-sung)';
UPDATE rules_rule SET key='Xiaoweixiao' WHERE key='XiaoWeiXiao';
UPDATE rules_rule SET key='Alley' WHERE key='Xiaoyu (Zhou Yu)';
UPDATE rules_rule SET key='Yume (Danyll Jann Balisi)' WHERE key='Yume';
UPDATE rules_rule SET key='Yuri (Cha Hee-min)' WHERE key='Yuri';
UPDATE rules_rule SET key='ZekaS' WHERE key='Zecas';
UPDATE rules_rule SET key='Zkai' WHERE key='Zka1';
-- Inserting all new valid players --
INSERT INTO rules_rule_valid_players (player_id, rule_id) VALUES
;
-- Deactivate redendant teams
UPDATE rules_rule SET active=FALSE WHERE key in (

);
COMMIT;