class Vector {
  int _x;
  int _y;
  
  Vector(int x, int y) {
    _x = x;
    _y = y;
  }
  
  void add(int x, int y) {
    _x += x;
    _y += y;
  }
  
  void add(Vector v) {
    _x += v.X();
    _y += v.Y();
  }
  
  Vector expectedAddResult(Vector v) {
    Vector newVector = new Vector(_x, _y);
    newVector.add(v);
    return newVector;
  }
  
  void multiply(int m) {
    _x *= m;
    _y *= m;
  }
  
  Vector expectedMultiplyResult(int m) {
    Vector newVector = new Vector(_x, _y);
    newVector.multiply(m);
    return newVector;
  }
  
  int X() {
    return _x;
  }
  
  int Y() {
    return _y;
  }
}
