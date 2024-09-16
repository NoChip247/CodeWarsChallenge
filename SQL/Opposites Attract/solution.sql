SELECT
  flower1,
  flower2,
  CASE 
    WHEN flower1 % 2 = 0 AND flower2 % 2 <> 0 THEN true
    WHEN flower1 % 2 <> 0 AND flower2 % 2 = 0 THEN true
    ELSE false
  END AS res
FROM love
