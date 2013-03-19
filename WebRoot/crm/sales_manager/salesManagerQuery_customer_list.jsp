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
<jsp:useBean id="query" scope="page" class="include.query.query_key"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="available" class="stock.getBalanceAmount" scope="request"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<script src="../../javascript/table/movetable.js">
</script>
<%
String keyword=(String)session.getAttribute("keyword");
String sales_ID=(String)session.getAttribute("sales_ID");
if(keyword==null||sales_ID==null){
response.sendRedirect("../include/error/session_error.jsp");
}else{
String dbase=(String)session.getAttribute("unit_db_name");
String tablename="crm_file";
String[] fieldName3=column.Column(dbase,tablename);
String condition="sales_ID='"+sales_ID+"' and check_tag='1'";
String queue="order by register_time desc";
ResultSet rs1=query.queryDB(dbase,tablename,keyword,fieldName3,condition,queue);
int intRowCount=query.intValue();
String strPage=request.getParameter("page");
if(strPage!=null&&!strPage.equals("")&&!validata.validata(strPage)){
	strPage="";
}
%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","符合条件的客户档案总数")%>：
  <%=intRowCount%><%=demo.getLang("erp","例")%></td>
			 <td <%=TD_STYLE3%> class="TD_STYLE3">
			 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="salesManagerQuery_customer_locate.jsp?sales_ID=<%=sales_ID%>"></div></td>
 </tr>
 </table>

<script type="text/javascript">/*yahoo*/
function id_link(link){
document.location.href=link;
}
var arriy_list = {
init : function(){
var myData = [['1'],
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>">


['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../file/query.jsp?customer_ID=<%=rs1.getString("customer_ID")%>")><%=rs1.getString("customer_ID")%></div>','<%=exchange.toHtml(rs1.getString("customer_name"))%>','<%=exchange.toHtml(rs1.getString("customer_class"))%>','<%=exchange.toHtml(rs1.getString("chain_name"))%>','<%=exchange.toHtml(rs1.getString("type"))%>','<%=exchange.toHtml(rs1.getString("contact_person1"))%>'],
</page:pages>
['']];

var ds = new Ext.data.Store({
proxy: new Ext.data.MemoryProxy(myData),
reader: new Ext.data.ArrayReader({}, [
                       {name: '<%=demo.getLang("erp","客户编号")%>'},
                       {name: '<%=demo.getLang("erp","客户名称")%>'},
                       {name: '<%=demo.getLang("erp","优质级别")%>'},
                       {name: '<%=demo.getLang("erp","客户分类")%>'},
	                   {name: '<%=demo.getLang("erp","客户类型")%>'},
					   
					   {name: '<%=demo.getLang("erp","联系人")%>'}
                  ])
        });
        ds.load();
       
        var colModel = new Ext.grid.ColumnModel([
			{header: "<%=demo.getLang("erp","客户编号")%>", width:150, sortable: true, locked:false, dataIndex: '<%=demo.getLang("erp","客户编号")%>'},
			{id:'change',header: "<%=demo.getLang("erp","客户名称")%>", width: 80, sortable: true,locked:false, dataIndex: '<%=demo.getLang("erp","客户名称")%>'},
			{header: "<%=demo.getLang("erp","优质级别")%>", width: 60, sortable: true, locked:false,  dataIndex: '<%=demo.getLang("erp","优质级别")%>'},
			{header: "<%=demo.getLang("erp","客户分类")%>", width: 300, sortable: true, locked:false, dataIndex: '<%=demo.getLang("erp","客户分类")%>'},
			{header: "<%=demo.getLang("erp","客户类型")%>", width: 60, sortable: true, locked:false, dataIndex: '<%=demo.getLang("erp","客户类型")%>'},
			
            {header: "<%=demo.getLang("erp","联系人")%>", width: 60, sortable: true,locked:false, dataIndex: '<%=demo.getLang("erp","联系人")%>'}
         ]);
		 
        var grid = new Ext.grid.Grid('grid-example', {
            ds: ds,
            cm: colModel,
            autoExpandColumn: 'change'
        });
        
        var layout = Ext.BorderLayout.create({
            center: {
                margins:{left:3,top:3,right:3,bottom:3},
                panels: [new Ext.GridPanel(grid)]
            }
        }, 'grid-panel');

        grid.render();
        
        grid.getSelectionModel().selectFirstRow();
    }
};
Ext.onReady(arriy_list.init, arriy_list);
</script>

<script type="text/javascript" src="../../javascript/ext/examples/examples.js"></script>
<div id="grid-panel" style="width:100%;height:75%;">
<div id="grid-example"></div>
</div>

<%query.close();%>
<page:updowntag num="<%=intRowCount%>" file="salesManagerQuery_customer_list.jsp"/>
<%}%>