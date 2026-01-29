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
