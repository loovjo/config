hook global BufCreate .*\.(j) %{
    set-option buffer filetype j
}

hook global WinSetOption filetype=j %[
    add-highlighter window/j-number regex \
        %/\b_?\d+\b|\b_?\d+b[0-9a-zA-Z]+\b|\b_:?\b/ \
        0:value

    add-highlighter window/j-string regex \
        %/'(?:[^']|'')*'/ \
        0:string

    add-highlighter window/j-operator regex \
        %/\b(?:assert\.|break\.|continue\.|else\.|elseif\.|for\.|for_\w+\.|goto_\w+\.|label_\w+\.|if\.|return\.|select\.|case\.|fcase\.|throw\.|try\.|catch[dt]?\.|while\.|whilst\.|do\.|end\.)|\{\{|\}\}/ \
        0:keyword

    add-highlighter window/j-function regex \
        %sh{echo 'KD86XFE9XEV8XFE9LlxFfFxRPTpcRXxcUTxcRXxcUTwuXEV8XFE8OlxFfFxRPlxFfFxRPi5cRXxcUT46XEV8XGJcUV86XEV8XFErXEV8XFErLlxFfFxRKzpcRXxcUSpcRXxcUSouXEV8XFEqOlxFfFxRLVxFfFxRLS5cRXxcUS06XEV8XFElXEV8XFElLlxFfFxRJTpcRXxcUV5cRXxcUV4uXEV8XFEkXEV8XFEkLlxFfFxRJDpcRXxcUX4uXEV8XFF+OlxFfFxRfFxFfFxRfFxiLlxFfFxRfFxiOlxFfFxRLFxFfFxRLC5cRXxcUSw6XEV8XFE7XEV8XFE7OlxFfFxRI1xFfFxRIy5cRXxcUSM6XEV8XFEhXEV8XFEvOlxFfFxRXDpcRXxcUVtcRXxcUVs6XEV8XFFdXEV8KD8hXHspXHsoPyFceyl8XFF7LlxFfFxRezpcRXxcUXs6OlxFfFxRfS5cRXxcUX06XEV8XFEiLlxFfFxRIjpcRXxcUT9cRXxcUT8uXEV8XGJcUUEuXEV8XGJcUUMuXEV8XGJcUWUuXEV8XGJcUUUuXEV8XGJcUWkuXEV8XGJcUWk6XEV8XGJcUUkuXEV8XGJcUWouXEV8XGJcUUwuXEV8XGJcUW8uXEV8XGJcUXAuXEV8XGJcUXAuLlxFfFxiXFFwOlxFfFxiXFFxOlxFfFxiXFFyLlxFfFxiXFFzOlxFfFxiXFF1OlxFfFxiXFF4OlxFfFxiXFFaOlxFfFxiXFFfMTpcRXxcYlxRXzI6XEV8XGJcUV8zOlxFfFxiXFFfNDpcRXxcYlxRXzU6XEV8XGJcUV82OlxFfFxiXFFfNzpcRXxcYlxRXzg6XEV8XGJcUV85OlxFfFxiXFEwOlxFfFxiXFExOlxFfFxiXFEyOlxFfFxiXFEzOlxFfFxiXFE0OlxFfFxiXFE1OlxFfFxiXFE2OlxFfFxiXFE3OlxFfFxiXFE4OlxFfFxiXFE5OlxFKSg/IVsuOl0p' | base64 -d} \
        0:function

    add-highlighter window/j-modifier regex \
        %sh{echo 'KFxRflxFfFxRL1xFfFxRLy5cRXxcUVxcRXxcUVwuXEV8XFFdOlxFfFxiXFFiLlxFfFxiXFFmLlxFfFxiXFFNLlxFfFxRXjpcRSg/PCFbe0ZdKSg6Onw6Lil8XFEhLlxFfFxRITpcRXxcUVsuXEV8XFFdLlxFfFxRIlxFfFxRYFxFfFxRQFxFfFxRQC5cRXxcUUA6XEV8XFEmXEV8XFEmLlxFfFxRJjpcRXxcYlxRZC5cRXxcYlxRRC5cRXxcYlxRRDpcRXxcYlxRRi5cRXxcYlxRRi4uXEV8XGJcUUYuOlxFfFxiXFFGOlxFfFxiXFFGOi5cRXxcYlxRRjo6XEV8XGJcUUguXEV8XGJcUUw6XEV8XGJcUVM6XEUpKD8hWy46XSk=' | base64 -d} \
        0:attribute

    add-highlighter window/j-comment regex \
        %/NB\.[^\n]*$/ \
        0:comment

    set-option b comment_line 'NB.'
    set-option b matching_pairs '(' ')'
]
