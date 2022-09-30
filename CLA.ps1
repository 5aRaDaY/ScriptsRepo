#
# Author: Maksym.Shnurkov
# Infopulse LLC
#
# Description: GUI script. ver. 1.2
# 

Import-Module ActiveDirectory
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.DirectoryServices")
$ErrorActionPreference = "silentlycontinue"
$PSDefaultParameterValues = @{"*-AD*:Server"='DC2-VM'}

$iconBase64 ='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Bxd27drJ+++/x6JFi/nyyx3IsoKamhquXStHrVbTt29fRo8ezbRp00lNTSU0NMwhSVIR8CawC/eJE0+Pu2hCLPATYLnT6exfVVUlFRae4MCBA5w5c5r6elf9vrOS25n/i4+PZ/DgFOLi4gkNDSU42OXb365ifC/U6SiZTCaqq6u5fr2KwsJCduz4N62trZ6qcFSUK2c5btw4hgwZQv/+A1CpVCagEPgE2A3Uw9fFk5t61iUdFgNMxxVEjLDZbL2qqiopLr7I6dNFnD9/jmvXvqKtrdVTjFQqlWi1WgIDAwkLC8fHx4fQ0FD3DnEtQUFB+PsH0Lt3L3eOX4NC4QLSbrdjtVppb+/AYGijqamJxsZGLBYLen0zN240otfrqa+vw2WrlERH9yc2Npbhw4cTHx9PXFw8wcHBQqFQtAOXgBzgIHCK2xy2uu3QdFkefYHhuDKsU4DBQgh/k8kkV1VVUlVVRXV1NcXFxdTUVNPY2IhOp8NsNmO32z31AVe7kmcDVeeofbNDDofDA6YkSWi1WkJDQwkICCAqqh+JiYlEREQSERFOv37R+Pr6CoVCYcF1uuwCcAg4AxQDekDc8xaZ24Ah4QonE4BEXJHVULem9HE4HBqbzSa1tbVRV1dHR0c7er3es83NbDbT2tqKyWTCbDZ3Oz3W6QX6+vqhVCpQq9WEhPTF29tVRe7bty8+Pt6oVGqnLMsWXAcsK4BS4DSuAsgVXBsk7+nA5beanF2miRZXpiXS/RuBy8vqiyutFgL44VpyOttTuH+7tu3EtR9BuK92oMktaIdbwMvADaAa1+nSOvcz53exMd+b2e4yZRS4HKvO47JBbqDAlYb3dj/v6oZbABOu47MCV1XnBl8fqbVyF1X+D/2Hvh39f/imXmayJw1uAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE4LTAzLTI2VDEzOjE4OjQ0KzAyOjAwz1H2qwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxOC0wMy0yNlQxMzoxODo0NCswMjowML4MThcAAABGdEVYdHNvZnR3YXJlAEltYWdlTWFnaWNrIDYuNy44LTkgMjAxNi0wNi0xNiBRMTYgaHR0cDovL3d3dy5pbWFnZW1hZ2ljay5vcmfmvzS2AAAAGHRFWHRUaHVtYjo6RG9jdW1lbnQ6OlBhZ2VzADGn/7svAAAAGHRFWHRUaHVtYjo6SW1hZ2U6OmhlaWdodAA1MTLA0FBRAAAAF3RFWHRUaHVtYjo6SW1hZ2U6OldpZHRoADUxMhx8A9wAAAAZdEVYdFRodW1iOjpNaW1ldHlwZQBpbWFnZS9wbmc/slZOAAAAF3RFWHRUaHVtYjo6TVRpbWUAMTUyMjA2MzEyNEdUwxAAAAATdEVYdFRodW1iOjpTaXplADYxLjRLQkIT9LDFAAAAQHRFWHRUaHVtYjo6VVJJAGZpbGU6Ly8uL3VwbG9hZHMvNTYvcEgyUzM3SC8xMzg4L2RhcnRodmFkZXJfOTYwMTQucG5nRlGIfAAAAABJRU5ErkJggg=='
$iconBytes       = [Convert]::FromBase64String($iconBase64)
# initialize a Memory stream holding the bytes
$stream          = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)


Function OnApplicationLoad {
	#Note: This function is not called in Projects
	#Note: This function runs before the form is created
	#Note: To get the script directory in the Packager use: Split-Path $hostinvocation.MyCommand.path
	#Note: To get the console output in the Packager (Windows Mode) use: $ConsoleOutput (Type: System.Collections.ArrayList)
	return $true #return true for success or false for failure
}

