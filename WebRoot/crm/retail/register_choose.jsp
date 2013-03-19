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
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<form method="post" action="../../crm_retail_register_choose_ok">
<%
String order_ID=request.getParameter("order_ID");
String stock_ID=request.getParameter("stock_ID");
String product_ID=request.getParameter("product_ID");
String sql = "select * from stock_balance_details_details where stock_ID='"+stock_ID+"' and product_ID='"+product_ID+"' order by register_time";

 ResultSet rs = stock_db.executeQuery(sql) ;
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3">
<div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","出库")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td>
</tr>
</table>
<input name="stock_ID" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=stock_ID%>">
<input name="product_ID" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=product_ID%>">
<input name="order_ID" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=order_ID%>">
 

<script type="text/javascript" src="../../javascript/ext/adapter/yui/yui-utilities.js"></script>   
<script type="text/javascript">/*yahoo*/
function id_link(link){
document.location.href=link;
}
var arriy_list = {
init : function(){
var myData = [['1'],
 <%
while(rs.next()){
%>
['<input type="checkbox" name="serial_number" value=<%=rs.getString("serial_number")%> style="height:10">','<%=rs.getString("product_ID")%>','<%=exchange.toHtml(rs.getString("product_name"))%>','<%=exchange.toHtml(rs.getString("stock_name"))%>','<%=rs.getString("serial_number")%>','<%=exchange.toHtml(rs.getString("register_time"))%>'],
<%}%>
['']];

var ds = new Ext.data.Store({
proxy: new Ext.data.MemoryProxy(myData),
reader: new Ext.data.ArrayReader({}, [
                       {name: ''},
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
                       {name: '<%=demo.getLang("erp","库房名称")%>'},
                       {name: '<%=demo.getLang("erp","S/N")%>'},
					   {name: '<%=demo.getLang("erp","入库时间")%>'}
                  ])
        });
        ds.load();
        var colModel = new Ext.grid.ColumnModel([
	        {header: "", width:40, sortable: true, locked:false, dataIndex: ''},
			{id:'change',header: "<%=demo.getLang("erp","产品编号")%>", width:100, sortable: true, locked:false, dataIndex: '<%=demo.getLang("erp","产品编号")%>'},
			{header: "<%=demo.getLang("erp","产品名称")%>", width: 70, sortable: true,locked:false, dataIndex: '<%=demo.getLang("erp","产品名称")%>'},
			{header: "<%=demo.getLang("erp","库房名称")%>", width: 70, sortable: true, locked:false,  dataIndex: '<%=demo.getLang("erp","库房名称")%>'},
			{header: "<%=demo.getLang("erp","S/N")%>", width: 140, sortable: true, locked:false, dataIndex: '<%=demo.getLang("erp","S/N")%>'},
		    {header: "<%=demo.getLang("erp","入库时间")%>", width: 140, sortable: true, locked:false,  dataIndex: '<%=demo.getLang("erp","入库时间")%>'}
			
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
<div id="grid-panel" style="width:100%;height:85%;">
<div id="grid-example"></div>
</div> 
<%stock_db.close();%>