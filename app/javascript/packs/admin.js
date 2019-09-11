const images = require.context('../images', true);
const imagePath = (name) => images(name, true);

//require("@rails/ujs").start();
require("turbolinks").start();

// import css
import './../stylesheets/bootstrap'
import './../stylesheets/error'
import './../stylesheets/markdown'
import './../stylesheets/common/bootstrap-validator.min'
import './../stylesheets/common/bootstrap-dialog'

import './../stylesheets/admin/base'
import './../stylesheets/admin/article'
import './../stylesheets/admin/markdown'
import './../stylesheets/admin/public'

// import js
import 'jquery'
import 'bootstrap/dist/js/bootstrap'
import './../src/common/bootstrap-dialog'
import './../src/common/bootstrap-validator'

function stopEventBubble(event) {
  if (event && event.stopPropagation) {
    event.stopPropagation()
  } else {
    event.cancelBubble = true;
  }
}
