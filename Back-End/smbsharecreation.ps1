$disk = "E:\"

$folder = "INF-LEHRE"

$path = $path + $folder

$networkdrive = "N"

$domain = "test.dom"

 

#Configuration for log file

$g_strLogPath = "smb.log"

[DateTime] $g_dtNow=[DateTime]::Now

$g_strDtNow=$g_dtNow.ToString("yyyyMMdd")

[System.Text.StringBuilder]  $g_strArrLogContent = new-object System.Text.StringBuilder

 

Function WriteToLog([string] $strLine)

{

       [DateTime] $dtNow=[DateTime]::Now

       $strLine=$dtNow.ToString("dd.MM.yyyy HH:mm:ss ") + $strLine

       Add-Content $g_strLogPath $strLine

       $g_strArrLogContent.Append($strLine) | Out-Null

       $g_strArrLogContent.Append("`r`n") | Out-Null

}

writetolog "Script is starting"

 

#Define the driveletter

if ($networkdrive -eq "S"){

$driveletter = "L"

}

 

else {

$driveletter = $networkdrive

}

#Define the group that need to be added

$grouprw = $driveletter + '-' + $folder + '_' + 'RW'

 

 

#Define the group that need to be added

$grouprf = $driveletter + '-' + $folder + '_' + 'RF'

 

#Creating folder for SMB share

New-Item -Path $path -ItemType Directory

writetolog "$path folder was created"

 

#Creating SMB Share folder

New-SmbShare -name "$folder" -Path "$path"

writetolog "$folder was upgraded to an SMBShare."

 

#Setting SMB permissions for RW Group

$rule = new-object System.Security.AccessControl.FileSystemAccessRule("$grouprw","Modify", "ContainerInherit,ObjectInherit", "None", "Allow")

$acl = Get-ACL $path

$acl.SetAccessRule($rule)

Set-ACL -Path $path -AclObject $acl

 

#Setting SMB permissions for RF Group

$rule = new-object System.Security.AccessControl.FileSystemAccessRule("$grouprf","ReadandExecute", "ContainerInherit,ObjectInherit", "None", "Allow")

$acl = Get-ACL $path

$acl.SetAccessRule($rule)

Set-ACL -Path $path -AclObject $acl

 

#Remove Users default Read permission

 

# 1. Remove NTFS rights inheritance

$aclofusers = Get-Acl -Path $path

$aclofusers.SetAccessRuleProtection($True, $True)

Set-Acl -Path $path -AclObject $aclofusers

 

# 2. Remove the "Users" group from ACL

$colRights = [System.Security.AccessControl.FileSystemRights] "FullControl"

$InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]::None

$PropagationFlag = [System.Security.AccessControl.PropagationFlags]::None

$objType = [System.Security.AccessControl.AccessControlType]::Allow

$objUser = New-Object System.Security.Principal.SecurityIdentifier("S-1-5-32-545")

$objACE = New-Object System.Security.AccessControl.FileSystemAccessRule($objUser, $colRights, $InheritanceFlag, $PropagationFlag, $objType)

$objACL = Get-Acl $path

$objACL.RemoveAccessRuleAll($objACE)

Set-Acl $path $objACL