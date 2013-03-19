<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java"%>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/tabs.css">
<script>
function changeTab(nseer_d){
	for(var i=0;i<5;i++){
		if(document.getElementById('nseer'+i)!=null&&document.getElementById('nseer'+i)!='undefined'){
			document.getElementById('nseer'+i).style.display='none';
		}
	}
	var div_obj=document.getElementById('Tabs0');
	var lis=div_obj.getElementsByTagName('li');
	for(var i=0;i<lis.length;i++){lis[i].id='';}
	lis[parseInt(nseer_d.substring(5))].id='main_cur';
	document.getElementById(nseer_d).style.display='block';
	document.getElementById('Tabs0').blur();
}
</script>
<%
try{
Vector columns1=mask.getColumnAttributes("usedTag");
Vector columns=mask.getColumnAttributes("nick");
Vector names=mask.getColumnAttributes("name");
Vector services=mask.getColumnAttributes("service");
Vector requireds=mask.getColumnAttributes("required");
Vector types=mask.getColumnAttributes("type");
List usedTagIndex = (List)new java.util.ArrayList();

int n=0;
while(n<columns1.size()) {
String usedTag=(String)columns1.elementAt(n);
String service=(String)services.elementAt(n);
if(usedTag.equals("y")&&(service.equals("b")||service.equals("p"))){usedTagIndex.add(n);}
n++;
}
if(usedTagIndex.size()!=0){
%>
<ul>
<li><a href="javascript:changeTab('nseer4');"><span><%=demo.getLang("erp","自定义信息")%></span></a></li>
</ul>
<%
}
}
		catch(Exception e){
		e.printStackTrace();
		}
%>