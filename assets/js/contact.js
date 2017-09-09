"use strict";

// Activate contact form
(function ( $ ) {

  var form = $("#contact");
  var submit = $("#contact button[type=submit]");

  $(form).on("submit", function(e) {
    e.preventDefault();

    var payload = {};

    $(submit).attr("disabled", true);

    $(form).find("[name]").each(function(i, el) {
      payload[$(el).attr("name")] = $(el).val();
    });

    $.ajax({
      url: "mailer/contact",
      type: "POST",
      data: payload,
      complete: function() {
        $(form).removeClass("submit-failure submit-success form-reset");
        $(submit).attr("disabled", false);
      },
      success: function() {
        $(form).trigger("reset")
               .addClass("submit-success form-reset");

        new Noty({
          text: "Thank you!",
          theme: 'icf',
          timeout: 2000,
          progressBar: false,
          container: ".signup-form-notifications",
          closeWith: ['click', 'button'],
          type: "info"
        }).show();

        // Change the state
        window.history.pushState('submitFailure', 'Thank you for submitting!', '?submit="true"');
      },
      error: function() {
        $(form).addClass("submit-failure");

        new Noty({
          "text": "Sorry, something went wrong!",
          theme: 'icf',
          progressBar: false,
          container: ".signup-form-notifications",
          closeWith: ['click', 'button'],
          type: "error"
        }).show();

        // Change the state
        window.history.pushState('submitFailure', 'Submit did not work :(', '?submit="false"&error="true"');
      }
    });
  });
}( jQuery ));
