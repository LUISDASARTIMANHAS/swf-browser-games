onClipEvent(enterFrame){
   _root.game.inner.inner2.ships.ship._x -= 8;
   if(_root.game.inner.inner2.ships.ship._x <= -1100)
   {
      _root.game.inner.inner2.ships.play();
   }
}
