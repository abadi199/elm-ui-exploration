module UI.Elements.Input.Text.Internal
    exposing
        ( Attribute(..)
        , HelpTextState(..)
        , State(..)
        , Theme(..)
        , emptyAttribute
        , initialState
        )

import UI.Parts.Icon.Theme as Icon
import UI.Parts.Input.Theme as Input
import UI.Parts.Label.Theme as Label
import UI.Parts.Message.Theme as Message
import UI.Validator as Validator exposing (Validator)


type State
    = State
        { value : String
        , shouldValidate : Bool
        , helpTextState : HelpTextState
        }


type HelpTextState
    = HelpTextOpened
    | HelpTextClosed


initialState : State
initialState =
    State
        { value = ""
        , shouldValidate = False
        , helpTextState = HelpTextClosed
        }


type Attribute msg
    = Attribute
        { onUpdate : Maybe (State -> msg)
        , validators : Maybe (List (Validator String))
        , helpText : Maybe String
        , helpButtonText : String
        , placeholderText : Maybe String
        }


emptyAttribute : Attribute msg
emptyAttribute =
    Attribute
        { onUpdate = Nothing
        , validators = Nothing
        , helpText = Nothing
        , helpButtonText = "Help"
        , placeholderText = Nothing
        }


type Theme
    = Theme
        { label : Maybe Label.Theme
        , input : Maybe Input.Theme
        , helpIcon : Maybe Icon.Theme
        , errorIcon : Maybe Icon.Theme
        , helpMessage : Maybe Message.Theme
        , errorMessage : Maybe Message.Theme
        }
