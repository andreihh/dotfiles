## Windows Settings

- Microsoft PowerToys:
  - Install from Microsoft Store or https://github.com/microsoft/PowerToys
  - Keyboard Manager: swap CapsLock and Esc
  - Until PowerToys supports toggling the Keyboard Manager with a shortcut,
    follow the instructions provided at
    https://github.com/microsoft/PowerToys/issues/4879#issuecomment-1937913707:
    1. Install `BurntToast` by running PowerShell as an administrator:
       ```
       #  Install BurntToast for notifications
       Install-Module -Name BurntToast
       ```
    1. Create the following PowerShell script `ptkm.ps1`:
       ```
       $kbm = Get-Process PowerToys.KeyboardManagerEngine -ErrorAction SilentlyContinue

       if ($kbm){
           Stop-Process -Name PowerToys.KeyboardManagerEngine
           New-BurntToastNotification -Text 'Powertoys Keyboard Manager DISABLED'
       } else {
           Start-Process -FilePath 'C:\Program Files\PowerToys\KeyboardManagerEngine\PowerToys.KeyboardManagerEngine.exe'
           New-BurntToastNotification -Text 'Powertoys Keyboard Manager ENABLED'
       }
       ```
    1. Create a shortcut to `ptkm.ps1` with the following properties:
      - Target:
        `pwsh -ExecutionPolicy Bypass -WindowStyle Hidden -File "C:\path\to\my\script.ps1"`
      - Shortuct key: `Ctrl + Alt + Z`

- Mouse Properties:
  - Pointer speed: 6/11
  - Enhance pointer precision: Disabled

- Keyboard Properties > Speed > Character repeat:
  - Repeat delay: Short
  - Repeat rate: Fast
