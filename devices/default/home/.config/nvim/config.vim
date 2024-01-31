
function! NextClosedFold(dir)
    let cmd = 'norm!z'..a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction

function! RepeatCmd(cmd) range abort
    let n = v:count < 1 ? 1 : v:count
    while n > 0
        exe a:cmd
        let n -= 1
    endwhile
endfunction

nnoremap <silent> <leader>zj :<c-u>call RepeatCmd('call NextClosedFold("j")')<cr>
nnoremap <silent> <leader>zk :<c-u>call RepeatCmd('call NextClosedFold("k")')<cr>

let g:vim_markdown_folding_disabled = 1
set conceallevel=2
" This should save file which requires root, but it doesn't work in neovim.
" There is plugin suda.vim, but I don't like it's option to re-open file - maybe make fork, it should be fairly
" simple plugin and just use part for :SudaWrite. TODO: Find solution.
"call nvim_create_user_command('W', 'w !sudo tee %', {'bang': v:true})

highlight nonascii guibg=Red ctermbg=1 term=standout
"au BufReadPost * syntax match nonascii "[^\u0000-\u007F]"

let g:sneak#label = 1

 function! MarkdownLevel()
    if getline(v:lnum) =~ '^ *# .*$'
        return "0"
    endif
    if getline(v:lnum) =~ '^ *## .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^ *### .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^ *#### .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^ *##### .*$'
        return ">4"
    endif
    if getline(v:lnum) =~ '^ *###### .*$'
        return ">5"
    endif
    return "=" 
endfunction
" TODO: Change to lua and fix not loading when opening bffer first time
"       which is probably caused by wiki.vim plugin or less likly vim-markdown
au BufEnter *.md setlocal foldexpr=MarkdownLevel()  
au BufEnter *.md setlocal foldmethod=expr  

" Search in visual selection
vnoremap // <Esc>/\%V

" vim: foldmethod=marker foldmarker=--{,--} textwidth=120 colorcolumn=121 nowrap
