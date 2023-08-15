To cloning this repo: `Win` + `X`, `I`
```shell
cd $home/Documents
git clone https://github.com/CavalierAhmad/powershell #Can skip next step if rename repo?
ren "powershell" "WindowsPowerShell" #Not tested
# git should be functional but test to make sure: git status
```

To disable the "Loading profiles took X ms" message, go to [C:\Users\ahmad\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json](C:/Users/ahmad/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState)

Add **-nologo** to `"commandline": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe"`:
```json
    "profiles": 
    {
        "defaults": {},
        "list": 
        [
            {
                "commandline": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe -nologo",
                "guid": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
                "hidden": false,
                "name": "Windows PowerShell"
            },
```