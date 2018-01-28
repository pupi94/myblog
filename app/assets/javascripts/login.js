//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree ../../../vendor/assets/javascripts/bootstrap_validator

$(function(){
  var $loginForm = $('#login_form');
  $loginForm.bootstrapValidator({
    feedbackIcons: {
      valid: 'glyphicon glyphicon-ok',
      invalid: 'glyphicon glyphicon-remove',
      validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
      user_name: {
        message: '账号不合法！',
        validators: {
          notEmpty: {
            message: '账号不能为空！'
          },
          regexp: {
            regexp: /^[a-zA-Z0-9]+$/,
            message: '账号不能为中文或者特殊字符！'
          }
        }
      },
      password: {
        validators: {
          notEmpty: {
            message: '密码不能为空！'
          }
        }
      }
    }
  });
  $loginForm.submit(function(){
    $loginForm.bootstrapValidator('validate')
    if(!$loginForm.data('bootstrapValidator').isValid()){
      return false;
    }
  });

  $loginForm.find('input').on('click', function(){
    $loginForm.find('.form-error').remove();
  })
});