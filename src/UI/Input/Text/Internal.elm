module UI.Input.Text.Internal
    exposing
        ( Attribute(..)
        , HelpTextState(..)
        , State(..)
        , emptyAttribute
        , initialState
        )

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