Function OnApplicationExit {
	#Note: This function is not called in Projects
	#Note: This function runs after the form is closed
	$script:ExitCode = 0 #Set the exit code for the Packager
}


Function IsThereText
{
	if(![string]::IsNullOrEmpty($TextBoxPass.text)) #only enable when you have text in the text box
    {
    $BtnReset.enabled = $true 	
    }
	
}


Function Search {
	
	$BtnSearch.enabled = $false 	
    $SearchUser = $TextBoxSearch.Text 
	$UserName="*"+$SearchUser+"*"         
	    
  if(![string]::IsNullOrWhiteSpace($TextBoxSearch.Text))
  {   
    $array_ad = New-Object System.Collections.ArrayList
    $Script:procInfo = @(Get-ADUser -Filter {Name -eq $SearchUser -or Name -like $UserName}).Name 
    $array_ad.AddRange(@($procInfo))  
    $ListBox.DataSource = $array_ad 
	$ListBox.Focus()
	$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#597d35")	
	$Statusbar.Text = "Search completed."
	$Statusbar.Visible = $true
	Start-Sleep -Seconds 1
    $Statusbar.Visible = $false    
  } 

  else
   {
    $Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ff0000")
    $Statusbar.Text = "User Name field is empty."
	$Statusbar.Visible = $true
	Start-Sleep -Seconds 2
    $Statusbar.Visible = $false
	$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#597d35")
   } 
    [System.Windows.Forms.Application]::DoEvents() 
	$BtnSearch.enabled = $true       

}


Function ClearAll {
	$BtnClear.enabled = $false 	
	$TextBoxSearch.Clear()
	$ListBox.DataSource = $null
	$TextBoxPass.Clear()
	$TextBoxLogs.Clear()
	$BtnReset.enabled = $false  	
	$TextBoxSearch.Focus()
	$Statusbar.Text = "Clear Completed."
	$Statusbar.Visible = $true
	Start-Sleep -Seconds 1
    $Statusbar.Visible = $false 
	[System.Windows.Forms.Application]::DoEvents() 
	$BtnClear.enabled = $true	
		
}


Function Check {
$BtnCheck.enabled = $false 	

	if ($ListBox.SelectedIndex -gt -1)
	{
		$UserSamName = $ListBox.SelectedItem
		$Employee = Get-ADUser -Filter "Name -eq '$UserSamName'" |select -ExpandProperty SamAccountName

		$CheckResult = Get-ADUser $Employee -Server "dc2-vm.infopulse.local" -Properties Name, CanonicalName, LockedOut, AccountLockOutTime, badPwdCount, LastBadPasswordAttempt, PasswordExpired, PasswordLastSet, LastLogonDate, AccountExpirationDate, Enabled, msDS-UserPasswordExpiryTimeComputed  | Select-Object Name, CanonicalName, LockedOut, AccountLockOutTime, badPwdCount, LastBadPasswordAttempt, PasswordExpired, PasswordLastSet, LastLogonDate, AccountExpirationDate, Enabled, @{Name=“ExpiryDate”;Expression={[datetime]::FromFileTime($_.“msDS-UserPasswordExpiryTimeComputed”)}}  

		$UName = $CheckResult.Name 
		$ExternalUserCheck = if ($CheckResult.CanonicalName -eq "infopulse.local/Staff/$UName") {""} else {" - ⚠  EXTERNAL OR SERVICE ACCOUNT⚠"}
		$LckdOut = if ($CheckResult.LockedOut -eq $true) {"[Lᴏᴄᴋᴇᴅ]⚠"} else {"[Nᴏᴛ Lᴏᴄᴋᴇᴅ]"}
		$LckdOuttime = ($CheckResult.AccountLockOutTime).ToString('dd.MM.yyyy HH:mm:ss')
		$PwdCount = $CheckResult.badPwdCount
		$BadPwdTime = ($CheckResult.LastBadPasswordAttempt).ToString('dd.MM.yyyy HH:mm:ss')
		$PwdLSet = ($CheckResult.PasswordLastSet).ToString('dd.MM.yyyy HH:mm:ss')
		$PwdStatus = if ($CheckResult.PasswordExpired -eq $true) {"[Exᴘɪʀᴇᴅ]⚠"} else {"[Aᴄᴛɪᴠᴇ]"}
		$PwdExp = ($CheckResult.ExpiryDate).ToString('dd.MM.yyyy HH:mm:ss')
		$ExpirationDate = $CheckResult.AccountExpirationDate
		$Enabled = if ($CheckResult.Enabled -eq $true) {"Enabled"} else {"Disabled"}
		$SystemDate = (get-date).Date
		$AccountExpirationDate = ($CheckResult.AccountExpirationDate).ToString('dd.MM.yyyy')
		$active = if ($CheckResult.Enabled -ne $false -OR $ExpirationDate -ge $SystemDate) {"Yes"} else {"Account is $Enabled, AccountExpirationDate: $AccountExpirationDate."}
		
		$ShowDetails = if ($CheckResult.Enabled -ne $false -OR $ExpirationDate -ge $SystemDate) {"•User Name: "+$UName+"`r`n"+"•User State: "+$LckdOut+"`r`n"+"•Lockout Time: "+$LckdOuttime+"`r`n"+"•Bad Pwd Count: "+$PwdCount+"`r`n"+"•Last Bad Pwd: "+$BadPwdTime+"`r`n"+"•Pwd Status: "+$PwdStatus+"`r`n"+"•Pwd Last Set: "+$PwdLSet+"`r`n"+"•Pwd Expiration Date: "+$PwdExp+"`r`n"+"•Account Active: "+$active+$ExternalUserCheck} else {"User Name: "+$UName+"`r`n"+$active}

		$TextBoxLogs.Text += "`r`n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-`r`n" + $ShowDetails + "`n"		
		$ListBox.Focus()
		$TextBoxLogs.Select($TextBoxLogs.Text.Length, 0)		
		$TextBoxLogs.ScrollToCaret()	
		$Statusbar.Text = "Check completed."
		$Statusbar.Visible = $true
		Start-Sleep -Seconds 1
		$Statusbar.Visible = $false
		
	}	
	else
	{
		$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ff0000")
		$Statusbar.Text = "↑ User Not Selected!"
		$Statusbar.Visible = $true
		Start-Sleep -Seconds 2
		$Statusbar.Visible = $false
		$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#597d35")
	} 
	
	[System.Windows.Forms.Application]::DoEvents() 
	$BtnCheck.enabled = $true	
}


