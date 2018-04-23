module UI.KeyCode
    exposing
        ( KeyCode(..)
        , fromInt
        , toInt
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


toInt : KeyCode -> Int
toInt keyCode =
    case keyCode of
        Enter ->
            13

        LeftArrow ->
            37

        UpArrow ->
            38

        RightArrow ->
            39

        DownArrow ->
            40

        Backspace ->
            8

        Other int ->
            int
