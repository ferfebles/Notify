Simple notification for Windows. You can launch a popup that can act when you click, close or wait until timeout.

Simple test:

  notify "Title" "Some text inside"

With timeout and click command

  notify "Title" "Some text inside" "20" "cmd /c %windir%\notepad.exe"

See the examples for more use cases, or launch notify for help.

Thanks to Melba23 for StringSize and to Jonathan Bennett and the AutoIt Team.

More information in http://testandset.posterous.com/notify-010-simply-notification-for-windows