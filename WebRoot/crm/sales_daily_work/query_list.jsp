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
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/hr/hr_file.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<script src="../../javascript/table/movetable.js"></script>
<%
String human_ID=(String)session.getAttribute("human_IDD");
String chain_group=Responsible.getString(crm_db,"hr_config_file_kind",human_ID);
String condition="";
String sql1="select * from hr_config_file_kind where describe1 like '%"+human_ID+"%'";
ResultSet rs11= hr_db.executeQuery(sql1) ;
while(rs11.next()){
	condition+="chain_ID='"+rs11.getString("file_ID")+"' or ";
}
if(!condition.equals("")){
condition=condition.substring(0,condition.length()-3);
}else{
condition="chain_ID!=''";
}
String tablename="hr_file";
String realname=(String)session.getAttribute("realeditorc");
condition="check_tag='1' and  human_major_first_kind_name='销售'";
String queue="order by register_time desc";
String validationXml="../../xml/hr/hr_file.xml";
String nickName="销售人员";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的客户经理总数");
%>
 <%@include file="../../include/search.jsp"%>
<%
ResultSet rs = crm_db.executeQuery(sql_search) ;
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
                       {name: '<%=demo.getLang("erp","档案编号")%>'},
                       {name: '<%=demo.getLang("erp","姓名")%>'},
                       {name: '<%=demo.getLang("erp","性别")%>'},
                       {name: '<%=demo.getLang("erp","机构")%>'},
                       {name: '<%=demo.getLang("erp","职位分类")%>'},
                       {name: '<%=demo.getLang("erp","职位名称")%>'},
                       {name: '<%=demo.getLang("erp","查看日志")%>'}
]
nseer_grid.column_width=[160,100,70,200,100,100,70];
nseer_grid.auto='<%=demo.getLang("erp","机构")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%if(chain_group.indexOf(","+rs.getString("chain_id")+",")!=-1||!rs.getString("excel_batch_tag").equals("0")){%>

['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../../hr/file/query.jsp?human_ID=<%=rs.getString("human_ID")%>")><%=rs.getString("human_ID")%></div>','<%=exchange.toHtml(rs.getString("human_name"))%>','<%=exchange.toHtml(rs.getString("sex"))%>','<%=exchange.toHtml(rs.getString("chain_name"))%>','<%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>','<%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query_daily_work_list.jsp?human_ID=<%=rs.getString("human_ID")%>&&readXml=n")><%=demo.getLang("erp","查看日志")%></div>'],
	<%}else{%>
  ['','<%=demo.getLang("erp","非责任人")%>','','','','',''],
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