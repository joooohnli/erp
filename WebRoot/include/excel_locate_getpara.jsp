<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.excel_export.ExcelWriter"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String export_mod=request.getParameter("export_mod");
String export_type=request.getParameter("export_type");
String[] cols=request.getParameterValues("col");
if(cols==null){
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" style="width: 50; " onClick=location="<%=export_type%>.jsp"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","对不起，您没有选择导出条目，请返回选择！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
</div>
<%}else{
String tablename=request.getParameter("tablename");
String tablenick=request.getParameter("tablenick");
try{
ExcelWriter ex=new ExcelWriter();
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
ex.CreExcel((String)session.getAttribute("unit_db_name"),tablename,tablenick,cols,path+"excel_files/"+export_mod+"_data.xls");
}catch(Exception ex){ex.printStackTrace();}
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<table class="TABLE_STYLE2">
 <tr class="TR_STYLE1">
 <td class="TD_STYLE3">&nbsp;</td>
 <td class="TD_STYLE3">
 <div class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","下载")%>" onClick=location="<%=export_type%>_down.jsp?export_mod=<%=export_mod%>&&export_type=<%=export_type%>"> 
 <input type="button" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" name="B5" onClick=location="<%=export_type%>.jsp"></div>
 </td>
 </tr>
</table>
<table class="TABLE_STYLE2">
 <tr class="TR_STYLE1">
 <td class="TD_STYLE3">
 <%=demo.getLang("erp","数据输出文件已成功生成，请下载。")%></td>
 <td class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
</div>
<%
}
%>