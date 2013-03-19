<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String key_mod=request.getParameter("key_mod");
String tablename=request.getParameter("tablename");
include.operateXML.Reading mask=new include.operateXML.Reading("xml/"+key_mod+"/"+tablename+".xml");
%>
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <form name="selectList" id="keyRegister" class="x-form" method="POST" action="../../../<%=key_mod%>_config_key_key_register_ok">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="key.jsp"></div></td>
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
 if($('keyRegister').childNodes.length<=1) return;
 col.value=col.value==cancelAll?selectAll:cancelAll;
}
function init(l,sl){
 var cols=l;
 sl.check.disabled=cols.childNodes.length>1?false:true;
 sl.check.value=selectAll;
}
window.onload=function(){
	init($("keyRegister"),document.selectList);
}
</SCRIPT>
<%try{
String sql="select * from security_publicconfig_key where tablename='"+tablename+"'";
ResultSet rs=crm_db.executeQuery(sql);
String key="";
if(rs.next()){
	key=","+rs.getString("column_group")+",";
}
%>
<input type="hidden" name="tablename" value="<%=tablename%>"> 
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" colspan=4><%=demo.getLang("erp","请选择用于关键字查询的字段")%>&nbsp;&nbsp;<INPUT onclick=selAll(this.form) type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","全选")%>" name=check>
&nbsp;</td> 
 </tr>
<% 
Vector columns=mask.getColumnAttributes("nick");
Vector columnse=mask.getColumnAttributes("name");
Vector services=mask.getColumnAttributes("service");
Vector usedTags=mask.getColumnAttributes("usedTag");
int n=0;
while(n<columns.size()){
if(!((String)services.elementAt(n)).equals("b")||((String)usedTags.elementAt(n)).equals("n")){
services.removeElementAt(n);
columnse.removeElementAt(n);
columns.removeElementAt(n);
usedTags.removeElementAt(n);
n--;
}
n++;
}
n=0;
while(n<columns.size()) {
	String service=(String)services.elementAt(n);
	if(key.indexOf(","+(String)columnse.elementAt(n)+",")!=-1){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=exchange.toHtml((String)columnse.elementAt(n))%>" checked><%=demo.getLang("erp",(String)columns.elementAt(n))%>&nbsp;</td>
<%}else{%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=exchange.toHtml((String)columnse.elementAt(n))%>"><%=demo.getLang("erp",(String)columns.elementAt(n))%>&nbsp;</td>
<%
}	
n++;
if(n<columns.size()){
	if(key.indexOf(","+(String)columnse.elementAt(n)+",")!=-1){
%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=exchange.toHtml((String)columnse.elementAt(n))%>" checked><%=demo.getLang("erp",(String)columns.elementAt(n))%>&nbsp;</td>
<%}else{%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=exchange.toHtml((String)columnse.elementAt(n))%>"><%=demo.getLang("erp",(String)columns.elementAt(n))%>&nbsp;</td>
<%
}	
}
n++;
if(n<columns.size()){
	if(key.indexOf(","+(String)columnse.elementAt(n)+",")!=-1){
%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=exchange.toHtml((String)columnse.elementAt(n))%>" checked><%=(String)columns.elementAt(n)%>&nbsp;</td> 
<%}else{%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=exchange.toHtml((String)columnse.elementAt(n))%>"><%=demo.getLang("erp",(String)columns.elementAt(n))%>&nbsp;</td>
<%
	}	
}
n++;
if(n<columns.size()){
	if(key.indexOf(","+(String)columnse.elementAt(n)+",")!=-1){
%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=exchange.toHtml((String)columnse.elementAt(n))%>" checked><%=demo.getLang("erp",(String)columns.elementAt(n))%>&nbsp;</td>

<%}else{%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=exchange.toHtml((String)columnse.elementAt(n))%>"><%=demo.getLang("erp",(String)columns.elementAt(n))%>&nbsp;</td>
<%
}	

}
n++;
%>
 </tr>
<%
}
crm_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
 </table>
  <input type="hidden" name="<%=Globals.TOKEN_KEY%>" 
 value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
</div>
