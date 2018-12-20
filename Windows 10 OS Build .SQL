Select Distinct	
		RS.Netbios_Name0 as 'System Name' ,
		U.User_Name0 as 'User Name',
		U.Full_User_Name0 as 'Full Name',
			CASE GSE.ChassisTypes0
			WHEN '3' THEN 'Desktop'
			WHEN '4' THEN 'Desktop'
			WHEN '6' THEN 'Desktop'
			WHEN '7' THEN 'Desktop'
			WHEN '13' THEN 'Desktop'
			WHEN '15' THEN 'Desktop'
			WHEN '8' THEN 'Laptop'
			WHEN '8' THEN 'Laptop'
			WHEN '9' THEN 'Laptop'
			WHEN '10' THEN 'Laptop'
			WHEN '11' THEN 'Laptop'
			WHEN '12' THEN 'Laptop'
			WHEN '17' THEN 'Laptop'
			WHEN '18' THEN 'Laptop'
			ELSE 'Unknown'
			END as 'Desktop/Laptop',
		CASE GCS.Model0  
			WHEN 'DSDT_PRJ' THEN 'HP Compaq 8100 Elite SFF PC'
			ELSE GCS.Model0
			END as 'Model',
		SE.SerialNumber0 as 'Serial Number',
		OS.Caption0 as 'Operating System Version',
		CASE OS.BuildNumber0
			WHEN '10240' THEN 'Windows 10 1507'
			WHEN '14393' THEN 'Windows 10 1607'
			WHEN '10586' THEN 'Windows 10 1511'
			WHEN '15063' THEN 'Windows 10 1703'
			WHEN '16299' THEN 'Windows 10 1709'
			WHEN '17134' THEN 'Windows 10 1803'
			WHEN '17763' THEN 'Windows 10 1809'
			ELSE 'Unknown'
			END as 'Build Number',
			RS.Active0 as '1=Active, 0=Inactive'
		

from v_R_System RS
LEFT JOIN v_GS_SYSTEM_ENCLOSURE SE
ON RS.ResourceID = SE.ResourceID

LEFT JOIN v_GS_COMPUTER_SYSTEM GCS
ON RS.ResourceID = GCS.ResourceID

LEFT JOIN
	v_GS_OPERATING_SYSTEM as OS
	ON OS.ResourceID = RS.ResourceID

LEFT JOIN
	v_R_User as U
	ON U.User_Name0 = RS.User_Name0

LEFT JOIN
	v_GS_WORKSTATION_STATUS as WS
	ON WS.ResourceID = RS.ResourceID

LEFT JOIN
	v_GS_SYSTEM_ENCLOSURE as GSE
	ON GSE.ResourceID = RS.ResourceID

WHERE
	GCS.Model0 != 'Virtual Machine'
	AND
	GCS.Model0 != 'VMware Virtual Platform'
	AND
	GCS.Model0 != 'Parallels Virtual Platform'
	
