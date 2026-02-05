oh-my-posh --init --shell pwsh --config ~/my-theme.omp.json | Invoke-Expression

Import-Module -Name Terminal-Icons
Import-Module posh-git

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Git
function gs {
    git status
}

function gb {
    git branch
}

function gb {
    git branch -v
}

function gbr {
    git branch -rv
}

function gd {
    git diff
}

function glo {
    git log --decorate --oneline
}

function gfp {
    git fetch -pv
}

# Chezmoi

function cm {
    cd ~\.local\share\chezmoi\
}

function cmc {
    cd ~\.config\chezmoi
}

# Misc
function ca {
    code .
}

function tab {
    wt -w 0 nt -d .
}

function rep {
    cd ~\repos
}

function site {
    cd ~\repos\sites
}

function git-mb-in {
    param(
        [Parameter(Mandatory)]
        [string]$TargetBranch
    )

    $base = git merge-base HEAD $TargetBranch

    Write-Host "`n=== Commits ===" -ForegroundColor Cyan
    git log --oneline "$base..$TargetBranch"

    Write-Host "`n=== Diff ===" -ForegroundColor Cyan
    git diff "$base..$TargetBranch"
}

function git-mb-out {
    param(
        [Parameter(Mandatory)]
        [string]$TargetBranch
    )

    $base = git merge-base HEAD $TargetBranch

    Write-Host "`n=== Commits ===" -ForegroundColor Cyan
    git log --oneline "$base..HEAD"

    Write-Host "`n=== Diff ===" -ForegroundColor Cyan
    git diff "$base..HEAD"
}

function git-mb {
    param(
        [Parameter(Mandatory)]
        [string]$TargetBranch
    )

    $base = git merge-base HEAD $TargetBranch

    Write-Host "`n=== YOUR CHANGES (base → HEAD) ===" -ForegroundColor Cyan
    git difftool "$base..HEAD"

    Write-Host "`n=== INCOMING CHANGES (base → $TargetBranch) ===" -ForegroundColor Green
    git difftool "$base..$TargetBranch"
}


function prep {
    cd "C:\Users\KaiPaterson-Hall\personal\repos"
}

function learn {
    cd ~\learn
}

function cms {
    cd ~\learn\public-repos\Umbraco-CMS
}

function tr {
    . $PROFILE
}

function cdf {
    $release = Get-ItemPropertyValue -LiteralPath 'HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full' -Name Release
    switch ($release) {
        { $_ -ge 533320 } { $version = '4.8.1 or later'; break }
        { $_ -ge 528040 } { $version = '4.8'; break }
        { $_ -ge 461808 } { $version = '4.7.2'; break }
        { $_ -ge 461308 } { $version = '4.7.1'; break }
        { $_ -ge 460798 } { $version = '4.7'; break }
        { $_ -ge 394802 } { $version = '4.6.2'; break }
        { $_ -ge 394254 } { $version = '4.6.1'; break }
        { $_ -ge 393295 } { $version = '4.6'; break }
        { $_ -ge 379893 } { $version = '4.5.2'; break }
        { $_ -ge 378675 } { $version = '4.5.1'; break }
        { $_ -ge 378389 } { $version = '4.5'; break }
        default { $version = $null; break }
    }

    if ($version) {
        Write-Host -Object ".NET Framework Version: $version"
    } else {
        Write-Host -Object '.NET Framework Version 4.5 or later is not detected.'
    }
}

Register-ArgumentCompleter -CommandName git-mb,git-mb-in,git-mb-out `
    -ParameterName TargetBranch `
    -ScriptBlock {
        param($commandName, $parameterName, $wordToComplete)

        git for-each-ref --format='%(refname:short)' refs/heads refs/remotes |
            Where-Object { $_ -like "$wordToComplete*" } |
            Sort-Object |
            ForEach-Object {
                [System.Management.Automation.CompletionResult]::new(
                    $_, $_, 'ParameterValue', $_
                )
            }
    }
