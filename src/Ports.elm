port module Ports exposing (scrollToTop)

import Json.Encode as Json


port outgoing : { action : String, data : Json.Value } -> Cmd msg


scrollToTop : Cmd msg
scrollToTop =
    outgoing
        { action = "scrollToTop"
        , data = Json.null
        }
