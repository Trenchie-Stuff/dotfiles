vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.4',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}
	use ({ 
		'svrana/neosolarized.nvim',
		as = 'neosolarized',
		config = function()
			vim.cmd('colorscheme neosolarized')
		end
	})
	use('nvim-treesitter/nvim-treesitter', {
		run =':TSUpdate'
	})

	use 'theprimeagen/harpoon'

	use 'mbbill/undotree'

	use 'tpope/vim-fugitive'
	
	use 'onsails/lspkind-nvim'

end)
