package
{
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="VisitorPunk")]
   public class VisitorPunk extends Visitor
   {
       
      
      public function VisitorPunk()
      {
         super();
         addFrameScript(0,frame1,1,frame2,2,frame3);
         interestList = new Array("btnGameCenter","btnGameCenter","btnGameCenter","btnBurger","btnBurger","btnBurger","btnIceCream","btnIceCream","btnIceCream","Other");
         MAX_MOOD = 100;
         MIN_MOOD = 0;
         pattiene = 5;
         ACCEL_MOOD = 2.5;
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
