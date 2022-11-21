# .files

- config for neovim
- prompt style with starship

### neovim config

- much of the workflow was based on ThePrimeagen workflow and on this article [https://dev.to/craftzdog/my-neovim-setup-for-react-typescript-tailwind-css-etc-58fb] ;
- must start by installing Neovim packer, by running:
`
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
`
- then run this nvim command: `:PackerSync` ;
- make sure to install these two npm packs: `npm i -g typescript-language-server @fsouza/prettierd` ;
