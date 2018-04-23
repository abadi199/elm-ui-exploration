module MultiSelect exposing (..)

import Dict
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import UI.Parts.MultiSelect.Internal as Internal


nextFocus : Test
nextFocus =
    describe "nextFocus tests"
        [ test "Next element of empty options should return Nothing" <|
            \_ ->
                Internal.nextFocus (Internal.Options (Dict.fromList [])) Internal.initialState
                    |> Internal.focusedKey
                    |> Expect.equal Internal.NoKeyFocused
        , test "Next element when no key is currently in focus should focus the first element" <|
            \_ ->
                Internal.nextFocus
                    (Internal.Options
                        (Dict.fromList
                            [ ( "1", "One" )
                            , ( "2", "Two" )
                            , ( "3", "Three" )
                            ]
                        )
                    )
                    Internal.initialState
                    |> Internal.focusedKey
                    |> Expect.equal (Internal.KeyFocused "1")
        , test "Next element for last key of some options should not change the focusedKey" <|
            \_ ->
                Internal.initialState
                    |> (\(Internal.State state) -> Internal.State { state | focusedKey = Internal.KeyFocused "3" })
                    |> Internal.nextFocus
                        (Internal.Options
                            (Dict.fromList
                                [ ( "1", "One" )
                                , ( "2", "Two" )
                                , ( "3", "Three" )
                                ]
                            )
                        )
                    |> Internal.focusedKey
                    |> Expect.equal (Internal.KeyFocused "3")
        , test "Next element for KeyFocused 3 should change to KeyFocused 4" <|
            \_ ->
                Internal.initialState
                    |> (\(Internal.State state) -> Internal.State { state | focusedKey = Internal.KeyFocused "3" })
                    |> Internal.nextFocus
                        (Internal.Options
                            (Dict.fromList
                                [ ( "1", "One" )
                                , ( "2", "Two" )
                                , ( "3", "Three" )
                                , ( "4", "Four" )
                                ]
                            )
                        )
                    |> Internal.focusedKey
                    |> Expect.equal (Internal.KeyFocused "4")
        ]


prevFocus : Test
prevFocus =
    describe "prevFocus tests"
        [ test "Prev element of empty options should return Nothing" <|
            \_ ->
                Internal.prevFocus (Internal.Options (Dict.fromList [])) Internal.initialState
                    |> Internal.focusedKey
                    |> Expect.equal Internal.NoKeyFocused
        , test "Prev element when no key is currently in focus should focus the last element" <|
            \_ ->
                Internal.prevFocus
                    (Internal.Options
                        (Dict.fromList
                            [ ( "1", "One" )
                            , ( "2", "Two" )
                            , ( "3", "Three" )
                            ]
                        )
                    )
                    Internal.initialState
                    |> Internal.focusedKey
                    |> Expect.equal (Internal.KeyFocused "3")
        , test "Prev element for first key of some options should not change the focusedKey" <|
            \_ ->
                Internal.initialState
                    |> (\(Internal.State state) -> Internal.State { state | focusedKey = Internal.KeyFocused "1" })
                    |> Internal.prevFocus
                        (Internal.Options
                            (Dict.fromList
                                [ ( "1", "One" )
                                , ( "2", "Two" )
                                , ( "3", "Three" )
                                ]
                            )
                        )
                    |> Internal.focusedKey
                    |> Expect.equal (Internal.KeyFocused "1")
        , test "Prev element for KeyFocused 4 should change to KeyFocused 3" <|
            \_ ->
                Internal.initialState
                    |> (\(Internal.State state) -> Internal.State { state | focusedKey = Internal.KeyFocused "4" })
                    |> Internal.prevFocus
                        (Internal.Options
                            (Dict.fromList
                                [ ( "1", "One" )
                                , ( "2", "Two" )
                                , ( "3", "Three" )
                                , ( "4", "Four" )
                                ]
                            )
                        )
                    |> Internal.focusedKey
                    |> Expect.equal (Internal.KeyFocused "3")
        ]
