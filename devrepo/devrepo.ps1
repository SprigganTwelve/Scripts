param(
    [Parameter(Position = 0)]
    [string]$Command,

    [Parameter(Position = 1)]
    [string]$Argument
)

$Commands = @(
    "open",
    "add",
    "list",
    "search",
    "info",
    "scan"
)
$ScriptRootPath = "commands"




#-- Default Behaviour
if(-not $Command){
    & "$PSScriptRoot\$ScriptRootPath\List.ps1"
    return
}


#-- Process Requests
if($Command -and $Commands -notcontains $Command){
    $Argument = $Command
    $Command = "open"
}


switch ($Command) {
    "open" {
        & "$PSScriptRoot\$ScriptRootPath\Open.ps1" $Argument
    }
    "list" {
        & "$PSScriptRoot\$ScriptRootPath\List.ps1"
    }
    "add"{
        & "$PSScriptRoot\$ScriptRootPath\Add.ps1"
    }
    Default {
        Write-Host "Commande inconnue : $Command"
    }
}