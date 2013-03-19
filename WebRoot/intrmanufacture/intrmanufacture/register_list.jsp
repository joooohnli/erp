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
<%nseer_db intrmanufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/manufacture/manufacture_apply.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<form method="post" action="register.jsp">
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
String sql1 = "select distinct apply_ID,check_time from manufacture_apply where check_tag='1' and excel_tag='2' and manufacture_tag='0' and type='委外部件' order by check_time" ;
ResultSet rs1 = intrmanufacture_db.executeQuery(sql1) ;
rs1.last();
int intRowCount1 = rs1.getRow();

String tablename="manufacture_apply";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and excel_tag='2' and manufacture_tag='0' and type='委外部件'";
String queue="order by check_time";
String validationXml="../../xml/manufacture/manufacture_apply.xml";
String nickName="委外计划";
String fileName="register_list.jsp";
String rowSummary=demo.getLang("erp","当前等待执行的委外计划明细总数");
%>
<%@include file="../../include/search.jsp"%>
<% 
try{
ResultSet rs= intrmanufacture_db.executeQuery(sql_search);
otherButtons="&nbsp;<input type=\"submit\" "+SUBMIT_STYLE1+" class=\"SUBMIT_STYLE1\" value=\""+demo.getLang("erp","生成执行单")+"\">";
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
                       {name: '<%=demo.getLang("erp","点选")%>'},
                       {name: '<%=demo.getLang("erp","计划单编号")%>'},
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
					   {name: '<%=demo.getLang("erp","产品名称")%>'},
	                   {name: '<%=demo.getLang("erp","描述")%>'},
					   {name: '<%=demo.getLang("erp","数量")%>'},
					   {name: '<%=demo.getLang("erp","出库单编号集合")%>'},
	                   {name: '<%=demo.getLang("erp","审核时间")%>'}
]
nseer_grid.column_width=[40,180,180,100,70,100,180,160];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
<%
String check_time="";
if(rs.getString("check_time")==null){
check_time="";
}else{
check_time=rs.getString("check_time");
}
%>
['<input type="checkbox" name="choice" value=<%=rs.getString("id")%>>','<span ><%=rs.getString("apply_ID")%></span>','<span><%=rs.getString("product_ID")%></span>','<span ><%=exchange.toHtml(rs.getString("product_name"))%></span>','<span ><%=rs.getString("product_describe")%></span>','<span ><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs.getDouble("amount"))%></span>','<span ><%=rs.getString("pay_ID_group")%></span>','<span ><%=exchange.toHtml(check_time)%></span>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
</form>
<%@include file="../../include/search_bottom.jsp"%>
<%@include file="../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
intrmanufacture_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>