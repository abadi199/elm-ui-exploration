module UI.Parts.MultiSelect
    exposing
        ( Attribute
        , State
        , initialState
        , onUpdate
        , view
        )

import Css exposing (..)
import Dict exposing (Dict)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick, onInput)
import Murmur3
import Theme exposing (Theme)
import Theme.Internal as Theme
import UI.Attribute as Attribute
import UI.Events exposing (onEnter)
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


view : Theme -> List (Attribute value comparable msg) -> State -> Html msg
view (Theme.Theme theme) attributes (Internal.State state) =
    let
        (Internal.Attribute attribute) =
            Attribute.process Internal.emptyAttribute attributes

        onUpdateHandler : (State -> msg) -> List (Html.Styled.Attribute msg)
        onUpdateHandler onUpdate =
            [ onInput (\value -> onUpdate (Internal.State { state | value = value }))
            , onEnter (onUpdate (Internal.State { state | selectedValues = state.value :: state.selectedValues, value = "" }))
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
            (state.selectedValues
                |> List.map (item (Internal.Attribute attribute) (Internal.State state))
                |> List.reverse
            )
        , input
            (type_ "text"
                :: value state.value
                :: css [ Css.width (pct 100) ]
                :: (attribute.onUpdate
                        |> Maybe.map onUpdateHandler
                        |> Maybe.withDefault []
                   )
            )
            []
        ]


item : Internal.Attribute value comparable msg -> State -> String -> Html msg
item (Internal.Attribute attribute) (Internal.State state) value =
    let
        onDeleteHandler onUpdate =
            { state | selectedValues = state.selectedValues |> List.filter (\item -> item /= value) }
                |> Internal.State
                |> onUpdate
                |> onClick
                |> List.singleton
    in
    div
        [ css
            [ display inlineBlock
            , margin (px 2)
            , padding (px 2)
            , border3 (px 1) solid (rgba 0 0 0 0.5)
            ]
        ]
        [ text value
        , button (type_ "button" :: (attribute.onUpdate |> Maybe.map onDeleteHandler |> Maybe.withDefault [])) [ text "X" ]
        ]



-- ATTRIBUTES


onUpdate : (State -> msg) -> Attribute value comparable msg
onUpdate msg =
    \(Internal.Attribute attribute) ->
        Internal.Attribute { attribute | onUpdate = Just msg }


options : Dict String String -> Attribute value comparable msg
options dict =
    \(Internal.Attribute attribute) ->
        Internal.Attribute { attribute | options = Internal.Options dict }
