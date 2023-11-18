package
{
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="VisitorWenart")]
   public class VisitorWenart extends Visitor
   {
       
      
      public function VisitorWenart()
      {
         super();
         addFrameScript(0,frame1,1,frame2,2,frame3);
         interestList = new Array("btnGameCenter","btnGameCenter","btnGameCenter","btnGameCenter","btnToyStore","btnToyStore","btnToyStore","btnToyStore","btnCafe","Other");
         MAX_MOOD = 100;
         MIN_MOOD = 0;
         pattiene = 15;
         ACCEL_MOOD = 2;
         gender = true;
         addEventListener(Event.ADDED,Initialize);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame3() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
   }
}
