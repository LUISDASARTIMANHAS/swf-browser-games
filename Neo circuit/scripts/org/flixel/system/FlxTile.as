package org.flixel.system
{
   import org.flixel.FlxObject;
   import org.flixel.FlxTilemap;
   
   public class FlxTile extends FlxObject
   {
       
      
      public var callback:Function;
      
      public var filter:Class;
      
      public var tilemap:FlxTilemap;
      
      public var index:uint;
      
      public var mapIndex:uint;
      
      public function FlxTile(param1:FlxTilemap, param2:uint, param3:Number, param4:Number, param5:Boolean, param6:uint)
      {
         super(0,0,param3,param4);
         immovable = true;
         moves = false;
         this.callback = null;
         this.filter = null;
         this.tilemap = param1;
         this.index = param2;
         visible = param5;
         allowCollisions = param6;
         this.mapIndex = 0;
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.callback = null;
         this.tilemap = null;
      }
   }
}
