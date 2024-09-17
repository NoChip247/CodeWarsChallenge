SELECT 
    id,
    CASE 
    WHEN base % factor = 0 THEN True 
    ELSE False 
    END AS res
FROM 
    kata
