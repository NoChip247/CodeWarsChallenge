You are working with a database that stores information about employees in a tech firm.  
The database includes a table named **employees** with the following columns:  

- **employee_id**: A unique integer identifier for each employee.  
- **full_name**: A string representing the employee's full name.  
- **team**: A string that specifies which team the employee is part of. The team can be one of the following four: `"backend"`, `"frontend"`, `"devops"`, or `"design"`.  
- **birth_date**: A date that represents the employee's birthdate.  

The company is planning an event where the youngest employee from each team will be given a chance to share their vision of future technology trends.  

Your task is to write an SQL query that retrieves the complete record for the youngest member of each team.  
You should consider the person with the **latest birthdate** as the youngest.  
Let's assume for this task that there are **no youngest employees who share the same birthdate**.  

The classical solution of using aggregate function and **GROUP BY** is forbidden.  
Can you come up with something more witty?  

The result should be ordered by **team** in ascending alphabetical order.  

Good luck!  

---

### Desired Output  

| employee_id | full_name   | team     | birth_date  |
|-------------|-------------|----------|-------------|
| 11          | John Doe    | backend  | 1980-12-01  |
| 7           | Jane Smith  | design   | 1985-05-03  |
| 24          | Bob Jones   | devops   | 1990-04-15  |
| 54          | Dana Smith  | frontend | 1995-05-03  |

---

### Solution  

```sql
SELECT 
    employee_id, 
    full_name, 
    team, 
    birth_date
FROM (
    SELECT 
        *, 
        ROW_NUMBER() OVER (PARTITION BY team ORDER BY birth_date DESC) AS rn
    FROM employees
) sub
WHERE rn = 1
ORDER BY team ASC
```

---

### Note

C'est la première fois que j'utilise une sous-requête sous cette forme `(...) sub`. Voici quelques explication pour ne pas oublier : 

Une **inline subquery** `FROM (…) sub` utile pour des requêtes simples ou ponctuelles. On met une requête entre parenthèse dans le `FROM`, en lui attribuant l'alias `sub`, ce qui permet de modifier une table rapidement avant de la requêter.

Comparaison avec structure classique `WITH AS`
| Structure | Utilité |
|-----------|---------|
| (...) sub | Sous-requête inline, utile pour des requêtes simples ou ponctuelles |
| WITH ... AS (...) | CTE, plus lisible et réutilisable dans des requêtes longues |

Ce que fait la sous-requête utilisée :
1. **ROW_NUMBER()**
- C’est une fonction SQL qui numérote les lignes dans un ensemble de résultats.
- Elle recommence à 1 pour chaque groupe défini par PARTITION BY.
2. **PARTITION BY team**
- Cela signifie que la numérotation se fait par équipe.
- Chaque équipe aura ses propres rangs commençant à 1.
3. **ORDER BY birth_date DESC**
- Les employés sont triés du plus jeune au plus âgé (car DESC = décroissant).
- Donc, le plus jeune dans chaque équipe aura rn = 1.

---

Version encore plus simple qui permet de :
- répondre au challenge
- sans utiliser GROUP BY et MIN/MAX
```sql
SELECT DISTINCT ON (team) * 
FROM employees
ORDER BY team, birth_date DESC
```
