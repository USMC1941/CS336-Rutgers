SELECT tblHistorySales.Customer, SUM(tblHistorySales.Qty) AS SumOfQty
FROM tblHistorySales
WHERE CarrierOptions NOT LIKE '%Bell%'
GROUP BY tblHistorySales.Customer
HAVING SUM(tblHistorySales.Qty)>4000
ORDER BY tblHistorySales.Customer;