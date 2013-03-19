package draft.intrmanufacture;
 
 
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import validata.ValidataNumber;

public class invoice_draft_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 intrmanufacture_db = new nseer_db_backup1(dbApplication);
if(intrmanufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){

ValidataNumber validata=new ValidataNumber();

String intrmanufacture_ID=request.getParameter("intrmanufacture_ID");
String register=request.getParameter("register");
String register_time=request.getParameter("register_time");
String real_invoiced_sum1=request.getParameter("real_invoiced_sum") ;
String[] id=request.getParameterValues("id") ;
String[] provider_ID=request.getParameterValues("provider_ID") ;
String[] real_contact_person=request.getParameterValues("real_contact_person") ;
String[] real_contact_person_tel=request.getParameterValues("real_contact_person_tel") ;
String[] invoiced_sum=request.getParameterValues("invoiced_sum") ;
String[] invoicing_sum=request.getParameterValues("invoicing_sum") ;
String[] remark=request.getParameterValues("remark") ;

double real_invoiced_sum=Double.parseDouble(real_invoiced_sum1);
int p=0;
	String provider_ID_control=provider_ID[0];
for(int i=0;i<provider_ID.length;i++){
	if(!invoicing_sum[i].equals("")){
		StringTokenizer tokenTO1 = new StringTokenizer(invoicing_sum[i],",");        
		String invoicing_sum2="";
            while(tokenTO1.hasMoreTokens()) {
                String invoicing_sum1 = tokenTO1.nextToken();
		invoicing_sum2+=invoicing_sum1;
		}
		if(!validata.validata(invoicing_sum2)){
		p++;
		}
		if(real_contact_person[i].indexOf("'")!=-1||real_contact_person[i].indexOf("\"")!=-1||real_contact_person[i].indexOf(",")!=-1||real_contact_person_tel[i].indexOf("'")!=-1||real_contact_person_tel[i].indexOf("\"")!=-1||real_contact_person_tel[i].indexOf(",")!=-1||remark[i].indexOf("'")!=-1||remark[i].indexOf("\"")!=-1||remark[i].indexOf(",")!=-1||real_contact_person[i].length()>30||real_contact_person_tel[i].length()>30){
		p++;
		}
	}
}
if(p==0){
int n=0;
for(int i=0;i<provider_ID.length;i++){
	if(!invoicing_sum[i].equals("")){
		n++;
	}
}
if(n!=0){
String sql8="select * from intrmanufacture_purchasing where intrmanufacture_ID='"+intrmanufacture_ID+"' and check_tag='0' and kind='发票' order by id";
ResultSet rs8=intrmanufacture_db.executeQuery(sql8);
if(rs8.next()){

for(int i=0;i<provider_ID.length;i++){
String sql="update intrmanufacture_purchasing set check_tag='0' where id='"+id[i]+"'";
intrmanufacture_db.executeUpdate(sql);
}

	provider_ID_control=provider_ID[0];
	double invoiced_sum_control=Double.parseDouble(invoiced_sum[0]);
for(int i=0;i<provider_ID.length;i++){
	if(invoicing_sum[i].equals("")) invoicing_sum[i]="0";
	StringTokenizer tokenTO = new StringTokenizer(invoicing_sum[i],",");        
		String invoicing_sum2="";
            while(tokenTO.hasMoreTokens()) {
                String invoicing_sum1 = tokenTO.nextToken();
		invoicing_sum2+=invoicing_sum1;
		}
if(provider_ID[i].equals(provider_ID_control)){
	if(Double.parseDouble(invoicing_sum2)!=0){
	invoiced_sum_control+=Double.parseDouble(invoicing_sum2);
		real_invoiced_sum+=Double.parseDouble(invoicing_sum2);
		String sql="update intrmanufacture_purchasing set real_contact_person='"+real_contact_person[i]+"',real_contact_person_tel='"+real_contact_person_tel[i]+"',invoicing_sum='"+invoicing_sum2+"',remark='"+remark[i]+"',register='"+register+"',register_time='"+register_time+"' where id='"+id[i]+"'";
		intrmanufacture_db.executeUpdate(sql);
		}else if(Double.parseDouble(invoicing_sum2)==0){
		String sql7="delete from intrmanufacture_purchasing where id='"+id[i]+"'";
		intrmanufacture_db.executeUpdate(sql7);
		String sql222="update intrmanufacture_details set invoice_check_tag='0' where intrmanufacture_ID='"+intrmanufacture_ID+"' and provider_ID='"+provider_ID[i]+"'";
		intrmanufacture_db.executeUpdate(sql222);
		}
}else{
	if(Double.parseDouble(invoicing_sum2)!=0){
		provider_ID_control=provider_ID[i];
	invoiced_sum_control=Double.parseDouble(invoiced_sum[i])+Double.parseDouble(invoicing_sum2);
		real_invoiced_sum+=Double.parseDouble(invoicing_sum2);
		String sql="update intrmanufacture_purchasing set real_contact_person='"+real_contact_person[i]+"',real_contact_person_tel='"+real_contact_person_tel[i]+"',invoicing_sum='"+invoicing_sum2+"',remark='"+remark[i]+"',register='"+register+"',register_time='"+register_time+"' where id='"+id[i]+"'";
		intrmanufacture_db.executeUpdate(sql);
		}else if(Double.parseDouble(invoicing_sum2)==0){
		String sql7="delete from intrmanufacture_purchasing where id='"+id[i]+"'";
		intrmanufacture_db.executeUpdate(sql7);
		String sql222="update intrmanufacture_details set invoice_check_tag='0' where intrmanufacture_ID='"+intrmanufacture_ID+"' and provider_ID='"+provider_ID[i]+"'";
		intrmanufacture_db.executeUpdate(sql222);
		}	
}
}
	response.sendRedirect("draft/intrmanufacture/invoice_ok.jsp?finished_tag=0");

 }else{
	response.sendRedirect("draft/intrmanufacture/invoice_ok.jsp?finished_tag=5");
	}
 }else{
	response.sendRedirect("draft/intrmanufacture/invoice_ok_d.jsp?intrmanufacture_ID="+intrmanufacture_ID+"");
	}
 }else{
	response.sendRedirect("draft/intrmanufacture/invoice_ok_e.jsp?intrmanufacture_ID="+intrmanufacture_ID+"");
}

	intrmanufacture_db.commit();	
	intrmanufacture_db.close();

}else{
	response.sendRedirect("error_conn.htm");
}

}
catch (Exception ex){
ex.printStackTrace();
}
}
}