hook global BufCreate .*\.bfpp %{
    set-option buffer filetype bfpp
}

hook global WinSetOption filetype=bfpp %[
    add-highlighter window/bfpp-prims regex \
        %{[+-,.<>\[\]]} \
        0:operator

    add-highlighter window/bfpp-keywords regex \
        %/\b((un)?declare|struct|run|to|unstable|assume stable|def|with|at)\b/ \
        0:keyword

    add-highlighter window/bfpp-linecomment regex \
        %{//[^\n]*} \
        0:comment

    add-highlighter window/directive regex \
        %{(#\w+) *([^\n]*)\n} \
        1:title \
        2:string

    add-highlighter window/bfpp regions
    add-highlighter window/bfpp/block-comment region \
        %{/\*} \
        %{\*/} \
        fill comment

    set-option buffer comment_block_begin '/*'
    set-option buffer comment_block_end '*/'
    set-option buffer comment_line '//'
]
