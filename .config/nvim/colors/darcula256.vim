" JetBrains Darcula theme for 256-color terminals.
let colors_name = 'darcula256'

" This is a dark theme, so force dark background.
set background=dark

let s:palette={
    \ 'Black': 235,
    \ 'Grey0': 236,
    \ 'Grey1': 238,
    \ 'Grey2': 243,
    \ 'White': 145,
    \ 'Red': 167,
    \ 'Tan': 179,
    \ 'Wheat': 101,
    \ 'Green': 65,
    \ 'Orange': 172,
    \ 'Yellow': 142,
    \ 'Blue': 67,
    \ 'Purple': 97,
    \ 'Cyan': 23,
    \ }

let s:ui={
    \ 'Bg': s:palette.Black,
    \ 'NormalFg': s:palette.White,
    \ 'NonTextFg': s:palette.Grey2,
    \ 'PromptFg': s:palette.Green,
    \ 'TitleFg': s:palette.Orange,
    \ 'CursorLineBg': s:palette.Grey0,
    \ 'GutterFg': s:palette.Grey2,
    \ 'GutterCursorFg': s:palette.White,
    \ 'GutterBg': s:palette.Grey0,
    \ 'SelectionFg': s:palette.White,
    \ 'SelectionBg': s:palette.Cyan,
    \ 'WinSepFg': s:palette.Grey2,
    \ 'WinSepSelFg': s:palette.White,
    \ 'WinSepBg': s:palette.Grey1,
    \ 'FloatFg': s:palette.White,
    \ 'FloatBg': s:palette.Grey1,
    \ 'FloatThumb': s:palette.Grey2,
    \ 'UriFg': s:palette.Blue,
    \ 'MatchParenFg': s:palette.Yellow,
    \ 'ReferenceBg': s:palette.Grey0,
    \ }

let s:vcs={
    \ 'AddedFg': s:palette.Wheat,
    \ 'ChangedFg': s:palette.Orange,
    \ 'ChangedInlineFg': s:palette.Tan,
    \ 'DeletedFg': s:palette.Red,
    \ }

let s:lsp={
    \ 'ErrorFg': s:palette.Red,
    \ 'WarningFg': s:palette.Orange,
    \ 'InfoFg': s:palette.Grey2,
    \ 'HintFg': s:palette.Grey2,
    \ 'CodeActionFg': s:palette.White,
    \ }

let s:syn={
    \ 'ConstantFg': s:palette.Purple,
    \ 'NumberFg': s:palette.Blue,
    \ 'StringFg': s:palette.Wheat,
    \ 'BooleanFg': s:palette.Orange,
    \ 'IdentifierFg': s:palette.White,
    \ 'FunctionFg': s:palette.Tan,
    \ 'FieldFg': s:palette.Purple,
    \ 'TypeFg': s:palette.White,
    \ 'KeywordFg': s:palette.Orange,
    \ 'PreProcFg': s:palette.Yellow,
    \ 'SpecialFg': s:palette.Yellow,
    \ 'DebugFg': s:palette.Grey2,
    \ 'CommentFg': s:palette.Grey2,
    \ 'DocumentationFg': s:palette.Green,
    \ 'SpecialCommentFg': s:palette.White,
    \ 'TodoFg': s:palette.Yellow,
    \ }

call theme#ApplyColorTheme(s:ui, s:vcs, s:lsp, s:syn)
