module Theme.Internal exposing (Theme(..))

import UI.Input.Text.Theme as InputText


type Theme
    = Theme { inputText : Maybe InputText.Theme }
