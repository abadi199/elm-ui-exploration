module UI.Parts.MultiSelect.Internal
    exposing
        ( Attribute(..)
        , Options(..)
        , State(..)
        , emptyAttribute
        , initialState
        )

import Dict exposing (Dict)


type Attribute value comparable msg
    = Attribute
        { onUpdate : Maybe (State -> msg)
        , options : Options value comparable
        }


type Options value comparable
    = Options (Dict String String)
    | CustomOptions
        { options : Dict String value
        , sortBy : value -> comparable
        , displayText : value -> String
        }


emptyAttribute : Attribute value comparable msg
emptyAttribute =
    Attribute
        { onUpdate = Nothing
        , options = Options Dict.empty
        }


type State
    = State
        { value : String
        , selectedValues : List String
        }


initialState : State
initialState =
    State
        { value = ""
        , selectedValues = []
        }
