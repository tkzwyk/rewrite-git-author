# rewrite-git-author
This tool rewrite past commit author of git.  
Refer to : [Changing author info - User Documentation](https://help.github.com/articles/changing-author-info/)

# Note
You must allow force pushing to master branch of target repository before this tool run.  
You can enable force pushing in `Settings -> Branches -> Protected branches` in target repository page in Github.

# How to use
1. Write target repository URL to `target-repository.txt` as below

    ```
    git@github.com:tkzwyk/rewrite-git-author.git
    git@github.com:tkzwyk/sample.git
    ```

2. Edit the followings in `rewrite_git_author` function in `rewrite-git-author.sh`

    ```bash
    OLD_EMAIL="your-old-email@example.com"
    CORRECT_NAME="Your Correct Name"
    CORRECT_EMAIL="your-correct-email@example.com"
    ```

3. Run script

    ```
    $ ./rewrite-git-author.sh target-repository.txt
    ```
