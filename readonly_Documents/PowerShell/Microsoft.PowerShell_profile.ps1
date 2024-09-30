oh-my-posh --init --shell pwsh --config ~/jandedobbeleer.omp.json | Invoke-Expression

Import-Module -Name Terminal-Icons

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Git
function gs {
    git status
}

function gd {
    git diff
}

# Chezmoi

function cm {
    cd ~\.local\share\chezmoi\
}

function cmc {
    cd ~\.config\chezmoi
}

function glo {
    git log --decorate --oneline
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

function learn {
    cd ~\learn
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