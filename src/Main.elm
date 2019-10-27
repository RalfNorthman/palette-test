module Main exposing (main)

import Color
import Color.Generator as ColGen
import Debug
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


knockoutRegular =
    Font.family
        [ Font.typeface "Knockout 49 A"
        , Font.sansSerif
        ]


tungstenRounded =
    Font.family
        [ Font.typeface "Tungsten Rounded A"
        , Font.sansSerif
        ]


inkwellSerif =
    Font.family
        [ Font.typeface "Inkwell Serif A"
        , Font.serif
        ]


hoeflerTitling =
    Font.family
        [ Font.typeface "Hoefler Titling A"
        , Font.serif
        ]


hoeflerText =
    Font.family
        [ Font.typeface "Hoefler Text A"
        , Font.serif
        ]


inkwellSans =
    Font.family
        [ Font.typeface "Inkwell Sans A"
        , Font.sansSerif
        ]


smashingFont =
    knockoutRegular


pumpkinsFont =
    tungstenRounded


displayFont =
    inkwellSerif


versesFont =
    inkwellSans


scaleInt =
    scaleFloat
        >> round


scaleFloat =
    modular 20 1.618


color =
    let
        base =
            Tango.scarletRed1

        ( comp1, comp2 ) =
            ColGen.splitComplementary 150 base

        background =
            comp2 |> ColGen.shade 40 |> ColGen.tone -20

        engine =
            comp1 |> ColGen.shade 5 |> ColGen.tone -65

        pumpor =
            engine |> ColGen.tint 15 |> ColGen.tone -10 |> ColGen.shade 22

        body =
            engine |> ColGen.tint 22 |> ColGen.tone -7

        design =
            base |> ColGen.tint 10 |> ColGen.tone -15

        shadow =
            background |> ColGen.shade 1

        border =
            design |> ColGen.shade 30 |> ColGen.tone -10

        title =
            design |> ColGen.shade 5 |> ColGen.tone -5
    in
    { design = col design
    , background = col background
    , pumpor = col pumpor
    , shadow = col shadow
    , body = col body
    , border = col border
    , title = col title
    }


overTitle : Element msg
overTitle =
    el
        [ Font.color color.design
        , Font.size <| scaleInt 4
        , Font.regular
        , Font.letterSpacing 2
        , centerX
        , smashingFont
        , Font.shadow { offset = ( 2, 2 ), blur = 3, color = color.background }
        ]
    <|
        text "Smashing"


adjust =
    2


adjustFloat =
    scaleFloat adjust


adjustInt =
    scaleInt adjust


underTitle : Element msg
underTitle =
    el
        [ Font.size <| scaleInt 4
        , Font.color color.shadow
        , Font.bold
        , pumpkinsFont
        , centerX
        , paddingXY (scaleInt 1) (scaleInt -1)
        , Background.color color.pumpor
        , Border.rounded <| scaleInt -2
        , above <| el [ moveDown adjustFloat, centerX ] overTitle
        ]
    <|
        text "PUMPKINs"


lyricsTitle : Color -> String -> Element msg
lyricsTitle clr txt =
    el
        [ Font.size <| scaleInt 3
        , Font.color clr
        , centerX
        , width shrink
        , displayFont
        , Font.extraBold
        ]
    <|
        text txt


lyricsBody : String -> Element msg
lyricsBody inTxt =
    let
        myParagraph txt =
            let
                lines =
                    String.lines txt
            in
            column
                [ versesFont
                , width shrink
                , Font.italic
                , Font.regular
                , Font.size <| scaleInt 1
                , Font.color color.background
                , Font.center
                , centerX
                , spacing <| scaleInt -4
                ]
            <|
                List.map text lines

        toParList =
            inTxt
                |> String.split "\n\n"
    in
    column
        [ spacing <| scaleInt 1
        , padding <| scaleInt -2
        , width fill
        ]
    <|
        List.map myParagraph toParList


lyricsBoxAttributes =
    [ spaceEvenly
    , padding <| scaleInt 1
    , Background.color color.body
    , Border.color color.border
    , width shrink
    , Border.width 6
    , centerX
    ]


