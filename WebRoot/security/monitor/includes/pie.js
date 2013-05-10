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
var link_div_date='';
link_div_date=xmlhttp2.responseText.split("★");
var link_element_date=link_div_date[1].split(",");
element_link=new Array(link_element_date.length);
for(var j=0;j<link_element_date.length;j++){
element_link[j]=link_element_date[j];
}
var text='';
text=link_div_date[0].split("^_^");
var static_array_text='';
static_array_text=text[0].split(",");
var static_array = new Array(static_array_text.length); 
for(var i=0;i<static_array_text.length;i++)
{
static_array[i]=static_array_text[i];
}
var data_text='';
data_text=text[1].split("<$$>");
var href_text='';
href_text=data_text[1].split(",");
//alert(href_text);
var array1 = new Array(href_text.length); 
for(var i=0;i<href_text.length;i++)
{
array1[i]=parseInt(href_text[i]);
}

xxColor=new Array("#ccc","#b5cc88","#6B8E23","#3CB371","#f59d56","yellow","#d8d8d8","#708090","#4682B4","red","#ffc20e","#ccc","#b5cc88","#6B8E23","#3CB371","#f59d56","yellow","#d8d8d8","#708090","#4682B4","red","#ffc20e","#b5cc88","#6B8E23","#3CB371","#f59d56","yellow","#d8d8d8","#708090","#4682B4","red","#ffc20e","#ccc","#b5cc88","#6B8E23","#3CB371");	
var pie=new Nseer_Pie_Div('pieChart',780,400,'欢迎使用川大科技系统访问分析图('+time1+')');
data_length=static_array.length
for(var i=0;i<static_array.length;i++){

dcake=new Array(static_array[i],parseInt(array1[i]),xxColor[i]);
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