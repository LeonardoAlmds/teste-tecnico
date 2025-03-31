LOAD DATA INFILE '/var/lib/mysql-files/1T2024.csv'
INTO TABLE T1_2024
CHARACTER SET utf8mb4 
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@`data`, @REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, @VL_SALDO_INICIAL, @VL_SALDO_FINAL)
SET 
	REG_ANS = TRIM(LEADING '0' FROM @REG_ANS),
    `data` = STR_TO_DATE(@`data`, '%Y-%m-%d'),
    VL_SALDO_INICIAL = REPLACE(@VL_SALDO_INICIAL, ',', '.'),
    VL_SALDO_FINAL = REPLACE(@VL_SALDO_FINAL, ',', '.');

LOAD DATA INFILE '/var/lib/mysql-files/2T2024.csv'
INTO TABLE T2_2024
CHARACTER SET utf8mb4 
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@`data`, @REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, @VL_SALDO_INICIAL, @VL_SALDO_FINAL)
SET 
	REG_ANS = TRIM(LEADING '0' FROM @REG_ANS),
    `data` = STR_TO_DATE(@`data`, '%Y-%m-%d'),
    VL_SALDO_INICIAL = REPLACE(@VL_SALDO_INICIAL, ',', '.'),
    VL_SALDO_FINAL = REPLACE(@VL_SALDO_FINAL, ',', '.');

LOAD DATA INFILE '/var/lib/mysql-files/3T2024.csv'
INTO TABLE T3_2024
CHARACTER SET utf8mb4 
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@`data`, @REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, @VL_SALDO_INICIAL, @VL_SALDO_FINAL)
SET 
	REG_ANS = TRIM(LEADING '0' FROM @REG_ANS),
    `data` = STR_TO_DATE(@`data`, '%Y-%m-%d'),
    VL_SALDO_INICIAL = REPLACE(@VL_SALDO_INICIAL, ',', '.'),
    VL_SALDO_FINAL = REPLACE(@VL_SALDO_FINAL, ',', '.');

LOAD DATA INFILE '/var/lib/mysql-files/4T2024.csv'
INTO TABLE T4_2024
CHARACTER SET utf8mb4 
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@`data`, @REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, @VL_SALDO_INICIAL, @VL_SALDO_FINAL)
SET 
    REG_ANS = TRIM(LEADING '0' FROM @REG_ANS),
	`data` = STR_TO_DATE(@`data`, '%Y-%m-%d'),
    VL_SALDO_INICIAL = REPLACE(@VL_SALDO_INICIAL, ',', '.'),
    VL_SALDO_FINAL = REPLACE(@VL_SALDO_FINAL, ',', '.');