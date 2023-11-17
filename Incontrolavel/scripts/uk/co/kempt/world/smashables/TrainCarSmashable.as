package uk.co.kempt.world.smashables
{
   import org.cove.ape.Vector2Force;
   import uk.co.kempt.Engine;
   import uk.co.kempt.state.WorldObjectState;
   import uk.co.kempt.world.WorldObject;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.world.smashables.TrainCarSmashable")]
   public class TrainCarSmashable extends Vehicle
   {
      
      private static const LABEL_DESTRUCT_1:String = "leftSide";
      
      private static const LABEL_DESTRUCT_2:String = "rightSide";
      
      private static const LABEL_DESTRUCT_3:String = "rollLeft";
      
      private static const LABEL_DESTRUCT_4:String = "rollRight";
       
      
      public function TrainCarSmashable()
      {
         super();
         var _loc1_:Array = [1,LABEL_DESTRUCT_1,LABEL_DESTRUCT_2,LABEL_DESTRUCT_3,LABEL_DESTRUCT_4];
         var _loc2_:int = int(Math.floor(Math.random() * _loc1_.length));
         if(_loc2_ > 0)
         {
            anim.gotoAndPlay(_loc1_[_loc2_]);
         }
         else
         {
            anim.gotoAndStop(1);
         }
      }
      
      override public function update() : void
      {
         var _loc1_:Number = NaN;
         if(_burnCount > 0)
         {
            _burnCount = 10;
         }
         if(state == WorldObjectState.ALIVE)
         {
            if(Engine.instance.gameTime % 11 == 0)
            {
               _loc1_ = 5;
               particle.addForce(new Vector2Force(false,(Math.random() - 0.5) * _loc1_,(Math.random() - 0.5) * _loc1_));
               rigidParticle.angularVelocity += (Math.random() - 0.5) * 0.22;
            }
         }
         super.update();
      }
      
      override public function destroy(param1:WorldObject) : void
      {
         if(Engine.instance.trainSystem.hasExploded)
         {
            super.destroy(param1);
         }
      }
      
      override public function get cost() : int
      {
         return 0;
      }
   }
}