rubyTitle =
    column [ spacing <| -(scaleInt -1) ]
        [ lyricsTitle color.border "Genom Ögon"
        , row [ Font.alignLeft ]
            [ lyricsTitle (rgba 0 0 0 0) "Genom "
            , el
                [ moveLeft <| scaleFloat 1 ]
              <|
                lyricsTitle color.border "av Rubin"
            ]
        ]


lyrics : Element msg
lyrics =
    el
        [ width fill
        , padding <| scaleInt 1
        ]
    <|
        row
            lyricsBoxAttributes
        <|
            [ el [ width <| px <| scaleInt 2 ] none
            , column
                [ alignTop
                , spacing -(scaleInt 1)
                ]
                [ el [ moveRight <| scaleFloat 3 ]
                    rubyTitle
                , lyricsBody rubyTxt
                ]
            , el [] none
            , column
                [ alignTop ]
                [ el [ moveRight <| scaleFloat 3 ] <|
                    lyricsTitle color.border "Blöder Orkidéen"
                , lyricsBody orchidTxt
                ]
            ]


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
            , spacing <| scaleInt 2
            , centerX
            ]
            [ column
                [ centerX
                , spacing -adjustInt
                ]
                [ overTitle
                , underTitle
                ]
            , lyrics
            ]


rubyTxt : String
rubyTxt =
    """
Snärj mig med alltid
Och dra in mig med kansken
Din oskyldighet är en skatt, din oskyldighet är döden
Din oskyldighet är allt jag har
Andas under vatten
Och leva under glas

Om du spinner din kärlek kring
Dina drömmars hemligheter
Kan du finna din kärlek borta
Och inte riktigt som den verkade
Framträda för att försvinna
Under dina mörkaste rädslor

Jag tror på aldrig
Jag tror på hela vägen
Men tro är att inte märka, tro är bara någon religion
Och religion kan inte hjälpa dig fly
Och med denna ring gifter vi oss sant
Och med denna ring gifter vi oss nu
Och med denna ring spelar jag så död
Men ingen ber om sanningen, så låt mig berätta

Om du spinner din kärlek kring
Dina drömmars hemligheter
Kan du finna din kärlek borta
Och inte riktigt som den verkade
Framträda för att försvinna
Under dina mörkaste rädslor

Till uppenbarelser av rosenkindad ungdom
Kommer ingen för att rädda dig
Så säg din frid i draget sorl
Men ungdom är slösat på de unga

Din styrka är min svaghet, din svaghet mitt hat
Min kärlek för dig kan bara inte förklara
Varför vi är evigt frysta, evigt vackra
Evigt förlorade inuti oss själva
Natten har kommit för att hålla oss unga

Natten har kommit för att hålla oss unga
Natten har kommit för att hålla oss unga
Natten har kommit för att hålla oss unga
Natten har kommit för att hålla oss unga
Natten har kommit för att hålla oss unga
"""


orchidTxt : String
orchidTxt =
    """
Om livet är mitt vittne
Kärlek min sång
Om inget betyder ingen
Då tom, hör jag till
Om rädsla besegras lätt
Kan jag locka
Mjölk från blomman
Blod från gryningen

Så här är vi
På din scen
Skratten vi delade
Drömmarna vi spart

Blöder orkidéen
Vi blöder orkidéen
Blöder orkidéen

Välsignad min svaghet
Välsignade mina oförätter
Som hat bildar sviten
Av en efter en
Såsom friheter dör lätt
Röstar vi viljan
Det är moln i min dusch
Spöken i mina armar

Ungdom är var du är
Tro någon syndares barn

Vi blöder orkidéen
Vi blöder orkidéen
Blöder orkidéen

Förgylld äro denna tysta marsch förbi seger genom larm
Så följaktligen hänförd
Står den här viljan för mycket?
Men hjärtat är orört av hjärtats oälskade

Blöder orkidéen
Blöder orkidéen
Här är vi
På din scen
Kärleken vi delar
Drömmarna vi kommer spara

De blöder orkidéen
De blöder orkidéen
De blöder orkidéen
Blöder orkidéen
"""
