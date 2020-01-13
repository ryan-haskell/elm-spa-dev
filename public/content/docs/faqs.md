# faqs

## common questions from the community!

### can i access query parameters?

You bet! Query parameters are available on the [PageContext](https://package.elm-lang.org/packages/ryannhg/elm-spa/latest/Spa-Types#PageContext) optionally passed into your page functions. Just omit the `always` function to provide the `PageContext` to your functions!

#### src/Pages/Example.elm

```elm
import Html exposing (Html)
import Utils.Spa as Spa
-- ...

page : Spa.Page Params.Example Model Msg model msg appMsg
page = 
  Page.static
    { title = always "homepage"
    , view = view
    }
    
view : PageContext -> Html Msg
view { queryParameters } =
  case Dict.get "name" queryParameters of
    Just name ->
      Html.text ("Hello, " ++ name ++ "!")

    Nothing ->
      Html.text "no name parameter"
```

So if you navigate to `/example` you'll see `no name parameters`

And if you navigate to `/example?name=Ryan` you'll see `Hello, Ryan!`.


### how can i pass flags into my app?

You can update the `type alias Flags` in `src/Global.elm` to control what [flags](https://guide.elm-lang.org/interop/flags.html) your app has access to.

From there, you can update `public/index.html` to control what JSON to pass into `Elm.Main.init`.


### how do i submit an faq?

If you think a question is common enough to make it in here, you can submit it
to the `#elm-spa-users` channel in [the official Elm slack](https://elmlang.herokuapp.com/).

If your question/answer combo gets 10 👍 emojis, it's officially considered "frequently asked"
and we'd be happy to add it in!

It's a ridiculous system, and I'm very excited to see if it actually works.
