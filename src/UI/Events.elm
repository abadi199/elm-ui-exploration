module UI.Events
    exposing
        ( onClickPreventDefault
        , onKeyDown
        , onMouseDownPreventDefault
        )

import Dict
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


onKeyDown : List ( KeyCode, msg ) -> Html.Styled.Attribute msg
onKeyDown list =
    let
        keyCodeDict =
            list |> List.map (\( keyCode, msg ) -> ( KeyCode.toInt keyCode, msg )) |> Dict.fromList
    in
    Html.Styled.Events.keyCode
        |> JD.andThen
            (\pressedKeyCode ->
                case Dict.get pressedKeyCode keyCodeDict of
                    Just msg ->
                        JD.succeed msg

                    Nothing ->
                        JD.fail "ignore"
            )
        |> on "keydown"
