module UI.Input.Text.Configs
    exposing
        ( help
        , label
        , onUpdate
        , validators
        )

import UI.Input.Text exposing (Config, State)
import UI.Input.Text.Internal as Internal
import UI.Validator as Validator exposing (Validator)


onUpdate : (State -> msg) -> Config msg
onUpdate onUpdate =
    \(Internal.Config config) -> Internal.Config { config | onUpdate = Just onUpdate }


label : String -> Config msg
label labelText =
    \(Internal.Config config) -> Internal.Config { config | labelText = Just labelText }


validators : List (Validator String) -> Config msg
validators validatorList =
    \(Internal.Config config) -> Internal.Config { config | validators = Just validatorList }


help : String -> Config msg
help helpText =
    \(Internal.Config config) -> Internal.Config { config | helpText = Just helpText }
