module Layouts.Docs exposing (view)

import Element exposing (..)
import Element.Font as Font
import Element.Region as Region
import Generated.Routes as Routes exposing (Route, routes)
import Html.Attributes as Attr
import Ui exposing (colors)
import Utils.Sidebar
import Utils.Spa as Spa


view : Spa.LayoutContext msg -> Element msg
view { page, route } =
    row
        [ width (fill |> maximum 720)
        , centerX
        , paddingEach
            { top = 48
            , left = 16
            , right = 16
            , bottom = 64
            }
        ]
        [ el
            [ width (px 200)
            , alignTop
            , Region.aside
            ]
            (viewSidebar route)
        , el
            [ alignTop
            , width fill
            , Element.htmlAttribute (Attr.style "max-width" "calc(100% - 200px)")
            , Region.mainContent
            ]
            page
        ]


viewSidebar : Route -> Element msg
viewSidebar route =
    Ui.sidebar
        { active = route
        , header = "docs"
        , links = Utils.Sidebar.docsLinks.overview
        , sections =
            [ { header = "elm-spa"
              , links = Utils.Sidebar.docsLinks.elmSpa
              }
            , { header = "pages"
              , links = Utils.Sidebar.docsLinks.pages
              }
            , { header = "layouts"
              , links = Utils.Sidebar.docsLinks.layouts
              }
            , { header = "other"
              , links = Utils.Sidebar.docsLinks.other
              }
            ]
        }
