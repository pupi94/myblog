/*
 使用范例: readonly = false 时 object_name target_node不能为空
 $('.element').uploadAttachment({
   url: '',
   download_path: '',
   delete_path: '',
   object_name: '',
   attachment: '',
   readonly: true,
   target_node: 'xxxx'
 });
 */

(function ($) {
  var defaultOpts = {
    url: '/admin/attachments/upload', //附件上传路径
    download_path: '/admin/attachments/download?file_path=', //附件下载路径
    delete_path: '/admin/attachments/delete?file_path=', //附件删除路径
    object_name: null, // 附件所属的表名
    attachment: '',
    readonly: true, // true: 只能查看文件；false: 可以上传、删除文件
    limit_file_number: 10, // 一次最多可选择上传的文件数量
    limit_file_size: 3 * 1024 * 1024, // 单个文件最大可上传的大小，单位字节
    target_node: null,  //input name属性，回填附件上传结果到这个input
    form_data: {} //除了以上属性还需要发送到服务器的属性全部用这个属性来保存
  };

  function _uploadAttachment(opts, element) {
    this.opts = opts;
    this.element = element;
    this.MAP_MSG = {
      file_size_exceed: '您选择的附件超过' + Math.ceil(opts.limit_file_size / 1024 / 1024) + 'M ，请处理后再提交！',
      file_type_not_support: '您选择的附件非支持类型，请重新选择！',
      file_name_repeat: '您已经选择该附件，请重新选择！',
      file_amount_exceed: '最多上传' + opts.limit_file_number + '个附件，请重新选择！'
    };
    this.localFiles = [];
    this.formData = this.buildExtraFormData();
    this.init();
  }

  _uploadAttachment.prototype = {
    buildExtraFormData: function () {
      var me = this;
      var arr = [];

      var keys = ['object_name'];
      keys.forEach(function (key) {
        var value = me.opts[key];
        if (value !== undefined && value !== null) {
          arr.push({name: key, value: value});
        }
      });

      if (me.opts.form_data) {
        keys = Object.keys(me.opts.form_data);
        if (keys && keys.length) {
          keys.forEach(function (key) {
            var value = me.opts.form_data[key];
            if (value !== undefined && value !== null) {
              arr.push({name: key, value: value});
            }
          })
        }
      }
      return arr;
    },
    appendImgHtml: function (attachment) {
      var me = this;
      var $ul = me.element.find('.attachment-show ul');
      if (attachment) {
        var html = '';
        attachment.split('-||-').forEach(function (url) {
          if (url) {
            var name = decodeURI(url.split('/').pop());
            //var type = decodeURI(name.split('\.').pop());
            html += '<li>'+'<img src="'+ url +'" class="img-rounded" title="'+ name +'">'+
              (me.opts.readonly ? '': '<span class="delete" data-url="'+ url +'"><i class="glyphicon glyphicon-remove"></i></span>')+'</li>';
          }
        });
        $ul.append(html);
      }
    },
    sendFileUpload: function () {
      var me = this;
      if (!me.localFiles || me.localFiles.length == 0) {
        return;
      }
      me.element.find('.attachment-operations input[name="files[]"]').fileupload(
        'send', {files: me.localFiles, formData: me.formData}
      );
    },
    checkFiles: function (files) {
      var me = this;
      var $fileImgs = me.element.find('.attachment-show li > img');

      //check files number
      if ($fileImgs.length + files.length > me.opts.limit_file_number) {
        BootstrapDialog.alert({
          message: '<strong>提示</strong>&nbsp;&nbsp;' + me.MAP_MSG['file_amount_exceed'],
          type: BootstrapDialog.TYPE_WARNING
        });
        return false;
      }
      var valid = true, msg = null;
      $.each(files, function (index, file) {
        //if (!/(\.|\/)(jpe?g|png|bmp|xlsx?|docx?|pdf|tif|gif)$/i.test(file.name)) {
        //目前只支持图片上传
        if (!/(\.|\/)(jpe?g|png|bmp|gif)$/i.test(file.name)) {
          //check file type
          valid = false;
          msg = me.MAP_MSG['file_type_not_support'];
        } else if ($fileImgs.text().indexOf(file.name) != -1) {
          //check file name can not repeat
          valid = false;
          msg = me.MAP_MSG['file_name_repeat'];
        } else if (file.size && file.size > me.opts.limit_file_size) {
          //check file size, not support IE8
          valid = false;
          msg = me.MAP_MSG['file_size_exceed'];
        }
        return valid;
      });
      if(!valid){
        BootstrapDialog.alert({
          message: '<strong>提示</strong>&nbsp;&nbsp;' + msg,
          type: BootstrapDialog.TYPE_WARNING
        });
      }
      return valid;
    },
    addToLocalFiles: function (files) {
      var me = this;
      $.each(files, function (index, file) {
        me.localFiles.push(file);
      });
    },
    buildFileUploadOption: function () {
      var me = this;
      return {
        url: me.opts.url,
        type: 'post',
        dataType:'json',
        add: function (e, data) {
          if(me.checkFiles(data.files)){
            me.addToLocalFiles(data.files);
            me.sendFileUpload();
          }
        },
        done: function (e, data) {
          me.updateAttachments(data.result);
        }
      }
    },
    updateAttachments: function (data) {
      var me = this;
      if (data.return_code == 0) {
        me.opts.attachment += '-||-' + data.attachment;
        me.appendImgHtml(data.attachment);
        me.resetTargetNode();
      } else {
        BootstrapDialog.alert({
          message: '<strong>提示</strong>&nbsp;&nbsp;' + data.return_info,
          type: BootstrapDialog.TYPE_DANGER
        });
      }
    },

    deleteAttachment: function (event) {
      console.log($(event.target));
      /*var me = this;
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
      }).done(me.updateAttachments.bind(me));*/
    },

    resetTargetNode: function () {
    },
    init: function () {
      var me = this;
      var $tpl = '<div class="attachment-upload-wrapper">' +
        '<div class="attachment-show">' +
          '<ul></ul>' +
        '</div>' +
      '</div>';
      me.element.empty().append($tpl);
      me.appendImgHtml(me.opts.attachment);

      if (!me.opts.readonly) {
        me.element.find('.attachment-show ul').on('click', 'span.delete', me.deleteAttachment.bind(me));

        var $tpl = $(
          '<div class="attachment-operations">' +
            '<span class="btn btn-default fileinput-button">' +
              '<i class="glyphicon glyphicon-plus"></i>' +
              '<input type="file" name="files[]" multiple>' +
            '</span>' +
            '<input type="hidden" name="'+ me.opts.target_node +'" value="'+ me.opts.attachment +'">' +
          '</div>'
        );
        me.element.find('.attachment-upload-wrapper').append($tpl);

        $('.attachment-show img').on('click', function(){
          window.open($(this).prop('src'))
        });

        $tpl.find('input[name="files[]"]').fileupload(
          me.buildFileUploadOption()
        ).prop(
          'disabled', !$.support.fileInput
        ).parent().addClass($.support.fileInput ? undefined : 'disabled');
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