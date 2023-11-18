package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="fx_trash")]
   public dynamic class fx_trash extends MovieClip
   {
       
      
      public var worldX:*;
      
      public var worldY:*;
      
      public var trashLevel:*;
      
      public var ground:*;
      
      public var bundle:*;
      
      public var worker:*;
      
      public function fx_trash()
      {
         super();
         addFrameScript(0,frame1,1,frame2,2,frame3,3,frame4);
      }
      
      internal function frame3() : *
      {
         stop();
      }
      
      internal function frame1() : *
      {
         addEventListener(Event.ENTER_FRAME,UpdateTrash);
         stop();
      }
      
      internal function frame4() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
      
      public function UpdateTrash(param1:Event) : void
      {
         if(trashLevel > 80)
         {
            if(currentFrame != 4)
            {
               gotoAndPlay(4);
            }
         }
         else if(trashLevel > 40)
         {
            if(currentFrame != 3)
            {
               gotoAndPlay(3);
            }
         }
         else if(currentFrame != 2)
         {
            gotoAndPlay(2);
         }
         bundle = trashLevel >= 10;
      }
   }
}
