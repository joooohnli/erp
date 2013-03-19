package include.ajax;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.io.*;
import include.nseer_db.*;
import include.tree_index.Nseer;
import include.tree_index.businessComment;

public class workSpace_use extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup erp_db = null;
Nseer n=new Nseer();
public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
businessComment demo=new businessComment();
demo.setPath(request);
PrintWriter out=response.getWriter();
String human_ID=(String)dbSession.getAttribute("human_IDD");
nseer_db_backup db = new nseer_db_backup(dbApplication);
nseer_db_backup db1 = new nseer_db_backup(dbApplication);
if(db.conn((String)dbSession.getAttribute("unit_db_name"))&&db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String view_tree_name=request.getParameter("view_tree_name");
String module_all=request.getParameter("module_all");
String view_tree_name1=view_tree_name+"_view";
String tree_table=view_tree_name+"_tree";
String groupName=view_tree_name+"Tree";
String gategory=request.getParameter("gategory") ;
StringBuffer buf = new StringBuffer();
StringBuffer buff = new StringBuffer();
String sql="select * from "+view_tree_name1+" where PARENT_CATEGORY_ID='"+gategory+"' and human_ID='"+human_ID+"'";
ResultSet rs=db.executeQuery(sql) ;
String chain_name="";
while (rs.next())
{
String sql1="select chain_name from "+tree_table+" where file_id='"+rs.getString("file_id")+"'";
ResultSet rs1=db1.executeQuery(sql1) ;
if(rs1.next()){
	chain_name=rs1.getString("chain_name");
}
if(rs.getString("hreflink").equals("")){

String file_path=rs.getString("file_path");

int path_len=file_path.split("/").length;

buff.append("style=\"background-image:url(images/mungg.gif);\" oncontextmenu=\"etv=event;right_click('"+chain_name+"','','"+view_tree_name+rs.getString("id")+"','"+rs.getString("CATEGORY_ID")+"','"+view_tree_name1+"')\"  href=\"javascript:menu_"+path_len+"('"+view_tree_name+"','"+rs.getString("CATEGORY_ID")+"','"+rs.getString("file_name")+"');\"  onmousemove=\"window.status='powered by nseer erp'\" onmouseover=\"window.status='powered by nseer erp'\">"+demo.getLang(groupName,rs.getString("file_name"))+"\n");
				
}else{

buf.append("style=\"background-image:url(images/muk.gif);\" oncontextmenu=\"etv=event;right_click('"+chain_name+"','"+rs.getString("file_path")+rs.getString("hreflink")+"','"+view_tree_name+rs.getString("id")+"','"+rs.getString("CATEGORY_ID")+"','"+view_tree_name1+"')\"  href=\"javascript:void(0)\"  onclick=\"open_blank('"+rs.getString("file_path")+rs.getString("hreflink")+"')\" onmouseover=\"window.status='powered by nseer erp';this.href='javascript:void(0)'; return true\">"+demo.getLang(groupName,rs.getString("file_name"))+"\n");

//加载模块（超连接路径）		
				
}

}
out.print(buf.toString()+buff.toString());

db.close();
db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
ex.printStackTrace();
}
}
}





