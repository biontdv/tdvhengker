# About tdvhunt

tdvhunt is a script to perform post exploitation (privilege escalation & credential hunting) on windows machine. This script will automate the powershell command and run some compiled binary. currently the script only work 100% if attacker got RDP session



# How to Use

1.  transfer and extract the zip file to the target machine.
2.  edit the first two line in tdvhunt.ps1. what string do you want to search for? and in which directory you want to search?  
3.  run the tdvhunt.ps1 in powershell (run as admin for credential hunting).
`. .\tdvhunt.ps1`

![](Animation.gif)
&nbsp;

# Feature

- Find juicy file direcotry - the script will find files with extensions .txt,.ini,.cfg,.config,.xml,.git,.ps1,.yml, .pptx,.log,.pdf,.xls,.xlsx,.doc,.docx,.txt,.ini,.exe,.kdbx,.rdp,.vnc,.cred,id\_rsa,id\_ecdsa . search those file maybe there is credential
- Show powershell history - the script will read powershell history for all user
- Find file that contain a string - the script will find file that contain a string in entire C:\\ directory
- Show all wifi password - the script will extract stored wifi password. there is a chance a user reuse their wifi's password
- Find sticky note - the script will find storage of sticky note. some user put their password in windows sticky note  ¯\\__(ツ)_/¯
- Read Windows security event log - the script will find string "/user" in security event log
- List installed application - the script will list all installed application. googling how to enumerate each application
-  find non default directory - the script will find non default folder in directory C:\\ , C;\\program files, C;\\program files (x86)
- Run Safetykatz - the script wil dump windows SAM file and vault cred use mimikatz. I hate vault credential
- Run Lazane - the script will run lazagne to extract credential
- Run Sharpup - the script will run sharpup to enumerate privilge escalation attack vector
- Run inveigh - the script will run inveigh to capture net-ntlm of user that tried to access windows machine

&nbsp;

# Next update

1.  work 100% in non GUI sessions
2.  add argument script
3.  find firefox cookies

&nbsp;

# Credits

- Safetykatz - [GhostPack/SafetyKatz: SafetyKatz is a combination of slightly modified version of @gentilkiwi's Mimikatz project and @subtee's .NET PE Loader (github.com)](https://github.com/GhostPack/SafetyKatz)
- Lazagne - [AlessandroZ/LaZagne: Credentials recovery project (github.com)](https://github.com/AlessandroZ/LaZagne)
- Sharpup - [GhostPack/SharpUp: SharpUp is a C# port of various PowerUp functionality. (github.com)](https://github.com/GhostPack/SharpUp)
- Inveigh - [Kevin-Robertson/Inveigh: .NET IPv4/IPv6 machine-in-the-middle tool for penetration testers (github.com)](https://github.com/Kevin-Robertson/Inveigh)
- EnableAllTokenPrivs - [raw.githubusercontent.com/fashionproof/EnableAllTokenPrivs/master/EnableAllTokenPrivs.ps1](https://raw.githubusercontent.com/fashionproof/EnableAllTokenPrivs/master/EnableAllTokenPrivs.ps1)
- PEN-200 Course
- HTB Academy Penetration Tester Job Role Path

&nbsp;
