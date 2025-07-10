-- 8. Proporcionar el Query que me traiga el precio del nodo (pml) en MDA y el precio en MTR del nodo 01ANS-85, 
-- ordenado por nodo (ascendente) , por fecha (descente) y ascendente por hora

SELECT
    COALESCE(mda.claNodo, mtr.claNodo) AS claNodo,
    COALESCE(mda.fecha, mtr.fecha) AS fecha,
    COALESCE(mda.hora, mtr.hora) AS hora,
    mda.pml AS pml_mda,
    mtr.pml AS pml_mtr
FROM
    MemSch.MemTraMDADet AS mda
FULL OUTER JOIN
    MemSch.MemTraMTRDet AS mtr ON mda.claNodo = mtr.claNodo
                               AND mda.fecha = mtr.fecha
                               AND mda.hora = mtr.hora
WHERE
    COALESCE(mda.claNodo, mtr.claNodo) = '01ANS-85'
ORDER BY
    claNodo ASC,
    fecha DESC,
    hora ASC;

-- 9. Proporciona el Query que me traiga el precio promedio por nodo en MTR y en MDA, 
-- y la diferencia de estos 2 precios promedio, ordenado por diferencia descendentemente.

WITH mda_promedio AS (
    SELECT
        claNodo,
        AVG(pml) AS pml_promedio_mda
    FROM
        MemSch.MemTraMDADet
    GROUP BY
        claNodo
),
mtr_promedio AS (
    SELECT
        claNodo,
        AVG(pml) AS pml_promedio_mtr
    FROM
        MemSch.MemTraMTRDet
    GROUP BY
        claNodo
)
SELECT
    COALESCE(mda.claNodo, mtr.claNodo) AS nodo,
    mda.pml_promedio_mda,
    mtr.pml_promedio_mtr,
    (mtr.pml_promedio_mtr - mda.pml_promedio_mda) AS diff_mda_mtr
FROM
    mda_promedio AS mda
FULL OUTER JOIN
    mtr_promedio AS mtr ON mda.claNodo = mtr.claNodo
ORDER BY
    diff_mda_mtr DESC;

-- 10.	Proporciona el precio de nodo en dlls tomando como tipo de cambio el campo valor que esta en la tabla MEMTraTcDet

WITH precios AS (
    SELECT claNodo, fecha, hora, pml FROM MemSch.MemTraMDADet
    UNION ALL
    SELECT claNodo, fecha, hora, pml FROM MemSch.MemTraMTRDet
)
SELECT
    p.claNodo,
    p.fecha,
    p.hora,
    p.pml,
    tc.valor AS tipo_de_cambio,
    (p.pml * tc.valor) AS pml_en_dolares
FROM
    precios AS p
INNER JOIN
    MemSch.MemTraTcDet AS tc ON p.fecha = tc.fecha
ORDER BY
    p.fecha,
    p.claNodo,
    p.hora;

-- 11.	Proporciona el listado de nodos por fecha, hora, de los precios de los nodos en mda y mtr, 
-- junto con el tipo de cambio y el precio de la tbfin

WITH precios AS (
    SELECT
        COALESCE(mda.claNodo, mtr.claNodo) AS claNodo,
        COALESCE(mda.fecha, mtr.fecha) AS fecha,
        COALESCE(mda.hora, mtr.hora) AS hora,
        mda.pml AS pml_mda,
        mtr.pml AS pml_mtr
    FROM
        MemSch.MemTraMDADet AS mda
    FULL OUTER JOIN
        MemSch.MemTraMTRDet AS mtr ON mda.claNodo = mtr.claNodo
                                   AND mda.fecha = mtr.fecha
                                   AND mda.hora = mtr.hora
)
SELECT
    p.claNodo,
    p.fecha,
    p.hora,
    p.pml_mda,
    p.pml_mtr,
    tc.valor AS tipo_de_cambio,
    tb.tbfin
FROM
    precios AS p
LEFT JOIN
    MemSch.MemTraTcDet AS tc ON p.fecha = tc.fecha
LEFT JOIN
    MemSch.MemTraTBFinVw AS tb ON p.fecha = tb.fecha
ORDER BY
    p.fecha,
    p.claNodo,
    p.hora;