Function Unlock {
$BtnUnlock.enabled = $false

	if ($ListBox.SelectedIndex -gt -1)
	{
		
		$UserSamName = $ListBox.SelectedItem
		$Employee = Get-ADUser -Filter "Name -eq '$UserSamName'" |select -ExpandProperty SamAccountName
		$UNInfo = Get-ADUser $Employee -Properties Name, CanonicalName | Select-Object Name, CanonicalName 
		$UserStatus = Get-ADUser $Employee -Properties LockedOut | Select-Object LockedOut	
		$FullUserPatch = $UNInfo.CanonicalName
		$DispName = $UNInfo.Name
			
		if ($FullUserPatch -eq "infopulse.local/Staff/$DispName")
		{
			
			
			if ($UserStatus.LockedOut -eq $true)
			{
				Unlock-ADAccount $Employee
				$TextBoxLogs.Text += "`r`n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-`r`n" + "User '$Employee' has been unlocked." + "`r`n_____________________________________________`r`n" +	"User response templates:" +
				"`r`n[EN] Your Infopulse domain account has been unlocked. Please try to log in now and let us know the results of the attempt." + "`r`n[UA] Ваш обліковий запис розблоковано. Перевірте, будь ласка, та повідомте результати спроби входу." +	"`r`n[RU] Ваша учётная запись разблокирована. Просьба проверить и сообщить результаты попытки входа." + "`n"

			}
			else
			{
				$TextBoxLogs.Text += "`r`n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-`r`n" + "User '$Employee' is currently not locked." + "`n"	

			}
			
			$TextBoxLogs.Focus()
			$TextBoxLogs.Select($TextBoxLogs.Text.Length, 0)
			$TextBoxLogs.ScrollToCaret()		
			$Statusbar.Text = "Job is Done!"
			$Statusbar.Visible = $true
			Start-Sleep -Seconds 1
			$Statusbar.Visible = $false 
			
		}
		
		else
		{		
		
		$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ff0000")
		$Statusbar.Text = "Not enough permissions to unlock AD account!"
		$Statusbar.Visible = $true
		Start-Sleep -Seconds 2
		$Statusbar.Visible = $false
		$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#597d35")
		
		}
	}	
	else
	{
		$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ff0000")
		$Statusbar.Text = "↑ User Not Selected!"
		$Statusbar.Visible = $true
		Start-Sleep -Seconds 2
		$Statusbar.Visible = $false
		$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#597d35")
	}    

		[System.Windows.Forms.Application]::DoEvents() 
		$BtnUnlock.enabled = $true

}


