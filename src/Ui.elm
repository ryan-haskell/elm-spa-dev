module Ui exposing
    ( button
    , colors
    , hero
    , markdown
    , sidebar
    , transition
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Generated.Routes as Routes exposing (Route)
import Html.Attributes as Attr
import Markdown


colors : { coral : Element.Color, white : Element.Color }
colors =
    { coral = rgb255 204 75 75
    , white = rgb255 255 255 255
    }


hero :
    { title : String
    , description : String
    , buttons : List ( String, String )
    }
    -> Element msg
hero options =
    column
        [ centerX
        , paddingXY 16 128
        , spacing 24
        ]
        (column [ spacing 12 ]
            [ el [ centerX, Font.size 64, Font.semiBold ]
                (text options.title)
            , el
                [ centerX
                , Font.size 24
                , alpha 0.5
                ]
                (text options.description)
            ]
            :: (if List.isEmpty options.buttons then
                    []

                else
                    [ row [ centerX, spacing 8 ] (List.map button options.buttons) ]
               )
        )


button : ( String, String ) -> Element msg
button ( label, url ) =
    link
        [ Background.color colors.white
        , Border.color colors.coral
        , Font.color colors.coral
        , paddingXY 24 8
        , Border.rounded 4
        , Border.width 2
        , Font.size 16
        , mouseOver
            [ Background.color colors.coral
            , Font.color colors.white
            ]
        , transition 200 [ "color", "background-color" ]
        ]
        { url = url, label = text label }


transition : Int -> List String -> Attribute msg
transition duration properties =
    Element.htmlAttribute <|
        Attr.style
            "transition"
            (properties
                |> List.map (\prop -> prop ++ " " ++ String.fromInt duration ++ "ms ease-in-out")
                |> String.join ", "
            )


markdown : String -> Element msg
markdown =
    let
        defaults =
            Markdown.defaultOptions
    in
    Markdown.toHtmlWith
        { defaults
            | sanitize = False
            , githubFlavored = Just { tables = True, breaks = False }
        }
        [ Attr.class "markdown" ]
        >> Element.html
        >> List.singleton
        >> paragraph []



-- sidebar


type alias Section =
    { header : String
    , links : List ( String, Route )
    }


sidebar :
    { header : String
    , active : Route
    , links : List ( String, Route )
    , sections : List Section
    }
    -> Element msg
sidebar options =
    column
        [ spacing 16 ]
        [ el [ Font.semiBold, Font.size 24 ] (text options.header)
        , column [ spacing 16 ]
            (List.concat
                [ List.map
                    (\link ->
                        el [ Font.color colors.coral ] (viewLink options.active link)
                    )
                    options.links
                , List.map
                    (\section ->
                        column [ spacing 16 ]
                            [ viewSectionHeader section.header
                            , viewLinks options.active section.links
                            ]
                    )
                    options.sections
                ]
            )
        ]


viewSectionHeader : String -> Element msg
viewSectionHeader label =
    el [ Font.semiBold, Font.size 20, alpha 0.5 ]
        (text label)


viewLinks : Route -> List ( String, Route ) -> Element msg
viewLinks route links =
    column
        [ spacing 12
        , Font.color colors.coral
        ]
        (List.map (viewLink route) links)


viewLink : Route -> ( String, Route ) -> Element msg
viewLink activeRoute ( label, route ) =
    link
        [ Font.underline
        , Font.size 16
        , mouseOver [ alpha 0.5 ]
        , transition 200 [ "opacity" ]
        , if activeRoute == route then
            alpha 0.5

          else
            alpha 1.0
        ]
        { url = Routes.toPath route
        , label = text label
        }
