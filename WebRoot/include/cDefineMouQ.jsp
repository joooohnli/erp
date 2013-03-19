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
<tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","自定义信息")%></div></td></tr>
<%
}
if(usedTagIndex.size()%2!=0) usedTagIndex.add(-1);
for(int i=0;i<usedTagIndex.size();i=i+2) {
	String required=(String)requireds.elementAt((Integer)usedTagIndex.get(i));
	String valuei="";
	if(rs.getString((String)names.elementAt((Integer)usedTagIndex.get(i))).indexOf("1800-01-01")==-1&&((String)types.elementAt((Integer)usedTagIndex.get(i))).equals("时间")){
		valuei=rs.getString((String)names.elementAt((Integer)usedTagIndex.get(i)));
	}else if(rs.getString((String)names.elementAt((Integer)usedTagIndex.get(i))).indexOf("1800-01-01")==-1&&((String)types.elementAt((Integer)usedTagIndex.get(i))).equals("数值")){
		valuei=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble((String)names.elementAt((Integer)usedTagIndex.get(i))));
	}else{
		valuei=rs.getString((String)names.elementAt((Integer)usedTagIndex.get(i)));
	}
	%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp",(String)columns.elementAt((Integer)usedTagIndex.get(i)))%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=valuei%></td>
<%if((Integer)usedTagIndex.get(i+1)!=-1){
		required=(String)requireds.elementAt((Integer)usedTagIndex.get(i+1));
		if(rs.getString((String)names.elementAt((Integer)usedTagIndex.get(i+1))).indexOf("1800-01-01")==-1&&((String)types.elementAt((Integer)usedTagIndex.get(i+1))).equals("时间")){
		valuei=rs.getString((String)names.elementAt((Integer)usedTagIndex.get(i+1)));
	}else if(rs.getString((String)names.elementAt((Integer)usedTagIndex.get(i+1))).indexOf("1800-01-01")==-1&&((String)types.elementAt((Integer)usedTagIndex.get(i+1))).equals("数值")){
		valuei=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble((String)names.elementAt((Integer)usedTagIndex.get(i+1))));
	}else{
		valuei=rs.getString((String)names.elementAt((Integer)usedTagIndex.get(i+1)));
	}
		%>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp",(String)columns.elementAt((Integer)usedTagIndex.get(i+1)))%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=valuei%></td>
 <%}else{%>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%">&nbsp;</td>
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