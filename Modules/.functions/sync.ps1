function sync ($message) {
    write-host "git add" -ForegroundColor Green
    git add .
    write-host "commit" -ForegroundColor Green
    git commit -am "$message"
    write-host "git push" -ForegroundColor Green
    git push
    write-host "Status:" -ForegroundColor Green
    git status
}
