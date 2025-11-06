
# Ścieżka do pliku wykonywalnego Ollama
$OllamaPath = "C:\Users\user\AppData\Local\Programs\Ollama\"
$TaskName = "Ollama Autostart"

# Sprawdź, czy zadanie już istnieje
if (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue) {
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
    Write-Host "🧹 Usunieto poprzednie zadanie o nazwie '$TaskName'."
}

# Utwórz akcję – uruchomienie Ollama w trybie serwera
$Action = New-ScheduledTaskAction -Execute $OllamaPath -Argument "serve"

# Wyzwalacz – po zalogowaniu dowolnego użytkownika
$Trigger = New-ScheduledTaskTrigger -AtLogOn

# Ustawienia uruchomienia z uprawnieniami administratora
$Principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -RunLevel Highest

# Rejestracja zadania w Harmonogramie zadań
Register-ScheduledTask -TaskName $TaskName -Action $Action -Trigger $Trigger -Principal $Principal `
    -Description "Automatyczne uruchamianie Ollama przy starcie systemu" `
    -Settings (New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable)

Write-Host "✅ Zadanie '$TaskName' zostalo utworzone pomyslnie!"
