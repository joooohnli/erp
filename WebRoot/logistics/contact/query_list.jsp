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
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<%nseer_db logistics_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/logistics/logistics_contact.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");
String tablename="logistics_contact";%>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%

String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and excel_tag='2' and gar_tag='0'";
String queue="order by contact_time desc";
String validationXml="../../xml/logistics/logistics_contact.xml";
String nickName="物流单位联络";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的物流单位联络总数");
%>
<%@include file="../../include/search.jsp"%>
<%try{
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+demo.getLang("erp","全选")+"\" name=\"check\" onclick=\"selAll()\">"+DgButton.getGar(tablename,request);
ResultSet rs1=logistics_db.executeQuery(sql_search);
int k=1;
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
                       {name: '<%=demo.getLang("erp","物流单位名称")%>'},
                       {name: '<%=demo.getLang("erp","联络理由")%>'},
                       {name: '<%=demo.getLang("erp","联络理由编号")%>'},
                       {name: '<%=demo.getLang("erp","被联络人")%>'},
                       {name: '<%=demo.getLang("erp","联络人")%>'},
                       {name: '<%=demo.getLang("erp","联络时间")%>'}
]
nseer_grid.column_width=[40,180,80,80,180,80,100,160];
nseer_grid.auto='<%=demo.getLang("erp","物流单位名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
	<%
String contact_time="";
if(rs1.getString("contact_time").equals("1800-01-01 00:00:00.0")){
contact_time="";
}else{
contact_time=rs1.getString("contact_time");
}
%>

['<input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs1.getString("id")%>" style="height:10">','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?contact_ID=<%=rs1.getString("contact_ID")%>")><%=rs1.getString("contact_ID")%></div>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../file/query.jsp?provider_ID=<%=rs1.getString("provider_ID")%>")><%=exchange.toHtml(rs1.getString("provider_name"))%></div>','<%=exchange.toHtml(rs1.getString("reason"))%>','<%=exchange.toHtml(rs1.getString("reasonexact"))%>','<%=exchange.toHtml(rs1.getString("person_contacted"))%>','<%=exchange.toHtml(rs1.getString("contact_person"))%>','<%=contact_time%>'],
<%k++;%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<%@include file="../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
logistics_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>