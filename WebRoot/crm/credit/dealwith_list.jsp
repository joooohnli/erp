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
<jsp:useBean id="query" scope="page" class="include.query.query"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/crm/crm_file.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是 ：","document_main","reason","value");%>

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<script src="../../javascript/table/movetable.js"></script>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<%
String register_ID=(String)session.getAttribute("human_IDD");
String condition="";
String sql1="";
String chain_group=Responsible.getString(crm_db,"crm_config_file_kind",register_ID);
String tablename="crm_file";
String realname=(String)session.getAttribute("realeditorc");
condition="check_tag='1' and credit_yes_or_not_tag='1'";
String queue="order by register_time";
String validationXml="../../xml/crm/crm_file.xml";
String nickName="客户档案";
String fileName="dealwith_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的客户档案总数");
%>
<%@include file="../../include/search.jsp"%>
<%
ResultSet rs1 = crm_db.executeQuery(sql_search) ;
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
                       {name: '<%=demo.getLang("erp","客户编号")%>'},
                       {name: '<%=demo.getLang("erp","客户名称")%>'},
                       {name: '<%=demo.getLang("erp","客户分类")%>'},
                       {name: '<%=demo.getLang("erp","销售人")%>'},
                       {name: '<%=demo.getLang("erp","赊货余额")%>'},
                       {name: '<%=demo.getLang("erp","开始")%>'}
]
nseer_grid.column_width=[160,200,70,70,100,70];
nseer_grid.auto='<%=demo.getLang("erp","客户分类")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>">
<%if(chain_group.indexOf(","+rs1.getString("chain_id")+",")!=-1){%>
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../file/query.jsp?customer_ID=<%=rs1.getString("customer_ID")%>")><%=rs1.getString("customer_ID")%></div>','<%=exchange.toHtml(rs1.getString("customer_name"))%>','<%=exchange.toHtml(rs1.getString("chain_name"))%>','<%=exchange.toHtml(rs1.getString("sales_name"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("salecredit_list_price_sum"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("dealwith.jsp?readXml=n&&customer_ID=<%=rs1.getString("customer_ID")%>&&customer_name=<%=toUtf8String.utf8String(exchange.toURL(rs1.getString("customer_name")))%>&&sales_ID=<%=rs1.getString("sales_ID")%>&&sales_name=<%=toUtf8String.utf8String(exchange.toURL(rs1.getString("sales_name")))%>&&salecredit_list_price_sum=<%=rs1.getDouble("salecredit_list_price_sum")%>")><%=demo.getLang("erp","开始")%></div>'],
<%}else{%>
  ['<%=demo.getLang("erp","非责任人")%>','','','','',''],
<%}%>
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
%>
<%@include file="../../include/head_msg.jsp"%>