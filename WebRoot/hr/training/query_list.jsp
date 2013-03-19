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
<jsp:useBean id="query" scope="page" class="include.query.query_three"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/hr/hr_training.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");
	 String tablename="hr_training";
%>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
  </table>
<%

String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and gar_tag='0'";
String queue="order by human_ID,register_time desc";
String validationXml="../../xml/hr/hr_file.xml";
String nickName="人力资源档案";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的培训登记总数：");
int k=1;
%>
<%@include file="../../include/search.jsp"%>
<% 
try{
ResultSet rs = hr_db.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+demo.getLang("erp","全选")+"\" name=\"check\" onclick=\"selAll()\">"+DgButton.getGar(tablename,request);
%>
<%@include file="../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
function id_link1(human_ID,check_time1,check_time2){
var check_time=check_time1+' '+check_time2;
var link1='query.jsp?human_ID='+human_ID+'&&time='+check_time;
document.location.href=link1;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '&nbsp;'},
                       {name: '<%=demo.getLang("erp","档案编号")%>'},
                       {name: '<%=demo.getLang("erp","姓名")%>'},
                       {name: '<%=demo.getLang("erp","职位分类")%>'},
                       {name: '<%=demo.getLang("erp","职位名称")%>'},
                       {name: '<%=demo.getLang("erp","培训时间")%>'},
					   {name: '<%=demo.getLang("erp","培训项目")%>'},
					   {name: '<%=demo.getLang("erp","培训课时")%>'},
					   {name: '<%=demo.getLang("erp","培训成绩")%>'}
]
nseer_grid.column_width=[40,180,100,100,100,160,100,100,100];
nseer_grid.auto='<%=demo.getLang("erp","姓名")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
  ['<%if(rs.getString("check_tag").equals("1")){%><input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs.getString("id")%>" style="height:10"><%}%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link1("<%=rs.getString("human_ID")%>","<%=toUtf8String.utf8String(exchange.toURL(rs.getString("check_time").substring(0,rs.getString("check_time").indexOf(" "))))%>","<%=toUtf8String.utf8String(exchange.toURL(rs.getString("check_time").substring(rs.getString("check_time").indexOf(" ")+1)))%>")><%=rs.getString("human_ID")%></div>','<%=exchange.toHtml(rs.getString("human_name"))%>','<%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>','<%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%>','<%=exchange.toHtml(rs.getString("register_time"))%>','<%=exchange.toHtml(rs.getString("training_item"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs.getDouble("training_hour"))%>','<%=exchange.toHtml(rs.getString("training_result_degree"))%>'],
  <%k++;%>
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
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<%
hr_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>