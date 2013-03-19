/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function loadAjaxDiv(input_id,fileKind_chain,e){//弹出ajax动态查询数据库层
e=e||window.event;
//if(document.getElementById('result_div')!=null){document.body.removeChild(document.getElementById('result_div'));}
var obj1=document.getElementById(input_id);
    var w = obj1.offsetWidth;
    var h = obj1.offsetHeight;
    var   x   =   obj1.offsetLeft,   y   =   obj1.offsetTop;   
    while(obj1=obj1.offsetParent){ 
       x+=obj1.offsetLeft;   
       y+=obj1.offsetTop;
    }
	
	var result_div=document.createElement('div');//动态创建div层
	result_div.id='result_div';
	result_div.className='result_div1';
	result_div.style.top=y+18;
	result_div.style.left=x;
	result_div.style.width=w;
	document.body.appendChild(result_div);//把层添加到body里
	
	search_suggest1(input_id,fileKind_chain,result_div);//调用ajax方法 传3个参数
	
	document.body.attachEvent('onmousedown',closeResult1,e);
}
function closeResult1(e){
	e=e||window.event;
	var scrollTop=parseInt(getScrollTop());
	var port_X=parseInt(e.clientX);
	var port_Y=parseInt(e.clientY)+scrollTop;
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

function getScrollTop1(){
var scrollTop=0;
if(document.documentElement&&document.documentElement.scrollTop){
scrollTop=document.documentElement.scrollTop;
}else if(document.body){
scrollTop=document.body.scrollTop;
}
return scrollTop;
}


function search_suggest1(input_id,fileKind_chain,div_obj){//根据输入内容快速查询下拉层
		var xmlhttp;
		var chain_id='';
		if(document.getElementById(fileKind_chain).value!=''){
			chain_id=document.getElementById(fileKind_chain).value.split(' ')[0];//获得chain-id
		}
		if(window.XMLHttpRequest){xmlhttp=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp) {xmlhttp.onreadystatechange = function() {
			if(xmlhttp.readyState==4){try {if(xmlhttp.status==200){
				div_obj.innerHTML='';
				if(parseInt(xmlhttp.responseText)==123){
				div_obj.style.display='none';
				}else{
				var div_options =xmlhttp.responseText.split("\n");
				var conter='';
				for (var i = 0; i < div_options.length; i++) {
				var suggest = '<div  onmouseover="style.backgroundColor=\'#E8F2FE\'" onmouseout="style.backgroundColor=\'\'"';
				suggest += 'onclick=\"javascript:setSearch1(this.innerHTML,\''+input_id+'\',\''+div_obj.id+'\');\" ';
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
			xmlhttp.send('chain_id='+chain_id);
		}
	
}
function setSearch1(input_value,input_id,div_id,param1){
	document.getElementById(input_id).value = input_value;
	document.body.removeChild(document.getElementById(div_id));
}
function reset(input_id){
	document.getElementById(input_id).value ='';
	//document.body.removeChild(document.getElementById(div_id));
}
function getRStyle(elem,IE,FF){//获取定义在css文件里的样式属性值
return navigator.appName=="Microsoft Internet Explorer"?elem.currentStyle[IE]:document.defaultView.getComputedStyle(elem, "").getPropertyValue(FF);
}