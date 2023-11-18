package
{
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="VisitorCheer")]
   public class VisitorCheer extends Visitor
   {
       
      
      public function VisitorCheer()
      {
         super();
         addFrameScript(0,frame1,1,frame2,2,frame3);
         interestList = new Array("btnBoutiqueA","btnBarberShop","btnJewelry","btnCafe","Other");
         MAX_MOOD = 100;
         MIN_MOOD = 26;
         pattiene = 5;
         ACCEL_MOOD = 2.5;
         gender = false;
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
