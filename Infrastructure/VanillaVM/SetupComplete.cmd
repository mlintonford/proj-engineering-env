mkdir C:\v1
echo "---Set Execution Policy 64 Bit---" > C:\v1\log.txt
cmd.exe /c powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force" >> C:/v1/log.txt
echo "---Set Execution Policy 32 Bit---" >> C:/v1/log.txt
%SystemRoot%\SysWOW64\cmd.exe /c powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force" >> C:/v1/log.txt
echo "---Show file extensions in Explorer---" >> C:/v1/log.txt
%SystemRoot%\System32\reg.exe ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ /v HideFileExt /t REG_DWORD /d 0 /f >> C:/v1/log.txt
echo "---Enable QuickEdit mode---" >> C:/v1/log.txt
%SystemRoot%\System32\reg.exe ADD HKCU\Console /v QuickEdit /t REG_DWORD /d 1 /f >> C:/v1/log.txt
echo "---Show Run command in Start Menu---" >> C:/v1/log.txt
%SystemRoot%\System32\reg.exe ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ /v Start_ShowRun /t REG_DWORD /d 1 /f >> C:/v1/log.txt
echo "---Show Administrative Tools in Start Menu---" >> C:/v1/log.txt
%SystemRoot%\System32\reg.exe ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ /v StartMenuAdminTools /t REG_DWORD /d 1 /f >> C:/v1/log.txt
echo "---Zero Hibernation File---" >> C:/v1/log.txt
%SystemRoot%\System32\reg.exe ADD HKLM\SYSTEM\CurrentControlSet\Control\Power\ /v HibernateFileSizePercent /t REG_DWORD /d 0 /f >> C:/v1/log.txt
echo "---Disable Hibernation Mode---" >> C:/v1/log.txt
%SystemRoot%\System32\reg.exe ADD HKLM\SYSTEM\CurrentControlSet\Control\Power\ /v HibernateEnabled /t REG_DWORD /d 0 /f >> C:/v1/log.txt
echo "---Disable password expiration for Administrator user---" >> C:/v1/log.txt
cmd.exe /c wmic useraccount where "name='Administrator'" set PasswordExpires=FALSE >> C:/v1/log.txt
echo "---Disable Windows Firewall---" >> C:/v1/log.txt
%SystemRoot%\System32\netsh.exe advfirewall set allprofiles state off >> C:/v1/log.txt
echo "---disable teredo---" > C:\v1\log.txt
powershell.exe -noprofile -command "&netsh interface teredo set state disabled" >> C:\v1\log.txt
echo "---disable 6to4---" > C:\v1\log.txt
powershell.exe -noprofile -command "&netsh interface ipv6 6to4 set state state=disabled undoonstop=disabled" >> C:\v1\log.txt
echo "---disable isatap---" >> C:\v1\log.txt
powershell.exe -noprofile -command "&netsh interface ipv6 isatap set state state=disabled" >> C:\v1\log.txt
echo "---disable ms_tcpip6---" >> C:\v1\log.txt
powershell.exe -noprofile -command "&Disable-NetAdapterBinding -InterfaceAlias "Ethernet1" -ComponentID ms_tcpip6" >> C:\v1\log.txt
echo "---reg disable IPv6 pseudo interfaces---" >> C:\v1\log.txt
powershell.exe -noprofile -command "&New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\services\TCPIP6\Parameters -Name DisabledComponents -PropertyType DWord -Value 0xffffffff" >> C:\v1\log.txt
echo "---join domain---" >> C:\v1\log.txt
powershell.exe -noprofile -command "&Add-Computer -domainname 'ODREPLACE_DOMAINNAME_ODREPLACE' -cred (New-Object System.Management.Automation.PSCredential ('\`d.T.~Ed/{954802AB-8B0E-4A5E-8FE6-6B1B8E686C7F}.{2F867E14-3E97-409D-8F26-FAE84266E024}\`d.T.~Ed/', (ConvertTo-SecureString '\`d.T.~Ed/{954802AB-8B0E-4A5E-8FE6-6B1B8E686C7F}.{786BC7EE-7419-4E76-A3EB-47F1B1EE09DF}\`d.T.~Ed/' -AsPlainText -Force)))" >> C:\v1\log.txt
echo "---net use connect to sccm unc---" >> C:\v1\log.txt 
net use \\ODREPLACE_SCCM_SERVER_UNC_ADDRESS_ODREPLACE /user:ODREPLACE_SCCM_SERVER_UNC_USERNAME_ODREPLACE ODREPLACE_SCCM_SERVER_UNC_PASSWORD_ODREPLACE
echo "---install ccm & connect to sccm server---" >> C:\v1\log.txt 
\\ODREPLACE_SCCM_SERVER_UNC_ADDRESS_ODREPLACE\sms_ODREPLACE_SCCM_SITECODE_LOWERCASE_ODREPLACE\Client\CCMSetup.exe /logon /forcereboot SMSSITECODE=AUTO
echo "---wait while install ccm---" >> C:\v1\log.txt 
Start-Sleep -s 300
echo "---restart---" >> C:\v1\log.txt 
powershell.exe -noprofile -command "&Restart-Computer" >> C:\v1\log.txt 