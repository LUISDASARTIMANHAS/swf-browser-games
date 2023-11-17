package uk.co.kempt.world
{
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import org.cove.ape.AbstractParticle;
   import uk.co.kempt.Engine;
   import uk.co.kempt.data.Lookup;
   import uk.co.kempt.sounds.UnstoppableSounds;
   import uk.co.kempt.state.GameState;
   import uk.co.kempt.utils.GarbageUtil;
   
   public class Building extends WorldObject
   {
      
      private static const FRICTION:Number = 0.2;
       
      
      private var _flagTime:int;
      
      public function Building()
      {
         super();
         friction = FRICTION;
         this._flagTime = -10000;
         filters = this.defaultFilters;
      }
      
      override public function die() : void
      {
         GarbageUtil.kill(this);
      }
      
      override public function update() : void
      {
         super.update();
         if(Engine.instance.state == GameState.DRAWING)
         {
            this.checkFlagged();
         }
      }
      
      override public function get updateable() : Boolean
      {
         return true;
      }
      
      override protected function addParticle(param1:AbstractParticle) : void
      {
         param1.fixed = true;
         param1.solid = false;
         translateParticle(param1);
         Engine.instance.addParticle(param1);
         Lookup.register(param1,this);
      }
      
      override public function get destructible() : Boolean
      {
         return true;
      }
      
      override public function prepareForSimulation() : Boolean
      {
         super.prepareForSimulation();
         filters = this.defaultFilters;
         return true;
      }
      
      override protected function onDying() : void
      {
         super.onDying();
         filters = null;
         Engine.instance.particleEngine.spawnExplosion(position,size);
         if(size < 20)
         {
            Engine.instance.soundMan.playSound(UnstoppableSounds.BUILDING_1);
         }
         else if(size < 50)
         {
            Engine.instance.soundMan.playSound(UnstoppableSounds.BUILDING_2);
         }
         else if(size < 100)
         {
            Engine.instance.soundMan.playSound(UnstoppableSounds.BUILDING_3);
         }
         else
         {
            Engine.instance.soundMan.playSound(UnstoppableSounds.BUILDING_4);
         }
         Engine.instance.animateScreen.invalidateGrubble();
         removeParticles();
      }
      
      private function get defaultFilters() : Array
      {
         return [new DropShadowFilter(3,90,0,1,1,1)];
      }
      
      private function checkFlagged() : void
      {
         var _loc3_:Number = NaN;
         var _loc1_:Number = Number(Math.abs(Engine.instance.gameTime - this._flagTime));
         var _loc2_:Number = 30;
         if(_loc1_ < _loc2_)
         {
            _loc3_ = 1 - _loc1_ / _loc2_;
            filters = this.defaultFilters.concat(new GlowFilter(16776960,1 * _loc3_,6,6));
         }
         else
         {
            filters = this.defaultFilters;
         }
      }
      
      override public function flagAsInSight() : void
      {
         super.flagAsInSight();
         this._flagTime = Engine.instance.gameTime;
      }
      
      override public function flagAsDestroyed() : void
      {
         super.flagAsDestroyed();
      }
   }
}
