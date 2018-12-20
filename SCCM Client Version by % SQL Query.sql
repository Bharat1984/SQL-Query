
Declare @CollectionID Varchar(8)
Set @CollectionID = 'SMS00001'
Select sys.Client_version0 as 'Client Version',
CASE
WHEN client_version0 = '5.00.7711.0000' Then'SCCM 2012 RTM'
WHEN client_version0 = '5.00.7711.0200'Then'SCCM 2012 RTM - CU1'
WHEN client_version0 = '5.00.7711.0301'Then'SCCM 2012 RTM - CU2'
WHEN client_version0 = '5.00.7804.1000'Then'SCCM 2012 SP1'
WHEN client_version0 = '5.00.7804.1202'Then'SCCM 2012 SP1 - CU1'
WHEN client_version0 = '5.00.7804.1300'Then'SCCM 2012 SP1 - CU2'
WHEN client_version0 = '5.00.7804.1400'Then'SCCM 2012 SP1 - CU3'
WHEN client_version0 = '5.00.7804.1500'Then'SCCM 2012 SP1 - CU4'
WHEN client_version0 = '5.00.7804.1600'Then'SCCM 2012 SP1 - CU5'
WHEN client_version0 = '5.00.7958.1000'Then'SCCM 2012 R2'
WHEN client_version0 = '5.00.7958.1203'Then'SCCM 2012 R2 - CU1'
WHEN client_version0 = '5.00.7958.1303'Then'SCCM 2012 R2 - CU2'
WHEN client_version0 = '5.00.7958.1401'Then'SCCM 2012 R2 - CU3'
WHEN client_version0 = '5.00.7958.1501'Then'SCCM 2012 R2 - CU4'
WHEN client_version0 = '5.00.7958.1604'Then'SCCM 2012 R2 - CU5'
WHEN client_version0 = '5.00.8239.1000'Then'SCCM 2012 R2 SP1'
WHEN client_version0 = '5.00.8239.1203'Then'SCCM 2012 R2 SP1 - CU1'
WHEN client_version0 = '5.00.8239.1301'Then'SCCM 2012 R2 SP1 - CU2'
WHEN client_version0 = '5.00.8239.1403'Then'SCCM 2012 R2 SP1 - CU3'
WHEN client_version0 = '5.00.8239.1501'Then'SCCM 2012 R2 SP1 - CU4'
WHEN client_version0 = '5.00.8325.1000'Then'SCCM 1511'
WHEN client_version0 = '5.00.8355.1000'Then'SCCM 1602'
WHEN client_version0 = '5.00.8355.1306'Then'SCCM 1602 - UR1'
WHEN client_version0 = '5.00.8412.1007'Then'SCCM 1606'
WHEN client_version0 = '5.00.8412.1307'Then'SCCM 1606 - UR1'
WHEN client_version0 = '5.00.8458.1000-1007'Then'SCCM 1610'
WHEN client_version0 = '5.00.8458.1006-1008'Then'SCCM 1610 - Update 1, FW (KB3209501)'
WHEN client_version0 = '5.00.8458.1009'Then'SCCM 1610 - IU (KB3214042)'
WHEN client_version0 = '5.00.8458.1520'Then'SCCM 1610 - UR (KB4010155)'
WHEN client_version0 = '5.00.8498.1007'Then'SCCM 1702'
WHEN client_version0 = '5.00.8498.1711'Then'SCCM 1702- UR1 (KB4019926)'
WHEN client_version0 = '5.00.8540.1000'Then'SCCM 1706'
WHEN client_version0 = '5.00.8540.1005'Then'SCCM 1706 - Update 1, FW (KB4039380)'
WHEN client_version0 = '5.00.8540.1007'Then'SCCM 1706 - Update 2, FW(KB4036267)'
WHEN client_version0 = '5.00.8540.1611'Then'SCCM 1706 - UR1 (KB4042949)'
WHEN client_version0 = '5.00.8577.1000'Then'SCCM 1710'
WHEN client_version0 = '5.00.8577.1108'Then'SCCM 1710 UR1 (KB4057517)'
WHEN client_version0 = '5.00.8577.1115'Then'SCCM 1710 UR2 (KB4086143)'
WHEN client_version0 = '5.00.8634.1007'Then'SCCM 1802'
WHEN client_version0 = '5.00.8634.1814'Then'SCCM 1802'
WHEN client_version0 = '5.00.8634.1813'Then'SCCM 1802 UR (KB4163547)'
WHEN client_version0 = '5.00.8692.1003'Then'SCCM 1806'
WHEN client_version0 = '5.00.8740.1003'Then'SCCM 1810'

ELSE
client_version0
END as 'ConfigMgr Release',
Count(DISTINCT sys.ResourceID) as 'Client Count',
(STR((COUNT(sys.ResourceID)*100.0/(
Select COUNT(SYS.ResourceID)
From [CM_SiteCode].[dbo].v_FullCollectionMembership FCM INNER JOIN [CM_SiteCode].[dbo].V_R_System sys on FCM.ResourceID = SYS.ResourceID
Where FCM.CollectionID = @CollectionID
and
Sys.Client0= '1')),5,2)) + ' %' AS 'Percent %'
From [CM_SiteCode].[dbo].v_FullCollectionMembership FCM INNER JOIN [CM_SiteCode].[dbo].V_R_System sys on FCM.ResourceID = SYS.ResourceID
Where SYS.Client0 = '1' and FCM.CollectionID = @CollectionID
Group By sys.Client_version0
Order by sys.Client_version0 DESC
