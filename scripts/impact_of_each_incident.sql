SELECT Type_Incident.idIncident ident, 
COUNT(Retard.idRetard) nombre_occurrences, 
COALESCE(SUM(Retard.duree_retard), '00:00:00') retard_total 
FROM Type_Incident LEFT JOIN Retard ON Type_Incident.idIncident = Retard.idIncident
GROUP BY ident
ORDER BY retard_total DESC, nombre_occurrences DESC
