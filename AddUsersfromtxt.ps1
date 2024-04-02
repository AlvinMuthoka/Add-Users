# Path to the text file containing users
$filePath = "C:\path\to\Users.txt"

# Validate if file exists
if (Test-Path $filePath) {
    # Read the content of the file
    $names = Get-Content $filePath

    # Loop through each line in the file
    foreach ($name in $names) 
      {
        $nameParts = $name -split ' '
        $firstName = $nameParts[0]
        $lastName = $nameParts[1]

        # Generate username based on first and last names
        $username = $firstName.Substring(0,1).ToLower() + $lastName.ToLower()

        # Check if the user already exists
        if (-not (Get-LocalUser -Name $username -ErrorAction SilentlyContinue)) {
            # Create the user
            New-LocalUser -Name $username -FullName "$firstName $lastName" -Description "Created via script"
            Write-Host "User $username created."
        } else {
            Write-Host "User $username already exists."
        }
    }
} else {
    Write-Host "File not found at $filePath."
}
