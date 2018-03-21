module UI.Parts.Input
    exposing
        ( view
        )

import Css
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attributes exposing (..)
import UI.Parts.Input.Theme as Theme exposing (Theme)
import UI.Parts.Internal as Internal


view : Theme -> String -> List (Attribute msg) -> Html msg
view ((Internal.InputTheme theme) as internalTheme) domId attributes =
    input
        (id domId :: css [ Theme.css internalTheme, Css.width (Css.pct 100) ] :: attributes)
        []
