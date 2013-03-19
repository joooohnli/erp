/*
 * 
 */
String.prototype.Trim = function()
{
return this.replace(/(^\s*)|(\s*$)/g, "");
}

function XmlDocument() {}
XmlDocument.create = function () {//firefox读取xml文件时使用
	if (document.implementation && document.implementation.createDocument) {
		return document.implementation.createDocument("", "", null);
	} 
}

function readXml(css,url){//读取xml文件,生成表单
var nseer_tag=true;
var xmlHttp;
var obj='';
if(window.ActiveXObject){
nseer_tag=true;
xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
} else if(window.XMLHttpRequest){ 
nseer_tag=false;
xmlHttp = new XMLHttpRequest(); }
if(nseer_tag){
try{
xmlHttp.onreadystatechange = function (){
if(xmlHttp.readyState == 4){
if(xmlHttp.status == 200 || xmlHttp.status == 0){
	
var xmlDOM = xmlHttp.responseXML; 
var treeToot = xmlDOM.documentElement;
var myLink=document.createElement('link');
//myLink.href=treeToot.getAttribute('css');
myLink.href=css+"?"+Math.random();
myLink.rel='stylesheet';
myLink.type='text/css';
var body=document.body;
body.appendChild(myLink);
//try {
var div_array=treeToot.childNodes;
createPage(treeToot,body);
//}catch(exception) { 
//alert(exception);
//}
}}
};
xmlHttp.open("GET", url+"?"+ Math.random(), false);
xmlHttp.send(null);
}catch(exception){ 
alert("您要访问的资源不存在!");
} 
}else{
//********************************************************FIREFOX***********************
var xmlDoc = XmlDocument.create();
	xmlDoc.async = false; 
	xmlDoc.load(url+"?"+ Math.random());
	if (xmlDoc.documentElement == null) {
		alert("配置文件读取错误，请检查。");
		return null;
	}
	
	
	//var xmlDOM = xmlHttp.responseXML; 
var treeToot = xmlDoc.documentElement; 
//createPageObj(treeToot);

try {
var div_array=treeToot.getElementsByTagName('div');
for(var a=0;a<div_array.length;a++){
if (div_array.item(a)==null||typeof(div_array.item(a).tagName)=='undefined') {
continue;
}

	var myDiv=document.createElement(div_array.item(a).tagName);
	myDiv.style.position='absolute';
	myDiv.style.top='100px';
	myDiv.style.right='50px';
	myDiv.id=div_array.item(a).getAttribute('id');
	myDiv.style.height=div_array.item(a).getAttribute('height');
	myDiv.style.width=div_array.item(a).getAttribute('width');
	myDiv.style.background=div_array.item(a).getAttribute('background');
	document.body.appendChild(myDiv);
	var table_array=div_array.item(a).getElementsByTagName('table');
	for(var b=0;b<table_array.length;b++){
	if (table_array.item(b)==null||typeof(table_array.item(b).tagName)=='undefined') {
		continue;
		}
		var myTable=document.createElement(table_array.item(b).tagName);
		myTable.id=table_array.item(b).getAttribute('id');
		myDiv.appendChild(myTable);
		var NEWTb=document.createElement('tbody');
		myTable.appendChild(NEWTb);
		var tr_array=table_array.item(b).getElementsByTagName('tr');
		for(var c=0;c<tr_array.length;c++){
		if (tr_array.item(c)==null||typeof(tr_array.item(c).tagName)=='undefined') {
		continue;
		}
			var myTr=document.createElement(tr_array.item(c).tagName);
			myTr.id=tr_array.item(c).getAttribute('id');
			
			NEWTb.appendChild(myTr);
			
			var td_array=tr_array.item(c).getElementsByTagName('td');
			for(var d=0;d<td_array.length;d++){
			if (td_array.item(d)==null||typeof(td_array.item(d).tagName)=='undefined') {
			continue;
			}
				var myTd=document.createElement(td_array.item(d).tagName);
				myTd.id=td_array.item(d).getAttribute('id');
				myTr.appendChild(myTd);
			
				var input_array=td_array.item(d).childNodes;
				
				for(var e=0;e<input_array.length;e++){
				
				if(typeof(input_array.item(e).tagName)=='undefined'){
				var myInput=document.createElement('span');
				myInput.innerHTML=input_array.item(e).nodeValue;
				myTd.appendChild(myInput);
				//
				}else{
				
					var myInput=document.createElement(input_array.item(e).tagName);
					if(input_array.item(e).tagName=='select'){
					var option_array=input_array.item(e).getElementsByTagName('option');
					for(var f=0;f<option_array.length;f++){	//alert(option_array.item(f));				
						var myOption=document.createElement(option_array.item(f).tagName);						
						nseerElementEvent(option_array.item(f),myOption);						
						myOption.text=option_array.item(f).firstChild.nodeValue;						
						myInput.appendChild(myOption);
					}
					}
					nseerElementEvent(input_array.item(e),myInput);
					myTd.appendChild(myInput);
					}					
				}
			}
		}
	}

}
}catch(exception) { 
}
}
}


