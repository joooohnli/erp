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
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/crm/crm_contact.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script src="../../javascript/table/movetable.js"></script>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%
String register_ID=(String)session.getAttribute("human_IDD");
String condition="";
String sql1="";
String chain_group=Responsible.getString(crm_db,"crm_config_file_kind",register_ID);
String tablename="crm_contact";
String realname=(String)session.getAttribute("realeditorc");
condition="check_tag='1' and gar_tag='0'";
String queue="order by contact_time desc";
String validationXml="../../xml/crm/crm_contact.xml";
String nickName="客户联络";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的客户联络总数");
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%@include file="../../include/search.jsp"%>
<%
ResultSet rs1 = crm_db.executeQuery(sql_search) ;
int k=1;
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
                       {name: '<%=demo.getLang("erp","联络单编号")%>'},
                       {name: '<%=demo.getLang("erp","客户名称")%>'},
                       {name: '<%=demo.getLang("erp","联络理由")%>'},
                       {name: '<%=demo.getLang("erp","联络理由编码")%>'},
                       {name: '<%=demo.getLang("erp","被联络人")%>'},
					   {name: '<%=demo.getLang("erp","联络人")%>'},
                       {name: '<%=demo.getLang("erp","联络时间")%>'},
					   {name: '<%=demo.getLang("erp","联络方式")%>'}
]
nseer_grid.column_width=[40,160,200,70,160,70,70,140,70];
nseer_grid.auto='<%=demo.getLang("erp","客户名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>">
<%if(chain_group.indexOf(","+rs1.getString("chain_id")+",")!=-1){%>
<%
String contact_time="";
if(rs1.getString("contact_time").equals("0000-00-00")){
contact_time="";
}else{
contact_time=rs1.getString("contact_time");
}
%>
  ['<input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs1.getString("id")%>" style="height:10">','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?contact_ID=<%=rs1.getString("contact_ID")%>")><%=rs1.getString("contact_ID")%></div>','<div style="text-decoration : underline;color:#3366FF" onclick=winopen("../file/query.jsp?customer_ID=<%=rs1.getString("customer_ID")%>")><%=exchange.toHtml(rs1.getString("customer_name"))%></div>','<%=exchange.toHtml(rs1.getString("reason"))%>','<%=rs1.getString("reasonexact")%>','<%=exchange.toHtml(rs1.getString("person_contacted"))%>','<%=exchange.toHtml(rs1.getString("contact_person"))%>','<%=exchange.toHtml(contact_time)%>','<%=exchange.toHtml(rs1.getString("contact_type"))%>'],
<%k++;%>
<%}else{%>
  ['','<%=demo.getLang("erp","非责任人")%>','','','','','','',''],
<%}%>
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
<%	
crm_db.close();
%>
<%@include file="../../include/head_msg.jsp"%>