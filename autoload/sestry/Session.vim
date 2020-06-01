let s:Session = {}

function! sestry#Session#new(name)
    let s = copy(s:Session)

    let s.name = a:name

    return s
endfunction

function! s:Session.exists() abort
    return filereadable(self.name)
endfunction

function! s:Session.is_loaded() abort
    return v:this_session ==# self.name
endfunction

function! s:Session.prev() abort
    return sestry#Session#new(self._add_suffix())
endfunction

function! s:Session.next() abort
    " TODO
endfunction

function! s:Session.suffix_count() abort
    return len(split(self.name, '.prev', 1)) - 1
endfunction

function! s:Session.delete() abort
    call delete(self.name)
endfunction

function! s:Session.rename_to(name) abort
    call rename(self.name, a:name)
endfunction

function! s:Session.make() abort
    execute 'mksession! ' . self.name
endfunction

function! s:Session.load() abort
    execute 'source ' . self.name
endfunction

function! s:Session._add_suffix() abort
    let count = 1
    let suffix = join(map(range(count), { -> '.' . g:sestry_session_suffix }), '')
                \ . '.'
                \ . fnamemodify(self.name, ':e')

    return fnamemodify(self.name, ':r') . suffix
endfunction

