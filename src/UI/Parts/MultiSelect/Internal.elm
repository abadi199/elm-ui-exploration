module UI.Parts.MultiSelect.Internal
    exposing
        ( Attribute(..)
        , AttributeData
        , Focus(..)
        , Options(..)
        , State(..)
        , StateData
        , emptyAttribute
        , initialState
        , toDict
        , toList
        )

import Dict exposing (Dict)


type Attribute comparable item msg
    = Attribute (AttributeData comparable item msg)


type alias AttributeData comparable item msg =
    { onUpdate : Maybe (State -> Cmd msg -> msg)
    , options : Options comparable item
    }


type Options comparable item
    = Options (Dict String String)
    | CustomOptions
        { options : Dict String item
        , sortBy : item -> comparable
        , displayText : item -> String
        }


toDict : Options comparable item -> Dict String String
toDict options =
    case options of
        Options dict ->
            dict

        CustomOptions { options, sortBy, displayText } ->
            options
                |> Dict.map (\key value -> displayText value)


toList : Options comparable item -> List ( String, String )
toList options =
    case options of
        Options dict ->
            Dict.toList dict

        CustomOptions { options, sortBy, displayText } ->
            Dict.toList options
                |> List.sortBy (\( _, value ) -> sortBy value)
                |> List.map (\( key, value ) -> ( key, displayText value ))


emptyAttribute : Attribute comparable item msg
emptyAttribute =
    Attribute
        { onUpdate = Nothing
        , options = Options Dict.empty
        }


type State
    = State StateData


type alias StateData =
    { value : String
    , selectedKeys : List String
    , focus : Focus
    }


type Focus
    = FocusOnInput
    | FocusOnOutside


initialState : State
initialState =
    State
        { value = ""
        , selectedKeys = []
        , focus = FocusOnOutside
        }
