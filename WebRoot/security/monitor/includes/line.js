/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
var line1;
function demo() {
	demo3();
	line1=window.setInterval("demo3();", 10000);//刷新频率
}

var href_data;
function demo3() {
var xmlhttp2;
href_data=false;
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

access_num=0;
nn=0;
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
var array1 = new Array(href_text.length); 

var nub=0;
for(var i=0;i<href_text.length;i++)
{
array1[i]=parseInt(href_text[i]);
if(array1[i]>nub)nub=array1[i];
}

if(nub<=30)y_horiz=nub;
if(nub>30)y_horiz=30;
var c = new Chart(document.getElementById('chart3'));
c.setDefaultType(CHART_LINE);
c.setHorizontalLabels(static_array);
c.setShowLegend(false);
c.add(data_text[0], '#4040FF', array1);

c.draw();
}else {
alert( xmlhttp2.status + '=' + xmlhttp2.statusText);							
						}
					} catch(exception) {
						alert(exception);                         
					}
				}
			};
		xmlhttp2.open("POST", "query_data_line.jsp", true);
		xmlhttp2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xmlhttp2.send('');				
		} else {	        
 alert('Can not create XMLHttpRequest object, please check your web browser.');
}	
}

