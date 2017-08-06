// 上传文件 插件
// require jQuery
// require css flex
/*
 使用范例:
 $('.element').uploadAttachment({
   url: '',
   service_name: '',    // require
   attachment_type: '', // require
   attachment_id: '',   // require
   object_name: '',     // require
   object_id: '',
   attachment: '',
   attachment_name: '',
   object_locked: true,
   auto_upload: true,
   form_data: {}
 });

 *** 如何获取最新的附件值：获取组件内 $('.element').find('input.component_attachment') 的值即可 ***
*/

(function ($) {
  var defaultOpts = {
    url: '/attachment/update',
    download_path: '/attachment/download?file_path=',
    service_name: null,
    attachment_type: null,
    attachment_id: null,
    object_name: null,
    object_id: null,
    attachment: null,
    attachment_name: null,
    object_locked: false, // true: 只能查看文件；false: 可以上传、删除文件
    auto_upload: false, // true: 文件选择后立即自动上传；false: 多文件手动上传
    limit_file_number: 10, // 一次最多可选择上传的文件数量
    limit_file_size: 3 * 1024 * 1024, // 单个文件最大可上传的大小，单位字节
    form_data: {} // 除了以上属性还需要发送到服务器的属性全部用这个属性来保存
  };

  function _uploadAttachment(opts, element) {
    this.opts = opts;
    this.element = element;
    this.localFiles = [];
    this.MAP_MSG = {
      file_size_exceed: '您选择的附件超过' + Math.ceil(opts.limit_file_size / 1024 / 1024) + 'M ，请处理后再提交！',
      file_type_not_support: '您选择的附件非支持类型，请重新选择！',
      file_name_repeat: '您已经选择该附件，请重新选择！',
      file_amount_exceed: '最多上传' + opts.limit_file_number + '个附件，请重新选择！'
    };
    element.addClass('whalemove_attachment_upload_container');
    this.init();
  }

  _uploadAttachment.prototype = {
    checkFiles: function (files) {
      var me = this;
      var $fileLinks = me.element.find('ul.clearfix > li > a');
      var rtn = {valid: true, msg: ''};

      //check files number
      if ($fileLinks.length + files.length > me.opts.limit_file_number) {
        rtn.valid = false;
        rtn.msg = me.MAP_MSG['file_amount_exceed'];
        return rtn;
      }

      $.each(files, function (index, file) {
        if (!/(\.|\/)(jpe?g|png|bmp|xlsx?|docx?|pdf|tif|gif)$/i.test(file.name)) {
          //check file type
          rtn.valid = false;
          rtn.msg = me.MAP_MSG['file_type_not_support'];
        } else if ($fileLinks.text().indexOf(file.name) != -1) {
          //check file name can not repeat
          rtn.valid = false;
          rtn.msg = me.MAP_MSG['file_name_repeat'];
        } else if (file.size && file.size > me.opts.limit_file_size) {
          //check file size, not support IE8
          rtn.valid = false;
          rtn.msg = me.MAP_MSG['file_size_exceed'];
        }
      });
      return rtn;
    },
    buildLinkFileHtml: function (url) {
      var me = this;
      var name = decodeURI(url.split('/').pop());
      var type = decodeURI(name.split('\.').pop());
      var $tpl = $('<li class="fl"><span class="file_type ' + type + '">' + type
        + '</span><a href="' + (me.opts.download_path + encodeURI(url)) + '" data-file_path="' + url + '" target="_blank">' + name + '</a>'
        + (me.opts.object_locked ? '</li>' : '<span class="delete_attachment" title="删除"></span></li>'));
      if (!me.opts.object_locked) {
        //add click event for the element of span.delete_attachment
        $tpl.find('span.delete_attachment').on('click', me.deleteAttachment.bind(me));
      }
      return $tpl;
    },
    buildUploadBtnHtml: function () {
      var me = this;
      var $tpl = $('<div class="attachment-operations"><span class="btn btn_grey_inv fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>'
        + (me.opts.auto_upload ? '上传附件' : '选择附件')
        + '</span><input type="file" class="file_upload" name="upload_attachment[]" multiple=""></span>'
        + (me.opts.auto_upload ? '</div>' : '<button class="btn btn-primary fileinput-button" disabled><i class="glyphicon glyphicon-upload"></i><span>上传附件</span></button></div>')
      );
      if (!me.opts.auto_upload) {
        $tpl.find('button.fileinput-button').on('click', me.sendFileUpload.bind(me));
      }
      $tpl.find('input.file_upload').fileupload(me.buildFileUploadOption())
      .prop('disabled', !$.support.fileInput)
      .parent().addClass($.support.fileInput ? undefined : 'disabled');
      return $tpl;
    },
    buildExtraFormData: function () {
      var me = this;
      var arr = [
        {name: 'service_name', value: me.opts.service_name},
        {name: 'attachment_type', value: me.opts.attachment_type},
        {name: 'attachment_id', value: me.opts.attachment_id},
        {name: 'object_name', value: me.opts.object_name},
        {name: 'object_id', value: me.opts.object_id},
        {name: 'attachment_name', value: me.opts.attachment_name},
        {name: 'object_locked', value: me.opts.object_locked}
      ];
      if (me.opts.form_data) {
        var keys = Object.keys(me.opts.form_data);
        if (keys && keys.length) {
          keys.forEach(function (key) {
            var value = me.opts.form_data[key]
            if (value != undefined && value != null) {
              arr.push({name: key, value: value});
            }
          })
        }
      }
      return arr;
    },
    buildFileUploadOption: function () {
      var me = this;
      return {
        url: me.opts.url,
        type: 'post',
        dataType: 'json',
        formData: me.buildExtraFormData(),
        add: function (e, data) {
          var validation = me.checkFiles(data.files);
          if (validation.valid) {
            if (me.opts.auto_upload) {
              me.element.find('.fileinput-button').attr('disabled', 'disabled');
              me.element.find('.fileinput-button span').text('正在上传');
              data.submit();
            } else {
              me.addToLocalFiles(data.files);
              me.element.find('button.fileinput-button').removeAttr('disabled');
              me.element.find('.attachment .error_msg').text('').addClass('hidden');
            }
          } else {
            me.element.find('.attachment .error_msg').text(validation.msg).removeClass('hidden');
          }
        },
        done: function (e, data) {
          if (me.opts.auto_upload) {
            me.element.find('.fileinput-button').removeAttr('disabled');
            me.element.find('.fileinput-button span').text('上传附件');
          } else {
            me.localFiles = [];
            me.element.find('span.fileinput-button').removeAttr('disabled');
            me.element.find('button.fileinput-button span').text('上传附件');
          }
          me.updateAttachments(data.result);
        }
      };
    },
    addToLocalFiles: function (files) {
      var me = this;
      var $ul = me.element.find('ul.clearfix');
      if ($ul.find('li').length == 0) {
        $ul.empty();
      }
      $.each(files, function (index, file) {
        me.localFiles.push(file);
        var fileType = file.name.substring(file.name.lastIndexOf('.') + 1);
        var $tpl = '<li class="fl"><span class="file_type uploading"' + '>' + fileType + '</span><a>' + file.name + '</a></li>';
        $ul.append($tpl);
      });
    },
    sendFileUpload: function () {
      var me = this;
      if (!me.localFiles || me.localFiles.length == 0) {
        return;
      }
      me.element.find('.fileinput-button').attr('disabled', 'disabled');
      me.element.find('button.fileinput-button span').text('正在上传');
      me.element.find('input.file_upload').fileupload('send', {files: me.localFiles});
    },
    deleteAttachment: function (event) {
      var me = this;
      var $link = $(event.target).siblings('a');
      var fileName = $link.text();
      var filePath = $link.data('file_path');
      if (!confirm('确定需要删除附件 ' + fileName + ' 吗？')) {
        return;
      }
      var data = $.extend(true, {
        attachment_type: me.opts.attachment_type,
        attachment_id: me.opts.attachment_id,
        attachment_name: me.opts.attachment_name,
        object_locked: me.opts.object_locked,
        delete_files: [filePath]
      }, me.opts.form_data);
      $.ajax({
        url: me.opts.url,
        type: 'post',
        dataType: 'json',
        data: data,
        cached: false
      }).done(me.updateAttachments.bind(me));
    },
    updateAttachments: function (data) {
      var me = this;
      if (data.return_code == 0) {
        me.opts.attachment = data.attachment;
        me.appendLinkFiles();
        me.resetModalRelatedTarget();
        /***  暴露给外部读取当前附件值： input.component_attachment  ***/
        me.element.find('input.component_attachment').val(me.opts.attachment);
        me.element.find('.attachment .error_msg').text('').addClass('hidden');
      } else {
        me.element.find('.attachment .error_msg').text(data.return_info).removeClass('hidden');
      }
    },
    appendLinkFiles: function () {
      var me = this;
      var $ul = me.element.find('ul.clearfix');
      $ul.empty();
      if (me.opts.attachment) {
        me.opts.attachment.split('-||-').forEach(function (url) {
          if (url) {
            var $tpl = me.buildLinkFileHtml(url);
            var $target = $ul.find('li.fl:last');
            if ($target.length) { //如果已有文件，则追加在文件末尾
              $target.after($tpl);
            } else {
              $ul.append($tpl);
            }
          }
        });
      } else {
        $ul.append('<span>没有附件</span>');
      }
    },
    resetModalRelatedTarget: function () {
      var me = this;
      var $relatedTarget = $('a.show-attachment-button[data-service-name=' + me.opts.service_name
        + '][data-attachment-type=' + me.opts.attachment_type + '][data-attachment-id=' + me.opts.attachment_id + ']');
      if ($relatedTarget) {
        $relatedTarget.data('attachment', me.opts.attachment);
        if (!me.opts.is_custom_text) {
          $relatedTarget.text(me.opts.attachment ? '查看附件' : '上传附件');
        }
      }
    },
    init: function () {
      var me = this;
      var $tpl = '<div class="attachment"><input class="component_attachment" hidden><div class="attachment-body"><ul class="clearfix"></ul><span class="error_msg hidden"></span></div></div>';
      me.element.empty().append($tpl);

      me.appendLinkFiles();

      if (!me.opts.object_locked) {
        me.element.find('div.attachment').append(me.buildUploadBtnHtml());
      }
    }
  };

  function uploadAttachment(options) {
    if (typeof options === 'string') {
      options = JSON.parse(options);
    }
    return new _uploadAttachment($.extend(true, {}, defaultOpts, options), this);
  }

  $.fn.uploadAttachment = uploadAttachment;
}(jQuery));