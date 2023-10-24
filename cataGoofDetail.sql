USE culinaryCatastrophe
DROP TABLE IF EXISTS #cataGoof

SELECT

    r.recipeName,
	r.recipeType,
    r.recipeStars,
    r.costMultiplier,
	ROUND(
		COALESCE((r.costMultiplier*i1.SellPrice),0) + 
		COALESCE((r.costMultiplier*i2.SellPrice),0) + 
		COALESCE((r.costMultiplier*i3.SellPrice),0) + 
		COALESCE((r.costMultiplier*i4.SellPrice),0) + 
		COALESCE((r.costMultiplier*i5.SellPrice),0)
		, 0) AS recipeSellPrice,



		
		ISNULL(r.recipeIng1, '') AS ing1, ISNULL(i1.Sources, '') AS i1Source, 
		ISNULL(r.recipeIng2, '') AS ing2, ISNULL(i2.Sources, '') AS i2Source, 
		ISNULL(r.recipeIng3, '') AS ing3, ISNULL(i3.Sources, '') AS i3Source, 
		ISNULL(r.recipeIng4, '') AS ing4, ISNULL(i4.Sources, '') AS i4Source, 
		ISNULL(r.recipeIng5, '') AS ing5, ISNULL(i5.Sources, '') AS i5Source
    
INTO #cataGoof
 
FROM dbo.recipes r

    LEFT JOIN dbo.ingredients i1 ON i1.Name = r.recipeIng1
    LEFT JOIN dbo.ingredients i2 ON i2.Name = r.recipeIng2
    LEFT JOIN dbo.ingredients i3 ON i3.Name = r.recipeIng3
    LEFT JOIN dbo.ingredients i4 ON i4.Name = r.recipeIng4
    LEFT JOIN dbo.ingredients i5 ON i5.Name = r.recipeIng5
    
WHERE	ISNULL(i1.Sources,'') <> 'goofyStall' AND
		ISNULL(i2.Sources,'') <> 'goofyStall' AND
		ISNULL(i3.Sources,'') <> 'goofyStall' AND
		ISNULL(i4.Sources,'') <> 'goofyStall' AND
		ISNULL(i5.Sources,'') <> 'goofyStall' 


SELECT *
FROM #cataGoof a
/*
INNER JOIN(
			SELECT recipeType, MAX(recipeSellPrice) recipeSellPrice
			FROM #cataGoof
			GROUP BY recipeType
			) b ON a.recipeType = b.recipeType AND a.recipeSellPrice = b.recipeSellPrice

ORDER BY CASE
	WHEN a.recipeType = 'Appetizers' THEN 1
	WHEN a.recipeType = 'Entr�es' THEN 2
	WHEN a.recipeType = 'Desserts' THEN 3
END ASC
*/