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
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/design/design_file.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script src="../../javascript/table/movetable.js">
</script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
String tablename="design_file";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and design_module_tag='0' and type!='物料' and type!='服务型产品' and type!='受托产品' and type!='外购商品'";
String queue="order by register_time";
String validationXml="../../xml/design/design_file.xml";
String nickName="产品档案";
String fileName="register_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的产品档案总数");
%>
 <%@include file="../../include/search.jsp"%>
<%try{
ResultSet rs1=design_db.executeQuery(sql_search);
%>
<%@include file="../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
function id_link1(product_ID,product_name,responsible_person_name){
	var link1='register.jsp?product_ID='+product_ID+'&&product_name='+product_name+'&&responsible_person_name='+responsible_person_name;
document.location.href=link1;

}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
                       {name: '<%=demo.getLang("erp","档次级别")%>'},
                       {name: '<%=demo.getLang("erp","产品分类")%>'},
					   {name: '<%=demo.getLang("erp","用途类型")%>'},
					   {name: '<%=demo.getLang("erp","制定设计单")%>'}
]
nseer_grid.column_width=[160,200,70,70,70,70];
nseer_grid.auto='<%=demo.getLang("erp","产品分类")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
	<%
String color="#000000";
if(rs1.getString("price_alarm_tag").equals("1")){
	color="red";
}
%>
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../file/query.jsp?product_ID=<%=rs1.getString("product_ID")%>")><%=rs1.getString("product_ID")%></div>','<%=exchange.toHtml(rs1.getString("product_name"))%>','<%=exchange.toHtml(rs1.getString("product_class"))%>','<%=exchange.toHtml(rs1.getString("chain_name"))%>','<%=exchange.toHtml(rs1.getString("type"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link1("<%=rs1.getString("product_ID")%>","<%=toUtf8String.utf8String(exchange.toURL(rs1.getString("product_name")))%>","<%=toUtf8String.utf8String(exchange.toURL(rs1.getString("responsible_person_name")))%>")><%=demo.getLang("erp","制定设计单")%></div>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%design_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>