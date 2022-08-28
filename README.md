lua configuration for neovim

packer required for plugins management

Linux: git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

Windows: git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"

put files to ~/.config/nvim/ directory
run: nvim +PackerSync


install language servers via :LspInstall
