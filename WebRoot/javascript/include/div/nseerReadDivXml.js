/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function XmlDocument() {}
XmlDocument.create = function () {//firefox读取xml文件时使用
	if (document.implementation && document.implementation.createDocument) {
		return document.implementation.createDocument("", "", null);
	} 
}

function readXml(url){//读取xml文件,生成表单
DWREngine.setAsync(false);
Multi.readXmlToHtml(url,{callback:function(html){
	var div_id=html.split('◎')[0];
	if(document.getElementById(div_id)!=null&&document.getElementById(div_id).style.display=='none'){document.getElementById(div_id).style.display='block';return true;}
	var div1=document.createElement('div')
	div1.id=div_id;
	div1.innerHTML=html.split('◎')[1];
	document.body.appendChild(div1);
	}});
DWREngine.setAsync(true);
}