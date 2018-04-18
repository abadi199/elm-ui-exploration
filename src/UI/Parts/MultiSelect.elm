module UI.Parts.MultiSelect
    exposing
        ( Attribute
        , State
        , initialState
        , onUpdate
        , options
        , view
        )

import Css exposing (..)
import Dict exposing (Dict)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onBlur, onClick, onFocus, onInput)
import Murmur3
import Process
import String
import Task exposing (Task)
import Theme exposing (Theme)
import Theme.Internal as Theme
import Time
import UI.Attribute as Attribute
import UI.Events exposing (onClickPreventDefault, onEnter, onMouseDownPreventDefault)
import UI.Parts.MultiSelect.Internal as Internal


seed : Int
seed =
    33214


type alias State =
    Internal.State


initialState : State
initialState =
    Internal.initialState


type alias Attribute value comparable msg =
    Internal.Attribute value comparable msg -> Internal.Attribute value comparable msg


view : Theme -> List (Attribute comparable item msg) -> State -> Html msg
view (Theme.Theme theme) attributes (Internal.State state) =
    let
        (Internal.Attribute attribute) =
            Attribute.process Internal.emptyAttribute attributes

        onUpdateHandler onUpdate =
            [ onInput (\value -> onUpdate (Internal.State { state | value = value, focus = Internal.FocusOnInput }) Cmd.none)
            , onFocus (onUpdate (Internal.State { state | focus = Internal.FocusOnInput }) Cmd.none)
            , onClick (onUpdate (Internal.State { state | focus = Internal.FocusOnInput }) Cmd.none)
            , onBlur (onUpdate (Internal.State { state | focus = Internal.FocusOnOutside }) Cmd.none)
            ]
    in
    div
        [ css
            [ displayFlex
            , flexDirection row
            , flexWrap Css.wrap
            , border3 (px 1) solid (rgba 0 0 0 0.5)
            ]
        ]
        [ div []
            (state.selectedKeys
                |> List.map (selectedItem attribute state)
                |> List.reverse
            )
        , input
            (type_ "text"
                :: value state.value
                :: css []
                :: (attribute.onUpdate
                        |> Maybe.map onUpdateHandler
                        |> Maybe.withDefault []
                   )
            )
            []
        , dropDown (Theme.Theme theme) attribute state
        ]


dropDown : Theme -> Internal.AttributeData comparable item msg -> Internal.StateData -> Html msg
dropDown (Theme.Theme theme) attribute state =
    let
        onUpdateHandler onUpdate =
            [ onMouseDownPreventDefault (onUpdate (Internal.State state) Cmd.none) ]

        view_ =
            ul
                (css [ Css.listStyle none, Css.width (pct 100), padding zero, margin zero ]
                    :: (attribute.onUpdate |> Maybe.map onUpdateHandler |> Maybe.withDefault [])
                )
                (attribute.options
                    |> Internal.toList
                    |> List.filter (\( key, value ) -> List.all ((/=) key) state.selectedKeys && (String.isEmpty state.value || String.contains (String.toLower state.value) (String.toLower value)))
                    |> List.map (dropDownItem (Theme.Theme theme) attribute state)
                )
    in
    case state.focus of
        Internal.FocusOnInput ->
            view_

        Internal.FocusOnOutside ->
            text ""


dropDownItem : Theme -> Internal.AttributeData comparable item msg -> Internal.StateData -> ( String, String ) -> Html msg
dropDownItem (Theme.Theme theme) attribute state ( key, item ) =
    let
        updatedState =
            Internal.State { state | selectedKeys = key :: state.selectedKeys, focus = Internal.FocusOnOutside, value = "" }

        onUpdateHandler onUpdate =
            [ onClickPreventDefault (onUpdate updatedState Cmd.none) ]
    in
    li
        (css [ Css.width (pct 100), hover [ backgroundColor (rgba 255 0 0 1) ] ]
            :: (attribute.onUpdate
                    |> Maybe.map onUpdateHandler
                    |> Maybe.withDefault []
               )
        )
        [ text item ]


selectedItem : Internal.AttributeData comparable item msg -> Internal.StateData -> String -> Html msg
selectedItem attribute state value =
    let
        onDeleteHandler onUpdate =
            { state | selectedKeys = state.selectedKeys |> List.filter (\item -> item /= value) }
                |> Internal.State
                |> (\state -> onUpdate state Cmd.none)
                |> onClickPreventDefault
                |> List.singleton
    in
    case Dict.get value (Internal.toDict attribute.options) of
        Just item ->
            div
                [ css
                    [ display inlineBlock
                    , margin (px 2)
                    , padding (px 2)
                    , border3 (px 1) solid (rgba 0 0 0 0.5)
                    ]
                ]
                [ text item
                , span
                    (css
                        [ border3 (px 1) solid (rgba 0 0 0 0.5)
                        , margin2 zero (px 10)
                        , padding (px 2)
                        ]
                        :: (attribute.onUpdate |> Maybe.map onDeleteHandler |> Maybe.withDefault [])
                    )
                    [ text "X" ]
                ]

        Nothing ->
            text ""



-- ATTRIBUTES


onUpdate : (State -> Cmd msg -> msg) -> Attribute comparable item msg
onUpdate msg =
    \(Internal.Attribute attribute) ->
        Internal.Attribute { attribute | onUpdate = Just msg }


options : Dict String String -> Attribute comparable item msg
options dict =
    \(Internal.Attribute attribute) ->
        Internal.Attribute { attribute | options = Internal.Options dict }
