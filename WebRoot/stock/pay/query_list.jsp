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
<jsp:setProperty name="mask" property="file" value="xml/stock/stock_pay.xml"/>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<% 
try{
	String tablename="stock_pay";
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
  <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
String register_ID=(String)session.getAttribute("human_IDD");
String realname=(String)session.getAttribute("realeditorc");
String condition="excel_tag='2' and gar_tag='0' and demand_amount!='0' and pay_ID not like '%part'";
String queue="order by check_time desc";
String validationXml="../../xml/stock/stock_gather.xml";
String nickName="出库单";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的出库单总数：");
int k=1;
%>
<%@include file="../../include/search.jsp"%>
<%
ResultSet rs1 = stock_db.executeQuery(sql_search);
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
                       {name: '<%=demo.getLang("erp","出库单编号")%>'},
                       {name: '<%=demo.getLang("erp","出库理由")%>'},
					   {name: '<%=demo.getLang("erp","完成时间")%>'},
                       {name: '<%=demo.getLang("erp","应出库总件数")%>'},
	                   {name: '<%=demo.getLang("erp","已出库总件数")%>'},
                       {name: '<%=demo.getLang("erp","出库单状态")%>'}
]
nseer_grid.column_width=[40,180,100,160,100,100,70];
nseer_grid.auto='<%=demo.getLang("erp","出库理由")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>">
<%
String delete_tag="1";
String check_tag="";
String pay_tag="";
String color="#FF9A31";
if(rs1.getString("pay_tag").equals("0")){
pay_tag="等待";
}else if(rs1.getString("pay_tag").equals("1")){
pay_tag="执行";
color="mediumseagreen";
}else if(rs1.getString("pay_tag").equals("2")){
pay_tag="完成";
delete_tag="0";
color="3333FF";
}
String finish_time="未完成";
if(!rs1.getString("finish_time").equals("1800-01-01 00:00:00.0")){
	finish_time=rs1.getString("finish_time");
}
%>

['<%if(delete_tag.equals("0")){%><input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs1.getString("id")%>⊙<%=delete_tag%>" style="height:10"><%}%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?pay_ID=<%=rs1.getString("pay_ID")%>")><span style="color:<%=color%>"><%=rs1.getString("pay_ID")%></span></div>','<span style="color:<%=color%>"><%=exchange.toHtml(rs1.getString("reason"))%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(finish_time)%></span>','<span style="color:<%=color%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs1.getDouble("demand_amount"))%></span>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs1.getDouble("paid_amount"))%>','<span style="color:<%=color%>"><%=exchange.toHtml(pay_tag)%></span>'],
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