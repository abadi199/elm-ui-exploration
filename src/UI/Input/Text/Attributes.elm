module UI.Input.Text.Attributes
    exposing
        ( help
        , onUpdate
        , placeholder
        , validators
        )

import UI.Input.Text exposing (Attribute, State)
import UI.Input.Text.Internal as Internal
import UI.Validator as Validator exposing (Validator)


onUpdate : (State -> msg) -> Attribute msg
onUpdate onUpdate =
    \(Internal.Attribute config) -> Internal.Attribute { config | onUpdate = Just onUpdate }


validators : List (Validator String) -> Attribute msg
validators validatorList =
    \(Internal.Attribute config) -> Internal.Attribute { config | validators = Just validatorList }


help : String -> Attribute msg
help helpText =
    \(Internal.Attribute config) -> Internal.Attribute { config | helpText = Just helpText }


placeholder : String -> Attribute msg
placeholder placeholderText =
    \(Internal.Attribute config) -> Internal.Attribute { config | placeholderText = Just placeholderText }
