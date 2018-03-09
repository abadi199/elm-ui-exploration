module Theme.Helpers exposing (process)


process : a -> List (a -> a) -> a
process empty styles =
    List.foldr (\f theme -> f theme) empty styles
