module UI.Parts.FloatingMessage
    exposing
        ( view
        )

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import UI.Parts.Message.Theme as Theme exposing (Theme)


view : Theme -> String -> Html msg
view theme helpText =
    span
        [ css
            [ color (rgba 0 0 0 0.5)
            , position absolute
            , top zero
            , right (px 24)
            , padding (px 5)
            , boxShadow5 (px 0) (px 2) (px 6) (px 0) (hsla 0 0 0 0.2)
            , backgroundColor (rgba 255 255 255 1)
            , after []
            ]
        ]
        [ text helpText ]
