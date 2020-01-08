module Layouts.Guide exposing (view)

import Element exposing (..)
import Element.Region as Region
import Generated.Routes exposing (Route)
import Html.Attributes as Attr
import Ui
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
        , header = "guide"
        , links = Utils.Sidebar.guideLinks
        , sections = []
        }
