" Vim syntax file
" Language: QSL
" Maintainer: Sebastian Kriems
" Latest Revision: 09 April 2016

if exists("b:current_syntax")
    finish
endif

" General Rule of Thumb:
" match larger groups after smaller groups later because groups defined later have priority over groups defined earlier.

" Operators
syn match Operator "\v\*" contained
syn match Operator "\v/" contained
syn match Operator "\v\+" contained
syn match Operator "\v-" contained

" numbers
syn match ints '\(\s\|,\|(\|<\|\[\)\@<=\d\+' contained
syn match ints '\(\s\|,\|(\|<\|\[\)\@<=[-+]\d\+' contained
syn match floats '\(\s\|,\|(\|<\|\[\)\@<=\d\+\.\d*' contained
syn match floats '\(\s\|,\|(\|<\|\[\)\@<=[-+]\d+\.\d*' contained

" variables
syn match variable '\(\[\|\$\)\@<=\w\+' contained

" methods and attributes
syn match methods '\(\w\+\)\.\@<=\w\+(\@=' contained
syn match attribs '\.\@<=\w\+' contained

" functions
syn match functions '\w\+(\@=' contained

" structure elements
syn keyword struct questionnaire survey module page text

" qtypes
syn keyword qtypes contained audio card-sort colorpicker dyngrid dropdown email grid grid-check grid-open multiple multiple-colorpicker open open-int open-intrange open-real open-realrange pdl-ask pdl-update popup placement questionnaire rank rule scale single single-colorpicker thermometer video contained

" question options
syn keyword options contained autoplay cols color colsum default_text displaymax dk dk_text exactly extracss extrajs horizontal language nav_back title widget_all_required hide_progress hide_buttons hide_controls columns input_width instructions labels left max min offset order roworder colorder play prompt range ranges ranktitle required required_text reverse right rows rowrank rowsample rowsum sample show_value single_required slots splitlabels timeout unique unrank varlabel width wrap_length

" category options
syn keyword options fixed xor distinct
" logic
syn keyword logic if not in elif else str int goto

" comments
syn keyword Todo contained TODO FIXME XXX NOTE
syn match comment "#.*$" contains=Todo


" variables
" syn region variables start="[" end="]" fold transparent contains=variable,ints,floats,logic,strings

" interludes and questions
syn region interlude start="{" end="}" fold transparent contains=ALL

" categories
syn region categories start="<" end=">" fold transparent contains=ALL

" strings
syn region strings start='"' end='"' contained
syn region strings start="'" end="'" contained


" highlighting
hi def link qtypes      Function
hi def link options     Keyword
hi def link variables   Identifier
hi def link struct      StorageClass
hi def link logic       Conditional
hi def link strings     String
hi def link ints        Number
hi def link floats      Float
hi def link comment     Comment
hi def link Todo        Todo
hi def link Operator    Operator
hi def link methods     Function
hi def link attribs     Function
hi def link functions   Identifier

let b:current_syntax = "qsl"
