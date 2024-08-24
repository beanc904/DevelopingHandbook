# git使用手册

## 一、创建初始仓库与使用基础

在工作目录处运行初始化仓库的命令，此时会创建一个`.git`的隐藏目录。

```bash
git init
```

将文件`<file>`添加进分布式版本控制系统中。git会自动分析文本文件的更改记录，并显示出来。

```bash
git add <file>
```

将仓库中的暂存代码进行提交。（其中，`<message>`中是本次提交的留言说明）

```bash
git commit -m <message>
```

## 二、git的进阶使用

### 1. 版本的重定位操作

可以使用如下命令进行对历史记录提交日志的查看。

```bash
git log
```

```bash
git log --pretty=oneline				//制表形式缩略展现
```

回退为上`n`个版本。

```bash
git reset --hard HEAD^				//回退上一个版本
git reset --hard HEAD^^				//回退上上个版本
git reset --hard HEAD~100			//回退为上100个版本
```

按照`commit id`来进行版本回退。（此处的`commit id`可以是具有特征性的前几位）

```bash
git reset --hard <commit id>
```

同时，也可以通过查看原先执行过的命令来查找未来版本的`commit id`进行版本转移与回退。

```bash
git reflog
```

### 2. 工作区和暂存区

“工作区”就是工作目录，也就是`.git`文件所在的文件夹处。

“版本库”则是工作区中`.git`文件夹中的内容，其中包含了版本控制系统的工作存储文件。

“暂存区`(stage)`”是在执行

```bash
git add <file>
```

后，将工作区文件转移至暂存区`(stage)`中，而后执行

```bash
git commit -m <message>
```

将暂存区中文件提交至分支中。

其中，可以使用查看状态的命令去查询工作目录中的相关文件在版本控制系统中的状态，具体如下。

```bash
git status
```

### 3. 管理修改

可以使用如下命令查看目前工作区文件与暂存区中文件的区别。

```bash
git diff HEAD -- <file>
```

简单讲解一下代码的提交顺序。第一次修改->`git add`->第二次修改->`git commit`，在这样的运行顺序下，只有第一次的修改被添加到了暂存区中，也就是说，只有第一次修改被`commit`到了版本控制系统中了。

### 4. 撤销修改

在这里，会用到暂存区与版本库文件修改的撤销。该命令的效果是回退到上一步对该文件的操作，例如：`<file>`自从修改后还没有被存放到暂存库中，那么回退的就是版本库的文件版本；`<file>`已经添加到暂存库，那么回退的就是暂存库里的文件版本。

```bash
git checkout -- <file>
```

同时，使用如下命令，可以得到撤销提交暂存库的操作：

```bash
git reset HEAD <file>
```

总结下来，当乱改了工作区文件内容，可以使用第一条命令撤销；当不仅乱改了文件内容，还提交到了暂存区，那么就可以使用第二条命令撤销更改回到第一条命令的使用场景，并进行进一步修改。

### 5. 删除文件

先在工作区中，将需要删除的文件删除掉，然后再使用`git`命令将更改提交进暂存库中。

```bash
rm <file>
git rm <file>
```

## 三、远程仓库的使用

### 1. 添加远程仓库

根据远程仓库`(github)`的提示，将本地的仓库链接到远程仓库，具体命令如下：

```bash
git remote add origin <git@github.com:name/name.git>
```

在`git`中，远程库有一个默认的叫法“origin”，当然也可以改成别的。

第一次将本地库的所有内容推送到远程库中。

```bash
git push -u origin master
```

语句的含义是，将本地`master`分支上的版本库推送至远程库`origin`中；同时还使用了`-u`参数，含义是首次将本地库与远程库关联起来，可以简化后续推送和拉取的命令。后续的提交就可以是如下命令：

```bash
git push origin master
```

### 2. 删除远程库

首先使用如下命令查看远程库信息：

```bash
git remote -v
```

接着，根据名称进行删除，例如远程库的名字叫做"origin"。

```bash
git remote rm origin
```

删除命令并不是删除远程库的存在，而是解除本地库与远程库的链接。

### 3. 拉取远程库

克隆远程库：

```bash
git clone <git@github.com:name/name.git>
git clone <https://github.com/name/name/git>
```

git支持多种传输协议，包括：https,ssh。但是，ssh协议传输速度最快。

## 四、分支管理

### 1. 创建与合并分支

分布式版本控制系统的实质是一个指针，由`HEAD`指向当前所属的工作分支，再由`master`指向其对应的分支（`master`为主分支）。也就是说，如果在主分支上工作的话，指针的指向应该是，`HEAD`指向`master`，`master`指向版本控制系统。而创建一个新的分支则是创建一个新的指针，并将`master`停留在原处，将`HEAD`指向新建分支。最后，也就是合并分支，则是将`master`与新分支的指针指向同一个版本。

创建一个新的`dev`分支，并将工作分支切换至`dev`分支。

```bash
git checkout -b dev					//-b参数表示创建并切换

git branch dev							//相当于如下两条命令，第一条
git checkout dev						//第二条
```

可以用如下命令查看当前分支：

```bash
git branch
```

修改完`dev`分支的内容后，切换至`master`分支，并将`dev`分支的修改合并到`dev`分支中。

```bash
git merge dev							//将dev分支的内容合并到当前分支
```

删除`dev`分支：

```bash
git branch -d dev
```

切换分支：（推荐使用这个）

```bash
git switch -c dev					//创建并切换分支至dev
git switch master					//切换至已有的master分支
```

`git`鼓励大量使用分支。

### 2. 解决冲突

当两个分支中的文件内容不同时，强行合并会产生冲突，此时需要手动解决冲突问题，再进行合并。

使用如下命令可以显示分支的合并图：

```bash
git log --graph
```

### 3. 分支管理策略

在进行分支合并的时候，`git`是会默认使用`Fast forward`模式进行合并的，该模式下合并后删除分支会丢掉分支信息，也就是所谓的线性合并。禁用`Fast forward`，`git`则会在合并时自动创建一个新的`commit`，然后再进行分支合并，这样，就算删除分支后，还是能够查询到先前工作的版本记录。

具体合并`dev`分支时，禁用`Fast forward`模式如下，

```bash
git merge --no-ff -m <message> dev
```

后续用`log`查看日志历史，

```bash
git log
```

### 4. Bug分支管理

当正在`dev`分支编写新功能时，可以使用如下命令进行工作现场藏匿，

```bash
git stash
```

此时，当前正在进行的所有修改等操作，都被作为工作现场存储在了`stash`中。此时的工作区是完全干净的。

这时候，就可以切换到主分支对代码中的bug创建新`issue`分支进行修复，修复完成后合并主分支并删除bug分支。

接着回到`dev`分支上恢复工作现场，继续工作，命令如下：

```bash
git switch dev					//切换至dev分支
git stash list					//显示存储的工作现场
git stash apply stash@{n}	//回到序号为n的工作现场
```

此时的工作区就被还原到了当时存储的工作现场，使用`status`就可以查看当时所有修改。

但是，如果需要将先前bug修改的操作，复制到当前`dev`工作分支中的话，则可以使用如下快捷命令，而不必重新修改，

```bash
git cherry-pick <commit id>
```

记住，复制的是修改！！不是文件！！

### 5. Feature分支管理

添加新功能时，会创建一个`feature`分支，并在该分支上进行操作。但是当不需要该新功能时，则需要删除该分支。

```bash
git branch -d <feature>					//此时会提示尚未合并
git branch -D <feature>					//强制删除feature分支
```

### 6. 多人协作

使用远程仓库时，其实就是将本地仓库与远程仓库链接了起来。使用如下命令可以查看链接的远程仓库。

```bash
git remote							//查看简略信息
git remote -v						//查看详细信息
```

#### 各种常见分支介绍

- `master`：主分支，要求必须必须稳定
- `dev`：开发分支
- `issue`：bug修复分支
- `feature`：新功能分支

推送分支：（可以选择性推送所需版本分支）

```bash
git push origin master			//推送master分支至远程仓库
git push origin dev					//推送dev分支至远程仓库
```

### 7. rebase

当多人在同一分支上协作时，很容易出现冲突。后推送的同学就只能先拉取，在本地进行合并，然后再推送远程仓库。每次合并再推送，分支就会变得非常不美观，此时就可以使用“变基”功能，将分支进行整合。具体命令如下，

```bash
git rebase
```

这是不使用变基的远程仓库提交版本历史，

```bash
$ git log --graph --pretty=oneline --abbrev-commit
* d1be385 (HEAD -> master, origin/master) init hello
*   e5e69f1 Merge branch 'dev'
|\  
| *   57c53ab (origin/dev, dev) fix env conflict
| |\  
| | * 7a5e5dd add env
| * | 7bd91f1 add new env
| |/  
* |   12a631b merged bug fix 101
|\ \  
| * | 4c805e2 fix bug 101
|/ /  
* |   e1e9c68 merge with no-ff
|\ \  
| |/  
| * f52c633 add merge
|/  
*   cf810e4 conflict fixed
```

这是变基之前的版本仓库图，

```bash
$ git log --graph --pretty=oneline --abbrev-commit
*   e0ea545 (HEAD -> master) Merge branch 'master' of github.com:michaelliao/learngit
|\  
| * f005ed4 (origin/master) set exit=1
* | 582d922 add author
* | 8875536 add comment
|/  
* d1be385 init hello
...
```

这是变基之后的版本仓库图，

```bash
$ git log --graph --pretty=oneline --abbrev-commit
* 7e61ed4 (HEAD -> master, origin/master) add author
* 3611cfe add comment
* f005ed4 set exit=1
* d1be385 init hello
...
```

下面是ChatGPT对`rebase`功能的解释：

在Git中，`rebase`是一个强大的工具，主要用于以下几个方面：

1. **清理提交历史**：
   - `rebase`可以将一系列的提交压缩成一个或几个提交，这样可以使提交历史更清晰、更简洁。例如，在功能分支上完成工作后，可以将多个中间提交合并为一个提交，然后再将这个提交应用到主分支上。

