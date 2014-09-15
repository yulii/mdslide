(function(w,d,l,undefined,self) {
  self = w.$mds = {};

  $mds.init = function() {
    self._class = 'slide'
    self._slide = d.getElementsByClassName(self._class);
    self._size  = self._slide.length;
    self._page  = +l.hash.slice(1);
    if (self._page <= 0 || isNaN(self._page)) {
      self._page = 1;
    }
  };
  $mds.page = function(p) {
    l.hash = '#' + p;
  };
  $mds.next = function() {
    if (self._page < self._size) {
      self.page(self._page + 1);
      return true;
    } else {
      return false;
    }
  };
  $mds.prev = function() {
    if (self._page > 1) {
      self.page(self._page - 1);
      return true;
    } else {
      return false;
    }
  };
  $mds.render = function(e, i, p) {
    p = self._page; i = self._size;
    e = self._slide;
    while (i--) {
      e[i].style.display = (e[i].dataset.page == p ? 'block' : 'none');
    }
  };
  $mds.refresh = function() {
    self.init();
    self.render();
  };

  w.onload       = $mds.refresh;
  w.onhashchange = $mds.refresh;

})(window, document, location);
