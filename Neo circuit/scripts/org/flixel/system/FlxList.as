package org.flixel.system
{
   import org.flixel.FlxObject;
   
   public class FlxList
   {
       
      
      public var object:FlxObject;
      
      public var next:FlxList;
      
      public function FlxList()
      {
         super();
         this.object = null;
         this.next = null;
      }
      
      public function destroy() : void
      {
         this.object = null;
         if(this.next != null)
         {
            this.next.destroy();
         }
         this.next = null;
      }
   }
}
