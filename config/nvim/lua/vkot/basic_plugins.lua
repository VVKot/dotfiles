return require('packer').startup {
  function(use)
    -- Manage packer itself.
    use {'wbthomason/packer.nvim', opt = true}
    -- Sensible defaults.
    use "tpope/vim-sensible"
    -- Comments.
    use "tpope/vim-commentary"
    -- Add/remove/change surroundings.
    use "tpope/vim-surround"
    -- Useful pair-wise mappings.
    use "tpope/vim-unimpaired"
    -- Repeat plugin commands.
    use "tpope/vim-repeat"
    -- Simplifies working with variants of the word.
    use "tpope/vim-abolish"
    -- Exchange two motions.
    use "tommcdo/vim-exchange"
  end
}
