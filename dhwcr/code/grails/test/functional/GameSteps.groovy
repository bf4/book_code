/***
 * Excerpted from "Cucumber Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
***/
import cucumber.runtime.PendingException

this.metaClass.mixin (cucumber.runtime.groovy.EN)

/*
Given(~'^I see (\\d+) buildings\$') { int arg1 ->
    // ...
}

When(~'^I slingshot a bird\$') { ->
    // ...
}

Then(~'^I should see (\\d+) buildings\$') { int arg1 ->
    // ...
}
*/

import furious.fowl.GameController

GameController gameController

Given(~'^I see (\\d+) buildings\$') { int buildings ->
    gameController = new GameController ()
    gameController.params.buildings = buildings
    gameController.index ()
}

When(~'^I slingshot a bird\$') { ->
    gameController.slingshot ()
}

Then(~'^I should see (\\d+) buildings\$') { int buildings ->
    gameController.params.buildings = null
    gameController.response.reset ()

    gameController.index ()

    expected = "You see ${buildings} building(s)."
    assert gameController.response.text.contains(expected)
}
