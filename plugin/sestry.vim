if exists('g:loaded_sestry')
  finish
endif
let g:loaded_sestry = 1

let g:sestry_session_dir = $HOME . '/.cache/sestry/sessions'
let g:sestry_session_filename = 'session'
let g:sestry_session_suffix = 'prev'
let g:sestry_session_keep_count = 3

call sestry#init#run()

command! SestryClean call sestry#clean_sessions()
command! SestryPrev call sestry#load_prev_session()
command! SestryNext call sestry#load_next_session()

augroup sestry
    autocmd!
    autocmd VimLeave * call sestry#run()
augroup END
