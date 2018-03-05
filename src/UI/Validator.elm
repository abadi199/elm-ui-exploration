module UI.Validator
    exposing
        ( ValidationResult
        , Validator
        , isInvalid
        , validate
        , view
        )

import Html exposing (..)
import Html.Attributes exposing (..)
import Result
import UI.Validator.Internal as Internal


type alias Validator value =
    value -> ValidationResult value


type alias ValidationResult value =
    Internal.ValidationResult value


isError : Internal.ValidationResult value -> Bool
isError validationResult =
    case validationResult of
        Internal.ValidationError _ ->
            True

        Internal.ValidationOk _ ->
            False


getErrorMessage : Internal.ValidationResult value -> Maybe String
getErrorMessage validationResult =
    case validationResult of
        Internal.ValidationError errorMessage ->
            Just errorMessage

        Internal.ValidationOk _ ->
            Nothing


validate : value -> List (Validator value) -> Result (List String) value
validate value validators =
    let
        errors =
            validators
                |> List.map (\f -> f value)
                |> List.filterMap getErrorMessage
    in
    if List.isEmpty errors then
        Result.Ok value
    else
        Result.Err errors


isInvalid : value -> List (Validator value) -> Bool
isInvalid value validators =
    case validate value validators of
        Result.Err _ ->
            True

        Result.Ok _ ->
            False


view : List (Validator value) -> value -> Html msg
view validators value =
    case validate value validators of
        Result.Err errors ->
            div [ attribute "aria-role" "alert" ] [ ul [] (errors |> List.map errorView) ]

        Result.Ok _ ->
            Html.text ""


errorView : String -> Html msg
errorView errorMessage =
    li [] [ text errorMessage ]
