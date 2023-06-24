" Options
set background=dark
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
set inccommand=split
set mouse=a
set number
set relativenumber
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu

" Tabs size
set expandtab
set shiftwidth=4
set tabstop=4


filetype plugin indent on
syntax on

set t_Co=256

" True color if available
let term_program=$TERM_PROGRAM

" Check for conflicts with Apple terminal app
if term_program !=? 'Apple_terminal'
    set termguicolors
else
    if $TERM !=? 'xterm-256color'
        set termguicolors
    endif
endif

" Italics
let &t_ZH="\e[3m"
let &t_ZR="e[23m"


call plug#begin()
    " Apperance
    Plug 'vim-airline/vim-airline'
    Plug 'ryanoasis/vim-devicons'
    Plug 'elvessousa/sobrio'

    " Utilities
    Plug 'sheerun/vim-polyglot'
    Plug 'jiangmiao/auto-pairs'
    Plug 'ap/vim-css-color'
    Plug 'preservim/nerdtree'

    " Completion / linters / formatters
    Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install'}
    Plug 'plasticboy/vim-markdown'
    Plug 'antoinemadec/vim-verilog-instance'

call plug#end()

" Airline
let g:airline_theme='sobrio'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" NERDTree
let NERDTreeShowHidden=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif


" CTRLP
let g:crtlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standerd']

" Disable math tex conceal feature
let g:text_conceal = ''
let g:vim_markdown_math = 1

" Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_makdown_frontmatter = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['tsx=typescriptreact']

" Language server stuff
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')


nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <Tab> gt
nnoremap <S-Tab> gT
inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"


" Skeleton Files
function! NewFile()
    silent! 0r $HOME/.vim/templates/v.skeleton
    %s/FILENAME/\=expand("%:t:r")/g
endfunction

autocmd BufNewFile *.v call NewFile()
