net user bglocaladmin P@ssw0rd1 /add /y
net localgroup administrators bglocaladmin /add
powershell.exe -c "Set-NetConnectionProfile -InterfaceAlias Ethernet -NetworkCategory Private"
Enable-PSRemoting -Force
winrm quickconfig -q
winrm quickconfig -transport:http
powershell.exe -c "winrm set winrm/config '@{MaxTimeoutms=\`"1800000\`"}'"
powershell.exe -c "winrm set winrm/config/winrs '@{MaxMemoryPerShellMB=\`"800\`"}'"
powershell.exe -c "winrm set winrm/config/service '@{AllowUnencrypted=\`"true\`"}'"
powershell.exe -c "winrm set winrm/config/service/auth '@{Basic=\`"true\`"}'"
powershell.exe -c "winrm set winrm/config/client/auth '@{Basic=\`"true\`"}'"
powershell.exe -c "winrm set winrm/config/listener?Address=*+Transport=HTTP '@{Port=\`"5985\`"}'"
powershell.exe -c "winrm set winrm/config/client '@{TrustedHosts=\`"*\`"}'"
Set-Service -Name winrm -Status running -StartupType automatic
Restart-Service winrm
powershell.exe -c "Set-ItemProperty 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' DisableAntiSpyware 1"
powershell.exe -c "Set-MpPreference -DisableRealtimeMonitoring $true"
