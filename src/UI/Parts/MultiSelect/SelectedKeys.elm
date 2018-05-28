module UI.Parts.MultiSelect.SelectedKeys
    exposing
        ( SelectedKeys
        , add
        , all
        , delete
        , empty
        , filter
        , focusNext
        , focusPrev
        , map
        , removeFocus
        , toList
        )


type SelectedKeys
    = SelectedKeys (List String)
    | SelectedKeysFocused (List String) String (List String)


empty : SelectedKeys
empty =
    SelectedKeys []


removeFocus : SelectedKeys -> SelectedKeys
removeFocus selectedKeys =
    case selectedKeys of
        SelectedKeys _ ->
            selectedKeys

        SelectedKeysFocused prev current next ->
            toList selectedKeys
                |> SelectedKeys


focusPrev : SelectedKeys -> SelectedKeys
focusPrev selectedKeys =
    case selectedKeys of
        SelectedKeys [] ->
            selectedKeys

        SelectedKeys (head :: tail) ->
            SelectedKeysFocused [] head tail

        SelectedKeysFocused prev current [] ->
            SelectedKeys (prev ++ [ current ])

        SelectedKeysFocused prev current (head :: tail) ->
            SelectedKeysFocused (prev ++ [ current ]) head tail


focusNext : SelectedKeys -> SelectedKeys
focusNext selectedKeys =
    case selectedKeys of
        SelectedKeys [] ->
            selectedKeys

        SelectedKeys (head :: tail) ->
            SelectedKeysFocused
                (listDropLast head tail)
                (listTakeLast head tail)
                []

        SelectedKeysFocused [] current next ->
            SelectedKeys (current :: next)

        SelectedKeysFocused (head :: tail) current next ->
            SelectedKeysFocused
                (listDropLast head tail)
                (listTakeLast head tail)
                (current :: next)


listDropLast : a -> List a -> List a
listDropLast head tail =
    if List.length tail == 0 then
        []

    else
        head :: (tail |> List.reverse |> List.drop 1 |> List.reverse)


listTakeLast : a -> List a -> a
listTakeLast head tail =
    tail
        |> List.reverse
        |> List.head
        |> Maybe.withDefault head


toList : SelectedKeys -> List String
toList selectedKeys =
    case selectedKeys of
        SelectedKeys list ->
            list

        SelectedKeysFocused prev current next ->
            prev ++ (current :: next) |> List.reverse


all : (String -> Bool) -> SelectedKeys -> Bool
all f selectedKeys =
    selectedKeys
        |> toList
        |> List.all f


add : String -> SelectedKeys -> SelectedKeys
add key selectedKeys =
    case selectedKeys of
        SelectedKeys list ->
            SelectedKeys (key :: list)

        SelectedKeysFocused prev current next ->
            SelectedKeysFocused (key :: prev) current next


delete : SelectedKeys -> SelectedKeys
delete selectedKeys =
    case selectedKeys of
        SelectedKeys list ->
            SelectedKeys (List.tail list |> Maybe.withDefault [])

        SelectedKeysFocused prev current next ->
            SelectedKeys (prev ++ next)


filter : (String -> Bool) -> SelectedKeys -> SelectedKeys
filter f selectedKeys =
    case selectedKeys of
        SelectedKeys list ->
            SelectedKeys (List.filter f list)

        SelectedKeysFocused prev current next ->
            if f current then
                SelectedKeys (prev ++ next)

            else
                SelectedKeysFocused (List.filter f prev) current (List.filter f next)


map : (String -> a) -> (String -> a) -> SelectedKeys -> List a
map focusF f selectedKeys =
    case selectedKeys of
        SelectedKeys list ->
            List.map f list

        SelectedKeysFocused prev current next ->
            List.map f prev ++ (focusF current :: List.map f next)
