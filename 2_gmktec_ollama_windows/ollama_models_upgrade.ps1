$models = ollama list | Select-Object -Skip 1 | ForEach-Object { $_.Split()[0] }
foreach ($model in $models) {
    Write-Output "Aktualizacja modeli: $model"
    ollama pull $model
}
