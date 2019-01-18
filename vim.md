# Setup

Prereq for C/C++ support: python2.7 & cmake & llvm/clang
Build and install cquery: https://github.com/cquery-project/cquery

Prereq for Python support: python-language-server

## Example: Ubuntu

```bash
apt-get install clang
apt-get install llvm-dev
apt-get install cmake
apt-get install python2.7-dev
pip install python-language-server
``` 


```bash
git clone THIS_REPO
mv vim-rc .vim
ln -s ~/.vim/.vimrc ~/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim
:PlugInstall
:q
cd ~/.vim/plugged/YouCompleteMe
./install.py --clang-completer
```
