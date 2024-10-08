// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require bootstrap-sprockets
//= require bootstrap
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("@fortawesome/fontawesome-free")
import 'bootstrap';
import Chart from 'chart.js/auto';

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` Java  Script helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


import "controllers"
