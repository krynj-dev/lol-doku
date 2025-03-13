BEGIN;
-- Restore metadata --
DELETE FROM meta_dataupdate WHERE id in (SELECT id FROM meta_dataupdate WHERE app='rules' ORDER BY date DESC LIMIT 1);
-- Reactivate teams --
UPDATE rules_rule SET active=TRUE WHERE key in (

);
-- Delete all new valid players --
DELETE FROM rules_rule_valid_players WHERE id in (SELECT id FROM rules_rule_valid_players WHERE (
));
-- Downdate rules --
UPDATE rules_rule SET key='24' WHERE key='24 (Seyfi Onat Aytemiz)';
UPDATE rules_rule SET key='404' WHERE key='404 (Zhi Choong Sheng)';
UPDATE rules_rule SET key='Alfred' WHERE key='Alfred (Alfredo González)';
UPDATE rules_rule SET key='Annie Bot' WHERE key='AnnieBot';
UPDATE rules_rule SET key='Antik' WHERE key='Oleg (Oleg Karkachev)';
UPDATE rules_rule SET key='Assassin' WHERE key='Sask';
UPDATE rules_rule SET key='Astra' WHERE key='Astra (Eduard Fritz)';
UPDATE rules_rule SET key='Balta129' WHERE key='Maximillion';
UPDATE rules_rule SET key='Bipolar' WHERE key='Bipolar (Ramsay Lochhead Devaraj)';
UPDATE rules_rule SET key='Blessing' WHERE key='Dispel';
UPDATE rules_rule SET key='BonO (Kim Gi-beom)' WHERE key='Bon0';
UPDATE rules_rule SET key='CoLiN' WHERE key='Colin';
UPDATE rules_rule SET key='Crimson' WHERE key='Crimson (Mert Koçak)';
UPDATE rules_rule SET key='Crowno' WHERE key='Crowdy';
UPDATE rules_rule SET key='Dani' WHERE key='Dani (Phillex Bulanadi)';
UPDATE rules_rule SET key='Deant' WHERE key='Deant9';
UPDATE rules_rule SET key='Don Cholo' WHERE key='Don Cholo (Sergio Salas)';
UPDATE rules_rule SET key='Endless' WHERE key='Endless (Xu Hao)';
UPDATE rules_rule SET key='FZZF' WHERE key='Fzzf';
UPDATE rules_rule SET key='Gravepast' WHERE key='Grave';
UPDATE rules_rule SET key='Heal (Peng Jun-Jie)' WHERE key='Fate (Peng Jun-Jie)';
UPDATE rules_rule SET key='Icon' WHERE key='ICON';
UPDATE rules_rule SET key='Jactroll' WHERE key='JACTROLL';
UPDATE rules_rule SET key='KL' WHERE key='KL (So Ka Lung)';
UPDATE rules_rule SET key='Kagame' WHERE key='Kagame (Yap Li Aw)';
UPDATE rules_rule SET key='Kite' WHERE key='Kite (Kim Yong-yeon)';
UPDATE rules_rule SET key='Krastyel' WHERE key='Krastymel';
UPDATE rules_rule SET key='Kuroko (Trần Tuấn Anh)' WHERE key='M1lo';
UPDATE rules_rule SET key='LanPeiFang' WHERE key='Kino';
UPDATE rules_rule SET key='Last' WHERE key='Last (Jeong Young-seok)';
UPDATE rules_rule SET key='Maxi' WHERE key='MAXI';
UPDATE rules_rule SET key='Molto' WHERE key='Moesakr';
UPDATE rules_rule SET key='Mushroom' WHERE key='Mushroom (Zhang Xiao-Fu)';
UPDATE rules_rule SET key='NL' WHERE key='NL (Hsiung Wen-An)';
UPDATE rules_rule SET key='Omni' WHERE key='Omni (Thomas Trinh Dung)';
UPDATE rules_rule SET key='Only' WHERE key='Only (Jordan Middleton)';
UPDATE rules_rule SET key='Ouroboy' WHERE key='SkyBart';
UPDATE rules_rule SET key='Over T1me' WHERE key='OverT1me';
UPDATE rules_rule SET key='Ozgur' WHERE key='Ozgur (Can Özgür Kara)';
UPDATE rules_rule SET key='Ozora' WHERE key='Doggy';
UPDATE rules_rule SET key='Pepiinero' WHERE key='Ptt';
UPDATE rules_rule SET key='Peraxy' WHERE key='Hespo';
UPDATE rules_rule SET key='Pretty' WHERE key='PrettyGRE';
UPDATE rules_rule SET key='Qingsi' WHERE key='QingSi';
UPDATE rules_rule SET key='QiuQiu (Liang Jian)' WHERE key='Aqiu';
UPDATE rules_rule SET key='Rby' WHERE key='Henli';
UPDATE rules_rule SET key='ReM' WHERE key='ReM (Lee Hyeon-seo)';
UPDATE rules_rule SET key='Revenge (Mohannad Alrashdi)' WHERE key='REV';
UPDATE rules_rule SET key='Rise' WHERE key='Rise (Zhang Sheng)';
UPDATE rules_rule SET key='SUP (Cho Se-hee)' WHERE key='Motive';
UPDATE rules_rule SET key='Sabo (Trần Nguyễn Anh Khoa)' WHERE key='Hamin';
UPDATE rules_rule SET key='Sheep' WHERE key='Sheep (Jamie Gallagher)';
UPDATE rules_rule SET key='Sigma' WHERE key='Sigma (Brent de Laet)';
UPDATE rules_rule SET key='Sâyn' WHERE key='Sâyn (Aleš Gall)';
UPDATE rules_rule SET key='Turtle' WHERE key='Turtle (Gabriel Peixoto)';
UPDATE rules_rule SET key='Usopp (Nguyễn Quốc Mạnh)' WHERE key='Tomoe';
UPDATE rules_rule SET key='Value' WHERE key='Value (Ross Luppino)';
UPDATE rules_rule SET key='Vasilii' WHERE key='Vas1lii';
UPDATE rules_rule SET key='Vergil' WHERE key='Vergil (Wang Hai-Han)';
UPDATE rules_rule SET key='Wall' WHERE key='Wall (Son Chang-hoon)';
UPDATE rules_rule SET key='WeiXiao' WHERE key='Wx';
UPDATE rules_rule SET key='Winner (Woo Joo-sung)' WHERE key='Wet';
UPDATE rules_rule SET key='XiaoWeiXiao' WHERE key='Xiaoweixiao';
UPDATE rules_rule SET key='Xiaoyu (Zhou Yu)' WHERE key='Alley';
UPDATE rules_rule SET key='Yume' WHERE key='Yume (Danyll Jann Balisi)';
UPDATE rules_rule SET key='Yuri' WHERE key='Yuri (Cha Hee-min)';
UPDATE rules_rule SET key='Zecas' WHERE key='ZekaS';
UPDATE rules_rule SET key='Zka1' WHERE key='Zkai';
-- Remove new rules --
DELETE FROM rules_rule WHERE key in (

);
COMMIT;