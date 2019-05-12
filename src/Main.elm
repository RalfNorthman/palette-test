module Main exposing (main)

import Element exposing (..)
import Element.Font as Font
import Html exposing (Html)


googleFont : String -> Attribute msg
googleFont fontName =
    let
        fontString =
            String.replace " " "+" fontName
    in
    Font.family
        [ Font.external
            { url =
                "https://fonts.googleapis.com/css?family="
                    ++ fontString
            , name = fontName
            }
        ]


main : Html msg
main =
    layout
        [ padding 20 ]
    <|
        el
            [ centerX
            , googleFont "Playfair Display"
            , Font.size 64
            , Font.italic
            ]
        <|
            text "PUMPKINS"
