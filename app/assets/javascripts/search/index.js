/**
 * Created by Abhinav Mishra on 7/25/16.
 */

;(function () {
  'use strict';

  $('.users.index').ready(function () {

    var constants,
    Index = {

      settings: {
        $form: $('#file-upload-form'),
        $alertDiv: $('.alert'),
        $fileField: $('#keywords'),
        successMsg: 'Your file has been uploaded. Keywords will be available' +
        ' once parsed',
        errorMsg: 'Uploaded file could not be parsed. Please check it.',
        fadeOutInterval: 10000,
        uploadPath: '/search'
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
              required: true,
              extension: "csv"
            }
          },
          messages: {
            "keywords": {
              required: 'Required',
              extension: 'Only .csv files are supported.'
            }
          },
          errorPlacement: function (error, element) {
            error.appendTo('#' + element.attr('id') + '_error');
          },
          submitHandler: function() {
            var reader  = new FileReader();
            var file = $('#keywords')[0].files[0];

            reader.addEventListener('load', function () {
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
          url: constants.uploadPath,
          data: {data: data},
          dataType: "JSON"
        })
        .done(Index.successHandler)
        .fail(Index.errorHandler)
        .always(Index.alwaysHandler)
      },

      successHandler: function() {
        constants.$alertDiv
        .removeClass('alert-danger')
        .addClass('alert-success')
        .html(constants.successMsg)
        .show()
        .fadeOut(constants.fadeOutInterval);
      },

      errorHandler: function() {
        constants.$alertDiv
        .removeClass('alert-success')
        .addClass('alert-danger')
        .html(constants.errorMsg)
        .show()
        .fadeOut(constants.fadeOutInterval);
      },

      alwaysHandler: function() {
        constants.$fileField.val("");
      }
    };

    (function () {
      Index.init();
    })();

  });
})();
