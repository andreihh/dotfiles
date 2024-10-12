" theme.vim
"
" Provides utilities to apply a color theme.

" Applies the given `fg`, `bg` and `style` to the given highlight `group`.
function! s:Hi(group, fg, bg, style) abort
  let hiOpts = [
    \ 'ctermfg=' . a:fg,
    \ 'ctermbg=' . a:bg,
    \ 'cterm=' . a:style,
    \ ]
  execute 'hi ' . a:group . ' ' . join(hiOpts)
endfunction

" Set of valid style values.
let s:style={
    \ 'Bold': 'bold,nocombine',
    \ 'Italic': 'italic,nocombine',
    \ 'Underline': 'underline,nocombine',
    \ 'Reverse': 'reverse,nocombine',
    \ 'BoldReverse': 'bold,reverse,nocombine',
    \ }

" Clears all formatting (`fg`, `bg`, `style`).
let s:none='NONE'

" Standard ANSI 16-color palette.
let theme#ansi={
    \ 'Black': 0,
    \ 'Red': 1,
    \ 'Green': 2,
    \ 'Yellow': 3,
    \ 'Blue': 4,
    \ 'Magenta': 5,
    \ 'Cyan': 6,
    \ 'Grey': 7,
    \ 'DarkGrey': 8,
    \ 'BrightRed': 9,
    \ 'BrightGreen': 10,
    \ 'BrightYellow': 11,
    \ 'BrightBlue': 12,
    \ 'BrightMagenta': 13,
    \ 'BrightCyan': 14,
    \ 'White': 15,
    \ }

