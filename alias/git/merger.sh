# an automatic merger for git

# Big Header

git add .

if [ -z "$1" ]
then
	git commit -m "Auto commit"
else
	git commit -m "$1"
fi

git pull --rebase

git push
