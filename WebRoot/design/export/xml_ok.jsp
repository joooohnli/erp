<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="java.text.*" import="javax.servlet.*,javax.servlet.http.*" import="com.xml.export.*"
import="include.excel_export.excel_three,include.get_sql.getKeyColumn"%>

<jsp:useBean id="query" scope="page" class="include.excel_export.excel"/>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@include file="../include/head.jsp"%>
<%
try{
String sql="";
String condition="";
String queue="";
String tablename=request.getParameter("tablename");
String dbase=(String)session.getAttribute("unit_db_name");
String realname=(String)session.getAttribute("realeditorc");
String[] cols=(String[])session.getAttribute("cols");
String[] colsNames=new String[cols.length];
for(int i=0;i<cols.length;i++){
colsNames[i]=cols[i].split("⊙")[1]+"/"+cols[i].split("⊙")[2];
}
if(tablename.equals("design_file")){
condition="where check_tag='1'";
queue="order by register_time";
}
sql="select * from "+tablename+" "+condition+" "+queue;
int a=sql.indexOf("where");
sql=sql.substring(a,sql.length());
XmlFactory xml= new XmlFactory("conf/xml/design/file_export.xml",dbase,tablename,colsNames,"conf/xml/design/data_excel.xml",sql);
xml.makeElement();
xml.Xmlwrite();
session.removeAttribute("cols");
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","下载")%>" onClick=location="xml_down.jsp">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" name="B5" onClick=location="xml.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数据输出文件已成功生成，请下载。")%></td>
 </tr>
 </table>
 </div>
 <%}catch(Exception ex){ex.printStackTrace();}%>