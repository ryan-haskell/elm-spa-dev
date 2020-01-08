module Pages.Guide.Dynamic exposing (Model, Msg, page)

import Element exposing (..)
import Generated.Guide.Params as Params
import Generated.Routes as Routes
import Http
import Spa.Page
import Ui
import Utils.Sidebar
import Utils.Spa exposing (Page)


page : Page Params.Dynamic Model Msg model msg appMsg
page =
    Spa.Page.element
        { title = \{ model } -> String.replace "-" " " model.slug ++ " · guide · elm-spa"
        , init = always init
        , update = always update
        , subscriptions = always subscriptions
        , view = view
        }



-- INIT


type alias Model =
    { content : String
    , slug : String
    }


init : Params.Dynamic -> ( Model, Cmd Msg )
init { param1 } =
    ( { content = "", slug = param1 }
    , Http.get
        { expect = Http.expectString FetchedContent
        , url = "/content/guide/" ++ param1 ++ ".md"
        }
    )



-- UPDATE


type Msg
    = FetchedContent (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchedContent (Ok markdown) ->
            ( { model | content = markdown }
            , Cmd.none
            )

        FetchedContent (Err _) ->
            ( { model | content = "something is goofed" }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Utils.Spa.PageContext -> Model -> Element Msg
view context model =
    column [ width fill, alignTop, spacing 32 ]
        [ Ui.markdown model.content
        , case Utils.Sidebar.nextGuideSection context.route of
            Just nextSection ->
                nextSection
                    |> Tuple.mapBoth
                        (\label -> "next up: " ++ label)
                        (\route -> Routes.toPath route)
                    |> Ui.button

            Nothing ->
                Ui.button ( "check out the docs?", "/docs" )
        ]
