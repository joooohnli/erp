/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function getXmlObj(module_name,tableName){//读取xml文件,返回和传入的tableName对应的xml节点对象
var url=module_name+'/';
if (window.ActiveXObject){
var xmlHttp;
var xml_obj;
xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
try{
xmlHttp.onreadystatechange = function (){
if(xmlHttp.readyState == 4){
if(xmlHttp.status == 200 || xmlHttp.status == 0){

var xmlDOM = xmlHttp.responseXML; 
var treeToot = xmlDOM.documentElement;
var tree_root_tagName=treeToot.getElementsByTagName('table');
for(var i=0;i<tree_root_tagName.length;i++){	
		xml_obj=tree_root_tagName[i];
}
}
}
};
xmlHttp.open("GET", url+"tree-config.xml", false);
xmlHttp.send(null);
}catch(exception){ 
alert(exception);
} 
}else{
   var xmlDoc = XmlDocument.create();
	xmlDoc.async = false; 
	xmlDoc.load(url+"tree-config.xml");
	if (xmlDoc.documentElement == null) {
		alert("配置文件读取错误，请检查。");
		return null;
	}
	
	var treeToot = xmlDoc.documentElement; 
	var tree_root_tagName=treeToot.getElementsByTagName('table');
for(var i=0;i<tree_root_tagName.length;i++){
		xml_obj=tree_root_tagName[i];
}
}
return xml_obj;
}

function createButton(module_name,tableName){//调用getXmlObj()方法获得xml对象,再调用createButtonDiv()方法创建按钮层
var url=module_name+'/';
createButtonDiv(getXmlObj(module_name,tableName),url);
}

function createButtonDiv(xml_obj,url){//在createButton()中调用
	var add_brother_tag=0;add_child_tag=0;delete_tag=0;change_tag=0;search_tag=0;
	if(xml_obj.getAttribute('add-brother-node')!=null&&xml_obj.getAttribute('add-brother-node')!=''){add_brother_tag=1;}
	if(xml_obj.getAttribute('add-child-node')!=null&&xml_obj.getAttribute('add-child-node')!=''){add_child_tag=1;}
	if(xml_obj.getAttribute('delete-node')!=null&&xml_obj.getAttribute('delete-node')!=''){delete_tag=1;}
	if(xml_obj.getAttribute('change-node')!=null&&xml_obj.getAttribute('change-node')!=''){change_tag=1;}
	if(xml_obj.getAttribute('search-node')!=null&&xml_obj.getAttribute('search-node')!=''){search_tag=1;}
	if(add_brother_tag==1||add_child_tag==1||delete_tag==1||change_tag==1||search_tag==1){
	var myDiv1=document.createElement('div');
	myDiv1.className='treeButton';	
	var table1=document.createElement('table');
	//table1.className='button1';
	var tbody1=document.createElement('tbody');
	if(add_brother_tag==1){
		var tr1=document.createElement('tr');
		tr1.className='';
		var td1=document.createElement('td');
		td1.className='';
		var input1=document.createElement('input');
		input1.className='BUTTON_STYLE1';
		input1.type='button';
		input1.onclick = function(){
			showAddBrotherDiv(xml_obj.getAttribute('tree-name'),xml_obj.parentNode.getAttribute('css'),xml_obj.getAttribute('add-brother-node'),url);
		}		
		DWREngine.setAsync(false);
		multiLangValidate.dwrGetLang("erp",'添加同级',{callback:function(msg){input1.value=msg;}});
		DWREngine.setAsync(true);
		td1.appendChild(input1);
		tr1.appendChild(td1);
		tbody1.appendChild(tr1);
	}
	if(add_child_tag==1){
		var tr1=document.createElement('tr');
		tr1.className='';
		var td1=document.createElement('td');
		td1.className='';
		var input1=document.createElement('input');
		input1.className='BUTTON_STYLE1';
		input1.type='button';
		input1.onclick = function(){
			showAddChildDiv(xml_obj.getAttribute('tree-name'),xml_obj.parentNode.getAttribute('css'),xml_obj.getAttribute('add-brother-node'),url);
		}	
		DWREngine.setAsync(false);
		multiLangValidate.dwrGetLang("erp",'添加下级',{callback:function(msg){input1.value=msg;}});
		DWREngine.setAsync(true);
		td1.appendChild(input1);
		tr1.appendChild(td1);
		tbody1.appendChild(tr1);
	}
	if(delete_tag==1){	
		var tr1=document.createElement('tr');
		tr1.className='';
		var td1=document.createElement('td');
		td1.className='';
		var input1=document.createElement('input');
		input1.className='BUTTON_STYLE1';
		input1.type='button';
		input1.onclick = function(){
			showDeleteDiv(xml_obj.getAttribute('tree-name'),xml_obj.parentNode.getAttribute('css'),xml_obj.getAttribute('delete-node'),url);
		}
		DWREngine.setAsync(false);
		multiLangValidate.dwrGetLang("erp",'删除所选',{callback:function(msg){input1.value=msg;}});
		DWREngine.setAsync(true);
		td1.appendChild(input1);
		tr1.appendChild(td1);
		tbody1.appendChild(tr1);
	}
	if(change_tag==1){
		var tr1=document.createElement('tr');
		tr1.className='';
		var td1=document.createElement('td');
		td1.className='';
		var input1=document.createElement('input');
		input1.className='BUTTON_STYLE1';
		input1.type='button';
		input1.onclick = function(){
			showChangeDiv(xml_obj.getAttribute('tree-name'),xml_obj.parentNode.getAttribute('css'),xml_obj.getAttribute('change-node'),url);
		}
		DWREngine.setAsync(false);
		multiLangValidate.dwrGetLang("erp",'修改所选',{callback:function(msg){input1.value=msg;}});
		DWREngine.setAsync(true);
		td1.appendChild(input1);
		tr1.appendChild(td1);
		tbody1.appendChild(tr1);
	}
	if(search_tag==1){
		var tr1=document.createElement('tr');
		tr1.className='';
		var td1=document.createElement('td');
		td1.className='';
		var input1=document.createElement('input');
		input1.className='BUTTON_STYLE1';
		input1.type='button';
		input1.onclick = function(){
			showQueryDiv(xml_obj.getAttribute('tree-name'),xml_obj.parentNode.getAttribute('css'),xml_obj.getAttribute('search-node'),url);
		}
		DWREngine.setAsync(false);
		multiLangValidate.dwrGetLang("erp",'快速查询',{callback:function(msg){input1.value=msg;}});
		DWREngine.setAsync(true);
		td1.appendChild(input1);
		tr1.appendChild(td1);
		tbody1.appendChild(tr1);
	}
	table1.appendChild(tbody1);
	myDiv1.appendChild(table1);
	document.getElementById('nseer1').appendChild(myDiv1);
	//document.body.appendChild(myDiv1);
	}
}