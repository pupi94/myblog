const images = require.context('../images', true);
const imagePath = (name) => images(name, true);

require("@rails/ujs").start()
require("turbolinks").start()

// import css
import './../stylesheets/bootstrap'
import './../stylesheets/common/bootstrap-validator.min'
import './../stylesheets/devise'

// import js
import 'jquery'
import 'bootstrap/dist/js/bootstrap'
import './../src/common/bootstrap-validator'
