(function(w,d,l,undefined) {
  // ページを読み込んだ時の初期化処理
  //   現在のページ数判定
  //   最終ページ判定
  // ハッシュ値が変わった時
  //   設定値を上書き更新する
  // ->  状態管理は $mds.data のハッシュに持たせる
  w.$mds = {};
  $mds.page = function() {
    return +l.hash.slice(1);
  };
  $mds.next = function() {
    l.hash = "#" + (this.page() + 1);
  };
  $mds.prev = function() {
    l.hash = "#" + (this.page() - 1);
  };
  $mds.render = function(p, e, i) {
    p = $mds.page();
    e = document.getElementsByClassName("slide");
    i = e.length;
    while (i--) {
      e[i].style.display = (e[i].dataset.page == p ? 'block' : 'none');
    }
  };

  w.onload = $mds.render;
  w.onhashchange = $mds.render;

})(window, document, location);
