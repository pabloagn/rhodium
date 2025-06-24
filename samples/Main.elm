-- Main.elm
-- This is a test for Elm language server and type checking.


module Main exposing (main)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style)



-- MAIN


main : Html msg
main =
    div
        [ style "text-align" "center"
        , style "padding" "20px"
        , style "font-family" "sans-serif"
        ]
        [ text "Welcome to Rhodium" ]
