module UI.Parts.Input.Theme
    exposing
        ( Styles
        , Them
        )

import UI.Parts.Input.Internal as Internal


type alias Theme =
    Internal.Theme


type alias Style =
    Theme -> Theme
