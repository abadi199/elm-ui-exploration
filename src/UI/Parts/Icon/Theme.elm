module UI.Parts.Icon.Theme
    exposing
        ( Style
        , Theme
        , emptyTheme
        )

import UI.Parts.Internal as Internal


type alias Theme =
    Internal.IconTheme


emptyTheme : Theme
emptyTheme =
    Internal.IconTheme {}


type alias Style =
    Theme -> Theme
