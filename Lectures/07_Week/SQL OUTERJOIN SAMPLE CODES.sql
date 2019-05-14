SELECT 
tblKitParts.SKU, tblKitParts.Description, tblKitParts.PCost, tblKitParts.Vender
FROM tblKitParts LEFT JOIN tblvender 
ON tblKitParts.Vender = tblvender.Vender;


SELECT 
tblKitParts.SKU, tblKitParts.Description, tblKitParts.PCost, tblvender.Vender, tblvender.ContactName
FROM tblKitParts RIGHT JOIN tblvender 
ON tblKitParts.Vender = tblvender.Vender;