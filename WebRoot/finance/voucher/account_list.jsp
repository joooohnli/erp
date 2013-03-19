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
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<%
	String sql = "select distinct voucher_in_month_id,attachment_amount,debit_sum,loan_sum,register,register_time,account_period from finance_voucher where check_tag='1' and account_tag='0' and account_period<'16' order by voucher_in_month_id" ;
	ResultSet rs = finance_db.executeQuery(sql) ;
	int intRowCount = query.count((String)session.getAttribute("unit_db_name"),sql);
int pageSize=25;
String pageSize_temp=request.getParameter("pageSize");
if(pageSize_temp!=null&&!pageSize_temp.equals("")){pageSize=Integer.parseInt(pageSize_temp);}
pageContext.setAttribute("pageSize",new Integer(pageSize).toString());
String strPage = request.getParameter("page");
int maxPage=(intRowCount+pageSize-1)/pageSize;
if(strPage==null||strPage!=null&&(strPage.equals("")||!validata.validata(strPage))){
	strPage="1";
}else if(Integer.parseInt(strPage)<=0){
	strPage="1";
}else if(maxPage>0&&Integer.parseInt(strPage)>maxPage){
	strPage=maxPage+"";
}
strPage=strPage+"⊙"+maxPage;
%> 
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">&nbsp;</td>
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
                       {name: '<%=demo.getLang("erp","附件数量")%>'},
                       {name: '<%=demo.getLang("erp","借方金额")%>'},
                       {name: '<%=demo.getLang("erp","贷方金额")%>'},
                       {name: '<%=demo.getLang("erp","制单")%>'},
                       {name: '<%=demo.getLang("erp","时间")%>'},
					   {name: '<%=demo.getLang("erp","登账")%>'}
                  ]
nseer_grid.column_width=[70,70,180,180,70,180,70];
nseer_grid.auto='<%=demo.getLang("erp","凭证号")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
	['<%=rs.getString("voucher_in_month_ID")%>','<%=rs.getString("attachment_amount")%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("debit_sum"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("loan_sum"))%>','<%=exchange.toHtml(rs.getString("register"))%>','<%=exchange.toHtml(rs.getString("register_time"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../../finance_voucher_account_ok?voucher_in_month_ID=<%=rs.getString("voucher_in_month_ID")%>&&account_period=<%=rs.getString("account_period")%>&&register_time=<%=toUtf8String.utf8String(exchange.toURL(rs.getString("register_time")))%>")><%=demo.getLang("erp","登账")%></div>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<page:updowntag num="<%=intRowCount%>" file="account_list.jsp"/>
<%@include file="../../../include/head_msg.jsp"%>
<%	
finance_db.close();
%>
