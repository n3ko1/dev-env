echo "Installing dependencies"
apt-get install tmux zsh git clang llvm-dev cmake python2.7-dev python-all-dev python-pip build-essential radare2
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo "Building cquery"
git clone --recursive https://github.com/cquery-project/cquery.git
cd cquery
git submodule update --init
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=release -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
cmake --build .
cmake --build . --target install

echo "Installing python dependencies"
pip install python-language-server

cd ~
echo "Downloading and installing configurations"
git clone https://github.com/n3ko1/vim-rc
mv ~/vim-rc ~/rad.vim
ln -s ~/.vim/.vimrc ~/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "When first running vim, run :PlugInstall"


git clone https://github.com/n3ko1/tmux-conf
mv ~/tmux-conf/.tmux.conf ~/.tmux.conf
mv ~/tmux-conf/.zshrc ~/.zshrc
rm -r ~/tmux-conf

git clone https://github.com/n3ko1/gdb-dashboard
mv ~/gdb-dashboard/.gdbinit ~/.gdbinit
rm -r ~/gdb-dashboard

echo "Setting up zsh as the default shell"
chsh -s /bin/zsh 

echo "Done."
