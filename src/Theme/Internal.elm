module Theme.Internal
    exposing
        ( SpacingTheme(..)
        , Theme(..)
        )

import Css
import UI.Elements.Input.Text.Theme as InputText


type Theme
    = Theme { inputText : Maybe InputText.Theme }


type SpacingTheme
    = SpacingTheme {}
