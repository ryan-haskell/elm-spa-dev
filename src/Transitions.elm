module Transitions exposing (transitions)

import Generated.Docs.Pages as Docs
import Generated.Guide.Pages as Guide
import Spa.Transition as Transition
import Utils.Spa as Spa


transitions : Spa.Transitions msg
transitions =
    { layout = Transition.fadeElmUi 300
    , page = Transition.fadeElmUi 300
    , pages =
        [ { path = Docs.path
          , transition = Transition.fadeElmUi 300
          }
        , { path = Guide.path
          , transition = Transition.fadeElmUi 300
          }
        ]
    }
