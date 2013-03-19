<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/stock/stock_apply_gather.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是 ：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%
try{
String purchaser_ID=(String)session.getAttribute("purchaser_ID") ;
String purchaser=(String)session.getAttribute("purchaser") ;
String crediter_name=(String)session.getAttribute("crediter_name") ;
String crediter_ID=(String)session.getAttribute("crediter_ID") ;
String purchasecredit_cost_price_sum=(String)session.getAttribute("purchasecredit_cost_price_sum") ;

String tablename="stock_apply_gather";
String realname=(String)session.getAttribute("realeditorc");
String condition="gatherer_ID='"+crediter_ID+"' and reason='采购放货' and cost_price_sum!='0' and check_tag='1'";
String queue="order by id";
String validationXml="../../xml/stock/stock_apply_gather.xml";
String nickName="采购放货单";
String fileName="dealwith.jsp";
%>
<%@include file="../../include/search.jsp"%>
<%
ResultSet rs1 = crm_db.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","返回")+"\" onclick=\"history.back()\">";
%>
<%@include file="../../include/search_top.jsp"%>

<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","放货单编号")%>'},
                       {name: '<%=demo.getLang("erp","供应商名称")%>'},
                       {name: '<%=demo.getLang("erp","采购人")%>'},
                       {name: '<%=demo.getLang("erp","产品数量")%>'},
	                   {name: '<%=demo.getLang("erp","总价")%>'},
	                   {name: '<%=demo.getLang("erp","开始")%>'}
]
nseer_grid.column_width=[160,200,70,70,100,70];
nseer_grid.auto='<%=demo.getLang("erp","供应商名称")%>';
nseer_grid.data = [

<page:pages rs="<%=rs1%>" strPage="<%=strPage%>">

['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../../stock/apply_gather/query.jsp?gather_ID=<%=rs1.getString("gather_ID")%>")><%=rs1.getString("gather_ID")%></div>','<%=exchange.toHtml(rs1.getString("gatherer_name"))%>','<%=exchange.toHtml(rs1.getString("purchaser"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs1.getDouble("demand_amount"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("cost_price_sum"))%>',
	<%if(rs1.getString("gather_tag").equals("2")){%>
	'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("dealwith_reconfirm.jsp?gather_ID=<%=rs1.getString("gather_ID")%>&&purchaser_ID=<%=purchaser_ID%>&&purchaser=<%=toUtf8String.utf8String(exchange.toURL(purchaser))%>&&purchasecredit_cost_price_sum=<%=toUtf8String.utf8String(exchange.toURL(purchasecredit_cost_price_sum))%>")><%=demo.getLang("erp","开始")%></div>'
		<%}else{%>
		'<%=demo.getLang("erp","入库未完成")%>' <%}%>],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
crm_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
<%@include file="../../include/head_msg.jsp"%>