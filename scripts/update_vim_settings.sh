# Change the directory to the temp directory.
cd /tmp;

# Retrieve the latest version from bitbucket.
echo -e "\n\033[01;34mRetreiving changes from BitBucket.org\033[00m"
hg clone https://kalekold@bitbucket.org/kalekold/vim-linux;

# Install the files.
echo -e "\n\033[01;30mInstalling files\033[00m"
rm -rf ~/.vim;
rm -f ~/.vimrc;
cp -rf /tmp/vim-linux/.vim/ ~/.vim/;
cp -f /tmp/vim-linux/.vimrc ~/.vimrc;
sudo cp -f /tmp/vim-linux/icons/vim.png /usr/share/pixmaps/vim.png

# Update vimrc for the current environment.
echo -e "\033[01;30mUpdating vimrc for current environment\033[00m"
# sed -i 's/CtrlP \/media\/Data\/Projects\//CtrlP \/home\/gary\/codebase\/gen2\/switch\//g' ~/.vimrc
# sed '/set cursorline/d' ~/.vimrc

# Remove any temporary files.
echo -e "\033[01;30mRemoving temporary files\033[00m"
rm -rf /tmp/vim-linux/;

# Change the directory to home.
cd ~;

echo -e "\033[01;34mDone\033[00m"
notify-send --icon=/usr/share/pixmaps/vim.png "Update complete" "All Vim settings have been updated to the latest version."
