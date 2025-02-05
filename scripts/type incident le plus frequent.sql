SELECT 
    ti.description AS type_incident,
    COUNT(r.idRetard) AS nombre_occurrences
FROM 
    Retard r
JOIN 
    Type_Incident ti ON r.idIncident = ti.idIncident
GROUP BY 
    ti.description
ORDER BY 
    nombre_occurrences DESC;
