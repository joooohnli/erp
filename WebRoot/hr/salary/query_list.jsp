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
nseer_db hr_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/hr/hr_salary.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
String tablename="hr_salary";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and register_finish_tag='1' and gar_tag='0'";
String queue="order by register_time desc";
String validationXml="../../xml/hr/hr_salary.xml";
String nickName="薪酬单";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的薪酬单总数");
%>
<%@include file="../../include/search.jsp"%>
<%
String register_ID=(String)session.getAttribute("human_IDD");
ResultSet rs = hr_db.executeQuery(sql_search) ;
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
                       {name: '<%=demo.getLang("erp","薪酬单编号")%>'},
                       {name: '<%=demo.getLang("erp","薪酬次数")%>'},
                       {name: '<%=demo.getLang("erp","总人数")%>'},
                       {name: '<%=demo.getLang("erp","总额（元）")%>'},
                       {name: '<%=demo.getLang("erp","登记时间")%>'}
]
nseer_grid.column_width=[150,100,100,100,200];
nseer_grid.auto='<%=demo.getLang("erp","薪酬单编号")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?salary_id=<%=rs.getString("salary_id")%>")><%=rs.getString("salary_id")%></div>','<%=rs.getString("pay_times")%>','<%=rs.getString("human_amount")%>','<%=rs.getString("salary_sum")%>','<%=rs.getString("register_time")%>'],
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
hr_db.close();
hr_db1.close();
}catch(Exception ex){ex.printStackTrace();}
%>