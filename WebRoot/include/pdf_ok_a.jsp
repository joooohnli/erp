<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="java.text.*" import="javax.servlet.*,javax.servlet.http.*"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1" colspan="2"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td>
<div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" name="B5" onClick=location="pdf.jsp">
 </td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <%
String file_amount=request.getParameter("file_amount");
if(file_amount.equals("0")){
%>
 <td><%=demo.getLang("erp","所选数据表无数据，请返回！")%> 
<%}else{%>
 <td><%=demo.getLang("erp","数据输出文件已成功生成，请下载。")%> 
<%}%>
 </td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
for(int i=1;i<=Integer.parseInt(file_amount);i++){
	String filename=pdf_mod+"_data"+i+".pdf";
	%>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><a href="pdf_down.jsp?filename=<%=filename%>"><%=demo.getLang("erp","下载")%><%=i%>：<%=filename%></a></td>
	<%
}
%>
</tr>
</table>
</div>