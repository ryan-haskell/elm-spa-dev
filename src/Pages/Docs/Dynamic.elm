module Pages.Docs.Dynamic exposing (Model, Msg, page)

import Element exposing (..)
import Generated.Docs.Params as Params
import Spa.Page
import Utils.Spa exposing (Page)
import Ui
import Http

page : Page Params.Dynamic Model Msg model msg appMsg
page =
    Spa.Page.element
        { title = always "Docs.Dynamic"
        , init = always init
        , update = always update
        , subscriptions = always subscriptions
        , view = always view
        }



-- INIT


type alias Model =
    { content : String
    }


init : Params.Dynamic -> ( Model, Cmd Msg )
init { param1 } =
    ( { content = "" }
    , Http.get
        { expect = Http.expectString FetchedContent
        , url = "/content/docs/" ++ param1 ++ ".md"
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


view : Model -> Element Msg
view model =
    Ui.markdown model.content
