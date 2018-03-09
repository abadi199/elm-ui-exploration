module Theme.Basic exposing (theme)

import Color exposing (Color, rgba)
import Theme exposing (Theme)
import UI.Input.Text.Theme as InputText
import UI.Label.Theme as Label


theme : Theme
theme =
    Theme.theme
        [ inputTextTheme ]


inputTextTheme : Theme.Style
inputTextTheme =
    Theme.inputText
        [ InputText.label
            [ Label.color (rgba 255 0 0 0.5)
            , Label.backgroundColor (rgba 0 0 0 0)
            ]
        ]
