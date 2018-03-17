module UI.Parts.Label
    exposing
        ( Label
        , invisible
        , label
        , view
        )

import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attributes exposing (..)
import UI.Parts.Internal as Internal
import UI.Parts.Label.Theme as Theme exposing (Theme)


type alias Label =
    Internal.Label


label : String -> Label
label =
    Internal.Label


invisible : String -> Label
invisible =
    Internal.InvisibleLabel


view : Theme -> String -> Label -> Html.Html msg
view ((Internal.LabelTheme theme) as internalTheme) domId label =
    case label of
        Internal.Label labelText ->
            Html.Styled.label
                [ for domId
                , css [ Theme.css internalTheme ]
                ]
                [ text labelText ]
                |> Html.Styled.toUnstyled

        Internal.InvisibleLabel _ ->
            text ""
                |> Html.Styled.toUnstyled
