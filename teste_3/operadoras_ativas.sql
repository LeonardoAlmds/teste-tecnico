CREATE TABLE operadoras_ativas (
    Registro_ANS VARCHAR(6) PRIMARY KEY,
    CNPJ VARCHAR(14) NOT NULL UNIQUE,
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
(@Registro_ANS, CNPJ, Razao_Social, Nome_Fantasia, @Modalidade, Logradouro, Numero, Complemento, 
 Bairro, Cidade, UF, CEP, DDD, Telefone, Fax, Endereco_eletronico, Representante, 
 Cargo_Representante, @Regiao_de_Comercializacao, Data_Registro_ANS)
SET 
  Registro_ANS = TRIM(LEADING '0' FROM @Registro_ANS),
  Modalidade = 
    CASE 
      WHEN LOCATE(' ', @Modalidade) > 0 
      THEN CONCAT(LEFT(@Modalidade, 1), LEFT(SUBSTRING_INDEX(@Modalidade, ' ', -1), 1))
      ELSE LEFT(@Modalidade, 2)
    END,
  Regiao_de_Comercializacao = NULLIF(@Regiao_de_Comercializacao, '');