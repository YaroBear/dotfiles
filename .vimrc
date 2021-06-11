set encoding=utf-8
set fileencodings=utf-8
set number
set autoindent
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
syntax on
set undofile


" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'OmniSharp/omnisharp-vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'runoshun/tscompletejob'
Plug 'prabirshrestha/asyncomplete-tscompletejob.vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/1.x',
  \ 'for': [
    \ 'javascript',
    \ 'typescript',
    \ 'css',
    \ 'less',
    \ 'scss',
    \ 'json',
    \ 'graphql',
    \ 'markdown',
    \ 'lua',
    \ 'python',
    \ 'html' ] }
Plug 'prabirshrestha/asyncomplete-emmet.vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

call asyncomplete#register_source(asyncomplete#sources#tscompletejob#get_source_options({
    \ 'name': 'tscompletejob',
    \ 'whitelist': ['typescript'],
    \ 'completor': function('asyncomplete#sources#tscompletejob#completor'),
    \ }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#emmet#get_source_options({
    \ 'name': 'emmet',
    \ 'whitelist': ['html'],
    \ 'completor': function('asynccomplete#sources#emmet#completor'),
    \ }))

if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescript.tsx', 'ts'],
        \ })
endif

if executable('css-languageserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'css-languageserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'css-languageserver --stdio']},
        \ 'whitelist': ['css', 'less', 'sass'],
        \ })
endif

if executable('html-languageserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'html-languageserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'html-languageserver --stdio']},
        \ 'whitelist': ['html'],
        \ })
endif

if executable('rust-analyzer')
  au User lsp_setup call lsp#register_server({
        \   'name': 'Rust Language Server',
        \   'cmd': {server_info->['rust-analyzer']},
        \   'whitelist': ['rust'],
        \ })
endif


let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

let g:asyncomplete_auto_popup = 1
