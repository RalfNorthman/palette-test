module Main exposing (main)

import Color
import Color.Generator as ColGen
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html)
import Palette.Tango as Tango


col : Color.Color -> Color
col paletteColor =
    paletteColor
        |> Color.toRGB
        |> (\( red, green, blue ) ->
                rgb255 (round red) (round green) (round blue)
           )


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


display =
    googleFont "Pinyon Script"


montserrat =
    googleFont "Montserrat"


scale =
    modular 64 2.0
        >> round


color =
    let
        base =
            Tango.scarletRed1

        ( comp1, comp2 ) =
            ColGen.splitComplementary 150 base

        background =
            comp2 |> ColGen.shade 40 |> ColGen.tone -20

        engine =
            comp1 |> ColGen.tint 10 |> ColGen.tone -55

        design =
            base |> ColGen.tint 5 |> ColGen.tone -35
    in
    { design = col design, background = col background, engine = col engine }


designText : Element msg
designText =
    el
        [ display
        , Font.color color.design
        , Font.shadow { offset = ( 1, 1 ), blur = 2, color = rgb 0 0 0 }
        , Font.size <| scale 2
        , centerX
        , moveDown 12
        , Font.letterSpacing 0
        ]
    <|
        text "Design"


engineeringText : Element msg
engineeringText =
    el
        [ montserrat
        , Font.size <| scale 1
        , Font.hairline
        , Font.letterSpacing -1
        , centerX
        , paddingXY 8 16
        , Background.color color.engine
        , above designText
        , Border.shadow { offset = ( 2, 2 ), size = 3, blur = 5, color = rgb 0 0 0 }
        ]
    <|
        text "Engineering"


main : Html msg
main =
    layout
        [ padding 20
        , Background.color color.background
        ]
    <|
        column
            [ spacing 0
            , width fill
            , height fill
            ]
            [ designText
            , engineeringText
            ]
