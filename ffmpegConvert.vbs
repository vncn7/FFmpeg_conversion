Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "powershell -WindowStyle Hidden -ExecutionPolicy Bypass -NoProfile -File ""C:\Users\example\Documents\project\ffmpegConvert.ps1""", 0, False