Function PwdGenerator {	

	$BtnGenerator.enabled = $false 
	
	function Get-RandomCharacters($length, $characters) {
    $random = 1..$length | ForEach-Object { Get-Random -Maximum $characters.length }
    $private:ofs=""
    return [String]$characters[$random]
	}
 
	function Scramble-String([string]$inputString){     
    $characterArray = $inputString.ToCharArray()   
    $scrambledStringArray = $characterArray | Get-Random -Count $characterArray.Length     
    $outputString = -join $scrambledStringArray
    return $outputString 
	}
 
	$password = Get-RandomCharacters -length 4 -characters 'abcdefghikmnoprstuvwxyz'
	$password += Get-RandomCharacters -length 2 -characters 'ABCDEFGHKLMNPRSTUVWXYZ'
	$password += Get-RandomCharacters -length 3 -characters '123456789'
	$password += Get-RandomCharacters -length 1 -characters '!?@#$%&*_=+'
  
	$password = Scramble-String $password
 
	$TextBoxPass.Text = $password
	
	[System.Windows.Forms.Application]::DoEvents() 
	$BtnGenerator.enabled = $true
	
}


Function CopyPwd {
	
	$BtnCopy.enabled = $false 	
  if(![string]::IsNullOrWhiteSpace($TextBoxPass.Text))
  {   
    $copyText = $TextBoxPass.Text.Trim()
 
    [System.Windows.Forms.Clipboard]::SetText($copyText)
 
    if ([System.Windows.Forms.Clipboard]::ContainsText() -AND
        [System.Windows.Forms.Clipboard]::GetText() -eq $copyText)
    {		
        $Statusbar.Text = "Password copied to clipboard."
        $Statusbar.Visible = $true
        Start-Sleep -Seconds 1
        $Statusbar.Visible = $false
    }
  } 

  else
   {
    $Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ff0000")
    $Statusbar.Text = "Set New Password field is empty."
	$Statusbar.Visible = $true
	Start-Sleep -Seconds 2
    $Statusbar.Visible = $false
	$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#597d35")
   } 
    [System.Windows.Forms.Application]::DoEvents() 
	$BtnCopy.enabled = $true    	
}


Function Reset {
	
$BtnReset.enabled = $false 	

	if ($ListBox.SelectedIndex -gt -1)
	{	
		$UserSamName = $ListBox.SelectedItem
		$Employee = Get-ADUser -Filter "Name -eq '$UserSamName'" |select -ExpandProperty SamAccountName
		$NewPass = $TextBoxPass.Text  		
		$UNInfo = Get-ADUser $Employee -Properties Name, CanonicalName | Select-Object Name, CanonicalName		
		$FullUserPatch = $UNInfo.CanonicalName
		$DispName = $UNInfo.Name
			
		if ($FullUserPatch -eq "infopulse.local/Staff/$DispName")
		{				   
		  if(![string]::IsNullOrWhiteSpace($TextBoxPass.Text))
		  { 
			$YesNo = New-Object -ComObject Wscript.Shell
			$answer = $YesNo.Popup("Do you want to continue?",0,"Alert",64+4)

			if($answer -eq 6)
			{
				
			Set-ADAccountPassword $Employee -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$NewPass" -Force)
			Unlock-ADAccount $Employee
			$TextBoxLogs.Text += "`r`n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-`r`n" + "New password: '$NewPass' for the User: '$Employee' set successfully." + "`r`n_____________________________________________`r`n" +	"User response templates:" + "`r`n[EN] Temporary password has been sent to you via SMS. Please confirm delivery and notify us about the results of a login attempt." + "`r`n[UA] Тимчасовий пароль відправлено по СМС. Прохання підтвердити отримання та повідомити результати спроби входу." +	"`r`n[RU] Временный пароль отправлен по СМС. Просьба подтвердить получение и сообщить результаты попытки входа." + "`n"  	
			$TextBoxLogs.Focus()
			$TextBoxLogs.Select($TextBoxLogs.Text.Length, 0)		
			$TextBoxLogs.ScrollToCaret()		
			$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#597d35")	
			$Statusbar.Text = "Password Reset completed."
			$Statusbar.Visible = $true
			Start-Sleep -Seconds 1
			$Statusbar.Visible = $false 			
			}
			
			else
			{
			$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ff0000")
			$Statusbar.Text = "Password Reset Cancelled."
			$Statusbar.Visible = $true
			Start-Sleep -Seconds 2
			$Statusbar.Visible = $false
			$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#597d35")
			} 
		   
		  } 

		  else
		   {
			$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ff0000")
			$Statusbar.Text = "Set New Password field is empty."
			$Statusbar.Visible = $true
			Start-Sleep -Seconds 2
			$Statusbar.Visible = $false
			$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#597d35")
		   } 
		  
		}
		
		else
		{			
			$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ff0000")
			$Statusbar.Text = "Not enough permissions to Reset AD Account Password!"
			$Statusbar.Visible = $true
			Start-Sleep -Seconds 2
			$Statusbar.Visible = $false
			$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#597d35")		
		}
	}
	
	else
	{
		$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ff0000")
		$Statusbar.Text = "↑ User Not Selected!"
		$Statusbar.Visible = $true
		Start-Sleep -Seconds 2
		$Statusbar.Visible = $false
		$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#597d35")
	}   
	
	[System.Windows.Forms.Application]::DoEvents() 
	$BtnReset.enabled = $true 
}

