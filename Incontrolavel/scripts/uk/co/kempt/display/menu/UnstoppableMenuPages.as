package uk.co.kempt.display.menu
{
   import flash.display.MovieClip;
   import uk.co.kempt.Engine;
   import uk.co.kempt.sounds.Snd;
   import uk.co.kempt.sounds.UnstoppableSounds;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.menu.UnstoppableMenuPages")]
   public class UnstoppableMenuPages extends MovieClip
   {
      
      public static const GAME_OVER:String = "gameOver";
      
      public static const HIGHSCORES:String = "highscores";
      
      public static const START:String = "start";
      
      public static const LEVEL_OVER:String = "levelOver";
      
      public static const DEFAULT:String = "default";
      
      public static const GAME_COMPLETE:String = "gameComplete";
      
      public static const LEVEL_START:String = "levelStart";
      
      public static const HOW_TO_PLAY:String = "howToPlay";
      
      public static const SERVER_ERROR:String = "serverError";
      
      public static const CREATE_USER:String = "createUser";
      
      public static const BLANK:String = "blank";
      
      public static const WAIT:String = "wait";
      
      public static const LEVEL_FAILED:String = "levelFailed";
      
      public static const REGION_OVER:String = "regionOver";
       
      
      private var _menuMusic:Snd;
      
      public function UnstoppableMenuPages()
      {
         super();
         this.gotoAndStop(BLANK);
      }
      
      override public function gotoAndStop(param1:Object, param2:String = null) : void
      {
         if(this.menuMusic)
         {
            switch(param1)
            {
               case START:
               case HOW_TO_PLAY:
               case GAME_OVER:
               case REGION_OVER:
               case GAME_COMPLETE:
               case HIGHSCORES:
                  this.menuMusic.fadeTo(1,1);
                  break;
               default:
                  this.menuMusic.fadeTo(0,0.6);
            }
         }
         super.gotoAndStop(param1,param2);
      }
      
      public function get menuMusic() : Snd
      {
         return this._menuMusic = Boolean(this._menuMusic) && !this._menuMusic.dead ? this._menuMusic : Engine.instance.soundMan.loopSound(UnstoppableSounds.MUSIC_MENU,0);
      }
   }
}
