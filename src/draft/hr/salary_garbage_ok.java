package draft.hr;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*; 
import include.nseer_cookie.*;
import java.sql.ResultSet;
import java.util.*;
import java.io.*;
import include.nseer_db.*;
import validata.ValidataNumber;
import validata.ValidataRecord;
import validata.ValidataTag;

public class salary_garbage_ok extends HttpServlet{
//创建方法
ServletContext application;
HttpSession session;


public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
HttpSession session=request.getSession();
PrintWriter out=response.getWriter();
counter count= new  counter(dbApplication);
ValidataNumber validata= new  ValidataNumber();
ValidataRecord vr= new  ValidataRecord();

nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
ValidataTag  vt= new  ValidataTag();
String checker=(String)session.getAttribute("realeditorc");
String checker_id=(String)session.getAttribute("human_IDD");
String salary_id=request.getParameter("salary_id");
String ids_str=request.getParameter("ids_str");
String ret_value="1";
String[] value1=ids_str.split("⊙");
if(ids_str!=null){
	String sql="update hr_file set salary_tag='0'";
	hr_db.executeUpdate(sql);
	for(int i=0;i<value1.length;i++){
		sql="update hr_salary set check_tag='2' where id='"+value1[i]+"'";
		hr_db.executeUpdate(sql);
	}
	out.println(ret_value);	
}else{
String sql="select salary_sum from hr_salary where salary_id='"+salary_id+"' and (check_tag='5' or check_tag='9') and register_finish_tag='1'";
ResultSet rs=hr_db.executeQuery(sql);
if(rs.next()){
	Double salary_sum=rs.getDouble("salary_sum");
	String[] human_id=request.getParameterValues("human_ID");
	String[] bonus_sum=request.getParameterValues("bonus_sum");
	String[] sale_bonus_sum=request.getParameterValues("sale_bonus_sum");
	String[] deduct_sum=request.getParameterValues("deduct_sum");
	Double[] subtotal=new Double[human_id.length];
	if(human_id!=null&&human_id.length>0){
		for(int i=0;i<human_id.length;i++){
			bonus_sum[i]=bonus_sum[i].replaceAll(",", "").replaceAll("，", "");
			if(!validata.validata(bonus_sum[i])){
				bonus_sum[i]="0";
			}
			sale_bonus_sum[i]=sale_bonus_sum[i].replaceAll(",", "").replaceAll("，", "");
			if(!validata.validata(sale_bonus_sum[i])){
				sale_bonus_sum[i]="0";
			}
			deduct_sum[i]=deduct_sum[i].replaceAll(",", "").replaceAll("，", "");
			if(!validata.validata(deduct_sum[i])){
				deduct_sum[i]="0";
			}
			subtotal[i]=Double.parseDouble(bonus_sum[i])+Double.parseDouble(sale_bonus_sum[i])-Double.parseDouble(deduct_sum[i]);
			sql="select standard_salary_sum,salary_sum from hr_salary_human_details where salary_id='"+salary_id+"' and human_id='"+human_id[i]+"'";
			ResultSet rs1=hr_db.executeQuery(sql);
			if(rs1.next()){
				Double salary_sum_temp=rs1.getDouble("standard_salary_sum")+subtotal[i];
				salary_sum+=salary_sum_temp-rs1.getDouble("salary_sum");
				sql="update hr_salary_human_details set bonus_sum='"+bonus_sum[i]+"',sale_bonus_sum='"+sale_bonus_sum[i]+"',deduct_sum='"+deduct_sum[i]+"',salary_sum='"+salary_sum_temp+"' where salary_id='"+salary_id+"' and human_id='"+human_id[i]+"'";
				hr_db.executeUpdate(sql);
			}
		}
		sql="update hr_salary set check_tag='2',salary_sum='"+salary_sum+"' where salary_id='"+salary_id+"'";
		hr_db.executeUpdate(sql);
		sql="update hr_file set salary_tag='0'";
		hr_db.executeUpdate(sql);
	}
	response.sendRedirect("draft/hr/salary_ok.jsp?finished_tag=2");

}else{
	response.sendRedirect("draft/hr/salary_ok.jsp?finished_tag=3");
}
}
hr_db.commit();
hr_db.close();
}
}catch (Exception ex){
	ex.printStackTrace();
}
}
}
