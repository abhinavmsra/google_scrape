/**
 * Created by Abhinav Mishra on 7/25/16.
 */

;(function () {
  'use strict';

  $('.search.index').ready(function () {

    var constants,
    Index = {

      settings: {
        $form: $('#file-upload-form'),
        formValidationAttributes: {
          focusInvalid: false,
          rules: {
            "search_file": {
              required: true,
              extension: 'csv'
            }
          },
          messages: {
            "search_file": {
              required: 'Required',
              extension: 'Only .csv files are supported'
            }
          },
          errorPlacement: function (error, element) {
            error.appendTo('#' + element.attr('id') + '_error');
          },
          submitHandler: function(form) {
            debugger;
            return false;
          }
        }
      },

      init: function () {
        constants = this.settings;
        this.validateForm();
      },

      validateForm: function () {
        constants.$form.validate({
          focusInvalid: false,
          rules: {
            "keywords": {
              required: true
            }
          },
          messages: {
            "keywords": {
              required: 'Required'
            }
          },
          errorPlacement: function (error, element) {
            error.appendTo('#' + element.attr('id') + '_error');
          },
          submitHandler: function() {
            var reader  = new FileReader();
            var file = $('#keywords')[0].files[0];

            reader.addEventListener('load', function () {
              console.log(reader.result)
              Index.formSubmitHandler(reader.result);
            }, false);

            if (file && file.type === 'text/csv') {
              reader.readAsDataURL(file);
            }
            return false;
          }
        });
      },

      formSubmitHandler: function(data) {
        $.ajax({
          type: "POST",
          url: '/search',
          data: {data: data},
          dataType: "JSON"
        })
      }
    };

    (function () {
      Index.init();
    })();

  });
})();
