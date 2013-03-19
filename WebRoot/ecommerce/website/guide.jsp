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
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>

<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db ecommerce_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form name="selectList" id="keyRegister" class="x-form" method="POST" action="../../ecommerce_website_guide_ok">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>"></div></td>
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
 if(obj.elements[i].tagName.toLowerCase()=="input" && obj.elements[i].type=="checkbox" && obj.elements[i].name=="col"){
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
<%
String unit_id=(String)session.getAttribute("unit_id");
String sql="select * from ecommerce_cols_top where unit_id='"+unit_id+"'";
ResultSet rs=ecommerce_db.executeQuery(sql);
String key="";
while(rs.next()){
	key=key+","+rs.getString("first_kind_ID")+",";
}
%>

<input type="hidden" name="unit_id" value="<%=unit_id%>">
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" colspan=4><%=demo.getLang("erp","请选择上部导航栏")%>&nbsp;&nbsp;<INPUT onclick=selAll(this.form) type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","全选")%>" name=check>
&nbsp;</td> 
 </tr>
<% 
int n=0;
String sql1="select * from ecommerce_config_cols_first order by first_kind_ID";
ResultSet rs1=ecommerce_db.executeQuery(sql1);
while(rs1.next()) {
	if(key.indexOf(","+rs1.getString("first_kind_ID")+",")!=-1){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=rs1.getString("first_kind_ID")%>~<%=exchange.toHtml(rs1.getString("first_kind_name"))%>" checked><%=demo.getLang("erp",rs1.getString("first_kind_name"))%>&nbsp;</td>
<%}else{%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=rs1.getString("first_kind_ID")%>~<%=exchange.toHtml(rs1.getString("first_kind_name"))%>"><%=demo.getLang("erp",rs1.getString("first_kind_name"))%>&nbsp;</td>
<%
}	
n++;
if(rs1.next()){
	if(key.indexOf(","+rs1.getString("first_kind_ID")+",")!=-1){
%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=rs1.getString("first_kind_ID")%>~<%=exchange.toHtml(rs1.getString("first_kind_name"))%>" checked><%=demo.getLang("erp",rs1.getString("first_kind_name"))%>&nbsp;</td>
<%}else{%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=rs1.getString("first_kind_ID")%>~<%=exchange.toHtml(rs1.getString("first_kind_name"))%>"><%=demo.getLang("erp",rs1.getString("first_kind_name"))%>&nbsp;</td>
<%
}	
}
n++;
if(rs1.next()){
	if(key.indexOf(","+rs1.getString("first_kind_ID")+",")!=-1){
%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=rs1.getString("first_kind_ID")%>~<%=exchange.toHtml(rs1.getString("first_kind_name"))%>" checked><%=demo.getLang("erp",rs1.getString("first_kind_name"))%>&nbsp;</td>
<%}else{%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=rs1.getString("first_kind_ID")%>~<%=exchange.toHtml(rs1.getString("first_kind_name"))%>"><%=demo.getLang("erp",rs1.getString("first_kind_name"))%>&nbsp;</td>
<%
	}	
}
n++;
if(rs1.next()){
	if(key.indexOf(","+rs1.getString("first_kind_ID")+",")!=-1){
%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=rs1.getString("first_kind_ID")%>~<%=exchange.toHtml(rs1.getString("first_kind_name"))%>" checked><%=demo.getLang("erp",rs1.getString("first_kind_name"))%>&nbsp;</td>
 </tr>
<%}else{%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col" value="<%=rs1.getString("first_kind_ID")%>~<%=exchange.toHtml(rs1.getString("first_kind_name"))%>"><%=demo.getLang("erp",rs1.getString("first_kind_name"))%>&nbsp;</td>
	 </tr>
<%
}	
}
n++;
}
%>
 </table>
<p>&nbsp;&nbsp;</p>
 
 <%
sql="select * from ecommerce_cols_bottom where unit_id='"+unit_id+"'";
rs=ecommerce_db.executeQuery(sql);
key="";
while(rs.next()){
	key=key+","+rs.getString("first_kind_ID")+",";
}
%>

 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" colspan=4><%=demo.getLang("erp","请选择下部导航栏")%>&nbsp;&nbsp;<INPUT onclick=selAll2(this.form) type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","全选")%>" name="check2">
&nbsp;</td> 
 </tr>
<% 
n=0;
sql1="select * from ecommerce_config_cols_first order by first_kind_ID";
rs1=ecommerce_db.executeQuery(sql1);
while(rs1.next()) {
	if(key.indexOf(","+rs1.getString("first_kind_ID")+",")!=-1){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col2" value="<%=rs1.getString("first_kind_ID")%>~<%=exchange.toHtml(rs1.getString("first_kind_name"))%>" checked><%=demo.getLang("erp",rs1.getString("first_kind_name"))%>&nbsp;</td>
<%}else{%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col2" value="<%=rs1.getString("first_kind_ID")%>~<%=exchange.toHtml(rs1.getString("first_kind_name"))%>"><%=demo.getLang("erp",rs1.getString("first_kind_name"))%>&nbsp;</td>
<%
}	
n++;
if(rs1.next()){
	if(key.indexOf(","+rs1.getString("first_kind_ID")+",")!=-1){
%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col2" value="<%=rs1.getString("first_kind_ID")%>~<%=exchange.toHtml(rs1.getString("first_kind_name"))%>" checked><%=demo.getLang("erp",rs1.getString("first_kind_name"))%>&nbsp;</td>
<%}else{%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col2" value="<%=rs1.getString("first_kind_ID")%>~<%=exchange.toHtml(rs1.getString("first_kind_name"))%>"><%=demo.getLang("erp",rs1.getString("first_kind_name"))%>&nbsp;</td>
<%
}	
}
n++;
if(rs1.next()){
	if(key.indexOf(","+rs1.getString("first_kind_ID")+",")!=-1){
%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col2" value="<%=rs1.getString("first_kind_ID")%>~<%=exchange.toHtml(rs1.getString("first_kind_name"))%>" checked><%=demo.getLang("erp",rs1.getString("first_kind_name"))%>&nbsp;</td>
<%}else{%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col2" value="<%=rs1.getString("first_kind_ID")%>~<%=rs1.getString("first_kind_name")%>"><%=demo.getLang("erp",rs1.getString("first_kind_name"))%>&nbsp;</td>
<%
	}	
}
n++;
if(rs1.next()){
	if(key.indexOf(","+rs1.getString("first_kind_ID")+",")!=-1){
%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col2" value="<%=rs1.getString("first_kind_ID")%>~<%=exchange.toHtml(rs1.getString("first_kind_name"))%>" checked><%=demo.getLang("erp",rs1.getString("first_kind_name"))%>&nbsp;</td>
 </tr>
<%}else{%>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><input type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="col2" value="<%=rs1.getString("first_kind_ID")%>~<%=exchange.toHtml(rs1.getString("first_kind_name"))%>"><%=demo.getLang("erp",rs1.getString("first_kind_name"))%>&nbsp;</td>
	 </tr>
<%
}	
}
n++;
}
ecommerce_db.close();
%>
 </table>
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
</div>


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

function selAll2(obj){
	var col=obj.elements["check2"];
 for(var i=0;i<obj.elements.length;i++){
 if(obj.elements[i].tagName.toLowerCase()=="input" && obj.elements[i].type=="checkbox" && obj.elements[i].name=="col2"){
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