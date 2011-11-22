@rem
notify.exe "Example 4" "Initial test.\nJust some lines:\n  * 10 timeout seconds\n  * launching notepad when clicked\n  * launching calculator when closing\n  * launching google if timed out" ^
 "10" "cmd /c %windir%\notepad.exe" "cmd /c %windir%\system32\calc.exe" "cmd /c start http://www.google.com"