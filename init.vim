	call plug#begin('~/.config/nvim/plugged')
	" The default plugin directory will be as follows:
	"   - Vim (Linux/macOS): '~/.vim/plugged'
	"   - Vim (Windows): '~/vimfiles/plugged'
	"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
	" You can specify a custom plugin directory by passing it as the argument
	"   - e.g. `call plug#begin('~/.vim/plugged')`
	"   - Avoid using standard Vim directory names like 'plugin'

	"Autocomplete

	Plug 'neoclide/coc.nvim', { 'branch' : 'release' }

	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }

	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	"Theme

	Plug 'morhetz/gruvbox'

	" Multiple language support

	Plug 'sheerun/vim-polyglot'

	" Make sure you use single quotes
	"Plug 'preservim/nerdtree', { 'on' : 'NERDTreeToggle' }
	Plug 'nvim-tree/nvim-tree.lua'
	Plug 'nvim-tree/nvim-web-devicons'
	Plug 'ryanoasis/vim-devicons'

	" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
	Plug 'junegunn/vim-easy-align'

	" Any valid git URL is allowed
	Plug 'https://github.com/junegunn/vim-github-dashboard.git'

	"Wiki stuff	
	Plug 'vimwiki/vimwiki'
	Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}

	" Multiple Plug commands can be written in a single line using | separators
	Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

	" On-demand loading

	" Using a non-default branch
	Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" vimwiki - Personal Wiki for Vim
" https://github.com/vimwiki/vimwiki
set nocompatible
filetype plugin on
syntax on
" vimwiki with markdown support
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
" helppage -> :h vimwiki-syntax 

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" vim-instant-markdown - Instant Markdown previews from Vim
" https://github.com/suan/vim-instant-markdown
let g:instant_markdown_autostart = 0	" disable autostart
map <leader>md :InstantMarkdownPreview<CR>

lua << EOF
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
require("nvim-tree").setup()
EOF

nnoremap <C-n> : NvimTreeToggle<CR>
inoremap <C-e> <C-o>a
nnoremap <C-f> : Telescope find_files<CR>

inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha


map <C-j> o<ESC>k
map <C-k> O<ESC>j

nnoremap <down> :m .+1<CR>==
nnoremap <up> :m .-2<CR>==

inoremap <down> <Esc>:m .+1<CR>==gi
inoremap <up> <Esc>:m .-2<CR>==gi
vnoremap <down> :m '>+1<CR>gv=gv
vnoremap <up> :m '<-2<CR>gv=gv

inoremap <expr> <CR> coc#pum#visible() ? coc#pum#next(0) : "\<CR>"
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

nnoremap ; mqA;<ESC>`q 

function Telescope()
	:Telescope
endfunction

set number relativenumber

let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
set background=dark
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction
 
" Toggle terminal on/off (neovim)
nnoremap <c-t> :call TermToggle(12)<CR>
 
" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-t>:q!<CR>

