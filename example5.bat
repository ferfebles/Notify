@rem
notify.exe "Example 5" "Initial test.\nJust some lines:\n  * 10 timeout seconds\n  * launching notepad when clicked\n  * launching calculator when closing\n  * launching google if timed out\n  * min. width 150 pixels" ^
"10" "cmd /c %windir%\notepad.exe" "cmd /c %windir%\system32\calc.exe" "cmd /c start http://www.google.com" "150"