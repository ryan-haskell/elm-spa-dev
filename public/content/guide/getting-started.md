# getting started

## don't have elm yet? [i gotchu](./installation)

<iframe width="560" height="315" src="https://www.youtube.com/embed/1TNQaJGkzh8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### what's in this section?

1. installing elm-spa
1. creating a new project
1. updating the layout
1. adding in a page


### installing elm-spa

Here's how to install elm-spa:

```bash
npm install --global elm-spa@latest
```

To see if that worked, run this:

```bash
elm-spa -v
```

You should see a version number print to the console.

### making a new project

You can create a new project with the [elm-spa init](/docs/elm-spa/init) command:

```bash
elm-spa init elm-spa-dev
```

That created a folder called `elm-spa-dev`, so let's enter it with `cd`:

```bash
cd elm-spa-dev
```

Running `npm start` is all you need to get your app running!

```bash
npm start
```

### adding in a page at /docs

This is how we can add a new page at `http://localhost:1234/docs`:

```bash
elm-spa add static Docs
```

If you'd like a better understanding of that command, you should check out the [elm-spa add docs here](/docs/elm-spa-add)!