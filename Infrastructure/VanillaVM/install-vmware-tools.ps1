$exe_name = 'VMware-tools-9.10.5-2981885-x86_64.exe'
$download_url = "https://packages.vmware.com/tools/esx/6.0u1/windows/x64/"

(New-Object System.Net.WebClient).DownloadFile($download_url, "c:\\windows\\temp\\setup.exe")
&c:\windows\temp\setup.exe /S /v`"/qn REBOOT=R`" | Out-Host

exit 0