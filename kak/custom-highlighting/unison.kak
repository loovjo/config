# ATS syntax highlighting
#
# Translated from
# https://github.com/unisonweb/unison/blob/trunk/editor-support/atom/language-unison/grammars/unison.cson
# Thanks!


hook global BufCreate .*\.(u|uu) %{
    set-option buffer filetype unison
}

hook global WinSetOption filetype=unison %[
    add-highlighter window/unison-reserved-chars regex \
        %<,|`|\[|\]|\{|\}|@|\|> \
        0:operator

    add-highlighter window/unison-if regex \
        %<(\s|^)(if|then|else|and|or)(\s|^)> \
        2:keyword

    add-highlighter window/unison-type-annotation regex \
        %<([^\r\n\t\f\\v "]+)\s*(:)(?=\s)> \
        1:function \
        2:operator

    add-highlighter window/unison-type-operator regex \
        %<([^\r\n\t\f\v "]+)\s*(:)(?=\s)> \
        1:keyword \
        2:operator

    add-highlighter window/unison-match-with regex \
        %/(\s|^)(match|with|->|cases)(\s|$)/ \
        2:keyword

    add-highlighter window/unison-general-keywords regex \
        %<(\s|^)(let|alias|handle|with|namespace|type|ability|where|use)(\s|$)> \
        2:keyword

    add-highlighter window/unison-boolean regex \
        %<true|false> \
        0:value

    add-highlighter window/unison-int regex \
        %<([^\w\d]|^)([+-]\d+)> \
        2:value

    add-highlighter window/unison-nat regex \
        %<([^\w\d]|^)(\d+)> \
        2:value

    add-highlighter window/unison-float regex \
        %<([^+\-\w\d]|^)([+-]?\d+\.\d*)> \
        2:value

    add-highlighter window/unison-text regex \
        %<(")(.*?)(")> \
        0:string

    add-highlighter window/unison regions
    add-highlighter window/unison/block-comment region \
        %/\{-/ \
        %/-\}/ \
        fill comment

    add-highlighter window/unison-line-comment regex \
        %/--[^\n]*/ \
        0:comment

    add-highlighter window/unison-eof_comment regex \
        %<---.*> \
        0:comment

    set-option buffer comment_block_begin '{-'
    set-option buffer comment_block_end '-}'
    set-option buffer comment_line '--'
]
