(function(w,d,l,undefined,self) {
  self = w.$mds = {};

  $mds.logger = function(e) { return; };
  $mds.debug = function(o) {
    if (o) {
      self.logger = function(e) { console.log(e); };
    } else {
      self.logger = function(e) { return; };
    }
    return true;
  };

  $mds.init = function() {
    self._class  = 'slide'
    self._slide  = d.getElementsByClassName(self._class);
    self._size   = self._slide.length;
    self._page   = +l.hash.slice(1);
    if (self._page <= 0 || isNaN(self._page)) {
      self._page = 1;
    }
    return true;
  };
  $mds.page = function(p) {
    l.hash = '#'+(p > 0 ? (p > self._size ? self._size : p) : 1);
    return true;
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
    return true;
  };
  $mds.refresh = function() {
    self.init();
    self.render();
    return true;
  };
  $mds.execute = function(cmd) {
    self.page(+cmd);
  };

  w.onload       = $mds.refresh;
  w.onhashchange = $mds.refresh;

  w.onkeyup = function(e, k, m) {
    self.logger(e.keyCode);
    k = e.keyCode;
    if (k == 13) {
      self._cmd = false;
      self.execute(self._keymap);
    }
    // Change command mode when input is `:`.
    if (k == 186) {
      self._cmd = true;
      self._keymap = '';
      return true;
    }
    if (self._cmd) {
      self._keymap += String.fromCharCode(k);
      return true;
    }
    if ([39, 40, 74, 76].indexOf(k) >= 0) {
      return self.next();
    }
    if ([37, 38, 72, 75].indexOf(k) >= 0) {
      return self.prev();
    }
    return false;
  };

})(window, document, location);
