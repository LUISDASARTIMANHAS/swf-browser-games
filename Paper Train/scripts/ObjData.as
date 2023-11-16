package
{
   import com.lib.*;
   import flash.geom.*;
   
   public class ObjData
   {
       
      
      public var obj_tree_08:Object;
      
      public var obj_tree_03:Object;
      
      public var hugeObjList:*;
      
      public var obj_cactus_01:Object;
      
      public var obj_cactus_02:Object;
      
      public var obj_cactus_03:Object;
      
      public var obj_tree_07:Object;
      
      public var obj_missing:Object;
      
      public var obj_truck_01:Object;
      
      public var obj_bridge_01:Object;
      
      public var obj_mount_02:Object;
      
      public var obj_station_01:Object;
      
      public var objList:Array;
      
      public var obj_mount_01:Object;
      
      public var obj_road_01:Object;
      
      public var obj_road_02:Object;
      
      public var obj_box_01:Object;
      
      public var obj_tower_01:Object;
      
      public var obj_marker_cow:Object;
      
      public var obj_dune_01:Object;
      
      public var obj_tractor_01:Object;
      
      public var obj_overpass_01:Object;
      
      public var obj_overpass_02:Object;
      
      public var obj_straw_01:Object;
      
      public var obj_river_01:Object;
      
      public var obj_lake_01:Object;
      
      public var obj_grass_01:Object;
      
      public var obj_cow_01:Object;
      
      public var obj_lamp_01:Object;
      
      public var obj_house_2:Object;
      
      public var obj_house_3:Object;
      
      public var obj_house_4:Object;
      
      public var obj_house_5:Object;
      
      public var obj_house_6:Object;
      
      public var obj_house_7:Object;
      
      public var obj_house_8:Object;
      
      public var obj_house_9:Object;
      
      public var obj_car_01:Object;
      
      public var obj_car_02:Object;
      
      public var obj_car_03:Object;
      
      public var obj_wood_01:Object;
      
      public var obj_chimney_01:Object;
      
      public var obj_field_01:Object;
      
      private var main:*;
      
      public var obj_bench_01:Object;
      
      public var obj_watertower_01:Object;
      
      public var obj_cover_01:Object;
      
      public var obj_embankment_01:Object;
      
      public var obj_house_10:Object;
      
      public var obj_pillar_01:Object;
      
      public var obj_tunnel_01:Object;
      
      public var obj_tunnel_02:Object;
      
      public var obj_barrel_01:Object;
      
      public var obj_tunnel_03:Object;
      
      public var obj_tree_01:Object;
      
      public var obj_tree_02:Object;
      
      public var obj_tree_04:Object;
      
      public var obj_tree_05:Object;
      
      public var obj_tree_06:Object;
      
      public function ObjData(param1:*)
      {
         var _loc2_:* = undefined;
         this.obj_missing = {
            "name":"obj_missing",
            "clip":ObjMissing
         };
         this.obj_house_2 = {
            "name":"obj_house_2",
            "clip":ObjHouse02
         };
         this.obj_house_3 = {
            "name":"obj_house_3",
            "clip":ObjHouse03
         };
         this.obj_house_4 = {
            "name":"obj_house_4",
            "clip":ObjHouse04
         };
         this.obj_house_5 = {
            "name":"obj_house_5",
            "clip":ObjHouse05
         };
         this.obj_house_6 = {
            "name":"obj_house_6",
            "clip":ObjHouse06
         };
         this.obj_house_7 = {
            "name":"obj_house_7",
            "clip":ObjHouse07
         };
         this.obj_house_8 = {
            "name":"obj_house_8",
            "clip":ObjHouse08
         };
         this.obj_house_9 = {
            "name":"obj_house_9",
            "clip":ObjHouse09
         };
         this.obj_house_10 = {
            "name":"obj_house_10",
            "clip":ObjHouse10
         };
         this.obj_grass_01 = {
            "name":"obj_grass_01",
            "clip":ObjGrass01
         };
         this.obj_tunnel_01 = {
            "name":"obj_tunnel_01",
            "clip":ObjTunnel01
         };
         this.obj_tunnel_02 = {
            "name":"obj_tunnel_02",
            "clip":ObjTunnel02
         };
         this.obj_tunnel_03 = {
            "name":"obj_tunnel_03",
            "clip":ObjTunnel03
         };
         this.obj_lamp_01 = {
            "name":"obj_lamp_01",
            "clip":ObjLamp01
         };
         this.obj_tree_01 = {
            "name":"obj_tree_01",
            "clip":ObjTree01
         };
         this.obj_tree_02 = {
            "name":"obj_tree_02",
            "clip":ObjTree02
         };
         this.obj_tree_03 = {
            "name":"obj_tree_03",
            "clip":ObjTree03
         };
         this.obj_tree_04 = {
            "name":"obj_tree_04",
            "clip":ObjTree04
         };
         this.obj_tree_05 = {
            "name":"obj_tree_05",
            "clip":ObjTree05
         };
         this.obj_tree_06 = {
            "name":"obj_tree_06",
            "clip":ObjTree06
         };
         this.obj_tree_07 = {
            "name":"obj_tree_07",
            "clip":ObjTree07
         };
         this.obj_tree_08 = {
            "name":"obj_tree_08",
            "clip":ObjTree08
         };
         this.obj_station_01 = {
            "name":"obj_station_01",
            "clip":ObjStation01
         };
         this.obj_tower_01 = {
            "name":"obj_tower_01",
            "clip":ObjTower01
         };
         this.obj_watertower_01 = {
            "name":"obj_watertower_01",
            "clip":ObjWaterTower01
         };
         this.obj_car_01 = {
            "name":"obj_car_01",
            "clip":ObjCar01
         };
         this.obj_car_02 = {
            "name":"obj_car_02",
            "clip":ObjCar02
         };
         this.obj_car_03 = {
            "name":"obj_car_03",
            "clip":ObjCar03
         };
         this.obj_bridge_01 = {
            "name":"obj_bridge_01",
            "clip":ObjBridge01
         };
         this.obj_river_01 = {
            "name":"obj_river_01",
            "clip":ObjRiver01
         };
         this.obj_road_01 = {
            "name":"obj_road_01",
            "clip":ObjRoad01
         };
         this.obj_road_02 = {
            "name":"obj_road_02",
            "clip":ObjRoad02
         };
         this.obj_barrel_01 = {
            "name":"obj_barrel_01",
            "clip":ObjBarrel01
         };
         this.obj_bench_01 = {
            "name":"obj_bench_01",
            "clip":ObjBench01
         };
         this.obj_cow_01 = {
            "name":"obj_cow_01",
            "clip":ObjCow01
         };
         this.obj_box_01 = {
            "name":"obj_box_01",
            "clip":ObjBox01
         };
         this.obj_overpass_01 = {
            "name":"obj_overpass_01",
            "clip":ObjOverpass01
         };
         this.obj_overpass_02 = {
            "name":"obj_overpass_02",
            "clip":ObjOverpass02
         };
         this.obj_cover_01 = {
            "name":"obj_cover_01",
            "clip":ObjCover01
         };
         this.obj_pillar_01 = {
            "name":"obj_pillar_01",
            "clip":ObjPillar01
         };
         this.obj_embankment_01 = {
            "name":"obj_embankment_01",
            "clip":ObjEmbankment01
         };
         this.obj_mount_01 = {
            "scale":0.5,
            "name":"obj_mount_01",
            "clip":ObjMount01
         };
         this.obj_mount_02 = {
            "scale":0.5,
            "name":"obj_mount_02",
            "clip":ObjMount02
         };
         this.obj_chimney_01 = {
            "name":"obj_chimney_01",
            "clip":ObjChimney01
         };
         this.obj_field_01 = {
            "name":"obj_field_01",
            "clip":ObjField01
         };
         this.obj_lake_01 = {
            "scale":0.5,
            "name":"obj_lake_01",
            "clip":ObjLake01
         };
         this.obj_tractor_01 = {
            "name":"obj_tractor_01",
            "clip":ObjTractor01
         };
         this.obj_truck_01 = {
            "name":"obj_truck_01",
            "clip":ObjTruck01
         };
         this.obj_wood_01 = {
            "name":"obj_wood_01",
            "clip":ObjWood01
         };
         this.obj_straw_01 = {
            "name":"obj_straw_01",
            "clip":ObjStraw01
         };
         this.obj_cactus_01 = {
            "name":"obj_cactus_01",
            "clip":ObjCactus01
         };
         this.obj_cactus_02 = {
            "name":"obj_cactus_02",
            "clip":ObjCactus02
         };
         this.obj_cactus_03 = {
            "name":"obj_cactus_03",
            "clip":ObjCactus03
         };
         this.obj_dune_01 = {
            "scale":0.5,
            "name":"obj_dune_01",
            "clip":ObjDune01
         };
         this.obj_marker_cow = {
            "marker":true,
            "type":"cow",
            "name":"obj_marker_cow",
            "clip":CowMarker
         };
         this.objList = [this.obj_missing,this.obj_marker_cow,this.obj_house_2,this.obj_house_3,this.obj_house_4,this.obj_house_5,this.obj_house_6,this.obj_house_7,this.obj_house_8,this.obj_house_9,this.obj_house_10,this.obj_grass_01,this.obj_tunnel_01,this.obj_tunnel_02,this.obj_tunnel_03,this.obj_lamp_01,this.obj_tree_01,this.obj_tree_02,this.obj_tree_03,this.obj_tree_04,this.obj_tree_05,this.obj_tree_06,this.obj_tree_07,this.obj_tree_08,this.obj_station_01,this.obj_tower_01,this.obj_watertower_01,this.obj_car_01,this.obj_car_02,this.obj_car_03,this.obj_bridge_01,this.obj_river_01,this.obj_road_01,this.obj_road_02,this.obj_barrel_01,this.obj_bench_01,this.obj_cow_01,this.obj_box_01,this.obj_overpass_01,this.obj_overpass_02,this.obj_cover_01,this.obj_pillar_01,this.obj_embankment_01,this.obj_mount_01,this.obj_mount_02,this.obj_chimney_01,this.obj_field_01,this.obj_lake_01,this.obj_tractor_01,this.obj_truck_01,this.obj_wood_01,this.obj_straw_01,this.obj_cactus_01,this.obj_cactus_02,this.obj_cactus_03,this.obj_dune_01];
         this.hugeObjList = [this.obj_mount_01,this.obj_mount_02,this.obj_lake_01,this.obj_dune_01];
         super();
         this.main = param1;
         for each(_loc2_ in this.objList)
         {
            this.calcObjBound(_loc2_);
         }
      }
      
      private function calcObjBound(param1:Object) : *
      {
         var _loc2_:* = new param1.clip();
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = _loc2_.width;
         var _loc6_:* = _loc2_.height;
         param1.bound = {
            "x":_loc3_,
            "y":_loc4_,
            "width":_loc5_ - _loc3_,
            "height":_loc6_ - _loc4_
         };
         if(param1.boundscale)
         {
            _loc3_ -= 9;
            _loc4_ -= 9;
            _loc5_ += 9;
            _loc6_ += 9;
         }
         else
         {
            _loc3_ -= 2;
            _loc4_ -= 2;
            _loc5_ += 2;
            _loc6_ += 2;
         }
         param1.showBound = {
            "x":_loc3_,
            "y":_loc4_,
            "width":_loc5_ - _loc3_,
            "height":_loc6_ - _loc4_
         };
      }
   }
}