Function OpenMSG { 

	$BtnSMS.enabled = $false
	$Pass = $TextBoxPass.Text
	$Outlook = New-Object -comObject Outlook.Application

if(![string]::IsNullOrWhiteSpace($TextBoxPass.Text))
  {   
    $mail = $Outlook.CreateItem(0)
	$mail.Bodyformat = 1
	$mail.Recipients.Add("SMSEagle@infopulse.com")
	$mail.Subject = "<PhoneNumberHere!>"
	$mail.Body = "Your new temporary password to corporate account is $Pass `nPlease, change it upon the first logon."
	$mail.save()

	$inspector = $mail.GetInspector
	$inspector.Display()
	
	$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#597d35")
	$Statusbar.Text = "Template loaded successfully."
	$Statusbar.Visible = $true
	Start-Sleep -Seconds 1
    $Statusbar.Visible = $false 
  } 

  else
   {
    $Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ff0000")
    $Statusbar.Text = "Set New Password field is empty."
	$Statusbar.Visible = $true
	Start-Sleep -Seconds 2
    $Statusbar.Visible = $false
	$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#597d35")
   } 
	[System.Windows.Forms.Application]::DoEvents() 
	$BtnSMS.enabled = $true 
}

Function Music {

$BtnMusic.enabled = $false 		 
$Statusbar.Text = "-=Feel The Power Of The Dark Side!=-"
$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ff0000")
$Statusbar.Visible = $true
Start-Sleep -milliseconds 1
[console]::beep(440,500);[console]::beep(440,500);[console]::beep(440,500);[console]::beep(349,350);[console]::beep(523,150);[console]::beep(440,500);[console]::beep(349,350);[console]::beep(523,150);[console]::beep(440,1000);[console]::beep(659,500);[console]::beep(659,500);[console]::beep(659,500);[console]::beep(698,350);[console]::beep(523,150);[console]::beep(415,500);[console]::beep(349,350);[console]::beep(523,150);[console]::beep(440,1000);

$BtnOn.Visible = $false
$BtnOnDark.Visible = $true
$BtnOff.Visible = $false
$BtnOffDark.Visible = $true

$Form.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#323333")
$Label1.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#DBDBDC")
$Label2.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#DBDBDC")
$Label3.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#DBDBDC") 
$LabelRPM.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#DBDBDC")

$TextBoxSearch.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#121212") 
$ListBox.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#121212") 
$TextBoxPass.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#121212") 

$TextBoxSearch.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#CCCCCC")
$ListBox.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#CCCCCC")
$TextBoxPass.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#CCCCCC") 

$BtnSearch.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#555657") 
$BtnClear.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#555657")  
$BtnCheck.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#555657")  
$BtnUnlock.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#555657") 
$Button7.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#555657") 
$BtnReset.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#555657") 
$BtnSMS.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#555657") 
$BtnGenerator.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#555657") 
$BtnCopy.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#555657") 
$BtnMusic.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#555657") 
$TextBoxLogs.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#0C0C0C")

$Button3.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#555657")
$Button2.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#555657")
$Button4.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#555657")

$BtnSearch.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#DBDBDC")
$BtnClear.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#DBDBDC") 
$BtnCheck.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#DBDBDC") 
$BtnUnlock.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#DBDBDC")
$Button7.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#DBDBDC")
$BtnReset.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#DBDBDC")
$BtnSMS.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#DBDBDC")
$BtnGenerator.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#DBDBDC")
$BtnCopy.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#DBDBDC")
$BtnMusic.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#DBDBDC")
$TextBoxLogs.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#CCCCCC")

$Button3.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#fab00e")
$Button2.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#fab00e")
$Button4.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#fab00e")

$Statusbar.Visible = $false
$Statusbar.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#597d35")
[System.Windows.Forms.Application]::DoEvents() 
$BtnMusic.enabled = $true 

}

