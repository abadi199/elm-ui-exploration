module UI.Input.Text
    exposing
        ( Config
        , State
        , initialState
        , value
        , view
        )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onBlur, onFocus, onInput, onMouseOut, onMouseOver)
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



-- CONFIG


type alias Config msg =
    Internal.Config msg -> Internal.Config msg



-- GETTER


value : State -> Result (List String) String
value (Internal.State state) =
    Result.Ok state.value



-- VIEW


view : List (Config msg) -> State -> Html msg
view configurations ((Internal.State state) as internalState) =
    let
        domId =
            generateDomId internalConfig

        ((Internal.Config config) as internalConfig) =
            configure configurations
    in
    div []
        [ labelView domId internalConfig
        , helpButtonView internalConfig internalState
        , helpView internalConfig internalState
        , inputView domId internalConfig internalState
        , validationView internalConfig internalState
        ]


labelView : String -> Internal.Config msg -> Html msg
labelView domId (Internal.Config config) =
    config.labelText
        |> Maybe.map (\labelText -> Html.label [ for domId ] [ Html.text labelText ])
        |> Maybe.withDefault (Html.text "")


helpView : Internal.Config msg -> State -> Html msg
helpView (Internal.Config config) (Internal.State state) =
    let
        helpTextView helpText =
            case state.helpTextState of
                Internal.HelpTextClosed ->
                    Html.p [ style [ ( "visibility", "collapse" ) ] ] [ Html.text helpText ]

                Internal.HelpTextOpened ->
                    Html.p [] [ Html.text helpText ]
    in
    config.helpText
        |> Maybe.map helpTextView
        |> Maybe.withDefault (Html.text "")


helpButtonView : Internal.Config msg -> State -> Html msg
helpButtonView (Internal.Config config) (Internal.State state) =
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
        |> Maybe.withDefault (Html.text "")


inputView : String -> Internal.Config msg -> State -> Html msg
inputView domId (Internal.Config config) (Internal.State state) =
    let
        ariaInvalid =
            if state.shouldValidate && (config.validators |> Maybe.map (Validator.isInvalid state.value) |> Maybe.withDefault False) then
                "true"
            else
                "false"
    in
    input
        [ config.onUpdate
            |> Maybe.map (\onUpdate -> onInput (\value -> onUpdate (Internal.State { state | value = value, shouldValidate = True })))
            |> Maybe.withDefault (id domId)
        , id domId
        , Html.Attributes.value state.value
        , Html.Attributes.attribute "aria-invalid" ariaInvalid
        ]
        []


validationView : Internal.Config msg -> State -> Html msg
validationView (Internal.Config config) (Internal.State state) =
    if state.shouldValidate then
        config.validators
            |> Maybe.map (\validators -> Validator.view validators state.value)
            |> Maybe.withDefault (Html.text "")
    else
        Html.text ""


configure : List (Config msg) -> Internal.Config msg
configure configurations =
    configurations
        |> List.foldl (\f config -> f config) Internal.emptyConfig


generateDomId : Internal.Config config -> String
generateDomId (Internal.Config config) =
    toString <|
        Murmur3.hashString seed (toString config)
