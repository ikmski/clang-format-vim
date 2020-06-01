" エンコーディング指定
scriptencoding utf-8

" 既にロード済みなら終了する
if exists('g:loaded_clang_format_vim')
    finish
endif
let g:loaded_clang_format_vim = 1

" ユーザ設定を一時退避
let s:save_cpo = &cpoptions
set cpoptions&vim

autocmd BufWritePost *.c,*.h     silent call clang_format#format_code()
autocmd BufWritePost *.cpp,*.hpp silent call clang_format#format_code()

" 退避していたユーザ設定を戻す
let &cpoptions = s:save_cpo
unlet s:save_cpo
