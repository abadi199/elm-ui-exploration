module UI.Attribute exposing (process)


process : attribute -> List (attribute -> attribute) -> attribute
process empty attributes =
    attributes
        |> List.foldl (\f attribute -> f attribute) empty