Function On
{
	$BtnOff.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")
	$BtnOff.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
	$BtnOn.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
	$BtnOn.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")	
	$BtnGenerator.Visible = $true 
	$BtnSMS.Visible = $true 
	$Label3.Visible = $true 
	$BtnCopy.Visible = $true 
	$BtnReset.Visible = $true 
	$TextBoxPass.Visible = $true 
	
}

Function Off
{
	$BtnOn.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")
	$BtnOn.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
	$BtnOff.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
	$BtnOff.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")
	$BtnGenerator.Visible = $false
	$BtnSMS.Visible = $false
	$Label3.Visible = $false
	$BtnCopy.Visible = $false
	$BtnReset.Visible = $false
	$TextBoxPass.Visible = $false
	$TextBoxPass.Clear()	
	$BtnReset.enabled = $false  	
	
}

Function OnDark
{
	$BtnOffDark.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#E62E34")
    $BtnOffDark.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#121212")	
	$BtnOnDark.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#121212")
	$BtnOnDark.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#E62E34")	
	$BtnGenerator.Visible = $true 
	$BtnSMS.Visible = $true 
	$Label3.Visible = $true 
	$BtnCopy.Visible = $true 
	$BtnReset.Visible = $true 
	$TextBoxPass.Visible = $true 
	
}

Function OffDark
{
	$BtnOffDark.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#121212")
    $BtnOffDark.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#E62E34")	
	$BtnOnDark.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#E62E34")
	$BtnOnDark.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#121212")
	$BtnGenerator.Visible = $false
	$BtnSMS.Visible = $false
	$Label3.Visible = $false
	$BtnCopy.Visible = $false
	$BtnReset.Visible = $false
	$TextBoxPass.Visible = $false
	$TextBoxPass.Clear()	
	$BtnReset.enabled = $false  	
	
}

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(850,692)
$Form.text          		     = "TEST"
$Form.FormBorderStyle    	     = "FixedSingle"
$Form.TopMost                    = $false
$Form.MaximizeBox 		         = $false
$Form.StartPosition 		     = 'CenterScreen'
$Form.Icon       				 = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))

$TextBoxLogs                        = New-Object system.Windows.Forms.RichTextBox
$TextBoxLogs.multiline           	= $true
$TextBoxLogs.width                  = 644
$TextBoxLogs.height                 = 406
$TextBoxLogs.location               = New-Object System.Drawing.Point(16,280)
$TextBoxLogs.Font 		         	= New-Object System.Drawing.Font('Consolas',11)
$TextBoxLogs.Scrollbars		 		= "Vertical"
$TextBoxLogs.ReadOnly 		 		= $true
$TextBoxLogs.text                   = "C:\WINDOWS\system32>_"


$TextBoxSearch                        = New-Object system.Windows.Forms.TextBox
$TextBoxSearch.multiline              = $false
$TextBoxSearch.width                  = 271
$TextBoxSearch.height                 = 20
$TextBoxSearch.location               = New-Object System.Drawing.Point(16,19)
$TextBoxSearch.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$TextBoxSearch.MaxLength              = 60

$ListBox                        = New-Object system.Windows.Forms.ListBox
$ListBox.text                   = "listBox"
$ListBox.width                  = 271
$ListBox.height                 = 195
$ListBox.location               = New-Object System.Drawing.Point(16,75)
$ListBox.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "User Name:"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(16,4)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Search Results:"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(16,59)
$Label2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "Set New Password:"
$Label3.AutoSize                 = $true
$Label3.width                    = 25
$Label3.height                   = 10
$Label3.location                 = New-Object System.Drawing.Point(502,143)
$Label3.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Label3.Visible 				 = $false

$Label4                          = New-Object system.Windows.Forms.Label
$Label4.text                     = "Status:"
$Label4.AutoSize                 = $true
$Label4.width                    = 25
$Label4.height                   = 10
$Label4.location                 = New-Object System.Drawing.Point(14,259)
$Label4.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Label4.ForeColor             	 = [System.Drawing.ColorTranslator]::FromHtml("#9b9b9b")

