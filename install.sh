echo "Installing dependencies"
sudo apt-get install tmux zsh git clang llvm-dev cmake python2.7-dev python-all-dev python-setuptools python-pip build-essential radare2

echo "Building and installing vim"
sudo apt-get remove vim
cd ~
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
        --enable-multibyte \
	    --enable-rubyinterp=yes \
	    --enable-pythoninterp=yes \
	    --with-python-config-dir=/usr/lib/python2.7/config \
	    --enable-python3interp=yes \
	    --with-python3-config-dir=/usr/lib/python3.5/config \
	    --enable-perlinterp=yes \
	    --enable-luainterp=yes \
        --enable-gui=gtk2 \
        --enable-cscope \
	    --prefix=/usr/local

make VIMRUNTIMEDIR=/usr/local/share/vim/vim81
sudo make install

echo "Building cquery"
git clone --recursive https://github.com/cquery-project/cquery.git
cd cquery
git submodule update --init
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=release -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
cmake --build .
sudo cmake --build . --target install

echo "Installing python dependencies"
sudo pip install python-language-server

echo "Oh-my-zsh installation"
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo "Installing configurations"
mkdir ~/.vim
cp .vimrc ~/.vim/.vimrc
ln -s ~/.vim/.vimrc ~/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c ':PlugInstall|qa!'
cd ~/.vim/plugged/YouCompleteMe
./install.py --clang-completer

cd ~/dev-env
cp .tmux.conf ~/.tmux.conf
cp .gdbinit ~/.gdbinit

echo "Done."
echo "Update .zshrc to fit your needs"
