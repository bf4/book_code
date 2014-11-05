package features.step_definitions
{
    import com.flashquartermaster.cuke4as3.utilities.*;
    import org.hamcrest.*;
    import org.hamcrest.object.*;
    import flash.events.*; 
    import org.flexunit.async.Async;
    import org.fluint.uiImpersonation.UIImpersonator;
    import GameUI;
    public class Steps
    {
        private var _game:GameUI;
        [Given  (/^the game is running$/, "async")]
        public function should_the_game_is_running():void
        {
            _game = new GameUI();
            Async.proceedOnEvent( this, _game, Event.ADDED_TO_STAGE );
            UIImpersonator.addChild( _game );
        }

        [When  (/^I play$/)]
        public function should_i_play():void
        {
            _game.playButton.dispatchEvent( new MouseEvent( MouseEvent.CLICK ) );
        }
        [Then  (/^I should be the winner$/)]
        public function should_i_should_be_the_winner():void
        {
            assertThat( _game.message.text, equalTo("You win!") );
        }
    }
}
