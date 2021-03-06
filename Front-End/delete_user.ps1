#Generated Form Function
function GenerateForm {
########################################################################
# Code Generated By: SAPIEN Technologies PrimalForms (Community Edition) v1.0.10.0
# Generated On: 28.10.2019 10:20
# Generated By: luisr
########################################################################

#region Import the Assemblies
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
#endregion

#region Generated Form Objects
$form1 = New-Object System.Windows.Forms.Form
$label2 = New-Object System.Windows.Forms.Label
$label1 = New-Object System.Windows.Forms.Label
$button1 = New-Object System.Windows.Forms.Button
$comboBox1 = New-Object System.Windows.Forms.ComboBox
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
#endregion Generated Form Objects

#Start Write-log function
    $path = "C:\Users\Administrator\Documents\LogFiles"
    $date = get-date -format "yyyy-MM-dd"
    $file = ("Log_" + $date + ".log")
    $logfile = $path + "\" + $file

    function Write-Log([string]$logtext, [int]$level = 0) {
        $logdate = get-date -format "yyyy-MM-dd HH:mm:ss"
        if ($level -eq 0) {
            $logtext = "[INFO] " + $logtext
            $text = "[" + $logdate + "] - " + $logtext
        }
        $text >> $logfile
    }
    Write-Log "Starting the application"


#----------------------------------------------
#Generated Event Script Blocks
#----------------------------------------------
#Provide Custom Code for events specified in PrimalForms.
$button1_OnClick= 
{
#Search User an delete him
$username = $ComboBox1.selectedItem 

Remove-ADUser -Identity $username -Confirm: $false
Write-Log "Removed AD-User"
$form1.close()

}

$OnLoadForm_StateCorrection=
{#Correct the initial state of the form to prevent the .Net maximized form issue
	$form1.WindowState = $InitialFormWindowState
}

#Some AD functions

#Get AD Users
$Users = get-aduser -filter * -Properties SamAccountName

Foreach ($User in $Users)
{
$ComboBox1.Items.Add($User.SamAccountName);
}
Write-Log "Get AD Users"
#----------------------------------------------
#region Generated Form Code
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 237
$System_Drawing_Size.Width = 318
$form1.ClientSize = $System_Drawing_Size
$form1.DataBindings.DefaultDataSourceUpdateMode = 0
$form1.Name = "form1"
$form1.Text = "Primal Form"

$label2.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 126
$System_Drawing_Point.Y = 83
$label2.Location = $System_Drawing_Point
$label2.Name = "label2"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 73
$label2.Size = $System_Drawing_Size
$label2.TabIndex = 3
$label2.Text = "Selecte User"

$form1.Controls.Add($label2)

$label1.DataBindings.DefaultDataSourceUpdateMode = 0
$label1.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",15.75,0,3,0)

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 103
$System_Drawing_Point.Y = 9
$label1.Location = $System_Drawing_Point
$label1.Name = "label1"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 127
$label1.Size = $System_Drawing_Size
$label1.TabIndex = 2
$label1.Text = "Delete User"

$form1.Controls.Add($label1)


$button1.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 216
$System_Drawing_Point.Y = 202
$button1.Location = $System_Drawing_Point
$button1.Name = "button1"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 90
$button1.Size = $System_Drawing_Size
$button1.TabIndex = 1
$button1.Text = "Delete User"
$button1.UseVisualStyleBackColor = $True
$button1.add_Click($button1_OnClick)

$form1.Controls.Add($button1)

$comboBox1.DataBindings.DefaultDataSourceUpdateMode = 0
$comboBox1.FormattingEnabled = $True
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 103
$System_Drawing_Point.Y = 109
$comboBox1.Location = $System_Drawing_Point
$comboBox1.Name = "comboBox1"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 21
$System_Drawing_Size.Width = 121
$comboBox1.Size = $System_Drawing_Size
$comboBox1.TabIndex = 0

$form1.Controls.Add($comboBox1)

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
