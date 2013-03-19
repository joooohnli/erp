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
Vector columns1=mask.getColumnAttributes("usedTag");
Vector columns=mask.getColumnAttributes("nick");
Vector names=mask.getColumnAttributes("name");
Vector services=mask.getColumnAttributes("service");
Vector requireds=mask.getColumnAttributes("required");

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
<tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","自定义信息")%></div></td></tr>
<%
}
if(usedTagIndex.size()%2!=0) usedTagIndex.add(-1);
for(int i=0;i<usedTagIndex.size();i=i+2) {
	String required=(String)requireds.elementAt((Integer)usedTagIndex.get(i));
	%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%if(required.equals("y")){%><font color=red>*</font><%}%><%=demo.getLang("erp",(String)columns.elementAt((Integer)usedTagIndex.get(i)))%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" style="width:49%" name="<%=exchange.toHtml((String)names.elementAt((Integer)usedTagIndex.get(i)))%>" ></td>
<%if((Integer)usedTagIndex.get(i+1)!=-1){
		required=(String)requireds.elementAt((Integer)usedTagIndex.get(i+1));
		%>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%"><%if(required.equals("y")){%><font color=red>*</font><%}%><%=demo.getLang("erp",(String)columns.elementAt((Integer)usedTagIndex.get(i+1)))%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><input name="<%=exchange.toHtml((String)names.elementAt((Integer)usedTagIndex.get(i+1)))%>" type="text" width="100%" ></td>
 <%}else{%>
 <td <%=TD_STYLE4%> class="TD_STYLE1" width="11%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%">&nbsp;</td>
 <%}%>
 </tr>
<%
}
}
		catch(Exception e){
		e.printStackTrace();
		}
%>