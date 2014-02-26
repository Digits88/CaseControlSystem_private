
update ClientFileMaster
set ClientID = ClientID - 60

SELECT cm.ClientID, cm.FirstName, cm.LastName,(CASE WHEN cm.IsActive = 1 THEN 'Yes' ELSE 'No'END) 'IsActive',cm.ClientCreatedOn,
cfm.FileID, lct.CaseType, cfm.CaseStatus,
ctd.TransactionID, ctd.TransactionDate, ctd.Description, ctd.BillingType, ctd.GeneralFund, ctd.TrustFund, ctd.CheckNo
FROM ClientMaster cm
LEFT JOIN ClientFileMaster cfm ON cfm.ClientID = cm.ClientID
LEFT JOIN LuCaseType lct ON lct.CaseTypeID = cfm.CaseTypeID
LEFT JOIN ClientTransactionDetails ctd ON ctd.FileID = cfm.FileID