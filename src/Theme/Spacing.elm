module Theme.Spacing
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
    Internal.SpacingTheme


type alias Style =
    Theme -> Theme


batch : List Style -> Style
batch =
    Debug.crash "Font.batch"


families : List String -> Style
families =
    Debug.crash "Font.families"


size : Css.FontSize a -> Style
size =
    Debug.crash "Font.size"


weight : Css.FontWeight a -> Style
weight =
    Debug.crash "Font.weight"
