/**
 * IAS Spinner Extension
 * An IAS extension to show a spinner when loading
 * http://infiniteajaxscroll.com
 *
 * This file is part of the Infinite AJAX Scroll package
 *
 * Copyright 2014-2017 Webcreate (Jeroen Fiege)
 */

var IASSpinnerExtension = function(options) {
  options = jQuery.extend({}, this.defaults, options);

  this.ias = null;
  this.uid = new Date().getTime();
  this.src = options.src;
  this.html = (options.html).replace('{src}', this.src);

  /**
   * Shows spinner
   */
  this.showSpinner = function() {
    var $spinner = this.getSpinner() || this.createSpinner(),
        $lastItem = this.ias.getLastItem();

    $lastItem.after($spinner);
    $spinner.fadeIn();
  };

  /**
   * Shows spinner
   */
  this.showSpinnerBefore = function() {
    var $spinner = this.getSpinner() || this.createSpinner(),
        $firstItem = this.ias.getFirstItem();

    $firstItem.before($spinner);
    $spinner.fadeIn();
  };

  /**
   * Removes spinner
   */
  this.removeSpinner = function() {
    if (this.hasSpinner()) {
      this.getSpinner().remove();
    }
  };

  /**
   * @returns {jQuery|boolean}
   */
  this.getSpinner = function() {
    var $spinner = jQuery('#ias_spinner_' + this.uid);

    if ($spinner.length > 0) {
      return $spinner;
    }

    return false;
  };

  /**
   * @returns {boolean}
   */
  this.hasSpinner = function() {
    var $spinner = jQuery('#ias_spinner_' + this.uid);

    return ($spinner.length > 0);
  };

  /**
   * @returns {jQuery}
   */
  this.createSpinner = function() {
    var $spinner = jQuery(this.html).attr('id', 'ias_spinner_' + this.uid);

    $spinner.hide();

    return $spinner;
  };

  return this;
};

/**
 * @public
 */
IASSpinnerExtension.prototype.bind = function(ias) {
  this.ias = ias;

  ias.on('next', jQuery.proxy(this.showSpinner, this));
  ias.on('render', jQuery.proxy(this.removeSpinner, this));

  try {
    ias.on('prev', jQuery.proxy(this.showSpinnerBefore, this));
  } catch (exception) {}
};

/**
 * @public
 * @param {object} ias
 */
IASSpinnerExtension.prototype.unbind = function(ias) {
  ias.off('next', this.showSpinner);
  ias.off('render', this.removeSpinner);

  try {
    ias.off('prev', this.showSpinnerBefore);
  } catch (exception) {}
};

/**
 * @public
 */
IASSpinnerExtension.prototype.defaults = {
  src: '/loading.gif',
  html: '<div class="ias-spinner"><img src="{src}"/></div>'
};
