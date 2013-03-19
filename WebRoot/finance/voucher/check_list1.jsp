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
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
 <jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<%
try{
	String sql = "select distinct voucher_in_month_id,attachment_amount,debit_sum,loan_sum,register,register_time from finance_voucher where check_tag='0' and account_period<'16' order by register_time" ;
	ResultSet rs = finance_db.executeQuery(sql) ;
	int intRowCount = query.count((String)session.getAttribute("unit_db_name"),sql);
String strPage=request.getParameter("page");
if(strPage!=null&&!strPage.equals("")&&!validata.validata(strPage)){
	strPage="";
}
if(intRowCount!=0){
	session.setAttribute("task_content","none");
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%>  class="TD_STYLE3"><%=demo.getLang("erp","等待审核：")%><%=intRowCount%><%=demo.getLang("erp","例")%></td>
 </tr>
 </table>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","凭证号")%>'},
                       {name: '<%=demo.getLang("erp","审核")%>'}
                  ]
nseer_grid.column_width=[180,180];
nseer_grid.auto='<%=demo.getLang("erp","凭证号")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
	['<%=rs.getString("voucher_in_month_ID")%>','<div style="text-decoration : underline;color:#3366FF" onclick=winopen("check.jsp?voucher_in_month_id=<%=rs.getString("voucher_in_month_id")%>&&register_time=<%=rs.getString("register_time")%>")><%=demo.getLang("erp","审核")%></div>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%
	}else{
	%>
<table valign="center">
<tr>
<td>&nbsp;</td>
</tr>
<tr>
<td><%session.removeAttribute("task_content");%></td>
</tr>
</table>
<%
	}	
finance_db.close();
 }catch(Exception tt){tt.printStackTrace();}
%>