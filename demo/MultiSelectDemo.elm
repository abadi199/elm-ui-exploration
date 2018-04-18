module MultiSelectDemo exposing (Model, Msg, init, subscriptions, update, view)

import Css
import Dict
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Theme.Basic
import UI.Parts.MultiSelect as MultiSelect


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { multiSelect : MultiSelect.State
    }


type Msg
    = MultiSelectUpdated MultiSelect.State (Cmd Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MultiSelectUpdated state cmd ->
            ( { model | multiSelect = state }, cmd )


view : Model -> Html.Html Msg
view model =
    div [ css [ Css.maxWidth (Css.vw 50) ] ]
        [ h1 [] [ text "Form Demo" ]
        , div
            [ css
                [ Css.property "display" "grid"
                , Css.property "grid-template-columns" "repeat(auto-fit,minmax(250px,1fr))"
                , Css.property "grid-gap" "10px"
                ]
            ]
            [ label []
                [ text "Please select your favorite dinosaurs"
                , MultiSelect.view Theme.Basic.theme
                    [ MultiSelect.onUpdate MultiSelectUpdated
                    , MultiSelect.options <|
                        Dict.fromList
                            [ ( "1", "Tyrannosaurus Rex" )
                            , ( "2", "Triceratop" )
                            , ( "3", "Iguanodon" )
                            , ( "4", "Spinosaurus" )
                            , ( "5", "Parasaurolophus" )
                            , ( "7", "Velociraptor" )
                            ]
                    ]
                    model.multiSelect
                ]
            ]
        ]
        |> Html.Styled.toUnstyled


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : ( Model, Cmd Msg )
init =
    ( { multiSelect = MultiSelect.initialState
      }
    , Cmd.none
    )
