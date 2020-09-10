" Palette: {{{

let g:dracula#palette           = {}
let g:dracula#palette.fg        = ['#C4CAD1', 253]

let g:dracula#palette.bglighter = ['#31353A', 238]
let g:dracula#palette.bglight   = ['#1A1D21', 237]
let g:dracula#palette.bg        = ['#1A1D21', 236]
let g:dracula#palette.bgdark    = ['#131518', 235]
let g:dracula#palette.bgdarker  = ['#0A0B0F', 234]

let g:dracula#palette.comment   = ['#676B79',  61]
let g:dracula#palette.selection = ['#FFCC95', 239]
let g:dracula#palette.subtle    = ['#424450', 238]

let g:dracula#palette.cyan      = ['#6FC1FF', 117]
let g:dracula#palette.green     = ['#63E6bE',  84]
let g:dracula#palette.orange    = ['#F6B352', 215]
let g:dracula#palette.pink      = ['#FF9AC1', 212]
let g:dracula#palette.purple    = ['#B084EB', 141]
let g:dracula#palette.red       = ['#EF5285', 203]
let g:dracula#palette.yellow    = ['#FFCC95', 228]

"
" ANSI
"
let g:dracula#palette.color_0  = '#212529'
let g:dracula#palette.color_1  = '#EF5285'
let g:dracula#palette.color_2  = '#63E6bE'
let g:dracula#palette.color_3  = '#F6B352'
let g:dracula#palette.color_4  = '#B084EB'
let g:dracula#palette.color_5  = '#FF9AC1'
let g:dracula#palette.color_6  = '#45A9F9'
let g:dracula#palette.color_7  = '#C4CAD1'
let g:dracula#palette.color_8  = '#6272A4'
let g:dracula#palette.color_9  = '#EF5285'
let g:dracula#palette.color_10 = '#63E6BE'
let g:dracula#palette.color_11 = '#FFCC95'
let g:dracula#palette.color_12 = '#D6ACFF'
let g:dracula#palette.color_13 = '#FF92DF'
let g:dracula#palette.color_14 = '#6FC1FF'
let g:dracula#palette.color_15 = '#C4CAD1'

" }}}

" Helper function that takes a variadic list of filetypes as args and returns
" whether or not the execution of the ftplugin should be aborted.
func! dracula#should_abort(...)
    if ! exists('g:colors_name') || g:colors_name !=# 'dracula'
        return 1
    elseif a:0 > 0 && (! exists('b:current_syntax') || index(a:000, b:current_syntax) == -1)
        return 1
    endif
    return 0
endfunction

" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0:
