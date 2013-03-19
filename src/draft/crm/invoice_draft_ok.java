package draft.crm;

import include.nseer_cookie.counter;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.io.PrintWriter;
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
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
ValidataNumber validata = new  ValidataNumber();
   nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
   counter  count= new   counter(dbApplication);
	PrintWriter out=response.getWriter();
String product_amount=request.getParameter("product_amount") ;
String reasonexact=request.getParameter("reasonexact") ;
String which_time=request.getParameter("which_time");
int num=Integer.parseInt(product_amount);
String reason=request.getParameter("reason") ;
String customer_ID=request.getParameter("customer_ID") ;
String customer_name=request.getParameter("customer_name") ;
String real_customer_mailing_address=request.getParameter("real_customer_mailing_address") ;
String real_contact_person=request.getParameter("real_contact_person") ;
String real_contact_person_tel=request.getParameter("real_contact_person_tel") ;
String real_contact_person_fax=request.getParameter("real_contact_person_fax") ;
String real_invoice_time=request.getParameter("real_invoice_time") ;
String real_invoice_type=request.getParameter("real_invoice_type") ;
String register=request.getParameter("register") ;
String register_ID=request.getParameter("register_ID") ;
String invoice_group=request.getParameter("invoice_group") ;
String register_time=request.getParameter("register_time") ;
double invoiced_subtotal_sum=0.0d;
double invoiced_subtotal_sum_all=0.0d;
int p=0;
for(int i=1;i<=num;i++){
	String tem_invoice_sum="invoice_sum"+i;
String invoice_sum2=request.getParameter(tem_invoice_sum) ;
if(invoice_sum2.equals("")) invoice_sum2="0";
StringTokenizer tokenTO2 = new StringTokenizer(invoice_sum2,",");        
String invoice_sum="";
            while(tokenTO2.hasMoreTokens()) {
                String invoice_sum1 = tokenTO2.nextToken();
		invoice_sum +=invoice_sum1;
		}
		if(!validata.validata(invoice_sum)){
			p++;
		}
}
if(p==0){
	int n=0;
if(n==0){
String sql8="select * from crm_order where order_id='"+reasonexact+"' and (invoice_check_tag='9' or invoice_check_tag='5') and which_time='"+which_time+"'";
ResultSet rs8=crm_db.executeQuery(sql8);
if(rs8.next()){
	String product_ID_control1=request.getParameter("product_ID1") ;
	String subtotal_control1=request.getParameter("invoiced_subtotal1") ;
	double subtotal_control=Double.parseDouble(subtotal_control1);
for(int j=1;j<=num;j++){
	invoiced_subtotal_sum=0;
	String tem_details_number="details_number"+j;
	String tem_product_name="product_name"+j;
	String tem_product_ID="product_ID"+j;
	String tem_subtotal="subtotal"+j;
	String tem_invoice_sum="invoice_sum"+j;
	String tem_invoiced_subtotal="invoiced_subtotal"+j;
	String tem_remark="remark"+j;
	//String tem_unit="unit"+j ;
	String tem_id="id"+j;
String id=request.getParameter(tem_id) ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String details_number=request.getParameter(tem_details_number) ;
String subtotal=request.getParameter(tem_subtotal) ;
String invoiced_subtotal=request.getParameter(tem_invoiced_subtotal) ;
String invoice_sum2=request.getParameter(tem_invoice_sum) ;
if(invoice_sum2.equals("")) invoice_sum2="0";
StringTokenizer tokenTO1 = new StringTokenizer(invoice_sum2,",");        
String invoice_sum="";
            while(tokenTO1.hasMoreTokens()) {
                String invoice_sum1 = tokenTO1.nextToken();
		invoice_sum +=invoice_sum1;
		}
String remark=request.getParameter(tem_remark) ;
if(product_ID.equals(product_ID_control1)){
if(invoice_sum!=null&&Double.parseDouble(invoice_sum)!=0){
subtotal_control+=Double.parseDouble(invoice_sum);
invoiced_subtotal_sum_all+=Double.parseDouble(invoice_sum);
	String sql1 = "update crm_ordering set reason='"+reason+"',customer_ID='"+customer_ID+"',customer_name='"+customer_name+"',real_customer_mailing_address='"+real_customer_mailing_address+"',real_contact_person='"+real_contact_person+"',real_contact_person_tel='"+real_contact_person_tel+"',real_contact_person_fax='"+real_contact_person_fax+"',real_invoice_time='"+real_invoice_time+"',real_invoice_type='"+real_invoice_type+"',register='"+register+"',register_ID='"+register_ID+"',register_time='"+register_time+"',product_ID='"+product_ID+"',product_name='"+product_name+"',invoice_sum='"+invoice_sum+"',remark='"+remark+"',invoice_group='"+invoice_group+"' where id='"+id+"'" ;
	crm_db.executeUpdate(sql1) ;
	
}else if(Double.parseDouble(invoice_sum)==0){
	String sql7 = "delete from crm_ordering where id='"+id+"'" ;	
	crm_db.executeUpdate(sql7) ;
}
}else{
if(invoice_sum!=null&&Double.parseDouble(invoice_sum)!=0){
product_ID_control1=product_ID;
subtotal_control=Double.parseDouble(invoiced_subtotal)+Double.parseDouble(invoice_sum);
invoiced_subtotal_sum_all+=Double.parseDouble(invoice_sum);
	String sql1 = "update crm_ordering set reason='"+reason+"',customer_ID='"+customer_ID+"',customer_name='"+customer_name+"',real_customer_mailing_address='"+real_customer_mailing_address+"',real_contact_person='"+real_contact_person+"',real_contact_person_tel='"+real_contact_person_tel+"',real_contact_person_fax='"+real_contact_person_fax+"',real_invoice_time='"+real_invoice_time+"',real_invoice_type='"+real_invoice_type+"',register='"+register+"',register_ID='"+register_ID+"',register_time='"+register_time+"',product_ID='"+product_ID+"',product_name='"+product_name+"',invoice_sum='"+invoice_sum+"',remark='"+remark+"',invoice_group='"+invoice_group+"' where id='"+id+"'" ;
	crm_db.executeUpdate(sql1) ;
}else if(Double.parseDouble(invoice_sum)==0){
	String sql7 = "delete from crm_ordering where id='"+id+"'" ;	
	crm_db.executeUpdate(sql7) ;
}
}
}

response.sendRedirect("draft/crm/invoice_ok.jsp?finished_tag=0");
	}else{
response.sendRedirect("draft/crm/invoice_ok.jsp?finished_tag=1");
}
	}else{	
response.sendRedirect("draft/crm/invoice_ok_a.jsp?order_ID="+reasonexact+"");
}
	}else{
	response.sendRedirect("draft/crm/invoice_ok_b.jsp?order_ID="+reasonexact+"");
	}
crm_db.commit();
crm_db.close();

}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}