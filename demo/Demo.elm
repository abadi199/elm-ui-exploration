module Demo exposing (Model, Msg, init, subscriptions, update, view)

import Html exposing (..)
import UI.Input.Text as InputText
import UI.Input.Text.Configs as InputText
import UI.Validator.String as StringValidator


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { firstName : InputText.State
    , lastName : InputText.State
    }


type Msg
    = FirstNameUpdated InputText.State
    | LastNameUpdated InputText.State


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FirstNameUpdated state ->
            ( { model | firstName = state }, Cmd.none )

        LastNameUpdated state ->
            ( { model | lastName = state }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Form Demo" ]
        , InputText.view
            [ InputText.label "First Name"
            , InputText.onUpdate FirstNameUpdated
            , InputText.help "Please enter your first name here."
            , InputText.validators
                [ StringValidator.required "First name is required."
                ]
            ]
            model.firstName
        , InputText.view
            [ InputText.label "Last Name"
            , InputText.onUpdate LastNameUpdated
            ]
            model.lastName
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : ( Model, Cmd Msg )
init =
    ( { firstName = InputText.initialState
      , lastName = InputText.initialState
      }
    , Cmd.none
    )
