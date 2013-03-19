
package garbage.intrmanufacture;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

import javax.servlet.*;
import java.io.* ;

import include.nseer_db.*;

public class invoice_recovery_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
nseer_db_backup1 qcs_db = new nseer_db_backup1(dbApplication);
PrintWriter out=response.getWriter();
try{
	if(qcs_db.conn((String)dbSession.getAttribute("unit_db_name"))){
	String tableName=request.getParameter("tableName");
	String ids_str=request.getParameter("ids_str");
	String gar_tag=request.getParameter("gar_tag");
	String field=request.getParameter("field");
	String ret_value="1";
	String[] value1=ids_str.split("⊙");
	if(gar_tag!=null&&!gar_tag.equals("")&&field!=null&&!field.equals("")){
	for(int i=0;i<value1.length;i++){
		String id=value1[i];
		String sqll="select "+field+" from "+tableName+" where id='"+id+"' and "+gar_tag;
		ResultSet rs=qcs_db.executeQuery(sqll);
		if(rs.next()){
			ret_value+="⊙"+rs.getString(field);
		}else{	
			sqll="update "+tableName+" set invoice_gar_tag='0' where id='"+id+"'";
		qcs_db.executeUpdate(sqll);
		}
	}
	}else{
		for(int i=0;i<value1.length;i++){
			String id=value1[i];
			String sqll="update "+tableName+" set invoice_gar_tag='0' where id='"+id+"'";
			qcs_db.executeUpdate(sqll);
		}
	}
	out.println(ret_value);
	qcs_db.commit();
	qcs_db.close();
	}else{
		response.sendRedirect("error_conn.htm");
	}
	}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	}