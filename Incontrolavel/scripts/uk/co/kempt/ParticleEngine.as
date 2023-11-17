package uk.co.kempt
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   import uk.co.kempt.display.particles.AngledDebris;
   import uk.co.kempt.display.particles.AngledDebris2;
   import uk.co.kempt.display.particles.AngledDebris3;
   import uk.co.kempt.display.particles.AngledFloorDamage;
   import uk.co.kempt.display.particles.BuildingDust;
   import uk.co.kempt.display.particles.Explosion;
   import uk.co.kempt.display.particles.ExplosionMed;
   import uk.co.kempt.display.particles.ExplosionSmall;
   import uk.co.kempt.display.particles.FloorDamage;
   import uk.co.kempt.display.particles.PubeBomb;
   import uk.co.kempt.display.particles.ScoreSprite;
   import uk.co.kempt.display.particles.Smoke;
   import uk.co.kempt.display.particles.VehicleDust;
   import uk.co.kempt.sounds.UnstoppableSounds;
   
   public class ParticleEngine
   {
       
      
      private var _display:DisplayObjectContainer;
      
      private var _epicExplosion:PubeBomb;
      
      public function ParticleEngine(param1:DisplayObjectContainer)
      {
         super();
         this._display = param1;
      }
      
      public function spawnAngledDebris(param1:Point, param2:Number) : void
      {
         var _loc8_:Class = null;
         var _loc9_:DisplayObject = null;
         var _loc3_:int = 8;
         var _loc4_:Number = 90;
         var _loc5_:Number = param2 - _loc4_ / 2;
         var _loc6_:Number = _loc3_ > 1 ? _loc4_ / (_loc3_ - 1) : 0;
         var _loc7_:int = 0;
         while(_loc7_ < _loc3_)
         {
            (_loc9_ = new (_loc8_ = this.randomClass([AngledDebris,AngledDebris2,AngledDebris3]))()).x = param1.x;
            _loc9_.y = param1.y;
            _loc9_.rotation = _loc5_;
            this.display.addChild(_loc9_);
            _loc5_ += _loc6_;
            _loc7_++;
         }
      }
      
      public function get display() : DisplayObjectContainer
      {
         return this._display;
      }
      
      public function spawnVehicleDust(param1:Point) : void
      {
         var _loc2_:VehicleDust = new VehicleDust();
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         var _loc3_:Number = 1;
         _loc2_.speedX = _loc3_ * (Math.random() - 0.5);
         _loc2_.speedY = _loc3_ * (Math.random() - 0.5);
         this.display.addChild(_loc2_);
      }
      
      public function spawnDust(param1:Point) : void
      {
         var _loc2_:BuildingDust = new BuildingDust();
         var _loc3_:Number = 8 * Math.random();
         var _loc4_:Number = Math.PI * 2 * Math.random();
         _loc2_.x = param1.x + Math.cos(_loc4_) * _loc3_;
         _loc2_.y = param1.y + Math.sin(_loc4_) * _loc3_;
         this.display.addChild(_loc2_);
      }
      
      public function spawnCostParticle(param1:Point, param2:int) : void
      {
         var _loc3_:ScoreSprite = null;
         if(param2 <= 0)
         {
            return;
         }
         _loc3_ = new ScoreSprite();
         _loc3_.x = param1.x;
         _loc3_.y = param1.y;
         _loc3_.value = param2;
         Engine.instance.hud.addChild(_loc3_);
      }
      
      public function spawnAngledFloorDamage(param1:Point, param2:Number) : void
      {
         var _loc6_:AngledFloorDamage = null;
         var _loc3_:Number = 20;
         var _loc4_:Number = param2 - _loc3_;
         var _loc5_:int = 0;
         while(_loc5_ < 3)
         {
            (_loc6_ = new AngledFloorDamage()).x = param1.x;
            _loc6_.y = param1.y;
            _loc6_.rotation = _loc4_;
            this.display.addChild(_loc6_);
            _loc4_ += _loc3_;
            _loc5_++;
         }
      }
      
      public function get epicExplosion() : PubeBomb
      {
         return this._epicExplosion;
      }
      
      public function spawnSmoke(param1:Point, param2:int = 1) : void
      {
         var _loc3_:Smoke = null;
         _loc3_ = new Smoke();
         var _loc4_:Number = 6;
         var _loc5_:Number = (Math.random() - 0.5) * _loc4_;
         var _loc6_:Number = (Math.random() - 0.5) * _loc4_;
         _loc3_.x = param1.x + _loc5_;
         _loc3_.y = param1.y + _loc6_;
         _loc3_.rotation = Math.random() * 360;
         this.display.addChild(_loc3_);
      }
      
      public function spawnEpicExplosion(param1:Point) : void
      {
         var _loc2_:PubeBomb = null;
         _loc2_ = new PubeBomb();
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         _loc2_.destroy(null);
         this.display.addChild(_loc2_);
         this._epicExplosion = _loc2_;
         Engine.instance.soundMan.playSound(UnstoppableSounds.NUKE);
      }
      
      public function spawnExplosion(param1:Point, param2:Number = 1) : void
      {
         var _loc4_:Explosion = null;
         var _loc3_:FloorDamage = new FloorDamage();
         if(param2 >= 60)
         {
            _loc4_ = new Explosion();
         }
         else if(param2 >= 20)
         {
            _loc4_ = new ExplosionMed();
         }
         else
         {
            _loc4_ = new ExplosionSmall();
         }
         _loc4_.x = _loc3_.x = param1.x;
         _loc4_.y = _loc3_.y = param1.y;
         this.display.addChild(_loc3_);
         this.display.addChild(_loc4_);
         var _loc5_:Number = param2 < 30 ? 1 / 4 : 1;
         Shaker.shake(Engine.instance.display,_loc5_,_loc5_,0.4,0.4,20,true);
      }
      
      private function randomClass(param1:Array) : Class
      {
         return param1[Math.floor(Math.random() * param1.length)];
      }
   }
}
