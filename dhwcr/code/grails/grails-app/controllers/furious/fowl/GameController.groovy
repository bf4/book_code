/***
 * Excerpted from "Cucumber Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
***/
package furious.fowl
class GameController {
    def index() {
        if (params.buildings) {
            session.buildings = params.buildings as int
        }
        if (session.buildings <= 0) {
            session.buildings = 3
        }
        render "You see ${session.buildings} building(s)."
    }

    def slingshot() {
        session.buildings--
        def result = session.buildings > 0 ? 'index' : 'victory'
        redirect(action: result)
    }
    def victory() {
        render "You win!"
    }

}