" Applies a theme with the given color sets.
"
" The following colors must be defined:
" - ui
"   - Bg (use 'NONE' for terminal default)
"   - NormalFg, NonTextFg, PromptFg, TitleFg
"   - CursorLineBg
"   - GutterFg, GutterCursorFg, GutterBg
"   - SelectionFg, SelectionBg
"   - WinSepFg, WinSepSelFg, WinSepBg
"   - FloatFg, FloatBg, FloatThumb
"   - UriFg
"   - MatchParenFg
"   - ReferenceBg
" - vcs
"   - AddedFg
"   - ChangedFg, ChangedInlineFg
"   - DeletedFg
" - lsp
"   - ErrorFg
"   - WarningFg
"   - InfoFg
"   - HintFg
"   - CodeActionFg
" - syn
"   - ConstantFg, NumberFg, StringFg, BooleanFg
"   - IdentifierFg, FunctionFg, VariableFg, TypeFg
"   - KeywordFg
"   - PreProcFg
"   - CommentFg, DocumentationFg
"   - SpecialFg, SpecialCommentFg, DebugFg, TodoFg
function! theme#ApplyColorTheme(ui, vcs, lsp, syn) abort
  " Remove all existing highlighting and set the defaults.
  hi clear

  " Load the syntax highlighting defaults, if it's enabled.
  if exists("syntax_on")
    syntax reset
  endif

  " Default highlight group links.
  hi! link NormalNC Normal
  hi! link QuickFixLine Normal
  hi! link MsgArea Normal
  hi! link ModeMsg Prompt
  hi! link MoreMsg Prompt
  hi! link Question Prompt
  hi! link Terminal Normal
  hi! link lCursor Cursor
  hi! link CursorIM Cursor
  hi! link CursorColumn CursorLine
  hi! link ColorColumn CursorLine
  hi! link EndOfBuffer NonText
  hi! link Conceal NonText
  hi! link SpecialKey NonText
  hi! link Whitespace NonText
  hi! link LineNrAbove LineNr
  hi! link LineNrBelow LineNr
  hi! link SignColumn LineNr
  hi! link Folded LineNr
  hi! link FoldColumn Folded
  hi! link VertSplit WinSeparator
  hi! link MsgSeparator StatusLine
  hi! link StatusLineTerm StatusLine
  hi! link StatusLineTermNC StatusLineNC
  hi! link CursorLineFold CursorLine
  hi! link CursorLineSign CursorLine
  hi! link TabLineFill TabLine
  hi! link CurSearch Search
  hi! link IncSearch Search
  hi! link Substitute Search
  hi! link Visual Search
  hi! link VisualNOS Visual
  hi! link PmenuSbar Pmenu
  hi! link WildMenu PmenuSel
  hi! link NormalFloat Pmenu
  hi! link MessageWindow Pmenu
  hi! link PopupNotification Todo
  hi! link SpellCap SpellBad
  hi! link SpellLocal SpellBad
  hi! link SpellRare SpellBad

  " VCS highlight group links. Must highlight:
  " - {Diff,Sign}Add
  " - {Diff,Sign}Change
  " - {Diff,Sign}Delete
  " - DiffText
  hi! link Added DiffAdd
  hi! link Changed DiffChange
  hi! link Removed DiffDelete
  hi! link SignifySignAdd SignAdd
  hi! link SignifySignChange SignChange
  hi! link SignifySignDelete SignDelete

  " Reporting highlight group links. Must highlight:
  " - Error{Sign,Msg}
  " - Warning{Sign,Msg}
  " - Info{Sign,Msg}
  " - Hint{Sign,Msg}
  hi! link Error ErrorMsg
  hi! link LspErrorText ErrorSign
  hi! link LspErrorHighlight ErrorMsg
  hi! link LspErrorVirtualText ErrorMsg
  hi! link LspWarningText WarningSign
  hi! link LspWarningHighlight WarningMsg
  hi! link LspWarningVirtualText WarningMsg
  hi! link LspInformationText InfoSign
  hi! link LspInformationHighlight InfoMsg
  hi! link LspInformationVirtualText InfoMsg
  hi! link LspHintText HintSign
  hi! link LspHintHighlight HintMsg
  hi! link LspHintVirtualText HintMsg
  hi! link LspInlayHintsType HintMsg
  hi! link LspInlayHintsParameter HintMsg
  hi! link LspCodeActionText CodeActionSign

  " Appearance:
  call s:Hi('Normal', a:ui.NormalFg, a:ui.Bg, s:none)
  call s:Hi('NonText', a:ui.NonTextFg, s:none, s:none)
  call s:Hi('Prompt', a:ui.PromptFg, s:none, s:style.BoldReverse)
  call s:Hi('Title', a:ui.TitleFg, s:none, s:none)
  call s:Hi('LineNr', a:ui.GutterFg, a:ui.GutterBg, s:none)
  call s:Hi('CursorLineNr', a:ui.GutterCursorFg, a:ui.GutterBg, s:none)
  call s:Hi('Cursor', a:ui.NormalFg, s:none, s:none)
  call s:Hi('CursorLine', s:none, a:ui.CursorLineBg, s:none)
  call s:Hi('WinSeparator', a:ui.WinSepFg, a:ui.WinSepBg, s:none)
  call s:Hi('StatusLine', a:ui.WinSepSelFg, a:ui.WinSepBg, s:none)
  call s:Hi('StatusLineNC', a:ui.WinSepFg, a:ui.WinSepBg, s:none)
  call s:Hi('TabLine', a:ui.WinSepFg, a:ui.WinSepBg, s:none)
  call s:Hi('TabLineSel', a:ui.WinSepSelFg, s:none, s:none)

  " Floats:
  call s:Hi('Pmenu', a:ui.FloatFg, a:ui.FloatBg, s:none)
  call s:Hi('PmenuSel', a:ui.SelectionFg, a:ui.SelectionBg, s:none)
  call s:Hi('PmenuThumb', a:ui.FloatThumb, a:ui.FloatThumb, s:none)

  " Highlighting:
  call s:Hi('Search', a:ui.SelectionFg, a:ui.SelectionBg, s:none)
  call s:Hi('MatchParen', a:ui.MatchParenFg, a:ui.ReferenceBg, s:none)
  call s:Hi('Directory', a:ui.UriFg, s:none, s:none)
  call s:Hi('Underlined', a:ui.UriFg, s:none, s:style.Underline)

  " Spelling:
  hi clear SpellBad
  hi SpellBad cterm=underline

  " Diffs:
  call s:Hi('DiffAdd', a:vcs.AddedFg, s:none, s:none)
  call s:Hi('DiffChange', a:vcs.ChangedFg, s:none, s:none)
  call s:Hi('DiffDelete', a:vcs.DeletedFg, s:none, s:none)
  call s:Hi('DiffText', a:vcs.ChangedInlineFg, s:none, s:style.Bold)
  call s:Hi('SignAdd', a:vcs.AddedFg, a:ui.GutterBg, s:none)
  call s:Hi('SignChange', a:vcs.ChangedFg, a:ui.GutterBg, s:none)
  call s:Hi('SignDelete', a:vcs.DeletedFg, a:ui.GutterBg, s:none)

  " Reporting:
  call s:Hi('ErrorMsg', a:lsp.ErrorFg, s:none, s:none)
  call s:Hi('WarningMsg', a:lsp.WarningFg, s:none, s:none)
  call s:Hi('InfoMsg', a:lsp.InfoFg, s:none, s:none)
  call s:Hi('HintMsg', a:lsp.HintFg, s:none, s:none)
  call s:Hi('ErrorSign', a:lsp.ErrorFg, a:ui.GutterBg, s:none)
  call s:Hi('WarningSign', a:lsp.WarningFg, a:ui.GutterBg, s:none)
  call s:Hi('InfoSign', a:lsp.InfoFg, a:ui.GutterBg, s:none)
  call s:Hi('HintSign', a:lsp.HintFg, a:ui.GutterBg, s:none)
  call s:Hi('CodeActionSign', a:lsp.CodeActionFg, a:ui.GutterBg, s:none)

  " Comments:
  call s:Hi('Comment', a:syn.CommentFg, s:none, s:none)

  " Constants:
  call s:Hi('Constant', a:syn.ConstantFg, s:none, s:style.Italic)
  call s:Hi('String', a:syn.StringFg, s:none, s:none)
  call s:Hi('Character', a:syn.StringFg, s:none, s:none)
  call s:Hi('Number', a:syn.NumberFg, s:none, s:none)
  call s:Hi('Float', a:syn.NumberFg, s:none, s:none)
  call s:Hi('Boolean', a:syn.BooleanFg, s:none, s:none)

  " Identifiers:
  call s:Hi('Identifier', a:syn.IdentifierFg, s:none, s:none)
  call s:Hi('Function', a:syn.FunctionFg, s:none, s:none)

  " Statements:
  call s:Hi('Statement', a:syn.KeywordFg, s:none, s:none)

  " Preprocessing:
  call s:Hi('PreProc', a:syn.PreProcFg, s:none, s:none)

  " Types:
  call s:Hi('Type', a:syn.KeywordFg, s:none, s:none)

  " Special:
  call s:Hi('Special', a:syn.SpecialFg, s:none, s:none)
  call s:Hi('Tag', a:syn.KeywordFg, s:none, s:none)
  call s:Hi('Delimiter', a:syn.KeywordFg, s:none, s:none)
  call s:Hi('SpecialComment', a:syn.SpecialCommentFg, s:none, s:style.Bold)
  call s:Hi('Debug', a:syn.DebugFg, s:none, s:style.Italic)

  " Other:
  call s:Hi('Todo', a:syn.TodoFg, s:none, s:style.Italic)

  " LSP:
  call s:Hi('LspReference', s:none, a:ui.ReferenceBg, s:none)
endfunction
