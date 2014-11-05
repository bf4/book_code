package
{
    import Game;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.text.TextField;

    public class GameUI extends Sprite
    {
        public var playButton:Sprite;
        public var message:TextField;
        private var _game:Game;
        public function GameUI()
        {
            _game = new Game();
            addPlayButton();
            addMessage();
        }

        private function handlePlayButtonClick( event:MouseEvent ):void
        {
            _game.play();
            if ( _game.isWinner() ) message.text = "You win!"
        }

        private function addPlayButton():void
        {
            var playButtonLabel:TextField = new TextField();
            playButtonLabel.text = "Play"
            playButton = new Sprite();
            playButton.graphics.beginFill( 0x00ff00 );
            playButton.graphics.drawRect( 0, 0, 100, 20 );
            playButton.graphics.endFill();
            playButton.addChild(playButtonLabel);
            playButton.addEventListener( MouseEvent.CLICK, handlePlayButtonClick );
            playButton.buttonMode = true;
            addChild( playButton )
        }

        private function addMessage():void
        {
            message = new TextField();
            message.height = 20;
            message.y = playButton.y + playButton.height + 5;
            addChild( message );
        }
    }
}
