module UI.KeyCode
    exposing
        ( KeyCode(..)
        , fromInt
        )


type KeyCode
    = Enter
    | LeftArrow
    | UpArrow
    | RightArrow
    | DownArrow
    | Backspace
    | Other Int


fromInt : Int -> KeyCode
fromInt int =
    case int of
        13 ->
            Enter

        37 ->
            LeftArrow

        38 ->
            UpArrow

        39 ->
            RightArrow

        40 ->
            DownArrow

        8 ->
            Backspace

        _ ->
            Other int
