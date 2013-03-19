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
<%nseer_db fund_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/fund/fund_apply_pay.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<script src="../../javascript/table/movetable.js"></script>
<%
String condition="";
String tablename="fund_apply_pay";
String realname=(String)session.getAttribute("realeditorc");
String condition0="excel_tag='2' and gar_tag='0' and reason='费用'";
String queue="order by register_time desc";
String validationXml="../../xml/fund/fund_apply_pay.xml";
String nickName="费用申请";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的费用申请单总数：");
String condition1="(check_tag='0' or check_tag='9') and gar_tag='0' and excel_tag='2' and reason='费用'";
String condition2="check_tag='1' and excel_tag='2' and gar_tag='0' and apply_tag='1' and reason='费用'";
String condition3="check_tag='1' and excel_tag='2' and gar_tag='0' and apply_tag='0' and reason='费用'";
int k=1;
%>
<%@include file="../../include/search_a.jsp"%>
<%
condition=condition1;
%>
<%@include file="../../include/search_b.jsp"%>
<%
int intRowCount1 = query.count((String)session.getAttribute("unit_db_name"),sql_search);
%>
<%
condition=condition2;
%>
<%@include file="../../include/search_b.jsp"%>
<%
int intRowCount2 = query.count((String)session.getAttribute("unit_db_name"),sql_search);
%>
<%
condition=condition3;
%>
<%@include file="../../include/search_b.jsp"%>
<%
int intRowCount3 = query.count((String)session.getAttribute("unit_db_name"),sql_search);
%>
<%
condition=condition0;
%>
<%@include file="../../include/search_b.jsp"%>
<%
ResultSet rs1 = fund_db.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+demo.getLang("erp","全选")+"\" name=\"check\" onclick=\"selAll()\">"+DgButton.getGar(tablename,request);
%>
<%@include file="../../include/search_top.jsp"%>
<FONT SIZE="" COLOR=""></FONT>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3"> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
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
					   {name: '&nbsp;'},
					   {name: '<%=demo.getLang("erp","费用申请编号")%>'},
                       {name: '<%=demo.getLang("erp","机构")%>'},
                       {name: '<%=demo.getLang("erp","员工")%>'},
					   {name: '<%=demo.getLang("erp","总金额")%>'},
					   {name: '<%=demo.getLang("erp","申请单状态")%>'},
	                   {name: '<%=demo.getLang("erp","审批状态")%>'},
					   {name: '<%=demo.getLang("erp","费用状态")%>'}
]
nseer_grid.column_width=[50,160,160,100,100,70,70,70];
nseer_grid.auto='<%=demo.getLang("erp","机构")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%
String delete_tag="1";
String check_tag="";
String pay_tag="";
String apply_tag="";
String color="#FF9A31";
if(rs1.getString("check_tag").equals("0")||rs1.getString("check_tag").equals("9")){
apply_tag="等待";
}else if(rs1.getString("check_tag").equals("1")&&rs1.getString("apply_tag").equals("0")){
apply_tag="执行";
color="mediumseagreen";
}else if(rs1.getString("check_tag").equals("1")&&rs1.getString("apply_tag").equals("1")){
apply_tag="完成";
delete_tag="0";
color="3333FF";
}
if(rs1.getString("check_tag").equals("9")){
check_tag="未通过";
}else if(rs1.getString("check_tag").equals("0")){
check_tag="等待审批";
}else if(rs1.getString("check_tag").equals("1")){
check_tag="通过";
}
if(rs1.getString("pay_tag").equals("0")){
pay_tag="等待";
}else if(rs1.getString("pay_tag").equals("1")){
pay_tag="执行";
}else if(rs1.getString("pay_tag").equals("2")){
pay_tag="完成";
}
%>

['<%if(delete_tag.equals("0")){%><input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs1.getString("id")%>⊙<%=delete_tag%>" style="height:10"><%}%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?apply_pay_ID=<%=rs1.getString("apply_pay_ID")%>")><%=rs1.getString("apply_pay_ID")%></div>','<%=exchange.toHtml(rs1.getString("chain_name"))%>','<%=exchange.toHtml(rs1.getString("human_name"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("demand_cost_price_sum"))%>','<span style="color:<%=color%>"><%=exchange.toHtml(apply_tag)%></span>','<%=exchange.toHtml(check_tag)%>','<%=exchange.toHtml(pay_tag)%>'],
<%k++;%>
</page:pages>
['']];
nseer_grid.init();
</script>
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%@include file="../../include/head_msg.jsp"%>
<%fund_db.close();%>