#Generated Form Function
function GenerateForm {
########################################################################
# Code Generated By: SAPIEN Technologies PrimalForms (Community Edition) v1.0.10.0
# Generated On: 20.10.2019 21:20
# Generated By: Luis Lüscher
########################################################################

#region Import the Assemblies
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
#endregion

#region Generated Form Objects
$form1 = New-Object System.Windows.Forms.Form
$textBox1 = New-Object System.Windows.Forms.TextBox
$btn_log = New-Object System.Windows.Forms.Button
$label2 = New-Object System.Windows.Forms.Label
$label1 = New-Object System.Windows.Forms.Label
$btn_create = New-Object System.Windows.Forms.Button
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
#endregion Generated Form Objects

#----------------------------------------------
#Generated Event Script Blocks
#----------------------------------------------
#Provide Custom Code for events specified in PrimalForms.
$handler_textBox1_TextChanged= 
{
#TODO: Place custom script here

}

$btn_create_OnClick= 
{
$disk = "E:\"

$folder = $textBox1.Text

$path = $disk + $folder

$networkdrive = "L"

$domain = "test.dom"

 

#Configuration for log file

$g_strLogPath = "C:\Users\Administrator\Documents\LogFiles\SMBLog\smb.log"

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

New-ADGroup -Path "OU=Folder,OU=Gruppen,OU=test.dom,dc=test,dc=dom" -Name $grouprw -GroupScope Global -GroupCategory Security 

 

#Define the group that need to be added

$grouprf = $driveletter + '-' + $folder + '_' + 'RF'

New-ADGroup -Path "OU=Folder,OU=Gruppen,OU=test.dom,dc=test,dc=dom" -Name $grouprf -GroupScope Global -GroupCategory Security 

 

#Creating folder for SMB share

New-Item -Path $path -ItemType Directory

writetolog "$path folder was created"

 

#Creating SMB Share folder

New-SmbShare -Name $folder -Path $path

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
$form1.close()

}

$btn_log_OnClick= 
{
Invoke-Item "C:\Users\Administrator\Documents\LogFiles\SMBLog\smb.log"

}

$OnLoadForm_StateCorrection=
{#Correct the initial state of the form to prevent the .Net maximized form issue
	$form1.WindowState = $InitialFormWindowState
}

#----------------------------------------------
#region Generated Form Code
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 260
$System_Drawing_Size.Width = 462
$form1.ClientSize = $System_Drawing_Size
$form1.DataBindings.DefaultDataSourceUpdateMode = 0
$form1.Name = "form1"
$form1.Text = "Primal Form"

$textBox1.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 197
$System_Drawing_Point.Y = 108
$textBox1.Location = $System_Drawing_Point
$textBox1.Name = "textBox1"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 144
$textBox1.Size = $System_Drawing_Size
$textBox1.TabIndex = 4
$textBox1.add_TextChanged($handler_textBox1_TextChanged)

$form1.Controls.Add($textBox1)


$btn_log.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 46
$System_Drawing_Point.Y = 225
$btn_log.Location = $System_Drawing_Point
$btn_log.Name = "btn_log"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 55
$btn_log.Size = $System_Drawing_Size
$btn_log.TabIndex = 3
$btn_log.Text = "Log"
$btn_log.UseVisualStyleBackColor = $True
$btn_log.add_Click($btn_log_OnClick)

$form1.Controls.Add($btn_log)

$label2.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 114
$System_Drawing_Point.Y = 111
$label2.Location = $System_Drawing_Point
$label2.Name = "label2"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 84
$label2.Size = $System_Drawing_Size
$label2.TabIndex = 2
$label2.Text = "Name of folder:"

$form1.Controls.Add($label2)

$label1.DataBindings.DefaultDataSourceUpdateMode = 0
$label1.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",15.75,0,3,0)

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 114
$System_Drawing_Point.Y = 9
$label1.Location = $System_Drawing_Point
$label1.Name = "label1"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 227
$label1.Size = $System_Drawing_Size
$label1.TabIndex = 1
$label1.Text = "Create Shared Folder"

$form1.Controls.Add($label1)


$btn_create.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 346
$System_Drawing_Point.Y = 225
$btn_create.Location = $System_Drawing_Point
$btn_create.Name = "btn_create"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 95
$btn_create.Size = $System_Drawing_Size
$btn_create.TabIndex = 0
$btn_create.Text = "Create Folder"
$btn_create.UseVisualStyleBackColor = $True
$btn_create.add_Click($btn_create_OnClick)

$form1.Controls.Add($btn_create)

#endregion Generated Form Code

#Save the initial state of the form
$InitialFormWindowState = $form1.WindowState
#Init the OnLoad event to correct the initial state of the form
$form1.add_Load($OnLoadForm_StateCorrection)
#Show the Form
$form1.ShowDialog()| Out-Null

} #End Function

#Call the Function
GenerateForm
