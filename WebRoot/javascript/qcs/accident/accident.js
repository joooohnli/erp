function loadAjaxDiv(input_id){//弹出ajax动态查询数据库层
if(document.getElementById('result_div')!=null){document.body.removeChild(document.getElementById('result_div'));}
    var input_obj=document.getElementById(input_id);
	var input_value=input_obj;
    var w = input_obj.offsetWidth;
    var h = input_obj.offsetHeight;
    var   x   =   input_obj.offsetLeft,   y   =   input_obj.offsetTop;   
    while(input_obj=input_obj.offsetParent){ 
       x+=input_obj.offsetLeft;   
       y+=input_obj.offsetTop;
    }
	var result_div=document.createElement('div');
	result_div.id='result_div';
	result_div.className='result_div1';
	result_div.style.top=y+18;
	result_div.style.left=x;
	result_div.style.width=w;
	document.body.appendChild(result_div);
	search_suggest(input_value.value,input_id,result_div);
	document.body.attachEvent('onmousedown',closeResult);
}

function closeResult(){
	var port_X=parseInt(event.clientX);
	var port_Y=parseInt(event.clientY);
	if(document.getElementById('result_div')!=undefined){
	var div=document.getElementById('result_div');
	var div_w=parseInt(div.style.width);
	var div_h=parseInt(getRStyle(div,'height','height'));
	var div_l=parseInt(div.style.left);
	var div_t=parseInt(div.style.top);
	if(port_X<div_l||port_X>(div_l+div_w)||port_Y<div_t||port_Y>(div_t+div_h)){
		document.body.removeChild(document.getElementById('result_div'));
		}
	}
}


function search_suggest(keyword,input_id,div_obj){//根据输入内容快速查询下拉层
	var search_tag=0;
		var xmlhttp;
		if(window.XMLHttpRequest){xmlhttp=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp) {xmlhttp.onreadystatechange = function() {
			if(xmlhttp.readyState==4){try {if(xmlhttp.status==200){
				//alert(xmlhttp.responseText);
				div_obj.innerHTML='';
				if(parseInt(xmlhttp.responseText)==179206725){
				document.getElementById(input_id).value='';
				div_obj.style.display='none';
				}else{
				var div_options =xmlhttp.responseText.split("\n");
				var conter='';
				for (var i = 0; i < div_options.length; i++){
                var array = div_options[i].split("/");
				var suggest = '<div  onmouseover="style.backgroundColor=\'#E8F2FE\'" onmouseout="style.backgroundColor=\'\'"';
				suggest += 'onclick=\"javascript:setSearch(this.innerHTML,\''+input_id+'\',\''+div_obj.id+'\',\''+array[1]+'\');\" ';
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
			xmlhttp.send('search_tag='+encodeURI(search_tag)+'&&keyword='+encodeURI(keyword));
		}
}
function setSearch(input_value,input_id,div_id,input_value2){
	var input_value1 = input_value.substring(0, input_value.indexOf("/"));
	document.getElementById(input_id).value = input_value1;
	document.getElementById('product_name').value = input_value2;
	document.body.removeChild(document.getElementById(div_id));
}

function formSumbit(this_tag){
var action_tag=this_tag;
var form;
var form_id;
if(action_tag=='register'){
form_id='accidentRegister';
form=document.getElementById('accidentRegister');
form.action='../../qcs_accident_register_ok';
}else if(action_tag=='dealwith'){
form_id='accidentDealwith';
form=document.getElementById('accidentDealwith');
form.action='../../qcs_accident_dealwith_ok';
}else if(action_tag=='change'){
form_id='accidentChange';
form=document.getElementById('accidentChange');
form.action='../../qcs_accident_change_ok';
}
if (doValidate('../../xml/qcs/qcs_accident.xml',form_id)){
form.submit();
}
}

function getRStyle(elem,IE,FF){//获取定义在css文件里的样式属性值
return navigator.appName=="Microsoft Internet Explorer"?elem.currentStyle[IE]:document.defaultView.getComputedStyle(elem, "").getPropertyValue(FF);
}