function nseerElementEvent(xml_obj,page_obj){//根据xml元素的属性，给javascript对象属性赋值

if(xml_obj.getAttribute('nseerDef')!='undefined'&&xml_obj.getAttribute('nseerDef')!=null&&xml_obj.getAttribute('nseerDef')!=''){page_obj.nseerDef=xml_obj.getAttribute('nseerDef');}
if(xml_obj.getAttribute('value')!='undefined'&&xml_obj.getAttribute('value')!=null&&xml_obj.getAttribute('value')!=''){page_obj.value=xml_obj.getAttribute('value');}
if(xml_obj.getAttribute('type')!='undefined'&&xml_obj.getAttribute('type')!=null&&xml_obj.getAttribute('type')!=''){page_obj.type=xml_obj.getAttribute('type');}
if(xml_obj.getAttribute('id')!='undefined'&&xml_obj.getAttribute('id')!=null&&xml_obj.getAttribute('id')!=''){page_obj.id=xml_obj.getAttribute('id');}
if(xml_obj.getAttribute('width')!='undefined'&&xml_obj.getAttribute('width')!=null&&xml_obj.getAttribute('width')!=''){page_obj.width=xml_obj.getAttribute('width');}
if(xml_obj.getAttribute('height')!='undefined'&&xml_obj.getAttribute('height')!=null&&xml_obj.getAttribute('height')!=''){page_obj.height=xml_obj.getAttribute('height');}
if(xml_obj.getAttribute('onfocus')!='undefined'&&xml_obj.getAttribute('onfocus')!=null&&xml_obj.getAttribute('onfocus')!=''){page_obj.onfocus = function(){
	eval(xml_obj.getAttribute('onfocus'));
};}
if(xml_obj.getAttribute('onblur')!='undefined'&&xml_obj.getAttribute('onblur')!=null&&xml_obj.getAttribute('onblur')!=''){page_obj.onblur = function(){
	eval(xml_obj.getAttribute('onblur'));
};}
if(xml_obj.getAttribute('onkeyup')!='undefined'&&xml_obj.getAttribute('onkeyup')!=null&&xml_obj.getAttribute('onkeyup')!=''){page_obj.onkeyup = function(){
	eval(xml_obj.getAttribute('onkeyup'));
};}
if(xml_obj.getAttribute('onkeydown')!='undefined'&&xml_obj.getAttribute('onkeydown')!=null&&xml_obj.getAttribute('onkeydown')!=''){function(){
	eval(page_obj.onkeydown = xml_obj.getAttribute('onkeydown'));
};}
if(xml_obj.getAttribute('onmouseover')!='undefined'&&xml_obj.getAttribute('onmouseover')!=null&&xml_obj.getAttribute('onmouseover')!=''){page_obj.onmouseover = function(){
	eval(xml_obj.getAttribute('onmouseover'));
};}
if(xml_obj.getAttribute('onmouseout')!='undefined'&&xml_obj.getAttribute('onmouseout')!=null&&xml_obj.getAttribute('onmouseout')!=''){page_obj.onmouseout = function(){
	eval(xml_obj.getAttribute('onmouseout'));
};}
if(xml_obj.getAttribute('onmouseup')!='undefined'&&xml_obj.getAttribute('onmouseup')!=null&&xml_obj.getAttribute('onmouseup')!=''){page_obj.onmouseup = function(){
	eval(xml_obj.getAttribute('onmouseup'));
};}
if(xml_obj.getAttribute('onmousedown')!='undefined'&&xml_obj.getAttribute('onmousedown')!=null&&xml_obj.getAttribute('onmousedown')!=''){page_obj.onmousedown = function(){
	eval(xml_obj.getAttribute('onmousedown'));
};}
if(xml_obj.getAttribute('class')!='undefined'&&xml_obj.getAttribute('class')!=null&&xml_obj.getAttribute('class')!=''){page_obj.className=xml_obj.getAttribute('class');}
if(xml_obj.getAttribute('onchange')!='undefined'&&xml_obj.getAttribute('onchange')!=null&&xml_obj.getAttribute('onchange')!=''){page_obj.onchange = function(){
	eval(xml_obj.getAttribute('onchange'));
};}
if(xml_obj.getAttribute('name')!='undefined'&&xml_obj.getAttribute('name')!=null&&xml_obj.getAttribute('name')!=''){page_obj.name=xml_obj.getAttribute('name');}
if(xml_obj.getAttribute('onclick')!='undefined'&&xml_obj.getAttribute('onclick')!=null&&xml_obj.getAttribute('onclick')!=''){page_obj.onclick=function (){eval(xml_obj.getAttribute('onclick'));}}
if(xml_obj.getAttribute('background')!='undefined'&&xml_obj.getAttribute('background')!=null&&xml_obj.getAttribute('background')!=''){page_obj.background=xml_obj.getAttribute('background');}
if(xml_obj.getAttribute('border')!='undefined'&&xml_obj.getAttribute('border')!=null&&xml_obj.getAttribute('border')!=''){page_obj.border=xml_obj.getAttribute('border');}
if(xml_obj.getAttribute('src')!='undefined'&&xml_obj.getAttribute('src')!=null&&xml_obj.getAttribute('src')!=''){page_obj.src=xml_obj.getAttribute('src');}
if(xml_obj.getAttribute('align')!='undefined'&&xml_obj.getAttribute('align')!=null&&xml_obj.getAttribute('align')!=''){page_obj.align=xml_obj.getAttribute('align');}
if(xml_obj.getAttribute('colspan')!='undefined'&&xml_obj.getAttribute('colspan')!=null&&xml_obj.getAttribute('colspan')!=''){page_obj.colspan=xml_obj.getAttribute('colspan');}
}

