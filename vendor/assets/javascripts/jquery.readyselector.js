(function ($) {
  'use strict';
  var ready = $.fn.ready;
  $.fn.ready = function (fn) {
    if (this.context === undefined) {
      // The $().ready(fn) case.
      ready(fn);
    } else if (this.selector) {
      ready($.proxy(function () {
        var selectors = this.selector.split(','),
            context = this.context;

        $.each(selectors, function(count, sel) {
          $(sel, context).each(fn);
        });
      }, this));
    } else {
      ready($.proxy(function () {
        $(this).each(fn);
      }, this));
    }
  };
})(jQuery);
