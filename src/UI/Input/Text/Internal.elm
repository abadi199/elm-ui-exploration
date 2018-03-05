module UI.Input.Text.Internal
    exposing
        ( Config(..)
        , HelpTextState(..)
        , State(..)
        , emptyConfig
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


type Config msg
    = Config
        { labelText : Maybe String
        , onUpdate : Maybe (State -> msg)
        , validators : Maybe (List (Validator String))
        , helpText : Maybe String
        , helpButtonText : String
        }


emptyConfig : Config msg
emptyConfig =
    Config
        { onUpdate = Nothing
        , labelText = Nothing
        , validators = Nothing
        , helpText = Nothing
        , helpButtonText = "Help"
        }