2. **解决分支间的冲突**：
   - 当你在一个分支上进行开发，而主分支也有更新时，可以使用`rebase`将你的分支重新基于最新的主分支。这会将你的分支上的提交一个一个地应用到主分支的最新提交之上。这样，你可以提前解决任何冲突，并确保你的分支与主分支保持最新。

3. **保持线性历史**：
   - 与`merge`操作不同，`rebase`不会产生额外的合并提交。这样，项目的历史记录就会更加线性，易于理解和跟踪。这对于希望保持清晰、线性提交历史的团队尤其有用。

#### 使用方法

假设你有一个分支`feature`，你想把它基于主分支`main`的最新提交之上。可以按以下步骤进行：

1. 切换到`feature`分支：
   ```bash
   git checkout feature
   ```

2. 执行`rebase`操作：
   ```bash
   git rebase main
   ```

这个操作会将`feature`分支上的提交一个一个地重新应用到`main`分支的最新提交之上。如果在这个过程中出现冲突，Git会暂停`rebase`并让你手动解决冲突。解决冲突后，使用以下命令继续`rebase`：
   ```bash
   git add <conflicted files>
   git rebase --continue
   ```

如果你想停止`rebase`并回到原来的状态，可以使用：
   ```bash
   git rebase --abort
   ```

#### 注意事项

- `rebase`会重写提交历史，因此不建议对已经共享的分支（如已经推送到远程仓库的分支）进行`rebase`操作，这样可能会导致其他开发人员的工作出现问题。
- 使用`rebase`需要一定的经验和谨慎，特别是在处理冲突时。

通过合理使用`rebase`，你可以使项目的提交历史更加整洁和易于理解。

## 五、标签管理

### 1. 创建标签

如下命令可以创建标签，默认状态会为`HEAD`创建标签，但同时也可以指定一个`commit id`进行标签的创建，

```bash
git tag <tagname>												//默认创建
git tag <tagname> <commit id>						//指定id创建
git tag -a <tagname> -m "blablabla..."	//为标签添加注释内容
```

### 2. 操作标签

标签的删除：

```bash
git tag -d <tagname>
```

推送标签至远程仓库：

```bash
git push origin <tagname>							//推送指定标签
git push origin --tags								//推送所有未推送的标签
```

删除远程标签：

```bash
git tag -d <tagname>										//先从本地删除
git push origin :refs/tags/<tagname>		//再将本地删除推送至远程
```

这里的远程仓库删除的原理是这样的，将`<local repository>`空出来，也就是将一个空的本地仓库信息推送到`<remote repository>`，

```bash
git push origin <local repository>:<remote repository>
```

举例解释上述命令就是，

```bash
git push origin master:new-branch
```

将本地的`master`分支推送至远程仓库的`new-branch`分支中。

## 六、自定义Git

### 1. 忽略特殊文件

有些必须存在于本地仓库的文件，但推送时又不想上传到远程仓库，这时就可以使用`.gitignore`文件对某些本地仓库文件进行屏蔽。

屏蔽规则如下：

```shell
# Windows:
Thumbs.db
ehthumbs.db
Desktop.ini

# Python:
*.py[cod]
*.so
*.egg
*.egg-info
dist
build

# My configurations:
db.ini
deploy_key_rsa

# 排除所有.开头的隐藏文件:
.*
# 排除所有.class文件:
*.class

# 不排除.gitignore和App.class:
!.gitignore
!App.class
```

将被`.gitignore`屏蔽掉的文件，强制添加至版本仓库，

```bash
git add -f <file>
```

查看屏蔽掉的所需添加文件的`.gitignore`规则，例中则是查看屏蔽`<file>`文件的具体规则是什么，

```bash
git check-ignore -v <file>
```

`.gitignore`文件一般存放于本地仓库的根目录。

### 2. 配置别名

对命令里面的某些字符进行替换，详细命令如下：

```bash
git config --global alias.<alias keyword> <origin keyword>
```

命令就是将`<origin word>`替换为`<alias keyword>`。举例如下：

```bash
git config --global alias.co checkout

git checkout <branch>
git co <branch>
```

例子中就是将`checkout`关键字替换成了`co`。

`--global`参数则是对用户使用进行配置，而不加该参数则是对当前仓库进行配置。全局配置信息被存放在用户文件夹下的`.gitconfig`文件中，仓库配置信息被存放在仓库的`.git/config`文件中。下面是两文件的内容简要展示，

```shell
#全局配置信息 -> .gitconfig
[alias]#替换信息
    co = checkout
    ci = commit
    br = branch
    st = status
[user]
    name = Your Name
    email = your@email.com

#仓库配置信息 -> .git/config 
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
    ignorecase = true
    precomposeunicode = true
[remote "origin"]
    url = git@github.com:michaelliao/learngit.git
    fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
    remote = origin
    merge = refs/heads/master
[alias]#替换信息
    last = log -1
```

有一个特别好用的丧心病狂替换，能将版本库日志彩色打印，

```bash
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
```

使用时如下，

```bash
git lg
```

## 七、搭建Git服务器

略略略~
