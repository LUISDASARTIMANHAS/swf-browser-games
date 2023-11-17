package uk.co.kempt.display.menu.pages
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import uk.co.kempt.Engine;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.menu.pages.CreateUserPage")]
   public class CreateUserPage extends AbstractPage
   {
       
      
      public var errman_mc:MovieClip;
      
      public var submitScore_btn:SimpleButton;
      
      public var user_txt:TextField;
      
      public function CreateUserPage()
      {
         super();
         this.submitScore_btn.addEventListener(MouseEvent.CLICK,this.onSubmitScoreClicked,false,0,true);
         this.errman_mc.visible = Engine.instance.highscoresSystem.errcode == 3;
      }
      
      private function onSubmitScoreClicked(param1:MouseEvent) : void
      {
         if(this.user_txt.text.length)
         {
            Engine.instance.highscoresSystem.createUser(this.user_txt.text);
         }
      }
   }
}
