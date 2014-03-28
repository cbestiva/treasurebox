$(".free-wall .size320").each(function() {  
    var bricks = $(this).find(".brick");  
    !bricks.length && (bricks = $(this));  
});  


$(function() {
  $(".free-wall").each(function() {
    var wall = new freewall(this);
    wall.reset({
      selector: '.size270',
      cellW: function(container) {
        var cellWidth = 270;
        if (container.hasClass('size270')) {
          cellWidth = container.width()/2;
        }
        return cellWidth;
      },
      cellH: function(container) {
        var cellHeight = 270;
        if (container.hasClass('size270')) {
          cellHeight = container.height()/2;
        }
        return cellHeight;
      },
      fixSize: 0,
      gutterY: 20,
      gutterX: 20,
      onResize: function() {
        wall.fitWidth();
      }
    });
    wall.fitWidth();
  });
  $(window).trigger("resize");
});