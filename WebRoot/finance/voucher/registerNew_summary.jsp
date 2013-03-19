<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%counter count=new counter(application);%>
<%@include file="../include/head.jsp"%>
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
 <jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<html> 
<script language="javascript" src="onlineEditTable.js"></script>
<script language="JavaScript"> 
var sign=0; 
 var table=window.opener.document.getElementById('tableOnlineEdit');
 
function writer(obj,offset){ 
 var value=obj.options[obj.selectedIndex].value;
 var paravalue=getParameterFromHref(window.location.href,'jsparameter'); 
 if (paravalue!="") {
 var td=window.opener.document.mutiValidation.elements[eval(paravalue+offset)];
 td.value=value;
 }
}

function writer2(obj,offset){ 
 var value=obj.options[obj.selectedIndex].value;
 var paravalue=getParameterFromHref(window.location.href,'jsparameter2'); 
 if (paravalue!="") {
 var td=window.opener.document.mutiValidation.elements[eval(paravalue+offset)];
 td.value=value;
 }
}

//从href中获得指定参数的值，来完成页面间参数传递的作用
function getParameterFromHref(sHref, parameterName)
{
 var args = sHref.split("?");
 var retval = "";
 
 if(args[0] == sHref) /*参数为空*/
 {
  return retval; /*无需做任何处理*/
 } 
 var str = args[1];
 args = str.split("&");
 for(var i = 0; i < args.length; i ++)
 {
 str = args[i];
 var arg = str.split("=");
 if(arg.length <= 1) continue;
 if(arg[0] == parameterName) retval = arg[1]; 
 }
 return retval;
} 
</script>
<div id="nseerGround" class="nseerGround">
<form id="form" class="x-form">    
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1">
 <tr> 
      <td <%=TD_STYLE11%> class="TD_STYLE1" width="30%" valign="top"><%=demo.getLang("erp","请选择凭证摘要")%></td>
      <td <%=TD_STYLE21%> class="TD_STYLE2" width="70%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="t0" onchange="writer(this,-1)" style="width: 60%;">
<option value="">
<%      
       String sql = "select * from finance_config_summary_first_kind ";
       ResultSet rs = finance_db.executeQuery(sql) ;
while(rs.next()){
%>
<option value="<%=exchange.toHtml(rs.getString("first_kind_name"))%>"><%=exchange.toHtml(rs.getString("first_kind_name"))%>
<%}%>
</select>
</tr>
  </table> 
<input name="dd" id="trId" value="dd" type="hidden">
</form>
</div>
<%finance_db.close();%>