# git命令汇总大全

## 一、基础方面

### 1. 操作

工作区初始化：

```bash
git init
```

工作区文件添加至暂存库`(stage)`：

```bash
git add <file>
```

暂存库推送至版本仓库：

```bash
git commit -m <message>
```

回退上一个已存储（暂存库的或者版本库最近的）的文件版本：

```bash
git checkout -- <file>
```

撤销提交暂存库：

```bash
git reset HEAD <file>
```

从版本仓库回退：

```bash
git reset --hard HEAD^					//回退一个版本
git reset --hard HEAD^^					//回退两个版本
git reset --hard HEAD~100				//回退100个版本

git reset --hard <commit id>		//根据提交id回退
```

### 2. 查看

版本仓库日志查看：

```bash
git log
git log --pretty=oneline
```

查看本次执行过的所有指令：

```bash
git reflog
```

查看本次工作区操作状态：

```bash
git status
```

查看当前工作区文件与暂存区中文件的区别：

```bash
git diff HEAD -- <file>
```

## 二、分支与标签管理

### 1. 分支管理

创建分支

```bash
#使用-b参数进行分支的创建与切换
git checkout -b dev
#新版git推荐使用switch -c进行创建切换
git switch -c dev

#可以分为以下两条命令
git branch dev										//创建分支dev
git checkout dev									//切换分支到dev
```

切换分支

```bash
git checkout <branch>
git switch <branch>
```

查看分支

```bash
git branch
```

查看分支合并图

```bash
#日志查看
git log

#原始命令
git log --graph

#利用替换原理修改全局参数命令
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

git lg								//后续可使用
```

合并分支

```bash
git merge <branch>				//将branch分支内容合并到当前分支

#合并时禁用Fast forward模式
git merge --no-ff -m <message> <dev>
```

删除分支

```bash
git branch -d <branch>							//会提示尚未合并
git branch -D <branch>							//强制删除
```

变基

```bash
git rebase
#详细查看远程仓库中的“变基”
```

### 2. 工作现场

藏匿工作现场

```bash
git stash
```

查看藏匿的工作现场

```bash
git stash list
```

回到序号为n的工作现场

```bash
git stash apply stash@{n}
```

将超前版本库中的超前修改应用到当前工作区

```bash
git cherry-pick <commit id>
```

### 3. 标签管理

创建标签

```bash
#默认创建
git tag <tagname>
#为指定id创建
git tag <tagname> <commit id>
#为创建的标签添加注释内容
git tag -a <tagname> -m "blablabla..."
```

推送标签至远程库

```bash
git push origin <tagname>					//推送指定标签
git push origin --tags						//推送所有未推送标签
```

删除标签

```bash
#删除本地标签
git tag -d <tagname>
#删除远程仓库标签
git push origin :refs/tags/<tagname>
```

删除远程仓库的原理

```bash
git push origin <local repository>:<remote repository>
```

## 三、远程仓库

### 1. 链接与删除

链接远程仓库：

```
git remote add
```

### 2. 查看远程仓库信息

```bash
git remote												//查看缩略信息
git remote -v											//查看详细信息
```

### 3. 常见分支

- `master`：主分支，要求必须稳定
- `dev`：开发分支
- `issue`：bug修复分支
- `feature`：新功能开发分支

### 4. 推送本地仓库

推送分支

```bash
git push origin <branch>
```

### 5. 变基

```bash
git rebase
git rebase <branch>
```

撤销变基

```bash
git rebase --abort
```

解决变基时的冲突

```bash
git add <conflicted files>
git rebase --continue
```

## 四、自定义Git

### 1. 忽略特殊文件

屏蔽规则

```shell
# <Language>:
<file name>.<file extension>

# 排除所有.开头的隐藏文件:
.*
# 排除所有.class文件:
*.class

# 不排除.gitignore和App.class:
!.gitignore
!App.class
```

强制添加屏蔽文件

```bash
git add -f <file>
```

查看屏蔽原因

```bash
git check-ignore -v <file>
```

### 2. 配置别名

全局配置

```bash
#配置信息存储在用户文件夹下的.gitconfig中
git config --global alias.<alias keyword> <origin keyword>
```

工作区配置

```bash
#配置信息存储在.git/config
git config alias.<alias keyword> <origin keyword>
```

