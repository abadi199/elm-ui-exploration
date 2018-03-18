module UI.Parts.Internal
    exposing
        ( IconTheme(..)
        , InputTheme(..)
        , Label(..)
        , LabelState(..)
        , LabelTheme(..)
        , MessageTheme(..)
        )

import Css
import Theme.Color as Color
import Theme.Font as Font


type InputTheme
    = InputTheme {}


type MessageTheme
    = MessageTheme {}


type LabelTheme
    = LabelTheme
        { color : Color.Theme
        , font : Font.Theme
        }


type LabelState
    = LabelState


type Label
    = Label String
    | InvisibleLabel String


type IconTheme
    = IconTheme {}
