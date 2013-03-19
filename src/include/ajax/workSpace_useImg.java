package include.ajax;

import include.nseer_db.nseer_db_backup;
import include.tree_index.Nseer;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

public class workSpace_useImg extends HttpServlet{
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

PrintWriter out=response.getWriter();

String sq="";

String cont="";

String cont1="";

String cont2="";

String cont3="";

nseer_db_backup db = new nseer_db_backup(dbApplication);

if(db.conn((String)dbSession.getAttribute("unit_db_name"))){

String module_name=request.getParameter("module_name") ;
if(module_name.indexOf("--")==-1){
 sq="select * from document_main where value='"+module_name+"'";
ResultSet rs=db.executeQuery(sq);
if(rs.next())
{
String url="images/erpPlatform/design/"+rs.getString("picture");
out.println(url);
}
}else{
String main_module=module_name.split("--")[0];
sq="select * from document_main where value='"+main_module+"'";

ResultSet rs=db.executeQuery(sq);
if(rs.next())
{
	sq="select * from "+rs.getString("reason")+"_tree where chain_name='"+module_name+"'";
	rs=db.executeQuery(sq);
	if(rs.next()){
	String url="images/erpPlatform/designSub/"+rs.getString("picture");
	out.println(url);
	}
}
}
db.close();

}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
ex.printStackTrace();
}
}
}
