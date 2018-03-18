module Theme.Spacing
    exposing
        ( Style
        , Theme
        , batch
        , css
        , emptyTheme
        , padding
        )

import Css
import Theme.Helpers as Helpers exposing (append)
import Theme.Spacing.Internal as Internal


type alias Theme =
    Internal.Theme


type alias Style =
    Theme -> Theme


batch : List Style -> Style
batch styles =
    \theme ->
        Helpers.process theme styles


emptyTheme : Theme
emptyTheme =
    Internal.Theme
        { padding = Nothing }


padding : Float -> Float -> Float -> Float -> Style
padding top right bottom left =
    \(Internal.Theme theme) ->
        Internal.Theme { theme | padding = Just ( top, right, bottom, left ) }


css : Theme -> Css.Style
css (Internal.Theme theme) =
    []
        |> append paddingCss theme.padding
        |> Css.batch


paddingCss : ( Float, Float, Float, Float ) -> Css.Style
paddingCss ( top, right, bottom, left ) =
    Css.padding4 (Css.px top) (Css.px right) (Css.px bottom) (Css.px left)
