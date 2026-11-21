param(
    [Parameter(Position=0)]
    [string] $Path,

    [Alias("n")]
    [string] $Name,

    [Alias("a", "al")]
    [string]$Alias,

    [Alias('ptl')]
    [string]$Plateform,

    [Alias("t")]
    [string[]] $Tags,

    [Alias("s","st")]
    [string] $Status,

    [Alias("cat")]
    [string] $Category,

    [Alias('dft', "d")]
    [bool]$Default = $true,

    [Alias("skp", "s")]
    [switch] $Skip
)

#-- Includes
$utilsPath = Join-Path "$PSScriptRoot" .. "utils/Utils.ps1"
. $utilsPath


#-- Path
$currentDirectoryPath = (Get-Location).Path
$rootProjectPath = Join-Path $PSScriptRoot ..

$devRepoConfigPath = "$rootProjectPath/config/devrepo.json"


#-- Functions
function AddPathToRegistery() {
    param (
        [string] $Path
    )

    $projectConfigPath = "$Path/.devrepo" 
    New-Item -ItemType Directory -Path $projectConfigPath | Out-Null
    
    #-- Project config    
    $projectsConfigPath = "$projectConfigPath/project.json"
    $projectConfig = [PSCustomObject]@{
        name      = ""
        tags      = $Tags
        alias     = $Alias
        category  = $Category
        path      = $Path
        status    = if ($null -eq $Status -and $Default) {"dev"} else {$Status}
        plateform = if ($null -eq $Plateform -and $Default) {"web"} else {$Plateform}
    }

    if (-not $Skip) {
        Complete-ProjectConfig -Config $projectConfig
    }

    $projectConfig.Properties | 
        Where-Object { $null -eq $_.Value } |
        ForEach-Object {
            $config.Properties.Remove($_.Name)
        }

    #-- Devrepoconfig

    $devrepoConfig = Get-Content -LiteralPath $devRepoConfigPath -Raw -Encoding UTF8 
    if(-not $devrepoConfig){
        $devrepoConfig = $devrepoConfig | ConvertFrom-Json
    }
    else {
        $devrepoConfig = [PSCustomObject]@{}
        Complete-DevrepoConfig -Config $devrepoConfig
    }


    #-- Saving
    $projectConfig | ConvertTo-Json -Depth 5 | 
        Set-Content -LiteralPath $projectsConfigPath -Encoding UTF8

    $devrepoConfig | ConvertTo-Json -Depth 5 | 
        Set-Content -LiteralPath $devrepoConfigPath -Encoding UTF8
}



#-- Deal with current repository
if($Path -eq "."){
    AddPathToRegistery -Path $currentDirectoryPath
    return
}


#-- Deal with specify repository
if (Test-Path -LiteralPath $Path -PathType Container) {
    AddPathToRegistery -Path $Path
    return
}

Write-Error "Something went wrong (verify if the dirctory exist)"


