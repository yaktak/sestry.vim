" Author: yaktak <yaktak00@gmail.com>
" Description: 作業履歴として自動でセッションを作るプラグイン

function! sestry#run() abort
    let s = sestry#_latest_sestry_session()

    if s.exists()
        call sestry#_rename_sessions_recursive(s, s.prev())
    endif

    call s.make()
endfunction

function! sestry#clean_sessions() abort
    call map(sestry#_get_sessions(), { _, s -> s.delete() })
endfunction

function! sestry#load_prev_session() abort
    if !sestry#_is_sestry_session_loaded()
        call sestry#_latest_sestry_session().load()
        return
    endif

    let prev = sestry#Session#new(v:this_session).prev()

    if !prev.exists()
        echo 'No more previous sessions'
        return
    endif

    call prev.load()
endfunction

function! sestry#load_next_session() abort
    " TODO
endfunction

function! sestry#_get_sessions() abort
    return map(split(globpath(g:sestry_session_dir, '*'), '\n'),
                \ { _, path -> sestry#Session#new(path) })
endfunction

function! sestry#_latest_sestry_session() abort
    let p = g:sestry_session_dir . '/'
                \ . g:sestry_session_filename
                \ . '.' . g:sestry_session_suffix
                \ . '.vim'

    return sestry#Session#new(p)
endfunction

function! sestry#_rename_sessions_recursive(from, to) abort
    if a:from.suffix_count() >= g:sestry_session_keep_count
        call a:from.delete()
        return
    endif

    if a:to.exists()
        call sestry#_rename_sessions_recursive(a:to, a:to.prev())
    endif

    call a:from.rename_to(a:to.name)
endfunction

function! sestry#_is_sestry_session_loaded() abort
    if (v:this_session == '')
        return 0
    endif

    return !empty(filter(sestry#_get_sessions(), { p -> p ==# v:this_session }))
endfunction
