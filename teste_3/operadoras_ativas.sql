CREATE TABLE operadoras_ativas (
    Registro_ANS VARCHAR(6),
    CNPJ VARCHAR(14),
    Razao_Social VARCHAR(140),
    Nome_Fantasia VARCHAR(140),
    Modalidade VARCHAR(2),
    Logradouro VARCHAR(40),
    Numero VARCHAR(20),
    Complemento VARCHAR(40),
    Bairro VARCHAR(30),
    Cidade VARCHAR(30),
    UF CHAR(2),
    CEP VARCHAR(8),
    DDD VARCHAR(4),
    Telefone VARCHAR(20),
    Fax VARCHAR(20),
    Endereco_eletronico VARCHAR(255),
    Representante VARCHAR(50),
    Cargo_Representante VARCHAR(40),
    Regiao_de_Comercializacao INT,
    Data_Registro_ANS DATE
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