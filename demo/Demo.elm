module Demo exposing (Model, Msg, init, subscriptions, update, view)

import Css
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Theme.Basic
import UI.Elements.Input.Text as InputText
import UI.Elements.Input.Text.Attributes as InputText
import UI.Parts.Label as Label
import UI.Parts.MultiSelect as MultiSelect
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
    , multiSelect : MultiSelect.State
    }


type Msg
    = FirstNameUpdated InputText.State
    | LastNameUpdated InputText.State
    | MultiSelectUpdated MultiSelect.State


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FirstNameUpdated state ->
            ( { model | firstName = state }, Cmd.none )

        LastNameUpdated state ->
            ( { model | lastName = state }, Cmd.none )

        MultiSelectUpdated state ->
            ( { model | multiSelect = state }, Cmd.none )


view : Model -> Html.Html Msg
view model =
    div []
        [ h1 [] [ text "Form Demo" ]
        , div
            [ css
                [ Css.property "display" "grid"
                , Css.property "grid-template-columns" "repeat(auto-fit,minmax(250px,1fr))"
                , Css.property "grid-gap" "10px"
                ]
            ]
            [ InputText.view Theme.Basic.theme
                [ InputText.onUpdate FirstNameUpdated
                , InputText.help "Please enter your first name here."
                , InputText.validators
                    [ StringValidator.required "First name is required."
                    , StringValidator.minLength 5 "Must be longer than 5."
                    ]
                ]
                (Label.label "First Name")
                model.firstName
            , InputText.view Theme.Basic.theme
                [ InputText.onUpdate LastNameUpdated
                , InputText.help "Please enter your last name here."
                , InputText.placeholder "Your last name (e.g.: Smith)"
                ]
                (Label.label "Last Name")
                model.lastName
            , MultiSelect.view Theme.Basic.theme
                [ MultiSelect.onUpdate MultiSelectUpdated ]
                model.multiSelect
            ]
        , div [ class "dialog" ] [ text "Are you sure you want to delete this address?", button [] [ text "Yes" ], button [] [ text "No" ] ]
        ]
        |> Html.Styled.toUnstyled


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : ( Model, Cmd Msg )
init =
    ( { firstName = InputText.initialState
      , lastName = InputText.initialState
      , multiSelect = MultiSelect.initialState
      }
    , Cmd.none
    )
