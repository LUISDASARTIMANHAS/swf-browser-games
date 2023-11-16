package
{
   import container.cHashMap;
   import org.flixel.*;
   
   public class cSaveGame
   {
      
      private static var m_save:FlxSave = new FlxSave();
      
      private static var m_singleton:cSaveGame = new cSaveGame();
      
      private static var m_levelTemp:cHashMap = new cHashMap();
      
      private static var m_playerTemp:Object;
      
      private static var m_achivementsTemp:Object;
      
      private static var m_achivementDataTemp:Object;
      
      private static var m_loaded:Boolean = false;
       
      
      public function cSaveGame()
      {
         super();
      }
      
      public static function getInstance() : cSaveGame
      {
         if(m_singleton == null)
         {
            m_singleton = new cSaveGame();
         }
         return m_singleton;
      }
      
      public function close() : void
      {
         m_save.close();
      }
      
      public function saveGameAvailable() : Boolean
      {
         if(!m_loaded)
         {
            m_loaded = m_save.bind("saveData");
         }
         if(m_loaded)
         {
            return m_save.data[0] != null;
         }
         return false;
      }
      
      public function loadLevelData(param1:String) : Object
      {
         var _loc2_:Object = null;
         if(!m_loaded)
         {
            m_loaded = m_save.bind("saveData");
         }
         if(m_loaded)
         {
            if(m_save.data[param1] == null)
            {
               m_save.data[param1] = this.CreateSaveLevelObject();
            }
            return m_save.data[param1];
         }
         _loc2_ = this.CreateSaveLevelObject();
         m_levelTemp.insert(param1,_loc2_);
         return _loc2_;
      }
      
      public function loadPlayerData() : Object
      {
         if(!m_loaded)
         {
            m_loaded = m_save.bind("saveData");
         }
         if(m_loaded)
         {
            if(m_save.data["player"] == null)
            {
               m_save.data["player"] = this.CreateSavePlayerObject();
            }
            return m_save.data["player"];
         }
         m_playerTemp = this.CreateSavePlayerObject();
         return m_playerTemp;
      }
      
      public function loadAchievementData() : Object
      {
         if(!m_loaded)
         {
            m_loaded = m_save.bind("saveData");
         }
         if(m_loaded)
         {
            if(m_save.data["achievementData"] == null)
            {
               m_save.data["achievementData"] = this.CreateAchievementDataObject();
            }
            return m_save.data["achievementData"];
         }
         m_achivementDataTemp = this.CreateAchievementDataObject();
         return m_achivementDataTemp;
      }
      
      public function loadAchievements() : Object
      {
         if(!m_loaded)
         {
            m_loaded = m_save.bind("saveData");
         }
         if(m_loaded)
         {
            if(m_save.data["achievements"] == null)
            {
               m_save.data["achievements"] = this.CreateAchievementsObject();
            }
            return m_save.data["achievements"];
         }
         m_achivementsTemp = this.CreateAchievementsObject();
         return m_achivementsTemp;
      }
      
      private function CreateAchievementDataObject() : Object
      {
         return {
            "numUpgrades":0,
            "cutConnections":0,
            "createdConnections":0,
            "plays":0,
            "powersProduced":0
         };
      }
      
      private function CreateAchievementsObject() : Object
      {
         var _loc1_:Object = new Object();
         var _loc2_:int = 0;
         while(_loc2_ < cAchievementData.NUM_ACHIEVEMENTS)
         {
            _loc1_[_loc2_.toString()] = false;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getLevelData(param1:String) : Object
      {
         if(!m_loaded)
         {
            m_loaded = m_save.bind("saveData");
         }
         if(m_loaded)
         {
            return m_save.data[param1];
         }
         return m_levelTemp.find(param1);
      }
      
      public function getPlayerData() : Object
      {
         if(!m_loaded)
         {
            m_loaded = m_save.bind("saveData");
         }
         if(m_loaded)
         {
            return m_save.data["player"];
         }
         return m_playerTemp;
      }
      
      public function eraseData() : Boolean
      {
         var _loc1_:Boolean = false;
         if(!m_loaded)
         {
            m_loaded = m_save.bind("saveData");
         }
         if(m_loaded)
         {
            m_levelTemp.clear();
            m_loaded = false;
            m_playerTemp = null;
            _loc1_ = m_save.erase();
            m_save.destroy();
            return _loc1_;
         }
         return false;
      }
      
      public function saveData() : Boolean
      {
         if(m_loaded)
         {
            return m_save.flush();
         }
         return false;
      }
      
      private function CreateSaveLevelObject() : Object
      {
         return {
            "bestTimeEasy":0,
            "bestTimeHard":0,
            "done":false
         };
      }
      
      private function CreateSavePlayerObject() : Object
      {
         return {
            "levelsDone":0,
            "difficulty":0
         };
      }
   }
}