$BtnSearch                         = New-Object system.Windows.Forms.Button
$BtnSearch.text                    = "Find Now"
$BtnSearch.width                   = 160
$BtnSearch.height                  = 40
$BtnSearch.location                = New-Object System.Drawing.Point(296,18)
$BtnSearch.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$BtnClear                         = New-Object system.Windows.Forms.Button
$BtnClear.text                    = "Clear All"
$BtnClear.width                   = 160
$BtnClear.height                  = 40
$BtnClear.location                = New-Object System.Drawing.Point(296,75)
$BtnClear.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$BtnCheck                         = New-Object system.Windows.Forms.Button
$BtnCheck.text                    = "Check Account Status"
$BtnCheck.width                   = 160
$BtnCheck.height                  = 40
$BtnCheck.location                = New-Object System.Drawing.Point(505,18)
$BtnCheck.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$BtnUnlock                         = New-Object system.Windows.Forms.Button
$BtnUnlock.text                    = "Unlock Account"
$BtnUnlock.width                   = 160
$BtnUnlock.height                  = 40
$BtnUnlock.location                = New-Object System.Drawing.Point(672,18)
$BtnUnlock.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$BtnReset                         = New-Object system.Windows.Forms.Button
$BtnReset.text                    = "Reset Password"
$BtnReset.width                   = 160
$BtnReset.height                  = 40
$BtnReset.location                = New-Object System.Drawing.Point(672,203)
$BtnReset.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$BtnReset.enabled  	         	 = $false
$BtnReset.Visible 			     = $false

$BtnGenerator                         = New-Object system.Windows.Forms.Button
$BtnGenerator.text                    = "Generate Password"
$BtnGenerator.width                   = 160
$BtnGenerator.height                  = 40
$BtnGenerator.location                = New-Object System.Drawing.Point(505,203)
$BtnGenerator.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$BtnGenerator.Visible 				 = $false

$BtnSMS                         = New-Object system.Windows.Forms.Button
$BtnSMS.text                    = "SMSEagle Reset Template"
$BtnSMS.width                   = 202
$BtnSMS.height                  = 40
$BtnSMS.location                = New-Object System.Drawing.Point(296,203)
$BtnSMS.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$BtnSMS.Visible 				   = $false

$BtnOn                        = New-Object system.Windows.Forms.Button
$BtnOn.text                   = "ON"
$BtnOn.width                  = 82
$BtnOn.height                 = 40
$BtnOn.location               = New-Object System.Drawing.Point(672,75)
$BtnOn.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',11,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$BtnOn.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")
$BtnOn.BackColor              = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$BtnOff                       = New-Object system.Windows.Forms.Button
$BtnOff.text                  = "OFF"
$BtnOff.width                 = 82
$BtnOff.height                = 40
$BtnOff.location              = New-Object System.Drawing.Point(748,75)
$BtnOff.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',11,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$BtnOff.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$BtnOff.BackColor             = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$BtnOnDark                        = New-Object system.Windows.Forms.Button
$BtnOnDark.text                   = "ON"
$BtnOnDark.width                  = 82
$BtnOnDark.height                 = 40
$BtnOnDark.location               = New-Object System.Drawing.Point(672,75)
$BtnOnDark.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',11,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$BtnOnDark.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#E62E34")
$BtnOnDark.BackColor              = [System.Drawing.ColorTranslator]::FromHtml("#121212")
$BtnOnDark.Visible 				 = $false

$BtnOffDark                       = New-Object system.Windows.Forms.Button
$BtnOffDark.text                  = "OFF"
$BtnOffDark.width                 = 82
$BtnOffDark.height                = 40
$BtnOffDark.location              = New-Object System.Drawing.Point(748,75)
$BtnOffDark.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',11,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$BtnOffDark.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#E62E34")
$BtnOffDark.BackColor             = [System.Drawing.ColorTranslator]::FromHtml("#121212")
$BtnOnDark.Visible 				 = $false

$TextBoxPass                        = New-Object system.Windows.Forms.TextBox
$TextBoxPass.multiline              = $false
$TextBoxPass.width                  = 282
$TextBoxPass.height                 = 20
$TextBoxPass.location               = New-Object System.Drawing.Point(505,159)
$TextBoxPass.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',14)
$TextBoxPass.MaxLength              = 20
$TextBoxPass.Visible 			    = $false

$BtnCopy                      = New-Object system.Windows.Forms.Button
$BtnCopy.text                 = "Copy"
$BtnCopy.width                = 45
$BtnCopy.height               = 31
$BtnCopy.location             = New-Object System.Drawing.Point(786,158)
$BtnCopy.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$BtnCopy.Visible 			 = $false

