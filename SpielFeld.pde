class SpielFeld {
  int _size;
  boolean[][] _felder;

  SpielFeld(int size) {
    _size = size;
    _felder = new boolean[_size][_size];

    setZero();
  }

  void setZero() {
    for (int i = 0; i < _size; i++) {
      for (int j = 0; j < _size; j++) {
        _felder[i][j] = false;
      }
    }
  }

  boolean getFeld(int x, int y) {
    if (outOfBounds(x, y)) {
      println("OUT OF BOUNDS : {0}/{1}", x, y);
      return true;
    }
    return _felder[x][y];
  }

  boolean getFeld(Vector v) {
    return getFeld(v.X(), v.Y());
  }

  void toggleFeld(int x, int y) {
    setFeld(x, y, !getFeld(x, y));
  }

  void toggleFeld(Vector v) {
    toggleFeld(v.X(), v.Y());
  }

  void setFeld(int x, int y, boolean value) {
    if (outOfBounds(x, y)) {
      println("OUT OF BOUNDS : {0}/{1}", x, y);
      return;
    }
    _felder[x][y] = value;
  }

  void setFeld(Vector v, boolean value) {
    setFeld(v.X(), v.Y(), value);
  }

  boolean outOfBounds(int x, int y) {
    return x < 0 || x >= _size || y < 0 || y >= _size;
  }

  boolean outOfBounds(Vector v) {
    return outOfBounds(v.X(), v.Y());
  }
}
