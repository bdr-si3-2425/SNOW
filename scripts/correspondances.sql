
SELECT 
  VGC.idGare AS gare_correspondance,
  G.nom AS nom_gare,
  VHG.idLigne,
  VHG.idHoraire,
  VHG.heure_arrivee
FROM Vue_Gares_Correspondance VGC
JOIN Vue_Horaires_Gares VHG 
  ON VGC.idGare = VHG.idGare
JOIN Gare G 
  ON G.idGare = VGC.idGare
 group by VGC.idGare, G.nom, vhg.idligne, vhg.idhoraire, vhg.heure_arrivee
ORDER BY VGC.idGare, VHG.heure_arrivee;

SELECT 
  VGC.idGare AS gare_correspondance,
  G.nom AS nom_gare,
  VHG.idLigne,
  VHG.idHoraire,
  VHG.heure_arrivee
FROM Vue_Gares_Correspondance VGC
JOIN Vue_Horaires_Gares VHG 
  ON VGC.idGare = VHG.idGare
JOIN Gare G 
  ON G.idGare = VGC.idGare
ORDER BY VGC.idGare, VHG.heure_arrivee;









