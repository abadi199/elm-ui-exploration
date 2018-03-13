module Theme.Font
    exposing
        ( Style
        , families
        , size
        , weight
        )

import Css


type alias Style =
    {}


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
