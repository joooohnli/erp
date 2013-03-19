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
<%nseer_db logistics_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/logistics/logistics_discussion.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<script src="../../javascript/table/movetable.js"></script>
<%
String tablename="logistics_discussion";
String realname=(String)session.getAttribute("realeditorc");
String condition="discussion_tag!='2' and modify_tag='0' and check_tag='1' and gar_tag='0'";
String queue="order by register_time";
String validationXml="../../xml/logistics/logistics_discussion.xml";
String nickName="报价单";
String fileName="change_list.jsp";
String rowSummary=demo.getLang("erp","当前可变更的报价单总数；");
%>
<%@include file="../../include/search.jsp"%>
<%
try{
ResultSet rs1=logistics_db.executeQuery(sql_search);
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
                       {name: '<%=demo.getLang("erp","报价单编号")%>'},
                       {name: '<%=demo.getLang("erp","物流单位名称")%>'},
                       {name: '<%=demo.getLang("erp","电话")%>'},
                       {name: '<%=demo.getLang("erp","拟发货时间")%>'},
                       {name: '<%=demo.getLang("erp","报价总额")%>'},
                       {name: '<%=demo.getLang("erp","变更")%>'}
]
nseer_grid.column_width=[180,200,160,100,150,70];
nseer_grid.auto='<%=demo.getLang("erp","物流单位名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%	
String demand_pay_time="";
if(!rs1.getString("demand_pay_time").equals("1800-01-01 00:00:00.0")) demand_pay_time=rs1.getString("demand_pay_time");
%>
['<%=rs1.getString("discussion_ID")%>','<%=exchange.toHtml(rs1.getString("provider_name"))%>','<%=exchange.toHtml(rs1.getString("demand_contact_person_tel"))%>','<%=exchange.toHtml(demand_pay_time)%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("sale_price_sum"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("change.jsp?discussion_ID=<%=rs1.getString("discussion_ID")%>")><%=demo.getLang("erp","变更")%></div>'],

</page:pages>
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
logistics_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>