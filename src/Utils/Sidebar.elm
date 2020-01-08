module Utils.Sidebar exposing
    ( docsLinks
    , guideLinks
    , nextDocsSection
    , nextGuideSection
    , prettify
    )

import Generated.Routes as Routes exposing (Route, routes)


type alias Link =
    ( String, Route )


guideLinks : List Link
guideLinks =
    [ ( "installation", routes.guide_dynamic "installation" )
    , ( "getting started", routes.guide_dynamic "getting-started" )
    , ( "components", routes.guide_dynamic "components" )
    , ( "layouts", routes.guide_dynamic "layouts" )
    , ( "markdown", routes.guide_dynamic "markdown" )
    , ( "wrapping up", routes.guide_dynamic "wrapping-up" )
    , ( "deploying", routes.guide_dynamic "deploying" )
    ]


docsLinks :
    { overview : List Link
    , elmSpa : List Link
    , pages : List Link
    , layouts : List Link
    , other : List Link
    }
docsLinks =
    { overview =
        [ ( "overview", routes.docs_top )
        ]
    , elmSpa =
        [ ( "overview", routes.docs_dynamic "elm-spa" )
        , ( "elm-spa init", routes.docs_dynamic_dynamic "elm-spa" "init" )
        , ( "elm-spa add", routes.docs_dynamic_dynamic "elm-spa" "add" )
        , ( "elm-spa build", routes.docs_dynamic_dynamic "elm-spa" "build" )
        ]
    , pages =
        [ ( "overview", routes.docs_dynamic "pages" )
        , ( "static", routes.docs_dynamic_dynamic "pages" "static" )
        , ( "sandbox", routes.docs_dynamic_dynamic "pages" "sandbox" )
        , ( "element", routes.docs_dynamic_dynamic "pages" "element" )
        , ( "component", routes.docs_dynamic_dynamic "pages" "component" )
        ]
    , layouts =
        [ ( "overview", routes.docs_dynamic "layouts" )
        , ( "transitions", routes.docs_dynamic_dynamic "layouts" "transitions" )
        ]
    , other =
        [ ( "components", routes.docs_dynamic "components" )
        , ( "deploying", routes.docs_dynamic "deploying" )
        , ( "faqs", routes.docs_dynamic "faqs" )
        ]
    }


nextGuideSection : Route -> Maybe Link
nextGuideSection =
    nextSection guideLinks


nextDocsSection : Route -> Maybe Link
nextDocsSection =
    nextSection
        (List.concat
            [ docsLinks.overview
            , docsLinks.elmSpa
            , docsLinks.pages
            , docsLinks.layouts
            , docsLinks.other
            ]
        )


{-| Get the next route for the guide.
-}
nextSection : List Link -> Route -> Maybe Link
nextSection links current =
    List.indexedMap Tuple.pair links
        |> List.filter (Tuple.second >> Tuple.second >> (==) current)
        |> List.map Tuple.first
        |> List.head
        |> Maybe.map (\index -> List.drop (index + 1) links)
        |> Maybe.andThen List.head


prettify : Route -> String
prettify =
    Routes.toPath
        >> String.replace "-" " "
        >> String.split "/"
        >> (\list -> List.drop (List.length list - 1) list)
        >> List.head
        >> Maybe.withDefault ""
