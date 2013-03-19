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
<%
try{
nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db qcsdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/qcs/qcs_sample.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<jsp:useBean id="query" scope="page" class="include.query.query_three"/>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
String tablename="qcs_sample";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and excel_tag='2' and dealwith_tag='0'";
String queue="order by register_time desc";
String validationXml="../../xml/qcs/qcs_sample.xml";
String nickName="样品登记单";
String fileName="dealwith_list.jsp";
String rowSummary=demo.getLang("erp","当前符合条件的样品登记单总数：");
%>
<%@include file="../../include/search.jsp"%>
<%
ResultSet rs=qcs_db.executeQuery(sql_search);
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
                       {name: '<%=demo.getLang("erp","登记单编号")%>'},
                       {name: '<%=demo.getLang("erp","质检类型")%>'},
                       {name: '<%=demo.getLang("erp","质检申请单编号")%>'},
					   {name: '<%=demo.getLang("erp","取样人")%>'},
                       {name: '<%=demo.getLang("erp","最近观察时间")%>'},
					   {name: '<%=demo.getLang("erp","处理")%>'}
]
nseer_grid.column_width=[180,200,180,100,100,70];
nseer_grid.auto='<%=demo.getLang("erp","质检类型")%>';
nseer_grid.data = [
<%
String sql="";
ResultSet rs1=null;
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
String time=formatter.format(now);
while(rs.next()){
sql="select deposit_limit from qcs_sample_details where sample_id='"+rs.getString("sample_id")+"'";
rs1=qcsdb.executeQuery(sql);
if(rs1.next()){

if((now.getTime()-rs.getDate("lately_view_time").getTime())>=(rs1.getInt("deposit_limit")*24*60*60*1000)){
%>
['<%=exchange.toHtml(rs.getString("sample_id"))%>','<%=rs.getString("quality_type")%>','<%=rs.getString("apply_id")%>','<%=exchange.toHtml(rs.getString("sampling_person"))%>','<%=exchange.toHtml(rs.getString("lately_view_time"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("dealwith.jsp?sample_id=<%=rs.getString("sample_id")%>&&apply_id=<%=rs.getString("apply_id")%>")><%=demo.getLang("erp","处理")%></div>'],
<%}}}%>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<%@include file="../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
qcsdb.close();
qcs_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>