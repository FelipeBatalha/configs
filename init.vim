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
	Plug 'preservim/nerdtree', { 'on' : 'NERDTreeToggle' }
	" Esse plug trouxe links errados: Plug 'ryanoasis/vim-devicons'

	" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
	Plug 'junegunn/vim-easy-align'

	" Any valid git URL is allowed
	Plug 'https://github.com/junegunn/vim-github-dashboard.git'

	" Multiple Plug commands can be written in a single line using | separators
	Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

	" On-demand loading
	Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
	Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

	" Using a non-default branch
	Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()

map <C-n> :call NERDTreeToggleAndRefresh()<CR>

map <C-t> :call Telescope()<CR>

inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha


map <C-j> o<ESC>k
map <C-k> O<ESC>j

inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

function Telescope()
	:Telescope
endfunction

function NERDTreeToggleAndRefresh()
  :NERDTreeToggle
  if g:NERDTree.IsOpen()
    :NERDTreeRefreshRoot
  endif
endfunction

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


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

