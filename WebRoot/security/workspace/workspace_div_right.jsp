<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*" import ="include.tree_index.Nseer"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>

<%
Nseer n=new Nseer();
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<table class="TABLE_STYLE3">
 <tr  class="TR_STYLE1">
 <td  class="TD_HANDBOOK_STYLE1"></td>
 </tr>
</table>

<%
try{
nseer_db security_db = new nseer_db((String)session.getAttribute("unit_db_name"));

String category_id=request.getParameter("category") ;
String human_ID=(String)session.getAttribute("human_IDD");
String tree_view_name=request.getParameter("tree_view_name");


String sql1 = "select * from drag_img where category='"+category_id+"' and human_id='"+human_ID+"' and tree_view_name='"+tree_view_name+"'";
ResultSet rs =security_db.executeQuery(sql1);
if(rs.next()){
if(!rs.getString("firstworkname").equals("")){
response.sendRedirect("../../"+rs.getString("firstworkname"));
}else{
	sql1="select * from "+tree_view_name+" where human_id='"+human_ID+"' order by file_id";
	rs =security_db.executeQuery(sql1);
	while(rs.next()){
		if(rs.getString("file_path").indexOf("config")==-1&&!rs.getString("hreflink").equals("")){
		response.sendRedirect("../../"+rs.getString("file_path")+rs.getString("hreflink"));
		rs.last();
		}
	}
}

}else{
out.println(demo.getLang("erp","未选择初始页面"));
}
security_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>

