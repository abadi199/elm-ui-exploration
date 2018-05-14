module UI.Parts.MultiSelect.Internal
    exposing
        ( Attribute(..)
        , AttributeData
        , Focus(..)
        , FocusedKey(..)
        , Options(..)
        , State(..)
        , StateData
        , addSelectedKeys
        , availableOptions
        , clearFocused
        , emptyAttribute
        , focus
        , focusedKey
        , initialState
        , nextFocus
        , prevFocus
        , selectFocused
        , toDict
        , value
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


availableOptions : State -> Options comparable item -> List ( String, String )
availableOptions (State state) options =
    (case options of
        Options dict ->
            Dict.toList dict

        CustomOptions { options, sortBy, displayText } ->
            Dict.toList options
                |> List.sortBy (\( _, value ) -> sortBy value)
                |> List.map (\( key, value ) -> ( key, displayText value ))
    )
        |> List.filter (\( key, value ) -> List.all ((/=) key) state.selectedKeys && (String.isEmpty state.value || String.contains (String.toLower state.value) (String.toLower value)))


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
    , focusedKey : FocusedKey
    }


type Focus
    = FocusOnInput
    | FocusOnOutside


type FocusedKey
    = NoKeyFocused
    | KeyFocused String


initialState : State
initialState =
    State
        { value = ""
        , selectedKeys = []
        , focusedKey = NoKeyFocused
        , focus = FocusOnOutside
        }


focusedKey : State -> FocusedKey
focusedKey (State state) =
    state.focusedKey


nextFocus : Options comparable item -> State -> State
nextFocus options ((State state) as internalState) =
    case state.focusedKey of
        NoKeyFocused ->
            options
                |> availableOptions internalState
                |> List.head
                |> Maybe.map Tuple.first
                |> Maybe.map (\key -> State { state | focusedKey = KeyFocused key })
                |> Maybe.withDefault internalState

        KeyFocused currentKey ->
            case next options internalState currentKey of
                Just nextKey ->
                    State { state | focusedKey = KeyFocused nextKey }

                Nothing ->
                    internalState


next : Options comparable item -> State -> String -> Maybe String
next options state key =
    options
        |> availableOptions state
        |> nextHelper key


nextHelper : String -> List ( String, a ) -> Maybe String
nextHelper key list =
    if list |> List.map Tuple.first |> List.member key |> not then
        List.head list |> Maybe.map Tuple.first

    else
        case list of
            [] ->
                Nothing

            head :: [] ->
                Nothing

            head :: next :: [] ->
                if Tuple.first head == key then
                    Just (Tuple.first next)

                else
                    Nothing

            head :: next :: nextNext :: rest ->
                if Tuple.first head == key then
                    Just (Tuple.first next)

                else if Tuple.first next == key then
                    Just (Tuple.first nextNext)

                else
                    nextHelper key (nextNext :: rest)


prevFocus : Options comparable item -> State -> State
prevFocus options ((State state) as internalState) =
    case state.focusedKey of
        NoKeyFocused ->
            options
                |> availableOptions internalState
                |> List.reverse
                |> List.head
                |> Maybe.map Tuple.first
                |> Maybe.map (\key -> State { state | focusedKey = KeyFocused key })
                |> Maybe.withDefault internalState

        KeyFocused currentKey ->
            case prev options internalState currentKey of
                Just prevKey ->
                    State { state | focusedKey = KeyFocused prevKey }

                Nothing ->
                    internalState


prev : Options comparable item -> State -> String -> Maybe String
prev options state key =
    options
        |> availableOptions state
        |> List.reverse
        |> nextHelper key


addSelectedKeys : String -> State -> State
addSelectedKeys key ((State state) as internalState) =
    State { state | selectedKeys = key :: state.selectedKeys }


selectFocused : State -> State
selectFocused ((State state) as internalState) =
    case state.focusedKey of
        NoKeyFocused ->
            internalState

        KeyFocused key ->
            addSelectedKeys key internalState


clearFocused : State -> State
clearFocused ((State state) as internalState) =
    State { state | focusedKey = NoKeyFocused }


value : String -> State -> State
value v (State state) =
    State { state | value = v }


focus : Focus -> State -> State
focus f (State state) =
    State { state | focus = f }
