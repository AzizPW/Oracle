<<<<<<< HEAD
SELECT
SERVERPROPERTY('Edition') AS 'Edition',
SERVERPROPERTY('ProductVersion') AS 'ProductVersion',
SERVERPROPERTY('ProductLevel') AS 'ProductLevel',
SERVERPROPERTY('ResourceLastUpdateDateTime') AS 'ResourceLastUpdateDateTime',
SERVERPROPERTY('ResourceVersion') AS 'ResourceVersion'
GO

SELECT
   SERVERPROPERTY ('MachineName') AS PhysicalMachineName,
   SERVERPROPERTY ('ServerName') AS SQLServerName,
   SERVERPROPERTY ('Edition') AS ServerEdition,
   CAST(SUBSTRING(@@Version,charindex('SQL',@@version, 1),15) AS VARCHAR(255)) +  ' + ' 
       + CAST (SERVERPROPERTY ('productlevel')AS VARCHAR (50)) + ' + (Build'
       + CAST (SERVERPROPERTY ('ProductVersion') AS VARCHAR (50)) +')' AS ProductVersion,
    RIGHT(@@version, (Len(@@Version)-charindex('Windows',@@version, 1))+1) AS [O.S.],
=======
SELECT
SERVERPROPERTY('Edition') AS 'Edition',
SERVERPROPERTY('ProductVersion') AS 'ProductVersion',
SERVERPROPERTY('ProductLevel') AS 'ProductLevel',
SERVERPROPERTY('ResourceLastUpdateDateTime') AS 'ResourceLastUpdateDateTime',
SERVERPROPERTY('ResourceVersion') AS 'ResourceVersion'
GO

SELECT
   SERVERPROPERTY ('MachineName') AS PhysicalMachineName,
   SERVERPROPERTY ('ServerName') AS SQLServerName,
   SERVERPROPERTY ('Edition') AS ServerEdition,
   CAST(SUBSTRING(@@Version,charindex('SQL',@@version, 1),15) AS VARCHAR(255)) +  ' + ' 
       + CAST (SERVERPROPERTY ('productlevel')AS VARCHAR (50)) + ' + (Build'
       + CAST (SERVERPROPERTY ('ProductVersion') AS VARCHAR (50)) +')' AS ProductVersion,
    RIGHT(@@version, (Len(@@Version)-charindex('Windows',@@version, 1))+1) AS [O.S.],
>>>>>>> 327b5e2c2d7f1e6078f5d0c4cff716a75d749ca2
 SERVERPROPERTY ('Collation') AS Collation