module UI.Events
    exposing
        ( onClickPreventDefault
        , onEnter
        , onMouseDownPreventDefault
        )

import Html.Styled
import Html.Styled.Events exposing (keyCode, on, onWithOptions)
import Json.Decode as JD


onEnter : msg -> Html.Styled.Attribute msg
onEnter tagger =
    on "keypress"
        (keyCode
            |> JD.andThen
                (\keyCode ->
                    case keyCode of
                        13 ->
                            JD.succeed tagger

                        _ ->
                            JD.fail ""
                )
        )


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
