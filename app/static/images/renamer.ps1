
$folderPath = "C:\Users\admin\Desktop\gubgub\images\background"  # Replace with the actual folder path

# Get all files in the folder
$files = Get-ChildItem -Path $folderPath -File

# Sort the files by name
$sortedFiles = $files | Sort-Object Name

# Iterate through each file and rename it
for ($i = 0; $i -lt $sortedFiles.Count; $i++) {
    $newName = "background$($i+1).jpg"
    $newPath = Join-Path -Path $folderPath -ChildPath $newName
    $sortedFiles[$i] | Rename-Item -NewName $newName -Force
    Write-Host "Renamed $($sortedFiles[$i].Name) to $newName"
}
