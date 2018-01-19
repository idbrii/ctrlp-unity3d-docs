" unity docs source for unite.vim
" Version:     0.0.1
" Authors:     idbrii
" Licence:     The MIT License {{{
"     Permission is hereby granted, free of charge, to any person obtaining a copy
"     of this software and associated documentation files (the "Software"), to deal
"     in the Software without restriction, including without limitation the rights
"     to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
"     copies of the Software, and to permit persons to whom the Software is
"     furnished to do so, subject to the following conditions:
"
"     The above copyright notice and this permission notice shall be included in
"     all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
"     IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
"     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
"     AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
"     LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
"     OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
"     THE SOFTWARE.
" }}}

let s:type_index_file = expand("<sfile>:p") . "/../../../ctrlp/type-index.txt"
let s:type_index_file = resolve(s:type_index_file)

" define source
function! unite#sources#unitydoc#define()
    return s:source
endfunction


" cache
let s:cache = []
function! unite#sources#unitydoc#refresh()
    let s:cache = []
endfunction

" source
let s:source = {
\   'name': 'unitydoc',
\   'description' : 'Look up Unity game engine documentation',
\   'max_candidates': 50,
\   'required_pattern_length': 1,
\   'action_table': {},
\   'default_action': {'common': 'execute'}
\}
function! s:source.gather_candidates(args, context)
    let g:DAVID_test = 'hi'
    let should_refresh = a:context.is_redraw
    let lang_filter = []
    for arg in a:args
        if arg == '!'
            let should_refresh = 1
        endif

        if arg =~ '[a-z]\{2\}'
            call add(lang_filter, arg)
        endif
    endfor

    if should_refresh
        call unite#sources#unitydoc#refresh()
    endif

    if empty(s:cache)
        call unite#sources#unitydoc#load_cache_from(s:type_index_file)
    endif

    return s:cache
endfunction

function! unite#sources#unitydoc#load_cache_from(type_index_file)
    python import unitydoc
    python unitydoc.load_cache()
endf
function! unite#sources#unitydoc#set_cache(cache)
    let s:cache = a:cache
endf

" action
let s:action_table = {}

let s:action_table.execute = {
\   'description': 'lookup unity docs'
\}
function! s:action_table.execute.func(candidate)
    let url = matchstr(a:candidate.action__page, '\[\zs[^\]]\+\ze\]')
    let base_url = "https://docs.unity3d.com/Documentation/ScriptReference/"
    let url = base_url . url
    execute ":Gogo " . url
endfunction

let s:action_table.tabopen = {
\   'description': 'open unity docs in a new tab'
\}
function! s:action_table.tabopen.func(candidate)
    execute 'tab' a:candidate.action__command
endfunction

let s:source.action_table.common = s:action_table

