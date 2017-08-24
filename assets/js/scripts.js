// JavaScript

// If there's a `data-background-image` attribute, replace the block
// background image with the value, inside `url([path])`
(function ( $ ) {

  var setCustomBgImg = function(el) {
    el = $(el);
    var imgUrl = el.attr('data-background-image');
    imgUrl != "" && (imgUrl = "url(" + imgUrl + ")");
    el.css('background-image', imgUrl);
  };

  $("[data-background-image]").each(function(k, el) {
    setCustomBgImg(el);

    $(el).change(function() {
      setCustomBgImg(el);
    });
  });

}( jQuery ));