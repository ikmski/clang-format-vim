" エンコーディング指定
scriptencoding utf-8

" ロード済みでなければ終了する
if !exists('g:loaded_clang_format_vim')
    finish
endif

" ユーザ設定を一時退避
let s:save_cpo = &cpoptions
set cpoptions&vim

let s:enabled = 1

function! clang_format#enable()
    let s:enabled = 1
endfunction

function! clang_format#disable()
    let s:enabled = 0
endfunction

function! clang_format#format_code()

    if s:enabled == 0
        return
    endif

    let l:style = "Goole"
    if g:clang_format_style_type != ""
        let l:style = g:clang_format_style_type
    else
        let l:style = json_encode(g:clang_format_style)
    endif

    let $CLANG_FORMAT_STYLE = "--style=" . l:style
    !clang-format ${CLANG_FORMAT_STYLE} -i % 1>/dev/null 2>/dev/null

endfunction

" 退避していたユーザ設定を戻す
let &cpoptions = s:save_cpo
unlet s:save_cpo
