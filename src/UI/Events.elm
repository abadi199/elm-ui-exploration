module UI.Events
    exposing
        ( onClickPreventDefault
        , onKeyDown
        , onMouseDownPreventDefault
        )

import Html.Styled
import Html.Styled.Events exposing (keyCode, on, onWithOptions)
import Json.Decode as JD
import UI.KeyCode as KeyCode exposing (KeyCode)


onMouseDownPreventDefault : msg -> Html.Styled.Attribute msg
onMouseDownPreventDefault =
    onPreventDefault "mousedown"


onClickPreventDefault : msg -> Html.Styled.Attribute msg
onClickPreventDefault =
    onPreventDefault "click"


onPreventDefault : String -> msg -> Html.Styled.Attribute msg
onPreventDefault event msg =
    let
        eventOptions =
            { preventDefault = True
            , stopPropagation = True
            }
    in
    onWithOptions event eventOptions (JD.succeed msg)


onKeyDown : KeyCode -> msg -> Html.Styled.Attribute msg
onKeyDown expectedKeyCode msg =
    Html.Styled.Events.keyCode
        |> JD.map KeyCode.fromInt
        |> JD.andThen
            (\pressedKeyCode ->
                if pressedKeyCode == expectedKeyCode then
                    JD.succeed msg
                else
                    JD.fail "ignore"
            )
        |> on "keydown"
