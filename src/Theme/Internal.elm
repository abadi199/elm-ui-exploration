module Theme.Internal
    exposing
        ( FontTheme(..)
        , SpacingTheme(..)
        , Theme(..)
        )

import Css
import UI.Elements.Input.Text.Theme as InputText


type Theme
    = Theme { inputText : Maybe InputText.Theme }


type FontTheme
    = FontTheme {}


type SpacingTheme
    = SpacingTheme {}
