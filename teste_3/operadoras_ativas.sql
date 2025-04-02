CREATE TABLE operadoras_ativas (
    Registro_ANS VARCHAR(6) PRIMARY KEY,
    CNPJ VARCHAR(14) NOT NULL,
    Razao_Social VARCHAR(140) NOT NULL,
    Nome_Fantasia VARCHAR(140),
    Modalidade VARCHAR(2) NOT NULL,
    Logradouro VARCHAR(40) NOT NULL,
    Numero VARCHAR(20) NOT NULL,
    Complemento VARCHAR(40),
    Bairro VARCHAR(30) NOT NULL,
    Cidade VARCHAR(30) NOT NULL,
    UF CHAR(2) NOT NULL, 
    CEP VARCHAR(8) NOT NULL,
    DDD VARCHAR(4),
    Telefone VARCHAR(20),
    Fax VARCHAR(20),
    Endereco_eletronico VARCHAR(255) NOT NULL,
    Representante VARCHAR(50) NOT NULL,
    Cargo_Representante VARCHAR(40) NOT NULL,
    Regiao_de_Comercializacao INT,
    Data_Registro_ANS DATE NOT NULL
);

LOAD DATA INFILE '/var/lib/mysql-files/Relatorio_cadop.csv' 
INTO TABLE operadoras_ativas 
CHARACTER SET utf8mb4 
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS 
(@Registro_ANS, @CNPJ, @Razao_Social, @Nome_Fantasia, @Modalidade, @Logradouro, @Numero, @Complemento, 
 @Bairro, @Cidade, @UF, @CEP, @DDD, @Telefone, @Fax, @Endereco_eletronico, @Representante, 
 @Cargo_Representante, @Regiao_de_Comercializacao, @Data_Registro_ANS)
SET 
    Registro_ANS = TRIM(LEADING '0' FROM @Registro_ANS),
    Razao_Social = CASE WHEN TRIM(@Razao_Social) = '' THEN 'S/N' ELSE TRIM(@Razao_Social) END,
    Nome_Fantasia = CASE WHEN TRIM(@Nome_Fantasia) = '' OR @Nome_Fantasia REGEXP '^(\\*{2,}|S/ Nº|s/n|S/N|SN)$' THEN 'S/N' ELSE TRIM(@Nome_Fantasia) END,
    Modalidade = CASE 
                    WHEN TRIM(@Modalidade) = '' THEN 'S/N' 
                    WHEN LOCATE(' ', @Modalidade) > 0 
                    THEN CONCAT(LEFT(@Modalidade, 1), LEFT(SUBSTRING_INDEX(@Modalidade, ' ', -1), 1))
                    ELSE LEFT(@Modalidade, 2)
                END,
    Logradouro = CASE WHEN TRIM(@Logradouro) = '' THEN 'S/N' ELSE TRIM(@Logradouro) END,
    Numero = CASE WHEN TRIM(@Numero) = '' OR @Numero REGEXP '^(LOTE s/N|\\*{2,}|S/ Nº|s/n|S/N|SN)$' THEN 'S/N' ELSE TRIM(@Numero) END,
    Complemento = CASE WHEN TRIM(@Complemento) = '' OR @Complemento REGEXP '^(LOTE s/N|\\*{2,}|S/ Nº|s/n|S/N|SN)$' THEN 'S/N' ELSE TRIM(@Complemento) END,
    Bairro = CASE WHEN TRIM(@Bairro) = '' THEN 'S/N' ELSE TRIM(@Bairro) END,
    Cidade = CASE WHEN TRIM(@Cidade) = '' THEN 'S/N' ELSE TRIM(@Cidade) END,
    UF = CASE WHEN TRIM(@UF) = '' THEN 'S/N' ELSE TRIM(@UF) END,
    CEP = CASE WHEN TRIM(@CEP) = '' THEN 'S/N' ELSE TRIM(@CEP) END,
    DDD = CASE WHEN TRIM(@DDD) = '' THEN 'S/N' ELSE TRIM(@DDD) END,
    Telefone = CASE WHEN TRIM(@Telefone) = '' THEN 'S/N' ELSE TRIM(@Telefone) END,
    Fax = CASE WHEN TRIM(@Fax) = '' THEN 'S/N' ELSE TRIM(@Fax) END,
    Endereco_eletronico = CASE WHEN TRIM(@Endereco_eletronico) = '' THEN 'S/N' ELSE TRIM(@Endereco_eletronico) END,
    Representante = CASE WHEN TRIM(@Representante) = '' THEN 'S/N' ELSE TRIM(@Representante) END,
    Cargo_Representante = CASE WHEN TRIM(@Cargo_Representante) = '' THEN 'S/N' ELSE TRIM(@Cargo_Representante) END,
    Regiao_de_Comercializacao = NULLIF(TRIM(@Regiao_de_Comercializacao), ''),
    Data_Registro_ANS = CASE WHEN TRIM(@Data_Registro_ANS) = '' THEN NULL ELSE @Data_Registro_ANS END;