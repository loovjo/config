# ATS syntax highlighting
#
# Translated from
# https://github.com/steinwaywhw/ats-mode-sublimetext/blob/master/ats.YAML-tmLanguage
# Thanks!


hook global BufCreate .*\.(dats|hats|cats|ats) %{
    set-option buffer filetype ats
}

hook global WinSetOption filetype=ats %[
    add-highlighter window/ats-char regex \
        %<(')([^\\]{0,1}|\\(\\|[abefpnrtv'"?]|[0-3]\d{0,2}|[4-7]\d?|x[a-fA-F0-9]{0,2}|u[a-fA-F0-9]{0,4}|U[a-fA-F0-9]{0,8}))(')> \
        0:string

    add-highlighter window/ats-boolean regex \
        %<true|false> \
        0:number # is there any for boolean?

    add-highlighter window/ats-identifier regex \
        %<\b[a-zA-Z][a-zA-Z0-9_']*\b> \
        0:variable

    add-highlighter window/ats-keyword regex \
        %<(#|\$)(\w+)|\b(castfn|and|andalso|assume|as|begin|break|case(\+|-)?|class|continue|dynload|dyn|else|end|exception|extern|fix|fn|for|fun|fnx|if|implement|implmnt|primplement|primplmnt|infixl|infixr|infix|in|lam|let|llam|local|macdef|macrodef|method|modprop|modtype|module|nonfix|object|of|op|or|orelse|overload|par|postfix|praxi|prefix|prfn|prfun|prval|rec|scase|sif|stacst|staif|staload|stavar|sta|struct|symelim|symintr|then|try|union|val(\+|-)?|var|when|where|while|withprop|withtype|withviewtype|withview|with)\b> \
        0:keyword

    add-highlighter window/ats-keyword-types regex \
        %<(#|\$)(\w+)|\b(abstype|abst@ype|abst0pe|absvtype|absvt@ype|absvt0pe|absviewtype|absviewt@ype|absviewt0pe|absview|absprop|datatype|datavtype|dataviewtype|dataview|dataprop|datasort|sortdef|propdef|viewdef|viewtypedef|vtypedef|stadef|typedef)\b> \
        0:keyword

    add-highlighter window/ats-number regex \
        %<\b((0(x|X)[0-9a-fA-F]*)|(([0-9]+\.?[0-9]*)|(\.[0-9]+))((e|E)(\+|~)?[0-9]+)?)(L|l|UL|ul|u|U|F|f|ll|LL|ull|ULL)?\b> \
        0:value

    add-highlighter window/ats-operator regex \
        "'!=|!|%|&&|&|\*|\+|-|-->|->|-<cloref1>|/|:=|<=|(?<=\s)<|==>|=>|=|>=|>>|>|\?|\|\||\||~|\[\]'" \
        0:operator

    # TODO: Add arrows/quantifiers

    add-highlighter window/ats regions
    add-highlighter window/ats/block region \
        %/(?:(?<=where)|(?<==)|(?<=then)|(?<=else)|(?<=\$rec)|(?<=\$rec_t)|(?<=\$rec_vt))(?:\s*)\{/ \
        %/\}/ \
        fill block

    add-highlighter window/ats/define-function region \
        %<\b(?:and|castfn|fn|fun|fnx|implement|implmnt|infixl|infixr|infix|overload|postfix|praxi|prfn|prfun|primplement|primplmnt|var)\b> \
        %<\b[a-zA-Z][a-zA-Z0-9_']*\b> \
        fill function

    add-highlighter window/ats/define-type region \
        %<\b(abstype|abst@ype|abst0pe|absvtype|absvt@ype|absvt0pe|absviewtype|absviewt@ype|absviewt0pe|absview|absprop|datatype|datavtype|dataviewtype|dataview|dataprop|datasort|sortdef|propdef|viewdef|viewtypedef|vtypedef|stadef|stacst|typedef)\b> \
        %<\b[a-zA-Z][a-zA-Z0-9_']*\b> \
        fill type

    add-highlighter window/ats/meta region \
        %<%\{> \
        %<%\}> \
        fill meta

    add-highlighter window/ats/record region \
        -recurse %"('|@)\{" \
        %"('|@)\{" \
        %<\}> \
        fill attribute

    add-highlighter window/ats/tuple region \
        -recurse %"('|@)\(" \
        %<('|@)\(> \
        %<\)> \
        fill attribute

    add-highlighter window/ats-comment-double-slash regex \
        %<//[^\n]*$> \
        0:comment

    add-highlighter window/ats-comment-rest regex \
        %<////.*> \
        0:comment

    add-highlighter window/ats/block-comment-c region \
        %</\*> \
        %<\*/> \
        fill comment

    add-highlighter window/ats/block-comment-sml region \
        -recurse %<\(\*> \
        %<\(\*> \
        %<\*\)> \
        fill comment
]
