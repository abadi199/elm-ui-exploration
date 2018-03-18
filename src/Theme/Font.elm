module Theme.Font
    exposing
        ( Style
        , Theme
        , batch
        , css
        , emptyTheme
        , families
        , size
        , weight
        )

import Css
import Theme.Font.Internal as Internal
import Theme.Helpers as Helpers exposing (append)


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
        { families = Nothing
        , size = Nothing
        , weight = Nothing
        }


families : List String -> Style
families fontFamilies =
    \(Internal.Theme theme) -> Internal.Theme { theme | families = Just fontFamilies }


size : Float -> Style
size fontSize =
    \(Internal.Theme theme) -> Internal.Theme { theme | size = Just fontSize }


weight : Int -> Style
weight fontWeight =
    \(Internal.Theme theme) -> Internal.Theme { theme | weight = Just fontWeight }


css : Theme -> Css.Style
css (Internal.Theme theme) =
    []
        |> append familiesCss theme.families
        |> append sizeCss theme.size
        |> append weightCss theme.weight
        |> Css.batch


familiesCss : List String -> Css.Style
familiesCss fontFamilies =
    Css.fontFamilies fontFamilies


sizeCss : Float -> Css.Style
sizeCss fontSize =
    Css.fontSize (Css.px fontSize)


weightCss : Int -> Css.Style
weightCss fontWeight =
    Css.fontWeight (Css.int fontWeight)
