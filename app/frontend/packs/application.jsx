// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

require("@rails/ujs").start()
require("turbolinks").start()

import React from 'react'
// import ReactDOM from 'react-dom'
// import PropTypes from 'prop-types'

const images = require.context('./../images', true);
const imagePath = (name) => images(name, true);

// import css
import './../stylesheets/application.scss'

// import js
import 'jquery'
import 'bootstrap/dist/js/bootstrap'