function createPage(xml_objs,parent_page_obj){//递归创建页面元素
	var obj_array=xml_objs.childNodes;
	for(var i=0;i<obj_array.length;i++){
		var myObj=document.createElement(obj_array.item(i).tagName);
		
		var nseer_name=obj_array.item(i).nodeValue;
		if (obj_array.item(i).tagName == 'table') {
			var myTbody = document.createElement('tbody');
			myObj.appendChild(myTbody);
			nseerElementEvent(obj_array.item(i), myObj);
			parent_page_obj.appendChild(myObj);
			if(parent_page_obj=document.body){myObj.style.filter='';}
			createPage(obj_array.item(i), myTbody);
		}
		else {
			if (typeof(obj_array.item(i).tagName) == 'undefined') {//如果该节点是文本内容(IE)
				if (obj_array.item(i).nodeValue.indexOf('demo.getLang') != -1) {//文本内容的多语种转换
					var text_temp = obj_array.item(i).nodeValue.Trim().substring(14);
					var group_name = text_temp.split(',')[0].substring(0, text_temp.split(',')[0].length - 1);
					nseer_name = text_temp.substring(group_name.length + 3).substring(0, text_temp.substring(group_name.length + 3).length - 2);
					DWREngine.setAsync(false);
					multiLangValidate.dwrGetLang(group_name, nseer_name, {
						callback: function(msg){
							nseer_name = msg;
						}
					});
					DWREngine.setAsync(true);
				}
				myObj.innerHTML = nseer_name;
			}
			else {
				nseerElementEvent(obj_array.item(i), myObj);
			}
			parent_page_obj.appendChild(myObj);
			createPage(obj_array.item(i), myObj);
		}
		//alert(myObj.currentStyle['height']);
	}
	
}