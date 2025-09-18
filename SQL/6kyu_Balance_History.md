# Challenge

You need to write a sql query that will return the daily balance history from monetary operations tables for all the time.  

The balance of the day (end day balance) is equal to the balance at the begin of the day with total amount of operations during the day added.  
The balance at the begin of the day is equal to the balance at the end of the previous day.  
The balance before the very first operation is zero.  

### Input  

**operations**  

| Column | Type      |
|--------|-----------|
| amount | numeric   |
| date   | timestamp |

Sample data:  

| amount            | date                          |
|-------------------|-------------------------------|
| 502.944042810036  | 2020-01-01T00:01:00.000+00:00 |
| 1101.5004691791   | 2020-01-01T00:02:00.000+00:00 |
| 1618.92180791447  | 2020-01-01T00:03:00.000+00:00 |
| -1656.39770507234 | 2020-01-02T10:01:00.000+00:00 |
| 656.39770507234   | 2020-01-03T00:05:00.000+00:00 |
| -656.39770507234  | 2020-01-03T00:07:00.000+00:00 |
| 613.944042810036  | 2020-01-04T01:01:00.000+00:00 |
| ...               | ...                           |

### Output  

| Column  | Type    |
|---------|---------|
| date    | date    |
| balance | numeric |

Sample result:  

| date       | balance             |
|------------|---------------------|
| 2020-01-01 | 3223.3663199036064  |
| 2020-01-02 | 1566.9686148312664  |
| 2020-01-03 | 1566.9686148312664  |
| ...        | ...                 |

---

### Solution  

```sql
SELECT
  CAST(date AS DATE) AS date,
  SUM(SUM(amount)) OVER (ORDER BY CAST(date AS DATE)) AS balance
FROM operations
GROUP BY CAST(date AS DATE)
ORDER BY date ASC
```

# Explications

`CAST(date AS DATE)`  
Tronque la colonne date pour ne garder que la partie date (utile si date contient un timestamp).  
Permet de grouper par jour.

`SUM(amount)` (l’agrégat interne)  
Calculé par groupe (ici : par jour) grâce au GROUP BY.  
Produit une colonne intermédiaire — appelons-la daily_total — qui vaut la somme des amount pour chaque date.

`SUM(SUM(amount))` avec `OVER(...)` (l’agrégat externe)  
Le `SUM(...) OVER (...)` est une fonction fenêtre. Elle prend la colonne daily_total (le résultat de l’agrégation de groupe) et calcule une somme cumulative sur les lignes résultantes du GROUP BY.  
Autrement dit : pour chaque ligne (chaque date), elle additionne tous les daily_total depuis le début (ou depuis la borne définie) jusqu’à cette ligne.

`OVER (ORDER BY CAST(date AS DATE))`  
Définit l’ordre dans lequel la fenêtre est parcourue — ici en ordre chronologique des dates.  
Par défaut (si tu n’ajoutes pas une clause ROWS/RANGE), la plupart des SGBD utilisent une frame de type UNBOUNDED PRECEDING … CURRENT ROW, ce qui produit bien un running total (cumul jusqu’à la date courante).  
  
Remarque pratique : si plusieurs lignes ont exactement la même valeur d’ORDER BY, le comportement des égalités dépend du frame (RANGE vs ROWS). Pour être déterministe avec des doublons, tu peux écrire explicitement : `SUM(SUM(amount)) OVER (ORDER BY CAST(date AS DATE) ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)`

3) Ordre d’évaluation simplifié

Logiquement (ordre d’exécution) :

FROM → lecture des lignes.

WHERE (si présent).

GROUP BY CAST(date AS DATE) → création des lignes groupées, calcul de SUM(amount) pour chaque date (-> daily_total).

Fonctions fenêtre (SUM(...) OVER(...)) calculées sur ces lignes groupées.

ORDER BY final pour l’affichage.

4) Exemple concret

Données operations (timestamp + amount) :

2025-09-01 10:00 → 100

2025-09-01 15:00 → -20

2025-09-02 09:00 → 50

2025-09-03 12:00 → 25

2025-09-03 18:00 → -5

Après GROUP BY CAST(date AS DATE) (daily_total):

2025-09-01 → 80

2025-09-02 → 50

2025-09-03 → 20

Après SUM(SUM(amount)) OVER (ORDER BY date) (cumul) :

2025-09-01 → balance = 80

2025-09-02 → balance = 80 + 50 = 130

2025-09-03 → balance = 130 + 20 = 150

5) Pourquoi cette forme (au lieu de SUM(amount) OVER (...)) ?

Si tu fais SUM(amount) OVER (ORDER BY CAST(date AS DATE)) sans GROUP BY, le cumul se fera ligne par ligne (utile si chaque ligne est un événement) et les multiples enregistrements du même jour affecteront l’ordre des additions.

En groupant d’abord et en faisant SUM(SUM(amount)) OVER (...), tu obtiens un cumul par jour, ce qui est souvent l’intention quand on veut un solde quotidien.

6) Conseils pratiques

Si tu veux t’assurer d’un comportement strict en cas d’égalité sur la clé d’ordre, préfère ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW.

Pour la lisibilité, tu peux d’abord sélectionner SUM(amount) AS daily_total dans la colonne, puis appliquer la fenêtre sur cette colonne (même requête, mais plus explicite).

En résumé :

SUM(amount) = total par date (agrégation de groupe).

SUM(SUM(amount)) OVER (ORDER BY CAST(date AS DATE)) = cumul (running total) de ces totaux journaliers, ordonné par date.
