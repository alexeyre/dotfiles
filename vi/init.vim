set langmap='z,\\,w,.e,pr,yt,fy,gu,ci,ro,lp,/[,=],aa,os,ed,uf,ig,dh,hj,tk,nl,sq,\\;q,-',qx,jc,kv,xb,bn,mm,w\\,,v.,z/,[-,#=,\"Z,<W,>E,PR,YT,FY,GU,CI,RO,LP,?{,+},AA,OS,ED,UF,IG,DH,HJ,TK,NL,SQ,_\",QX,JC,KV,XB,BN,MM,W<,V>,Z?,sq,SQ

call plug#begin()
        Plug 'sheerun/vim-polyglot'
        Plug 'skywind3000/asyncrun.vim'

        Plug 'lervag/vimtex'
        Plug 'PontusPersson/pddl.vim'

        Plug 'tpope/vim-abolish'
        Plug 'ctrlpvim/ctrlp.vim'
        Plug 'vimwiki/vimwiki'

        Plug 'tomlion/vim-solidity'
call plug#end()

let g:vimwiki_list = [{'path': '~/Heimat/', 'ext': '.md'}]

hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic

set background=dark
let mapleader =","
set mouse=a
set clipboard+=unnamedplus
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber
set splitbelow splitright

autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber 

filetype plugin indent on
let g:vimtex_view_general_viewer = 'open'
let g:vimtex_quickfix_ignore_filters = [
      \ 'Underfull',
      \ 'Overfull',
      \]

