<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%
String sql_excel=sql_search.substring(0,sql_search.indexOf("limit"));
%>
<input type="hidden" id="<%=inputTextId2%>" value="<%=keyword%>">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE6%> class="TD_STYLE6"><input type="text" id="<%=inputTextId1%>" name="keyword" style="width: 25%" onkeyup="n_S.loadAjaxDiv(this.id,event);" value="<%=keyword.replaceAll("⊙"," ")%>">&nbsp;<input type="button" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","搜索")%>" onclick="n_S.resultFormSubmit('<%=fileName%>','<%=inputTextId1%>','<%=inputTextId2%>','<%=validationXml%>','0');"><%if(search_init!=0){%>&nbsp;<input type="button" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","结果中搜索")%>" onclick="n_S.showResultDiv('search_result');"><%}%><%=otherButtons%></td>
 </tr>
 </table>