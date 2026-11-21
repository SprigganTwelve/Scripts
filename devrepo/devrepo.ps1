param(
    [Parameter(Position = 0)]
    [string]$Command,

    [Parameter(Position = 1, ValueFromRemainingArguments)]
    [string[]]$Arguments
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
if( $Commands -notcontains $Command){
    $Arguments = @($Command) + $Arguments
    $Command = "open"
}



switch ($Command) {
    "open" {
        & "$PSScriptRoot\$ScriptRootPath\Open.ps1" $Arguments
    }
    "list" {
        & "$PSScriptRoot\$ScriptRootPath\List.ps1"
    }
    "add"{
        & "$PSScriptRoot\$ScriptRootPath\add\Add.ps1" $Arguments
    }
    Default {
        Write-Host "Commande inconnue : $Command"
    }
}