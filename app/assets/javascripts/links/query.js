/**
 * Created by Abhinav Mishra on 7/27/16.
 */

;(function () {
  'use strict';

  $(document).ready(function () {

    var constants,
    Query = {

      settings: {
        $form: $('#query-form'),
        $containsField: $('#contains'),
        $urlField: $('#url'),
        $pathDepthField: $('#path_depth'),
        $outputContainer: $('#query-result')
      },

      init: function () {
        constants = this.settings;
        this.bindUIActions();
      },

      bindUIActions: function () {
        constants.$form.on('submit', this.submitHandler);
      },

      submitHandler: function() {
       $.ajax({
         url: '/links?' + $(this).serialize(),
         method: 'GET'
       })
       .done(Query.successHandler);

        return false;
      },

      successHandler: function(data) {
        var prettify_response = Query.syntaxHighlight(JSON.stringify(data, undefined, 4));

        constants.$outputContainer
        .html(prettify_response)
        .removeClass('hide')
      },

      /*
      *  JSON Prettify code copied from:
      *   http://stackoverflow.com/questions/4810841/how-can-i-pretty-print-json-using-javascript#answer-7220510
      * */
      syntaxHighlight: function(json) {
        var urlRegex = new RegExp(/[-a-zA-Z0-9@:%_\+.~#?&//=]{2,256}\.[a-z]{2,4}\b(\/[-a-zA-Z0-9@:%_\+.~#?&//=]*)?/gi);
        json = json.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
        return json.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, function (match) {
          var cls = 'number';

          if (urlRegex.test(match)) {
            return '<a href=' + match + '>' + match + '</a>';
          }
          if (/^"/.test(match)) {
            if (/:$/.test(match)) {
              cls = 'key';
            } else {
              cls = 'string';
            }
          } else if (/true|false/.test(match)) {
            cls = 'boolean';
          } else if (/null/.test(match)) {
            cls = 'null';
          }
          return '<span class="' + cls + '">' + match + '</span>';
      });
    }
    };

    (function () {
      Query.init();
    })();

  });
})();
