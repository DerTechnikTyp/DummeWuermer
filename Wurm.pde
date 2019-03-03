class Wurm { //<>//
  private final int minimumColor = 50;
  private final int maximumColor = 250;

  boolean _alive;
  color _color;
  boolean _turnLeft;
  Direction _direction;
  Vector _position;

  Wurm(Vector position, Direction direction, boolean turnLeft) {
    _alive = true;
    _turnLeft = turnLeft;
    _position = position;
    _direction = direction;
    _color = getRandomColor();
  }
  
  boolean isAlive() {
    return _alive;
  }

  Vector getPosition() {
    return _position;
  }

  color getColor() {
    return _color;
  }

  color getRandomColor() {
    return color(random(minimumColor, maximumColor), random(minimumColor, maximumColor), random(minimumColor, maximumColor));
  }

  void makeProgress(SpielFeld spielFeld) {
    if (_alive) {
      if (turnPossible(spielFeld)) {
        // turn
        turn();
      } else if (noPossibleWay(spielFeld) || spielFeld.outOfBounds(_position)) {
        // DIE
        _alive = false;
        println("Worm died");
        return;
      } else if (pathBlocked(spielFeld)) {
        // evade
        evade(spielFeld);
      } 
      moveForward();
    }
  }

  boolean turnPossible(SpielFeld spielFeld) {
    // two blocks to the side the worm turns has to be free
    Direction nextDirection = directionNext(_direction, _turnLeft);
    return !spielFeld.getFeld(_position.expectedAddResult(nextDirection.toVector().expectedMultiplyResult(2))) && //
      previousTurnPossible(spielFeld) && //
      directTurnPossible(spielFeld, _turnLeft);
  }

  boolean directTurnPossible(SpielFeld spielFeld, boolean turnLeft) {
    // turn on the spot possible
    Direction nextDirection = directionNext(_direction, turnLeft);
    return !spielFeld.getFeld(_position.expectedAddResult(nextDirection.toVector()));
  }

  boolean previousTurnPossible(SpielFeld spielFeld) {
    // move one block back - inaccurate because of possible Direction change
    Direction nextDirection = directionNext(_direction, _turnLeft);
    Vector lastPosition = _position.expectedAddResult(_direction.toVector().expectedMultiplyResult(-1));
    return !spielFeld.getFeld(lastPosition.expectedAddResult(nextDirection.toVector().expectedMultiplyResult(2))) && //
      !spielFeld.getFeld(lastPosition.expectedAddResult(nextDirection.toVector()));
  }

  boolean pathBlocked(SpielFeld spielFeld) {
    // moving straight not possible, both one or two blocks
    return spielFeld.getFeld(_position.expectedAddResult(_direction.toVector())) || //
      spielFeld.getFeld(_position.expectedAddResult(_direction.toVector().expectedMultiplyResult(2)));
  }

  boolean noPossibleWay(SpielFeld spielFeld) {
    // blocked from all sides
    Direction nextDirection = directionNext(_direction, _turnLeft);
    Direction oppositeDirection = directionNext(_direction, !_turnLeft);

    return spielFeld.getFeld(_position.expectedAddResult(_direction.toVector())) && //
      spielFeld.getFeld(_position.expectedAddResult(nextDirection.toVector())) && //
      spielFeld.getFeld(_position.expectedAddResult(oppositeDirection.toVector()));
  }

  void turn() {
    println("Worm turning");
    _direction = directionNext(_direction, _turnLeft);
  }

  void evade(SpielFeld spielFeld) {
    println("Worm evading");
    if (directTurnPossible(spielFeld, !_turnLeft)) { // first opposite direction "AWAY"
      _direction = directionNext(_direction, !_turnLeft);
    } else if (directTurnPossible(spielFeld, _turnLeft)) { // second normal direction "KAMIKAZE"
      _direction = directionNext(_direction, _turnLeft);
    } else { // why didn't noPossibleWay() detect?
      println("something is wrong!");
    }
  }

  void moveForward() {
    _position.add(_direction.toVector());
  }
}
