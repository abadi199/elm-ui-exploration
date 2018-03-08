module UI.Input.Text
    exposing
        ( Attribute
        , State
        , initialState
        , invisibleLabel
        , label
        , value
        , view
        )

import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attributes exposing (..)
import Html.Styled.Events as Events exposing (onBlur, onFocus, onInput, onMouseOut, onMouseOver)
import Murmur3
import Result
import UI.Input.Text.Internal as Internal
import UI.Validator as Validator


seed : Int
seed =
    95858


type alias State =
    Internal.State


initialState : State
initialState =
    Internal.initialState



-- LABEL


type Label
    = Label String
    | InvisibleLabel String


label : String -> Label
label =
    Label


invisibleLabel : String -> Label
invisibleLabel =
    InvisibleLabel



-- CONFIG


type alias Attribute msg =
    Internal.Attribute msg -> Internal.Attribute msg



-- GETTER


value : State -> Result (List String) String
value (Internal.State state) =
    Result.Ok state.value



-- VIEW


view : List (Attribute msg) -> Label -> State -> Html.Html msg
view configurations label ((Internal.State state) as internalState) =
    let
        domId =
            generateDomId internalAttribute

        ((Internal.Attribute config) as internalAttribute) =
            configure configurations
    in
    div []
        [ labelView domId internalAttribute label
        , helpButtonView internalAttribute internalState
        , helpView internalAttribute internalState
        , inputView domId internalAttribute label internalState
        , validationView internalAttribute internalState
        ]
        |> Html.Styled.toUnstyled


labelView : String -> Internal.Attribute msg -> Label -> Html msg
labelView domId (Internal.Attribute config) label =
    case label of
        Label labelText ->
            Html.Styled.label [ for domId ] [ text labelText ]

        InvisibleLabel _ ->
            text ""


helpView : Internal.Attribute msg -> State -> Html msg
helpView (Internal.Attribute config) (Internal.State state) =
    let
        helpTextView helpText =
            case state.helpTextState of
                Internal.HelpTextClosed ->
                    p [ style [ ( "visibility", "collapse" ) ] ] [ text helpText ]

                Internal.HelpTextOpened ->
                    p [] [ text helpText ]
    in
    config.helpText
        |> Maybe.map helpTextView
        |> Maybe.withDefault (text "")


helpButtonView : Internal.Attribute msg -> State -> Html msg
helpButtonView (Internal.Attribute config) (Internal.State state) =
    let
        eventsHandler onUpdate =
            [ onMouseOver <| onUpdate (Internal.State { state | shouldValidate = False, helpTextState = Internal.HelpTextOpened })
            , onMouseOut <| onUpdate (Internal.State { state | shouldValidate = False, helpTextState = Internal.HelpTextClosed })
            , onFocus <| onUpdate (Internal.State { state | shouldValidate = False, helpTextState = Internal.HelpTextOpened })
            , onBlur <| onUpdate (Internal.State { state | shouldValidate = False, helpTextState = Internal.HelpTextClosed })
            ]

        events =
            config.onUpdate
                |> Maybe.map eventsHandler
                |> Maybe.withDefault []
    in
    config.helpText
        |> Maybe.map (\_ -> div ([ tabindex 0 ] ++ events) [ text config.helpButtonText ])
        |> Maybe.withDefault (text "")


inputView : String -> Internal.Attribute msg -> Label -> State -> Html msg
inputView domId (Internal.Attribute config) label (Internal.State state) =
    let
        noAttribute =
            id domId

        defaultPlaceholder =
            case label of
                InvisibleLabel labelText ->
                    Attributes.placeholder labelText

                _ ->
                    noAttribute

        placeholder =
            config.placeholderText
                |> Maybe.map (\placeholderText -> Attributes.placeholder placeholderText)
                |> Maybe.withDefault defaultPlaceholder

        onUpdateEvent =
            config.onUpdate
                |> Maybe.map (\onUpdate -> onInput (\value -> onUpdate (Internal.State { state | value = value, shouldValidate = True })))
                |> Maybe.withDefault noAttribute

        ariaInvalid =
            if state.shouldValidate && (config.validators |> Maybe.map (Validator.isInvalid state.value) |> Maybe.withDefault False) then
                "true"
            else
                "false"

        ariaLabel =
            case label of
                InvisibleLabel labelText ->
                    Attributes.attribute "aria-label" labelText

                _ ->
                    noAttribute
    in
    input
        [ onUpdateEvent
        , Attributes.value state.value
        , Attributes.attribute "aria-invalid" ariaInvalid
        , ariaLabel
        , placeholder
        , id domId
        ]
        []


validationView : Internal.Attribute msg -> State -> Html msg
validationView (Internal.Attribute config) (Internal.State state) =
    if state.shouldValidate then
        config.validators
            |> Maybe.map (\validators -> Validator.view validators state.value)
            |> Maybe.withDefault (text "")
    else
        text ""


configure : List (Attribute msg) -> Internal.Attribute msg
configure configurations =
    configurations
        |> List.foldl (\f config -> f config) Internal.emptyAttribute


generateDomId : Internal.Attribute config -> String
generateDomId (Internal.Attribute config) =
    toString <|
        Murmur3.hashString seed (toString config)
