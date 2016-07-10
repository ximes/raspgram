function setSwitchery(switchElement, checkedBool) {
    if((checkedBool && !switchElement.isChecked()) || (!checkedBool && switchElement.isChecked())) {
        switchElement.setPosition(true);
        switchElement.handleOnchange(true);
    }
}
  $(document).on('ready page:change', function() {  


  $('.simple_form.light .js-switch').change(function(){
    $(this).closest('form').submit();
  });

  $(".range").ionRangeSlider({
    type: 'single',
    force_edges: true,
    hide_min_max: true,
    hide_from_to: true,
    grid: true,
    onStart: function (data) {
        var $this = $(this),
        value = $this.prop("value");
        disable = true;
    },
    onFinish: function (data) {
      data.input.closest('.simple_form.light').submit();
    },
  }).on("change", function () {
    //var $this = $(this), from = $this.data("from"),to = $this.data("to");

    //console.log(from + " - " + to);

    //$(".range_colors").attr('fgColor', tinycolor("hsl(" + data.from + ", 100, 50)").toHex());
      //console.log(  $(this).closest('.simple_form.light').css("border", "1px solid red"))
});;

  $(".range.range_hue").change(function(){
      $(".hue-well").css('background-color', 'red');
      console.log();
  });;

  // Example of infinite knob, iPod click wheel
  var v, up = 0,
  down = 0,
  i = 0,
  $idir = $("div.idir"),
  $ival = $("div.ival"),
  incr = function() {
    i++;
    $idir.show().html("+").fadeOut();
    $ival.html(i);
  },
  decr = function() {
    i--;
    $idir.show().html("-").fadeOut();
    $ival.html(i);
  };
  $("input.infinite").knob({
    min: 0,
    max: 20,
    stopper: false,
    change: function() {
    if (v > this.cv) {
    if (up) {
    decr();
    up = 0;
    } else {
    up = 1;
    down = 0;
    }
    } else {
    if (v < this.cv) {
    if (down) {
    incr();
    down = 0;
    } else {
    down = 1;
    up = 0;
    }
    }
    }
    v = this.cv;
    }
  });

});