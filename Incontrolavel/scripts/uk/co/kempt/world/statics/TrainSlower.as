package uk.co.kempt.world.statics
{
   import flash.filters.DropShadowFilter;
   import uk.co.kempt.Engine;
   import uk.co.kempt.sounds.Snd;
   import uk.co.kempt.sounds.UnstoppableSounds;
   import uk.co.kempt.utils.MathUtil;
   import uk.co.kempt.world.WorldObject;
   import uk.co.kempt.world.smashables.StaticSmashable;
   
   public class TrainSlower extends StaticSmashable
   {
       
      
      private var _destroyer:WorldObject;
      
      public function TrainSlower()
      {
         super();
         var _loc1_:Number = 8;
         filters = [new DropShadowFilter(2,90,0,0.2,_loc1_,_loc1_,1)];
      }
      
      override public function get hasDebris() : Boolean
      {
         return false;
      }
      
      override public function die() : void
      {
         this._destroyer = null;
         super.die();
      }
      
      override public function destroy(param1:WorldObject) : void
      {
         this._destroyer = param1;
         super.destroy(param1);
      }
      
      override public function get cost() : int
      {
         return 0;
      }
      
      override protected function onDying() : void
      {
         var _loc3_:Number = NaN;
         super.onDying();
         Engine.instance.trainSystem.slow();
         if(this._destroyer)
         {
            _loc3_ = MathUtil.radianAngle(this._destroyer.position,this.position);
            rotation = _loc3_ / Math.PI * 180;
         }
         var _loc1_:Snd = Engine.instance.soundMan.playSound(UnstoppableSounds.WATER_BARREL,0.3);
         var _loc2_:Number = (x - Engine.GAME_WIDTH / 2) / Engine.GAME_WIDTH;
         _loc1_.pan = _loc2_;
      }
   }
}
