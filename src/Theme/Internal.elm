module Theme.Internal
    exposing
        ( Theme(..)
        )

import Css
import UI.Elements.Input.Text.Theme as InputText


type Theme
    = Theme
        { inputText : Maybe InputText.Theme
        }
