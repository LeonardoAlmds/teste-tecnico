-- Quais as 10 operadoras com maiores despesas em "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR" no último trimestre?
SELECT 
    o.Razao_Social, 
    SUM(t.VL_SALDO_FINAL) AS Total_Despesas
FROM T4_2024 t
JOIN operadoras_ativas o ON t.REG_ANS = o.Registro_ANS
WHERE t.DESCRICAO LIKE 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR'
GROUP BY o.Razao_Social
ORDER BY Total_Despesas DESC
LIMIT 10;

-- Quais as 10 operadoras com maiores despesas nessa categoria no último ano?
SELECT 
    o.Razao_Social, 
    SUM(t.VL_SALDO_FINAL) AS Total_Despesas
FROM (
    SELECT REG_ANS, VL_SALDO_FINAL, DESCRICAO FROM T1_2024
    UNION ALL
    SELECT REG_ANS, VL_SALDO_FINAL, DESCRICAO FROM T2_2024
    UNION ALL
    SELECT REG_ANS, VL_SALDO_FINAL, DESCRICAO FROM T3_2024
    UNION ALL
    SELECT REG_ANS, VL_SALDO_FINAL, DESCRICAO FROM T4_2024
) t
JOIN operadoras_ativas o ON t.REG_ANS = o.Registro_ANS
WHERE t.DESCRICAO LIKE 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR'
GROUP BY o.Razao_Social
ORDER BY Total_Despesas DESC
LIMIT 10;