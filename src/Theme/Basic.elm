module Theme.Basic exposing (theme)

import Css exposing (bold, px, rgba)
import Theme exposing (Theme)
import Theme.Color as Color
import Theme.Font as Font
import Theme.Spacing as Spacing
import UI.Elements.Input.Text.Theme as InputText
import UI.Parts.Label.Theme as Label


theme : Theme
theme =
    Theme.theme
        [ inputTextTheme ]


inputTextTheme : Theme.Style
inputTextTheme =
    Theme.inputText
        [ InputText.label [ labelStyle ]
        ]


labelStyle : Label.Style
labelStyle =
    Label.batch
        [ Label.color [ labelColor ]
        , Label.font [ labelFont ]
        , Label.spacing [ labelSpacing ]
        ]


labelFont : Font.Style
labelFont =
    Font.batch
        [ Font.families [ "Sans serif" ]
        , Font.size 18
        , Font.weight Font.normal
        ]


labelColor : Color.Style
labelColor =
    Color.batch
        [ Color.foreground (Color.color (rgba 255 0 0 0.5))
        , Color.background (Color.color (rgba 0 0 0 0.2))
        , Color.border (Color.color (rgba 0 255 255 1))
        ]


labelSpacing : Spacing.Style
labelSpacing =
    Spacing.batch
        [ Spacing.padding 10 10 10 10
        ]
