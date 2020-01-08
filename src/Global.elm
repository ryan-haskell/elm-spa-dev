module Global exposing
    ( Flags
    , Model
    , Msg(..)
    , init
    , subscriptions
    , update
    )

import Generated.Routes as Routes exposing (Route)
import Ports


type alias Flags =
    ()


type alias Model =
    {}


type Msg
    = ScrollToTop


type alias Commands msg =
    { navigate : Route -> Cmd msg
    }


init : Commands msg -> Flags -> ( Model, Cmd Msg, Cmd msg )
init _ _ =
    ( {}
    , Cmd.none
    , Cmd.none
    )


update : Commands msg -> Msg -> Model -> ( Model, Cmd Msg, Cmd msg )
update _ msg model =
    case msg of
        ScrollToTop ->
            ( model
            , Cmd.none
            , Ports.scrollToTop
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
