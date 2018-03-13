module UI.Parts.Label
    exposing
        ( Label
        , invisible
        , label
        , view
        )

import Css
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attributes exposing (..)
import UI.Parts.Label.Internal as Internal
import UI.Parts.Label.Theme exposing (Theme)


type alias Label =
    Internal.Label


label : String -> Label
label =
    Internal.Label


invisible : String -> Label
invisible =
    Internal.InvisibleLabel


view : Theme -> String -> Label -> Html.Html msg
view (Internal.Theme theme) domId label =
    case label of
        Internal.Label labelText ->
            Html.Styled.label
                [ for domId
                , []
                    |> append Css.color theme.color
                    |> append Css.backgroundColor theme.backgroundColor
                    |> css
                ]
                [ text labelText ]
                |> Html.Styled.toUnstyled

        Internal.InvisibleLabel _ ->
            text ""
                |> Html.Styled.toUnstyled


append : (a -> b) -> Maybe a -> List b -> List b
append f maybe list =
    maybe
        |> Maybe.map (\a -> f a :: list)
        |> Maybe.withDefault list
