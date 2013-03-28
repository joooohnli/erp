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
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/stock/stock_transfer_gather.xml"/>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<% 
try{
	String tablename="stock_transfer_gather";
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
String register_ID=(String)session.getAttribute("human_IDD");
String realname=(String)session.getAttribute("realeditorc");
String condition="excel_tag='2' and gar_tag='0'";
String queue="order by register_time desc";
String validationXml="../../xml/stock/stock_transfer_gather.xml";
String nickName="内部调入申请单";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的调入申请单总数：");
int k=1;
%>
<%@include file="../../include/search.jsp"%>
<%
ResultSet rs1 = stock_db.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+demo.getLang("erp","全选")+"\" name=\"check\" onclick=\"selAll()\">"+DgButton.getGar(tablename,request);
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
					   {name: '&nbsp;'},
                       {name: '<%=demo.getLang("erp","申请单编号")%>'},
                       {name: '<%=demo.getLang("erp","调入库")%>'},
					   {name: '<%=demo.getLang("erp","登记时间")%>'},
                       {name: '<%=demo.getLang("erp","总件数")%>'},
	                   {name: '<%=demo.getLang("erp","申请单状态")%>'},
                       {name: '<%=demo.getLang("erp","审核状态")%>'},
	                   {name: '<%=demo.getLang("erp","入库状态")%>'}
]
nseer_grid.column_width=[40,180,100,160,70,70,70,70];
nseer_grid.auto='<%=demo.getLang("erp","调入库")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%
String delete_tag="1";
String check_tag="";
String gather_tag="";
String transfer_gather_tag="";
String color="#FF9A31";
if(rs1.getString("check_tag").equals("0")||rs1.getString("check_tag").equals("9")){
transfer_gather_tag="等待";
}else if(rs1.getString("check_tag").equals("1")&&rs1.getString("transfer_gather_tag").equals("0")){
transfer_gather_tag="执行";
color="mediumseagreen";
}else if(rs1.getString("check_tag").equals("1")&&rs1.getString("transfer_gather_tag").equals("1")){
transfer_gather_tag="完成";
delete_tag="0";
color="3333FF";
}
if(rs1.getString("check_tag").equals("9")){
check_tag="未通过";
}else if(rs1.getString("check_tag").equals("0")){
check_tag="等待";
}else if(rs1.getString("check_tag").equals("1")){
check_tag="通过";
}
if(rs1.getString("gather_tag").equals("0")){
gather_tag="等待";
}else if(rs1.getString("gather_tag").equals("1")){
gather_tag="执行";
}else if(rs1.getString("gather_tag").equals("2")){
gather_tag="完成";
}
%>
 ['<%if(delete_tag.equals("0")){%><input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs1.getString("id")%>⊙<%=delete_tag%>" style="height:10"><%}%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?gather_ID=<%=rs1.getString("gather_ID")%>")><span style="color:<%=color%>"><%=rs1.getString("gather_ID")%></span></div>','<span style="color:<%=color%>"><%=exchange.toHtml(rs1.getString("reasonexact"))%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs1.getString("register_time"))%></span>','<span style="color:<%=color%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs1.getDouble("demand_amount"))%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(transfer_gather_tag)%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(check_tag)%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(gather_tag)%></span>'],
<%k++;%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<%
stock_db.close();	
}catch(Exception e){e.printStackTrace();}	
%>
<%@include file="../../include/head_msg.jsp"%>