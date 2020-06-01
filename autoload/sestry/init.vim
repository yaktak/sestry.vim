function! sestry#init#run() abort
    if !isdirectory(g:sestry_session_dir)
        call mkdir(iconv(g:sestry_session_dir, &encoding, &termencoding), 'p')
    endif
endfunction
