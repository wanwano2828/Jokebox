// Javascriptの記述
//■back-to-top ボタン
$(function(){

  //#back-to-topがクリックされたら上に戻る
  // animateメソッドを使用
  $('#back-to-top a').click(function() {
      $('html, body').animate({
          scrollTop:0
      }, 800);
      return false;
  });

});