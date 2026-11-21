function Complete-ProjectConfig {
    param(
        [PSCustomObject]$Config
    )

    if (-not $Config.name) {
        $Config.name = Read-Host " > What is the name of your project?"
    }

    if (-not $Config.alias) {
        $Config.alias = Read-Host " > Do you want to add an alias to your project?"
    }

    if (-not $Config.status) {
        $Config.status = Read-Host " > What is the status of your project [dev/test/prod/complete]?"
    }

    if (-not $Config.plateform) {
        $Config.plateform = Read-Host " > What is the platform this project is being built for?"
    }
}


function Complete-DevrepoConfig {
    param(
        [PSCustomObject]$Config
    )

    if (-not $Config.root_path) {
        $path = Read-Host " > What path do you wanna use for storing your projects related configuration [./path]?"

        if ($path -eq ".") {
            $path = (Get-Location).Path
        }
        elseif (-not (Test-Path -LiteralPath $path -PathType Container)) {
            Write-Host " > The specified path does not exist or is not a directory."
            return
        }

        $Config.root_path = $path
    }
}