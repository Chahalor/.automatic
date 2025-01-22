# Big Header

if grep -q "bash" <<< "$SHELL"
then
	echo "$(cat $1)" >> ~/.bashrc

elif grep -q "zsh" <<< "$SHELL"
then
	echo "$(cat $1)" >> ~/.zshrc

else
	echo "unsupported shell"
fi