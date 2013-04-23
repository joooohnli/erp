/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
var time1;
var pie1;
//john
//删除字符串中的空格
String.prototype.Trim = function() 
{ 
return this.replace(/(^\s*)|(\s*$)/g, ""); 
} 

function draw_pie(time)
{
time1=time;
nseer_pie();
pie1=window.setInterval("nseer_pie();", 10000);
}
var data_length;
function nseer_pie() {
var xmlhttp2;
if (window.XMLHttpRequest)
		{
		xmlhttp2=new XMLHttpRequest();
		}
		else if (window.ActiveXObject)
		{
		xmlhttp2=new ActiveXObject("Microsoft.XMLHTTP");
		}
		if(xmlhttp2) {
			xmlhttp2.onreadystatechange = function() {
			if (xmlhttp2.readyState==4)
				{
				try {
					if(xmlhttp2.status==200) {
access_num1=0;
var link_div=xmlhttp2.responseText.split("^_^");
var i = 0;
var j = 0;
var name = new Array();
var amount = new Array();
var id =  new Array();
while(i < link_div.length-1) {
	//删除空格才能使后边的view_info1调用成功
	name[j] = link_div[i].toString().Trim();
	amount[j] = parseInt(link_div[i+1]);
	id[j] = link_div[i+2];
	i=i+3;
	j=j+1;
}
xxColor=new Array("#ccc","#b5cc88","#6B8E23","#3CB371","#f59d56","yellow","#d8d8d8","#708090","#4682B4","red","#ffc20e","#ccc","#b5cc88","#6B8E23","#3CB371","#f59d56","yellow","#d8d8d8","#708090","#4682B4","red","#ffc20e","#b5cc88","#6B8E23","#3CB371","#f59d56","yellow","#d8d8d8","#708090","#4682B4","red","#ffc20e","#ccc","#b5cc88","#6B8E23","#3CB371");	
var pie=new Nseer_Pie_Div('pieChart',780,400,'药品动态分析图');
data_length=name.length;
for(var i=0;i<data_length;i++){
dcake=new Array(name[i],amount[i],xxColor[i],id[i]);
pie.nseerPieS[i]=dcake;
}
pie.draw();
}else {
	alert( xmlhttp2.status + '=' + xmlhttp2.statusText);							
						}
					} catch(exception) {
						alert(exception);                         
					}
				}
			};
		xmlhttp2.open("POST", "query_data.jsp", true);
		xmlhttp2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xmlhttp2.send('');				
		} else {	        
	alert('Can not create XMLHttpRequest object, please check your web browser.');
}	
}