

## Devrepo

First, one should know when developping many different project ondifferents environnement accross time it became more and more diffucult to keep track of every of them and sometimes becoming kind of unfamiliar wiht them.


This projet resolve around developping commands for bowsing & organizing dev projects.
It keeps track of your repositories and init commands that could or must be
run every time you projet is opening.

## How does operate ?

devrepo is a command line tool build for powershell environnement
supporting many options and arguments.

Each time devrepo register a prroject, it generate defaullt config files
for each project registered independently (such as project.json et init.ps1)

- project.json

This configuration file is used for decribing a project

```json
{
    "name": "Mon super projet",
    "alias": "mygame",
    "path": "D:\\Dev\\MyGame",

    "status": "dev",
    "category": "game",
    "platform": "pc",

    "mode": "development",

    "tags": [
        "unity",
        "csharp",
        "3d"
    ]
}
```



- init.ps1

```bash
Write-Host "Initialisation de MyGame..." -ForegroundColor Cyan

docker compose up -d

npm install

Start-Process "code" "."

Write-Host "Projet prêt !" -ForegroundColor Green

```