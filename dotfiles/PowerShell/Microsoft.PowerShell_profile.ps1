function y
{
    $tmp = (New-TemporaryFile).FullName
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path)
    {
        Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
    }
    Remove-Item -Path $tmp
}

oh-my-posh.exe init pwsh --config $env:POSH_THEMES_PATH\atomic.omp.json | Invoke-Expression

Import-Module posh-git # 引入 posh-git
Import-Module PSReadLine # 历史命令联想

# 设置预测文本来源为历史记录
Set-PSReadLineOption -PredictionSource History
# 设置 Tab 为菜单补全和 Intellisense
Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete
# 每次回溯输入历史，光标定位于输入内容末尾
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
# 设置向上键为后向搜索历史记录
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
# 设置向下键为前向搜索历史纪录
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# coreutils alias 优先配置
# "rm", "ls", "cp", "mv",
$binPath = "$HOME\scoop\shims"
foreach ($cmd in "cat", "touch", "rm", "cp", "mv")
{
    try
    {
        Remove-Item "alias:$cmd" -Force -ErrorAction Stop
    } catch
    {
        # alias 不存在或无法移除也忽略
    }
    Set-Alias $cmd "$binPath\$cmd.exe"
}

# 配置替换
Set-Alias -Name ff -Value fastfetch
Set-Alias -Name which -Value Get-Command

# 默认显示 icons
function ls
{ exa --icons @args
}
# 显示文件目录详情
function ll
{ exa --icons --long --header @args
}
# 显示全部文件目录，包括隐藏文件
function la
{ exa --icons --long --header --all @args
}
# 显示详情的同时，附带 git 状态信息
function lg
{ exa --icons --long --header --all --git @args
}
# 替换 tree 命令
function tree
{ exa --tree --icons @args
}

# 设置代理环境变量
function proxy
{
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("on","off")]
        [string]$action
    )

    if ($action -eq "on")
    {
        $env:HTTP_PROXY  = "http://127.0.0.1:7897"
        $env:HTTPS_PROXY = "http://127.0.0.1:7897"
        Write-Host "Set Proxy env successfully:"
        Write-Host "HTTP_PROXY=$env:HTTP_PROXY"
        Write-Host "HTTPS_PROXY=$env:HTTPS_PROXY"
    } elseif ($action -eq "off")
    {
        Remove-Item Env:HTTP_PROXY  -ErrorAction SilentlyContinue
        Remove-Item Env:HTTPS_PROXY -ErrorAction SilentlyContinue
        Write-Host "Unset Proxy env successfully."
    }
}

function zedsync
{
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("push", "pull", "stash")]
        [string]$Action
    )

    $zedConfig = Join-Path $HOME "AppData\Roaming\Zed"
    Push-Location $zedConfig

    try
    {
        if ($action -eq "push")
        {
            git add .
            git commit -m "Auto Sync (win): $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
            git push origin main
        } elseif ($Action -eq "pull")
        {
            git pull origin main
        } elseif ($Action -eq "stash")
        {
            git stash
        }
    } finally
    {
        Pop-Location

    }
}

function zedconfig
{
    $zedConfig = Join-Path $HOME "AppData\Roaming\Zed"
    Push-Location $zedConfig

    try
    {
        zed .
    } finally
    {
        Pop-Location

    }
}

function pwshconfig
{
    $pwshConfig = Join-Path $HOME "Documents\PowerShell"
    Push-Location $pwshConfig

    try
    {
        zed .
    } finally
    {
        Pop-Location
    }
}

# ANCHOR: zoxide config
# =============================================================================
#
# Utility functions for zoxide.
#

# Call zoxide binary, returning the output as UTF-8.
function global:__zoxide_bin {
    $encoding = [Console]::OutputEncoding
    try {
        [Console]::OutputEncoding = [System.Text.Utf8Encoding]::new()
        $result = zoxide @args
        return $result
    } finally {
        [Console]::OutputEncoding = $encoding
    }
}

# pwd based on zoxide's format.
function global:__zoxide_pwd {
    $cwd = Get-Location
    if ($cwd.Provider.Name -eq "FileSystem") {
        $cwd.ProviderPath
    }
}

# cd + custom logic based on the value of _ZO_ECHO.
function global:__zoxide_cd($dir, $literal) {
    $dir = if ($literal) {
        Set-Location -LiteralPath $dir -Passthru -ErrorAction Stop
    } else {
        if ($dir -eq '-' -and ($PSVersionTable.PSVersion -lt 6.1)) {
            Write-Error "cd - is not supported below PowerShell 6.1. Please upgrade your version of PowerShell."
        }
        elseif ($dir -eq '+' -and ($PSVersionTable.PSVersion -lt 6.2)) {
            Write-Error "cd + is not supported below PowerShell 6.2. Please upgrade your version of PowerShell."
        }
        else {
            Set-Location -Path $dir -Passthru -ErrorAction Stop
        }
    }
}

# =============================================================================
#
# Hook configuration for zoxide.
#

# Hook to add new entries to the database.
$global:__zoxide_oldpwd = __zoxide_pwd
function global:__zoxide_hook {
    $result = __zoxide_pwd
    if ($result -ne $global:__zoxide_oldpwd) {
        if ($null -ne $result) {
            zoxide add "--" $result
        }
        $global:__zoxide_oldpwd = $result
    }
}

# Initialize hook.
$global:__zoxide_hooked = (Get-Variable __zoxide_hooked -ErrorAction Ignore -ValueOnly)
if ($global:__zoxide_hooked -ne 1) {
    $global:__zoxide_hooked = 1
    $global:__zoxide_prompt_old = $function:prompt

    function global:prompt {
        if ($null -ne $__zoxide_prompt_old) {
            & $__zoxide_prompt_old
        }
        $null = __zoxide_hook
    }
}

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

# Jump to a directory using only keywords.
function global:__zoxide_z {
    if ($args.Length -eq 0) {
        __zoxide_cd ~ $true
    }
    elseif ($args.Length -eq 1 -and ($args[0] -eq '-' -or $args[0] -eq '+')) {
        __zoxide_cd $args[0] $false
    }
    elseif ($args.Length -eq 1 -and (Test-Path -PathType Container -LiteralPath $args[0])) {
        __zoxide_cd $args[0] $true
    }
    elseif ($args.Length -eq 1 -and (Test-Path -PathType Container -Path $args[0] )) {
        __zoxide_cd $args[0] $false
    }
    else {
        $result = __zoxide_pwd
        if ($null -ne $result) {
            $result = __zoxide_bin query --exclude $result "--" @args
        }
        else {
            $result = __zoxide_bin query "--" @args
        }
        if ($LASTEXITCODE -eq 0) {
            __zoxide_cd $result $true
        }
    }
}

# Jump to a directory using interactive search.
function global:__zoxide_zi {
    $result = __zoxide_bin query -i "--" @args
    if ($LASTEXITCODE -eq 0) {
        __zoxide_cd $result $true
    }
}

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

Set-Alias -Name z -Value __zoxide_z -Option AllScope -Scope Global -Force
Set-Alias -Name zi -Value __zoxide_zi -Option AllScope -Scope Global -Force

# =============================================================================
#
# To initialize zoxide, add this to your configuration (find it by running
# `echo $profile` in PowerShell):
#
# Invoke-Expression (& { (zoxide init powershell | Out-String) })
# ANCHOR_END: zoxide config
