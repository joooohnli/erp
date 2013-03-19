function loadAjaxDiv(input_id,event){//弹出ajax动态查询数据库层
if(document.getElementById('result_div')!=null){document.body.removeChild(document.getElementById('result_div'));return false;}
var obj1=document.getElementById(input_id);
    var w = obj1.offsetWidth;
    var h = obj1.offsetHeight;
    var   x   =   obj1.offsetLeft,   y   =   obj1.offsetTop;   
    while(obj1=obj1.offsetParent){ 
       x+=obj1.offsetLeft;   
       y+=obj1.offsetTop;
    }
	var result_div=document.createElement('div');
	result_div.nTag='result_div';
	result_div.id='result_div';
	result_div.className='result_div1';
	result_div.style.top=y+18;
	result_div.style.left=x;
	result_div.style.width=w;
	document.body.appendChild(result_div);
	search_suggest(input_id,result_div);
	if(document.attachEvent) document.attachEvent('onmousedown',closeResult,event);
	if(document.addEventListener) document.addEventListener('mousedown',closeResult,event);
}

function search_suggest(input_id,div_obj){//根据输入内容快速查询下拉层
	var search_tag=0;
		var xmlhttp;
		if(window.XMLHttpRequest){xmlhttp=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp) {xmlhttp.onreadystatechange = function() {
			if(xmlhttp.readyState==4){try {if(xmlhttp.status==200){
				//alert(xmlhttp.responseText);
				if(search_tag==5||search_tag==6){
					if(parseInt(xmlhttp.responseText)==0){document.getElementById(input_id).value='';return false;}
				}
				div_obj.innerHTML='';
				if(parseInt(xmlhttp.responseText)==0){
				div_obj.style.display='none';
				}else{
				var div_options =xmlhttp.responseText.split("\n");
				var conter='';
				for (var i = 0; i < div_options.length; i++) {
				var suggest = '<div  onmouseover="style.backgroundColor=\'#E8F2FE\'" onmouseout="style.backgroundColor=\'\'"';
				suggest += 'onclick=\"javascript:setSearch(this.innerHTML,\''+input_id+'\',\''+div_obj.id+'\');\" ';
				suggest += '>' + div_options[i] + '</div>';
				conter += suggest;
				}
				div_obj.innerHTML = null;
				div_obj.innerHTML = '';
				div_obj.innerHTML = conter;
				}
			}else {alert( xmlhttp.status + '=' + xmlhttp.statusText);}} catch(exception) {alert(exception);}}};
			xmlhttp.open("POST", "register_search.jsp", true);
			xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xmlhttp.send('search_tag='+encodeURI(search_tag));
		}
	
}
function setSearch(input_value,input_id,div_id,param1){
	document.getElementById(input_id).value = input_value;
	document.body.removeChild(document.getElementById(div_id));
}

function formSubmit(action_tag){
	var form;
	if (action_tag == 'register') {
		form = document.getElementById('mutiValidation');
		form.action = '../../qcs_product_register_ok';
	}else if (action_tag == 'check') {
		form = document.getElementById('mutiValidation');
		if (form.Ref[0].checked) {
			form.action = "check_delete_reconfirm.jsp";
		}else {
			form.action = "../../qcs_product_check_ok";
		}
	}else if (action_tag == 'change') {
		form = document.getElementById('mutiValidation');
		form.action = '../../qcs_product_change_ok';
	}else if (action_tag == 'registerKey') {
		form = document.getElementById('mutiValidation');
		form.action = '../../qcs_product_register_key_ok';
	}
if (doValidate('../../xml/qcs/qcs_product_config.xml','mutiValidation')){
	form.submit();
	}
}
