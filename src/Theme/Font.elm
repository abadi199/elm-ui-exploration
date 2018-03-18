module Theme.Font
    exposing
        ( Style
        , Theme
        , batch
        , bold
        , css
        , emptyTheme
        , extraBold
        , extraLight
        , families
        , heavy
        , light
        , medium
        , normal
        , semiBold
        , size
        , thin
        , weight
        )

import Css
import Theme.Font.Internal as Internal
import Theme.Helpers as Helpers exposing (append)


type alias Theme =
    Internal.Theme


type alias Style =
    Theme -> Theme


type alias Weight =
    Internal.Weight


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


weight : Weight -> Style
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


weightCss : Weight -> Css.Style
weightCss (Internal.Weight fontWeight) =
    Css.fontWeight (Css.int fontWeight)



-- WEIGHT


thin : Weight
thin =
    Internal.Weight 100


extraLight : Weight
extraLight =
    Internal.Weight 200


light : Weight
light =
    Internal.Weight 300


normal : Weight
normal =
    Internal.Weight 400


medium : Weight
medium =
    Internal.Weight 500


semiBold : Weight
semiBold =
    Internal.Weight 600


bold : Weight
bold =
    Internal.Weight 700


extraBold : Weight
extraBold =
    Internal.Weight 800


heavy : Weight
heavy =
    Internal.Weight 900
