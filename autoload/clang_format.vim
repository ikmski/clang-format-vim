" エンコーディング指定
scriptencoding utf-8

" ロード済みでなければ終了する
if !exists('g:loaded_clang_format_vim')
    finish
endif

" ユーザ設定を一時退避
let s:save_cpo = &cpoptions
set cpoptions&vim

function! clang_format#format_code()

    if g:clang_format_style == ""
        let g:clang_format_style = "Google"
    endif

    if g:clang_format_style != "file"

        let $CLANG_FORMAT_STYLE = "--style=" . g:clang_format_style
        !clang-format ${CLANG_FORMAT_STYLE} -i % 1>/dev/null 2>/dev/null

    else

        let l:option_file = clang_format#find_option_file()
        if l:option_file != ""

            !clang-format --style=file -i % 1>/dev/null 2>/dev/null

        endif
    endif

endfunction

function! clang_format#find_option_file()

    let l:option_file = ".clang-format"
    if filereadable(l:option_file)
        return l:option_file
    endif

    return ""

endfunction

" 退避していたユーザ設定を戻す
let &cpoptions = s:save_cpo
unlet s:save_cpo
