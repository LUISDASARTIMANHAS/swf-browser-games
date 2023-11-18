package
{
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="VisitorBeard")]
   public class VisitorBeard extends Visitor
   {
       
      
      public function VisitorBeard()
      {
         super();
         addFrameScript(0,frame1,1,frame2,2,frame3);
         interestList = new Array("btnBurger","btnBurger","btnBurger","btnIceCream","Other");
         MAX_MOOD = 100;
         MIN_MOOD = 26;
         pattiene = 10;
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