$LabelRPM                        = New-Object system.Windows.Forms.Label
$LabelRPM.text                   = "Reset Password Menu:"
$LabelRPM.AutoSize               = $true
$LabelRPM.width                  = 25
$LabelRPM.height                 = 40
$LabelRPM.location               = New-Object System.Drawing.Point(504,85)
$LabelRPM.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Statusbar                       = New-Object system.Windows.Forms.Label
$Statusbar.AutoSize              = $false
$Statusbar.width                 = 637
$Statusbar.height                = 20
$Statusbar.location              = New-Object System.Drawing.Point(60,259)
$Statusbar.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Statusbar.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#597d35")

$BtnMusic                        = New-Object system.Windows.Forms.Button
$BtnMusic.text                   = "♫"
$BtnMusic.width                  = 25
$BtnMusic.height                 = 25
$BtnMusic.location               = New-Object System.Drawing.Point(809,661)
$BtnMusic.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Groupbox                        = New-Object system.Windows.Forms.Groupbox
$Groupbox.height                 = 130
$Groupbox.width                  = 556
$Groupbox.text                   = "Reset Password Menu"
$Groupbox.location               = New-Object System.Drawing.Point(290,127)
$Groupbox.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#9b9b9b")

$Groupbox2                       = New-Object system.Windows.Forms.Groupbox
$Groupbox2.height                = 197
$Groupbox2.width                 = 183
$Groupbox2.text                  = "Useful Links"
$Groupbox2.location              = New-Object System.Drawing.Point(663,274)
$Groupbox2.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#9b9b9b")

$Button3                         = New-Object system.Windows.Forms.Button
$Button3.text                    = "SMSEagle Console"
$Button3.width                   = 160
$Button3.height                  = 40
$Button3.location                = New-Object System.Drawing.Point(11,23)
$Button3.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Button3.ForeColor             	 = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$Button2                         = New-Object system.Windows.Forms.Button
$Button2.text                    = "Employee Contacts"
$Button2.width                   = 160
$Button2.height                  = 40
$Button2.location                = New-Object System.Drawing.Point(11,80)
$Button2.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Button2.ForeColor             	 = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$Button4                         = New-Object system.Windows.Forms.Button
$Button4.text                    = "SD Quick Case"
$Button4.width                   = 160
$Button4.height                  = 40
$Button4.location                = New-Object System.Drawing.Point(11,137)
$Button4.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Button4.ForeColor             	 = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$Form.controls.AddRange(@($TextBoxSearch,$TextBoxLogs,$ListBox,$BtnSearch,$BtnClear,$BtnCheck,$BtnUnlock,$BtnReset,$TextBoxPass,$BtnGenerator,$BtnCopy,$BtnSMS,$BtnOff,$BtnOn,$BtnOnDark,$BtnOffDark,$BtnMusic,$Groupbox2,$LabelRPM,$Label1,$Label2,$Label3,$Label4,$Statusbar,$Groupbox))
$Groupbox2.controls.AddRange(@($Button3,$Button2,$Button4))

$BtnSearch.Add_Click({ Search })
$BtnOff.Add_Click({ Off })
$BtnOffDark.Add_Click({ OffDark })
$BtnOn.Add_Click({ On })
$BtnOnDark.Add_Click({ OnDark })
$BtnReset.Add_Click({ Reset })
$BtnCheck.Add_Click({ Check })
$BtnUnlock.Add_Click({ Unlock })
$BtnGenerator.Add_Click({ PwdGenerator })
$BtnClear.Add_Click({ ClearAll })
$BtnCopy.Add_Click({ CopyPwd })
$BtnSMS.Add_Click({ OpenMSG })
$BtnMusic.Add_Click({ Music })
$Button3.Add_Click({[system.Diagnostics.Process]::start("https://smseagle/")})
$Button2.Add_Click({[system.Diagnostics.Process]::start("https://reports.infopulse.local/Corporate/report/CorporateReports/HR/Employee%20Contacts")})
$Button4.Add_Click({[system.Diagnostics.Process]::start("https://sd:42445/SC/ServiceCatalog/RequestOffering/e883c34f-2033-78f0-e29f-33c0e6657f3c,137b81d0-6d43-692d-854f-79b3dba70148")})
$TextBoxPass.add_TextChanged({ IsThereText })
$TextBoxSearch.Add_KeyDown({if ($_.KeyCode -eq "Enter") 
    { Search }})
$ListBox.Add_KeyDown({if ($_.KeyCode -eq "Enter") 
    { Check }})

[void]$Form.ShowDialog()
