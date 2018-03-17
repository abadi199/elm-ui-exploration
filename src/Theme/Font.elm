module Theme.Font
    exposing
        ( Style
        , Theme
        , families
        , size
        , weight
        )

import Css
import Theme.Internal as Internal


type alias Theme =
    Internal.FontTheme


type alias Style =
    Theme -> Theme


batch : List Style -> Style
batch styles =
    \(Internal.FontTheme theme) -> Internal.FontTheme theme


families : List String -> Style
families fontFamilies =
    \(Internal.FontTheme theme) -> Internal.FontTheme theme


size : Css.FontSize a -> Style
size fontSize =
    \(Internal.FontTheme theme) -> Internal.FontTheme theme


weight : Css.FontWeight a -> Style
weight fontWeight =
    \(Internal.FontTheme theme) -> Internal.FontTheme theme
