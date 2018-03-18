module Theme.Helpers
    exposing
        ( append
        , normalize
        , process
        )

import Css


process : a -> List (a -> a) -> a
process empty styles =
    List.foldr (\f theme -> f theme) empty styles


append : (a -> b) -> Maybe a -> List b -> List b
append f maybe list =
    maybe
        |> Maybe.map (\a -> f a :: list)
        |> Maybe.withDefault list


normalize : Css.Style
normalize =
    Css.batch
        [ Css.boxSizing Css.borderBox
        ]
