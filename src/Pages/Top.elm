module Pages.Top exposing (Model, Msg, page)

import Element exposing (..)
import Element.Font as Font
import Generated.Params as Params
import Spa.Page
import Ui
import Utils.Spa exposing (Page)


type alias Model =
    ()


type alias Msg =
    Never


page : Page Params.Top Model Msg model msg appMsg
page =
    Spa.Page.static
        { title = always "elm-spa"
        , view = always view
        }



-- VIEW


view : Element Msg
view =
    column
        [ paddingXY 16 0
        , width fill
        ]
        [ Ui.hero
            { title = "elm-spa"
            , description = "single page apps made easy"
            , buttons = [ ( "learn more", "/guide" ) ]
            }
        , el [ width (fill |> maximum 480), centerX ] <|
            Ui.markdown """
### what is elm-spa?

__elm-spa__ is a framework for building web apps in [Elm](https://elm-lang.org). It's not a "framework" like React or VueJS,
it's more of a framework like NextJS, Rails, or .NET MVC.

It provides simple tooling and a convention for creating single page apps, so you can focus on the cool thing you want to build!

Also– it comes with a built-in pale dude:

<iframe width="560" height="315" src="https://www.youtube.com/embed/2HFVcPksBCY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### routing

With __elm-spa__, routes are based on a standard folder structure, so you don't need
to write a bunch of routing and url parsing code!

### page transitions

life is better when things fade smoothly! __elm-spa__ gives you page transitions
out of the box.

this site uses it, click around and check it out!

### helpful docs and friendly people

The Elm ecosystem has a big focus on the human side of building things, so on top of the friendly compiler, an _even friendlier_ community, you'll also have access to a bunch of documentation!

### want to learn more?
"""
        , column [ spacing 8, centerX, paddingXY 0 32 ]
            [ el [ centerX ] <| Ui.button ( "check out the docs", "/docs" )
            , el [ centerX, alpha 0.5 ] (text "or")
            , el [ centerX ] <| Ui.button ( "follow the guide", "/guide" )
            ]
        ]
