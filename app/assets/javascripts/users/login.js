$(function(){
	$('input').focus(function(){
		$('.result span').remove();
	});
	$('input').blur(function(){
		var e=$(this);
		if(e.attr("data-validate")){      //attr() 方法设置或返回被选元素的属性值。
			e.closest('.field').find(".input-help").remove();//closest() 方法获得匹配选择器的第一个祖先元素，从当前元素开始沿 DOM 树向上。
			var $checkdata=e.attr("data-validate").split(',');
			var $checkvalue=e.val();
			var $checkstate=true;
			var $checktext="";
			if(e.attr("placeholder")==$checkvalue){
				$checkvalue="";
			}
			if($checkvalue!="" || e.attr("data-validate").indexOf("required")>=0){
				for(var i=0;i<$checkdata.length;i++){
					var $checktype=$checkdata[i].split(':');
					if(! $datacheck(e,$checktype[0],$checkvalue)){
						$checkstate=false;
						$checktext=$checktext+"<li>"+$checktype[1]+"</li>";
					}
				}
			};
			if($checkstate){
				e.closest('.form-group').removeClass("check-error");
				e.parent().find(".input-help").remove();
				e.closest('.form-group').addClass("check-success");
			}else{
				e.closest('.form-group').removeClass("check-success");
				e.closest('.form-group').addClass("check-error");
				e.closest('.field').append('<div class="input-help"><ul>'+$checktext+'</ul></div>');
			}
		}
	});
	$datacheck=function(element,type,value){
		$value=value.replace(/(^\s*)|(\s*$)/g, "");//前后去空格
		switch(type){
			case "required":return /[^(^\s*)|(\s*$)]/.test($value);break;//检查输入内容是否为空
			case "check_En":return /^[A-Za-z0-9]+$/.test($value);break;//检查是否包括英文字母和数字之外的字符
			default:return true;break;
		}
		return false;
	}
	$('form').submit(function(){
		$(this).find('input[data-validate]').trigger("blur");
		var numError = $(this).find('.check-error').length;
		if(numError){
			$(this).find('.check-error').first().find('input[data-validate]').first().focus().select();
			return false;
		}
	});
}) 