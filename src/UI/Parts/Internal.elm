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
import Theme.Spacing as Spacing


type InputTheme
    = InputTheme
        { color : Color.Theme
        , font : Font.Theme
        , spacing : Spacing.Theme
        }


type MessageTheme
    = MessageTheme {}


type LabelTheme
    = LabelTheme
        { color : Color.Theme
        , font : Font.Theme
        , spacing : Spacing.Theme
        }


type LabelState
    = LabelState


type Label
    = Label String
    | InvisibleLabel String


type IconTheme
    = IconTheme {}
