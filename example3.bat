@rem
notify.exe "Ejemplo 3" "Initial test.\nJust some lines:\n  * 30 timeout seconds\n  * launching notepad when clicked\n  * launching calculator when closing" ^
 "30" "cmd /c %windir%\notepad.exe" "cmd /c %windir%\system32\calc.exe"