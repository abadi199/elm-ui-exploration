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


type InputTheme
    = InputTheme {}


type MessageTheme
    = MessageTheme {}


type LabelTheme
    = LabelTheme
        { color : Color.Theme
        }


type LabelState
    = LabelState


type Label
    = Label String
    | InvisibleLabel String


type IconTheme
    = IconTheme {}
