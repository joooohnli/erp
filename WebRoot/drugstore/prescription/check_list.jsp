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
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stock_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/stock/stock_apply_gather.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
String register_ID=(String)session.getAttribute("human_IDD");
String tablename="stock_apply_gather";
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='0' and excel_tag='2'";
String queue="order by register_time";
String validationXml="../../xml/stock/stock_apply_gather.xml";
String nickName="入库申请单";
String fileName="check_list.jsp";
String rowSummary=demo.getLang("erp","当前等待审核的申请单总数：");
%>
<%@include file="../../include/search.jsp"%>
<%
try{
String sql_search1 = "select * from drugstore_prescription where status=0";
ResultSet rs = stock_db.executeQuery(sql_search1) ;
//test
//System.out.println(rs.getString("prescription_id"));
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
                       {name: '<%=demo.getLang("erp","领药单编号")%>'},
                       {name: '<%=demo.getLang("erp","开药医生编号")%>'},
					   {name: '<%=demo.getLang("erp","开药医生姓名")%>'},
                       {name: '<%=demo.getLang("erp","领药人姓名")%>'},
	                   {name: '<%=demo.getLang("erp","开药时间")%>'},
                       {name: '<%=demo.getLang("erp","流程")%>'}
]
nseer_grid.column_width=[180,180,160,100,70,100,70,70];
nseer_grid.auto='<%=demo.getLang("erp","领药单编号")%>';
nseer_grid.data=[<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
['<%=rs.getString("prescription_id")%>','<%=rs.getString("people_id_give")%>','<%=rs.getString("people_name_give")%>','<%=rs.getString("people_name_take")%>','<%=rs.getString("time")%>'
,'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("check.jsp?prescription_id=<%=rs.getString("prescription_id")%>")>审核</div>'],
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
stock_db.close();
stock_db1.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>