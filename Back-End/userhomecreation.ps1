cls

[String] $user = "tksou"

[String] $newfoldername = "tksou"

[String] $Path = "\\MTZHWTK3LL08\Users\Administrator\Desktop\UserHomes"

[String] $dfsTarget = "\\MTZHWTK3LL08\Users\Administrator\Desktop\UserHomes\tksou"

[String] $dfsPath = "\\base.dom\Daten\zuerich\Homes"

[String] $dfsPathuser = "\\base.dom\Daten\zuerich\Homes\tksou"

 

 

$g_strLogPath = ".\PSExec.log.txt"

[DateTime] $g_dtNow = [DateTime]::Now

$g_strDtNow = $g_dtNow.ToString("yyyyMMdd")

[System.Text.StringBuilder]  $g_strArrLogContent = new-object System.Text.StringBuilder

 

Function WriteToLog([string] $strLine) {

    [DateTime] $dtNow = [DateTime]::Now

    $strLine = $dtNow.ToString("dd.MM.yyyy HH:mm:ss ") + $strLine

    Add-Content $g_strLogPath $strLine

    $g_strArrLogContent.Append($strLine) | Out-Null

    $g_strArrLogContent.Append("`r`n") | Out-Null

}

 

Function createuserhome {

    # Assign user's home directory path

    $homeDirectory = $dfsPathuser

    # Finally set their home directory and home drive letter in Active Directory

    Set-ADUser $user -HomeDirectory $homeDirectory -HomeDrive U

}

 

$Domain = (Get-WmiObject Win32_ComputerSystem).Domain

 

#Combining the two information

$newpath = $Path + '\' + $newfoldername

 

#Check if the folder already exists.

if (Test-Path $newpath -PathType Container) {

    WriteToLog "This folder already exists!"

}

else {

 

    #Display the whole path in the terminal

    WriteToLog "New Folder will be: $newpath"

 

 

    #Directory is get created by New-Item

    New-Item -path $newpath -Itemtype Directory

    #User get Full Controll of his folder

    $rule = new-object System.Security.AccessControl.FileSystemAccessRule ("$domain\$user", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")

    $acl = Get-ACL $newpath

    $acl.SetAccessRule($rule)

    Set-ACL -Path $newpath -AclObject $acl

    #Folder has been created message

    WriteToLog "New Folder $newfoldername has been created on $Path"

 

    if ($dfspath -eq '\\base.dom\Daten\Stamford\Homes') {

        #In this Case there is no DFS folder required

                

        createuserhome

 

        WritetoLog "$dfspath equals Stamford\homes no DFS Folder required"

    }               

 

    elseif ($dfspath -eq '\\base.dom\Daten\London\Homes') {

        #In this Case there is no DFS folder required

 

        createuserhome

 

        writetoLog "$dfspath equals London\homes no DFS Folder required"

    }

               

    elseif ($dfspath -eq '\\base.dom\Daten\Oslo\Homes') {

        #In this Case there is no DFS folder required

 

        #Directory is get created by New-Item

        createuserhome

 

        writetoLog "$dfspath equals Oslo\homes no DFS Folder required"

    }

 

    elseif ($dfspath -eq '\\base.dom\Daten\Milano\Homes') {

        #In this Case there is no DFS folder required

               

 

        #Directory is get created by New-Item

        createuserhome  

 

        writetoLog "$dfspath equals Milano\Homes no DFS Folder required"

    }

 

    elseif ($dfspath -eq '\\base.dom\Daten\Singapore\Homes') {

        #In this Case there is no DFS folder required

               

        #Directory is get created by New-Item

        createuserhome  

 

        writetoLog "$dfspath equals Singapore\Homes no DFS Folder required"

    }

 

    elseif ($dfspath -eq '\\base.dom\Daten\Frankfurt\Homes') {

        #In this Case there is no DFS folder required

               

        #Directory is get created by New-Item

        createuserhome   

 

        writetoLog "$dfspath equals Frankfurt\Homes no DFS Folder required"

    }

 

    elseif ($dfspath -eq '\\base.dom\Daten\Wien\Homes') {

        #In this Case there is no DFS folder required

               

        #Directory is get created by New-Item

        createuserhome  

 

        writetoLog "$dfspath equals Wien\Homes no DFS Folder required"

    }

 

    else {

        #In this Case there is an DFS Folder required

        writetoLog "$dfspath requires DFS folder"

 

        #Testing if the Dfsnpath already exits

        try {

            Get-DfsnFolderTarget -Path "$dfspathuser" -ErrorAction Stop

        }

        catch {

            WriteToLog "Path not found. Clear to proceed"

        }

 

        #Specify the necessary data for the variable $newdfsfolder.

        $NewDFSFolder = @{

            Path                  = $dfsPathuser

            State                 = 'Online'

            TargetPath            = $dfsTarget

            TargetState           = 'Online'

            ReferralPriorityClass = 'globalhigh'

        }

 

        #Creating the new DfsFolder

        New-DfsnFolder @NewDFSFolder

 

        #Output the userhome path at the end of the script and copy it to the clipboard.

        WriteToLog "The following path was created for the $user : $newpath."

    }

}