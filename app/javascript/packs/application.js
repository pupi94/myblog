const images = require.context('../images', true);
const imagePath = (name) => images(name, true);

require("@rails/ujs").start()
require("turbolinks").start()

// import css
import './../stylesheets/bootstrap'
import './../stylesheets/error'
import './../stylesheets/markdown'
import './../stylesheets/common/nprogress'

import './../stylesheets/blog/index'
import './../stylesheets/blog/article'

// import js
import 'jquery'
import 'bootstrap/dist/js/bootstrap'
import './../src/common/nprogress'
import './../src/common/nprogress'
import './../src/blog/index'
