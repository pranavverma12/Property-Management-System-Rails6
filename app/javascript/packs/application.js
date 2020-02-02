// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)




















































$(function () {
    $(document).on('click', '#doNotPressThisButton', function (e) {
        e.preventDefault();

        alert('I wish you had listened!');

        $('a').addClass('fa-spin');
        $('p').addClass('fa-spin');
        $('button').addClass('fa-spin');

        setTimeout(function () { $('.scaffoldListTable').addClass('fa-spin') }, 2000);
        setTimeout(function () { $('.scaffold').addClass('fa-spin') }, 4000);
        setTimeout(function () { $('#wrapper').addClass('fa-spin') }, 7000);

        setTimeout(function () {
            $('.fa-spin').removeClass('fa-spin');
        }, 10000);
    })
});