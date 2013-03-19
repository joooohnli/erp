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
<%
try{
String[] cols=request.getParameterValues("col");
String[] nicks=request.getParameterValues("nick");
String[] reqs=request.getParameterValues("req");
String[] colnames=request.getParameterValues("colname");



for(int i=1;i<=20;i++) {
OperateXML.editXML(file,"name","c_define"+i,"usedTag","n");

}
if(cols!=null){
for(int i=0;i<cols.length;i++) {
OperateXML.editXML(file,"name",cols[i],"usedTag","y");
}
}
if(nicks!=null){
for(int i=1;i<=nicks.length;i++) {
if(nicks[i-1].equals("")){
OperateXML.editXML(file,"name","c_define"+i,"nick","未命名");
}else{
	OperateXML.editXML(file,"name","c_define"+i,"nick",nicks[i-1]);
}
}
}

for(int i=0;i<colnames.length;i++) {
OperateXML.editXML(file,"name",colnames[i],"required","n");
OperateXML.editXML(file,"name",colnames[i],"validate","n");
}
String str=",";
if(reqs!=null){
for(int i=0;i<reqs.length;i++) {
str+=reqs[i]+",";
OperateXML.editXML(file,"name",reqs[i],"required","y");
OperateXML.editXML(file,"name",reqs[i],"validate","y");
}
}

for(int i=0;i<colnames.length;i++) {
if(str.indexOf(colnames[i])!=-1){
Deleting.delDepXML(file,"name",colnames[i],"name","required");
String[] v_value={"name:required"};
Inserting.addDepXML(file,"name",colnames[i],v_value);
}else{
Deleting.delDepXML(file,"name",colnames[i],"name","required");
}
}

 OperateXML.close();
response.sendRedirect(currentPage);
}catch(Exception ex){
 ex.printStackTrace();
}
%>