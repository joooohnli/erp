<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*" import="java.text.*" import="java.util.Vector"%>
<%
String export_mod=request.getParameter("export_mod");
String export_type=request.getParameter("export_type");
String table=request.getParameter("data");
String tablename=table.split("⊙")[0];
String tablenick=table.split("⊙")[1];
include.operateXML.Reading mask=new include.operateXML.Reading("xml/"+export_mod+"/"+tablename+".xml");
%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form name="selectList" id="timeLocateValidation" class="x-form" method="post" action="<%=export_type%>_locate_getpara.jsp">
<input type="hidden" name="export_mod" value="<%=export_mod%>">
<input type="hidden" name="export_type" value="<%=export_type%>">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确定")%>"> <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="<%=export_type%>.jsp"></div>
 </td>
 </tr>
 </table>
<SCRIPT language="javascript">
function $() {
 var elements = new Array();
 for (var i = 0; i < arguments.length; i++) {
 var element = arguments[i];
 if (typeof element == 'string')
 element = document.getElementById(element);
 if (arguments.length == 1) 
 return element;
 elements.push(element);
 }
 return elements;
}
var selectAll='<%=demo.getLang("erp","全选")%>';
var cancelAll='<%=demo.getLang("erp","取消")%>';

function selAll(obj){
	var col=obj.elements["check"];
 for(var i=0;i<obj.elements.length;i++){
 if(obj.elements[i].tagName.toLowerCase()=="input" && obj.elements[i].type=="checkbox"){
 if(col.value==selectAll){
 obj.elements[i].checked=true;
 }else{
 obj.elements[i].checked=false;
 }
  
 }
 } 
 if($('timeLocateValidation').childNodes.length<=1) return;
 col.value=col.value==cancelAll?selectAll:cancelAll;
}

function init(l,sl){
 var cols=l;
 sl.check.disabled=cols.childNodes.length>1?false:true;
 sl.check.value=selectAll;
}
window.onload=function(){
	init($("timeLocateValidation"),document.selectList);
}
</SCRIPT>
<input type="hidden" name="tablename" value="<%=tablename%>">
 <input type="hidden" name="tablenick" value="<%=tablenick%>">

 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" colspan=4><%=demo.getLang("erp","请选择要导出的字段")%>&nbsp;&nbsp;<INPUT onclick="selAll(this.form)" type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","全选")%>" name=check>
&nbsp;</td> 
 </tr>
  
<% 
Vector nicks=mask.getColumnAttributes("nick");
Vector names=mask.getColumnAttributes("name");
Vector Ttypes=mask.getColumnAttributes("Ttype");
Vector services=mask.getColumnAttributes("service");
Vector usedTags=mask.getColumnAttributes("usedTag");
int n=0;
while(n<nicks.size()) {
if(!((String)services.elementAt(n)).equals("b")||((String)usedTags.elementAt(n)).equals("n")){
nicks.removeElementAt(n);
names.removeElementAt(n);
Ttypes.removeElementAt(n);
services.removeElementAt(n);
usedTags.removeElementAt(n);
n--;
}
n++;
}
n=0;
while(n<nicks.size()) {
if(((String)services.elementAt(n)).equals("b")){
     String name=(String)names.elementAt(n);
	  String nick=(String)nicks.elementAt(n);
	  String Ttype=(String)Ttypes.elementAt(n);
	  String str=Ttype+"⊙"+name+"⊙"+nick;
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=exchange.toHtml(str)%>"><%=demo.getLang("erp",nick)%>&nbsp;</td>
<%n++;
if(n<nicks.size()){
name=(String)names.elementAt(n);
nick=(String)nicks.elementAt(n);
Ttype=(String)Ttypes.elementAt(n);
str=Ttype+"⊙"+name+"⊙"+nick;
%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=exchange.toHtml(str)%>"><%=demo.getLang("erp",nick)%>&nbsp;</td>
<%}
n++;
if(n<nicks.size()){
name=(String)names.elementAt(n);
nick=(String)nicks.elementAt(n);
Ttype=(String)Ttypes.elementAt(n);
str=Ttype+"⊙"+name+"⊙"+nick;
%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=exchange.toHtml(str)%>"><%=demo.getLang("erp",nick)%>&nbsp;</td> 
<%}
n++;
if(n<nicks.size()){
name=(String)names.elementAt(n);
nick=(String)nicks.elementAt(n);
Ttype=(String)Ttypes.elementAt(n);
str=Ttype+"⊙"+name+"⊙"+nick;
%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=exchange.toHtml(str)%>"><%=demo.getLang("erp",nick)%>&nbsp;</td>
 </tr>
<%}}
n++;
}%>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="10"></td>
 </tr>
 </table>
</form>