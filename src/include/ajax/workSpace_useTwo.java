package include.ajax;
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.io.*;
import include.nseer_db.*;
import java.util.Vector;
import include.tree_index.businessComment;
import include.tree_index.Nseer;

public class workSpace_useTwo extends HttpServlet{
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
Vector vData = new Vector();
PrintWriter out=response.getWriter();
String human_ID=(String)dbSession.getAttribute("human_IDD");
nseer_db_backup db = new nseer_db_backup(dbApplication);
nseer_db_backup db1 = new nseer_db_backup(dbApplication);
if(db.conn((String)dbSession.getAttribute("unit_db_name"))&&db1.conn((String)dbSession.getAttribute("unit_db_name"))){

String view_tree_name=request.getParameter("view_tree_name") ;

String module_all=request.getParameter("module_all");

String view_tree_name1=view_tree_name+"_view";
String groupName=view_tree_name+"Tree";
String tree_table=view_tree_name+"_tree";
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

if(rs.getString("hreflink").indexOf("?")!=-1)

				{
				buff.append("style=\"background-image:url(../../images/mungg.gif);\" oncontextmenu=\"etv=event;right_click('"+module_all+"--"+rs.getString("MODULE_NAME")+"','','"+view_tree_name+rs.getString("id")+"','"+rs.getString("CATEGORY_ID")+"','"+view_tree_name1+"')\"   href=\"javascript:menu_three('"+view_tree_name+"','"+rs.getString("CATEGORY_ID")+"','"+rs.getString("MODULE_NAME")+"');\">"+demo.getLang(groupName,rs.getString("MODULE_NAME"))+"\n");
				
				}else{
				buf.append("style=\"background-image:url(../../images/muk.gif);\"oncontextmenu=\"etv=event;right_click('"+module_all+"--"+rs.getString("MODULE_NAME")+"','"+rs.getString("hreflink")+"','"+view_tree_name+rs.getString("id")+"','"+rs.getString("CATEGORY_ID")+"','"+view_tree_name1+"')\"  href=\"javascript:void(0)\" onclick=\"open_blank('../../"+rs.getString("hreflink")+"')\">"+demo.getLang(groupName,rs.getString("MODULE_NAME"))+"\n");
				
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




