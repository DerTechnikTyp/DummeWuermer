final Direction NORTH = new Direction(0, 0, -1); 
final Direction EAST = new Direction(1, 1, 0);
final Direction SOUTH = new Direction(2, 0, 1);
final Direction WEST = new Direction(3, -1, 0);
final Direction INVALID = new Direction(-1, 0, 0);

Direction directionFromIndex(int index) {
  switch(index) {
  case 0: 
    return NORTH;
  case 1: 
    return EAST;
  case 2: 
    return SOUTH;
  case 3: 
    return WEST;
  }
  return INVALID;
}

Direction directionNextFromIndex(int index, boolean turnLeft) {
  int direction = index;
  if (turnLeft) {
    direction--;
  }
  else {
    direction++;
  }
  return directionFromIndex(direction % 4);
}

Direction directionNext(Direction direction, boolean turnLeft) {
  return directionNextFromIndex(direction.getIndex(), turnLeft);
}

class Direction {
  final Vector _vector;
  final int _index;

  private Direction(int index, int x, int y) {
    _vector = new Vector(x, y);
    _index = index;
  }

  Vector toVector() {
    return _vector;
  }

  int getIndex() {
    return _index;
  }
}
