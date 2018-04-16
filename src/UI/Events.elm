module UI.Events exposing (onEnter)

import Html.Styled
import Html.Styled.Events exposing (keyCode, on)
import Json.Decode as JE


onEnter : msg -> Html.Styled.Attribute msg
onEnter tagger =
    on "keypress"
        (keyCode
            |> JE.andThen
                (\keyCode ->
                    case keyCode of
                        13 ->
                            JE.succeed tagger

                        _ ->
                            JE.fail ""
                )
        )
