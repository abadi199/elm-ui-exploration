module UI.Parts.Input.Theme
    exposing
        ( Style
        , Theme
        , emptyTheme
        )

import UI.Parts.Internal as Internal


type alias Theme =
    Internal.InputTheme


type alias Style =
    Theme -> Theme


emptyTheme : Theme
emptyTheme =
    Internal.InputTheme {}
