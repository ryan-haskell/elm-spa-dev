module Layout exposing (view)

import Element exposing (..)
import Element.Font as Font
import Generated.Routes as Routes exposing (Route, routes)
import Ui exposing (colors)
import Utils.Spa as Spa


view : Spa.LayoutContext msg -> Element msg
view { page, route } =
    column
        [ height fill
        , width fill
        , Font.family
            [ Font.external
                { url = "https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,600"
                , name = "Source Sans Pro"
                }
            , Font.serif
            ]
        ]
        [ viewHeader route
        , page
        , viewFooter
        ]


viewHeader : Route -> Element msg
viewHeader currentRoute =
    row
        [ spacing 16
        , paddingEach { top = 32, left = 16, right = 16, bottom = 0 }
        , centerX
        , width (fill |> maximum 720)
        ]
        [ el [ Font.semiBold ] (viewLink currentRoute ( "elm-spa", routes.top ))
        , el [ Font.size 16 ] (viewLink currentRoute ( "docs", routes.docs_top ))
        , el [ Font.size 16 ] (viewLink currentRoute ( "guide", routes.guide ))
        , el [ alignRight ]
            (Ui.button ( "get started", "/guide" ))
        ]


viewLink : Route -> ( String, Route ) -> Element msg
viewLink currentRoute ( label, route ) =
    if currentRoute == route then
        el
            [ Font.underline
            , Font.color colors.coral
            , alpha 0.5
            , Ui.transition 200 [ "opacity" ]
            ]
            (text label)

    else
        link
            [ Font.underline
            , Font.color colors.coral
            , mouseOver [ alpha 0.5 ]
            , Ui.transition 200 [ "opacity" ]
            ]
            { label = text label
            , url = Routes.toPath route
            }


viewFooter : Element msg
viewFooter =
    row
        [ width (fill |> maximum 720)
        , centerX
        , paddingXY 16 48
        , Font.size 16
        , alpha 0.5
        ]
        [ text "this site was built with elm-spa!"
        , row [ alignRight, spacing 16, Font.underline ]
            [ newTabLink []
                { url = "https://package.elm-lang.org/packages/ryannhg/elm-spa/latest"
                , label = text "the elm package"
                }
            , newTabLink []
                { url = "https://github.com/ryannhg/elm-spa"
                , label = text "the github repo"
                }
            ]
        ]
