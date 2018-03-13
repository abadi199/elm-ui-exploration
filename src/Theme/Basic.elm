module Theme.Basic exposing (theme)

import Css exposing (rgba)
import Theme exposing (Theme)
import Theme.Color as Color
import Theme.Font as Font
import UI.Input.Text.Theme as InputText
import UI.Label.Theme as Label


theme : Theme
theme =
    Theme.theme
        [ inputTextTheme ]


inputTextTheme : Theme.Style
inputTextTheme =
    Theme.inputText
        [ InputText.label [ labelStyle ]
        , InputText.input []
        , InputText.helpIcon []
        , InputText.errorIcon []
        , InputText.helpMessage []
        , InputText.errorMessage []
        ]


labelStyle : Label.Style
labelStyle =
    Label.batch
        [ Label.color [ labelColor ]
        , Label.font [ labelFont ]
        , Label.spacing [ labelSpacing ]
        ]


labelFont : Font.Theme
labelFont =
    Font.theme
        [ Font.families [ "Helvetica" ]
        , Font.size (px 15)
        , Font.weight bold
        ]


labelColor : Color.Theme
labelColor =
    Color.theme
        [ Color.foreground (rgba 0 0 0 0.5)
        , Color.background (rgba 0 0 0 0)
        ]


labelSpacing : Spacing.Theme
labelSpacing =
    Spacing.theme
        [ Spacing.padding (px 10) (px 10) (px 10) (px 10)
        , Spacing.margin zero zero zero zero
        ]
