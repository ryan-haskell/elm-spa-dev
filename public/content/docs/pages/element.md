# Page.element

## pages with state and side-effects.

<iframe width="560" height="315" src="https://www.youtube.com/embed/dMu-5eTp1Bg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


### pages with state and side-effects.

Okay so I lied about `/docs/pages/static` using [Page.static](./static). We actually
need to make an HTTP request on `init` to fetch content from [this markdown file](/content/docs/pages/element.md) that you're reading.

So for that reason, we're going to upgrade to a `Page.element`– which is able to
send `Cmd Msg` and do cool things like making web requests.

Let's use `elm-spa add` to create an element page like this:

```bash
elm-spa add element Docs.Dynamic.Dynamic
```

Since we are using `Dynamic`, this route will match paths like these:

- `/docs/pages/static`
- `/docs/pages/element`
- `/docs/elm-spa/add`

For that first example, our `init` function receives `Params` that look like this:

```elm
{ param1 = "pages"
, param2 = "static"
}
```

(You can read more about this in the [pages overview](/docs/pages))