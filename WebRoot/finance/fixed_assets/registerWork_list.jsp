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
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="query" scope="page" class="include.query.query"/>

<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String table_width="100%";
try{
String file_id=(String)session.getAttribute("file_id");
String kind_id=(String)session.getAttribute("kind_id");
String kind_name=(String)session.getAttribute("kind_name");
String type_id=(String)session.getAttribute("type_id");
String type_name=(String)session.getAttribute("type_name");
String dbase=(String)session.getAttribute("unit_db_name");
String tablename="finance_fa_file";
String fieldName1="currency";
String fieldName2="file_id";
String fieldName3="type_id";
String fieldName4="department_id";
String fieldName5="exchange_rate";//finance_fa_change表中任意两字段
String condition="work_total!=''";
String queue="order by file_id";
ResultSet rs=query.queryDB(dbase,tablename,"","",file_id,kind_id,type_id,"",fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition,queue,"");

int intRowCount=query.intRowCount();
%>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<script type="text/javascript" src="../../javascript/finance/fixed_assets/registerWork_locate.js"></script>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","提交")%>" onClick="send()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="registerWork_locate.jsp"></div></td>
 </tr>
 </table>
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td align="center"><font size="4"><b><%=demo.getLang("erp","工作量登记单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" id="theObjTable">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","固定资产编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="180"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","固定资产名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="100"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","规格型号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="80"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","工作总量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="80"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","累计工作量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="80"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","工作量单位")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="80"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","剩余工作量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="80"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","本月工作量")%></td>
 </tr>
 <%
 int i=0;
 String work_sum="";
 while(rs.next()){
 	if(rs.getString("work_sum").equals("")){
 	work_sum="0";
 	}else{
 	work_sum=rs.getString("work_sum");
 	}
 	double surplus=Double.parseDouble(rs.getString("work_total"))-Double.parseDouble(work_sum);
  %>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="hidden" id="fiel_id" value="<%=rs.getString("file_id")%>"><%=rs.getString("file_id")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs.getString("file_name"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("specification")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("work_total")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("work_sum")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs.getString("work_unit")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=surplus%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" value="<%=rs.getString("work_month")%>" id="work_month<%=i%>" onblur="work_month1(this.id);"></td>
 
 <input type="hidden" id="surplus<%=i%>" value="<%=surplus%>">
 </tr>
 <%
 i++;
 }%>
</table>
<%@include file="../include/paper_bottom.html"%> 
</div>
<%
finance_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>