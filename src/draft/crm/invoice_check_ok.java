package draft.crm;

import include.nseer_cookie.counter;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.Iterator;
import java.util.List;
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
import validata.ValidataTag;


public class invoice_check_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
ValidataTag vt = new ValidataTag();
String reasonexact=request.getParameter("reasonexact") ;
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"crm_order","order_ID",reasonexact,"invoice_check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"crm_order","order_ID",reasonexact,"invoice_check_tag").equals("9")){
counter  count=new counter(dbApplication);
ValidataNumber validata=new  ValidataNumber();
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
int p=0;
int pp=0;
List rsList = (List)new java.util.ArrayList();
	String[] elem=new String[3];
	String sql="select id,describe1,describe2 from crm_config_workflow where type_id='06'";
	ResultSet rset=crm_db.executeQuery(sql);
	while(rset.next()){
		elem=new String[3];
		elem[0]=rset.getString("id");
		elem[1]=rset.getString("describe1");
		elem[2]=rset.getString("describe2");
		rsList.add(elem);
	}
for(int i=1;i<=num;i++){
	String tem_invoice_sum="invoice_sum"+i;
	String tem_remark="remark"+i;
String invoice_sum2=request.getParameter(tem_invoice_sum) ;
String remark=request.getParameter(tem_remark) ;
if(invoice_sum2==null||invoice_sum2.equals("")){
	invoice_sum2="0";
	pp++;
}
if(remark==null) remark="";
StringTokenizer tokenTO2 = new StringTokenizer(invoice_sum2,",");        
String invoice_sum="";
            while(tokenTO2.hasMoreTokens()) {
                String invoice_sum1 = tokenTO2.nextToken();
		invoice_sum +=invoice_sum1;
		}
		if(!validata.validata(invoice_sum)){
			p++;
		}
		if(remark.indexOf("'")!=-1||remark.indexOf("\"")!=-1){
			p++;
		}
}
if(p==0&&pp!=num){

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
String register_time=request.getParameter("register_time") ;
String invoice_group=request.getParameter("invoice_group") ;
double invoiced_subtotal_sum=0;
int n=0;
if(n!=0){
	response.sendRedirect("draft/crm/invoice_ok_a.jsp?order_ID="+reasonexact+"");
}else{
int which_time=Integer.parseInt(request.getParameter("which_time")) ;
double invoiced_subtotal_sum_all=0.0d;
for(int j=1;j<=num;j++){
	invoiced_subtotal_sum=0;
	String tem_details_number="details_number"+j;
	String tem_product_name="product_name"+j;
	String tem_product_ID="product_ID"+j;
	String tem_subtotal="subtotal"+j;
	String tem_invoice_sum="invoice_sum"+j;
	String tem_invoiced_subtotal="invoiced_subtotal"+j;
	String tem_remark="remark"+j;
	String tem_id="id"+j;
String id=request.getParameter(tem_id) ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String details_number=request.getParameter(tem_details_number) ;
String subtotal=request.getParameter(tem_subtotal) ;
String invoice_sum2=request.getParameter(tem_invoice_sum) ;

String remark=request.getParameter(tem_remark) ;
//String tem_unit=request.getParameter(tem_unit) ;
if(invoice_sum2!=null&&!invoice_sum2.equals("")){
StringTokenizer tokenTO1 = new StringTokenizer(invoice_sum2,",");        
String invoice_sum="";
            while(tokenTO1.hasMoreTokens()) {
                String invoice_sum1 = tokenTO1.nextToken();
		invoice_sum +=invoice_sum1;
		}
invoiced_subtotal_sum_all+=Double.parseDouble(invoice_sum);
	String sql1 = "update crm_ordering set reason='"+reason+"',customer_ID='"+customer_ID+"',customer_name='"+customer_name+"',real_customer_mailing_address='"+real_customer_mailing_address+"',real_contact_person='"+real_contact_person+"',real_contact_person_tel='"+real_contact_person_tel+"',real_contact_person_fax='"+real_contact_person_fax+"',real_invoice_time='"+real_invoice_time+"',real_invoice_type='"+real_invoice_type+"',register='"+register+"',register_ID='"+register_ID+"',register_time='"+register_time+"',product_ID='"+product_ID+"',product_name='"+product_name+"',invoice_sum='"+invoice_sum+"',remark='"+remark+"',invoice_group='"+invoice_group+"' where id='"+id+"'";
	crm_db.executeUpdate(sql1) ;
	if(rsList.size()==0){
		sql1="update crm_ordering set check_tag='1' where id='"+id+"'";
		crm_db.executeUpdate(sql1) ;
		sql1="select subtotal,invoiced_subtotal from crm_order_details where order_ID='"+reasonexact+"' and details_number='"+details_number+"'";
		rset=crm_db.executeQuery(sql1);
		if(rset.next()){
			double subtotal_control=rset.getDouble("invoiced_subtotal")+Double.parseDouble(invoice_sum);
			double subtotala=rset.getDouble("subtotal");
			if(subtotal_control==subtotala){
			sql1="update crm_order_details set invoiced_subtotal='"+subtotal_control+"',invoice_tag='1' where order_ID='"+reasonexact+"' and details_number='"+details_number+"'";
			crm_db.executeUpdate(sql1) ;
			}else{		
			String sql3="update crm_order_details set invoiced_subtotal='"+subtotal_control+"' where order_ID='"+reasonexact+"' and details_number='"+details_number+"'";
			crm_db.executeUpdate(sql3) ;
			}
		}
	}
}
}

if(rsList.size()==0){
	int m=0;
double sale_price_sum=0.0d;
double invoiced_sum=0.0d;
double uninvoice_sum=0.0d;
String sql4="select id from crm_order_details where order_ID='"+reasonexact+"' and invoice_tag='0'";
ResultSet rs4=crm_db.executeQuery(sql4);
if(!rs4.next()){
String sql6="select sale_price_sum from crm_order where order_ID='"+reasonexact+"'";
ResultSet rs6=crm_db.executeQuery(sql6);
if(rs6.next()){
	sale_price_sum=rs6.getDouble("sale_price_sum");
}
String sql5="update crm_order set invoiced_sum='"+sale_price_sum+"',uninvoice_sum='0',invoice_tag='3' where order_ID='"+reasonexact+"'";
	crm_db.executeUpdate(sql5) ;
	String sql21="select id from crm_order where gather_tag='3' and logistics_tag='3' and receive_tag='3' and invoice_tag='3' and pay_tag='3' and check_tag='1' and order_ID='"+reasonexact+"'";
		ResultSet rs21=crm_db.executeQuery(sql21);
		if(rs21.next()){
		String sql22="update crm_order set order_tag='2',order_status='完成',accomplish_time='"+register_time+"' where order_ID='"+reasonexact+"'";
		crm_db.executeUpdate(sql22);
		}
}else{
	String sql6="select sale_price_sum,invoiced_sum from crm_order where order_ID='"+reasonexact+"'";
ResultSet rs6=crm_db.executeQuery(sql6);
if(rs6.next()){
	sale_price_sum=rs6.getDouble("sale_price_sum");
	invoiced_sum=rs6.getDouble("invoiced_sum")+invoiced_subtotal_sum_all;
}
uninvoice_sum=sale_price_sum-invoiced_sum;
String sql5="update crm_order set invoiced_sum='"+invoiced_sum+"',uninvoice_sum='"+uninvoice_sum+"',invoice_check_tag='0',which_time='"+which_time+"' where order_ID='"+reasonexact+"'";
	crm_db.executeUpdate(sql5) ;
}
}else{
	String sql1="update crm_order set invoice_check_tag='1',invoice_tag='2',which_time='"+which_time+"' where order_ID='"+reasonexact+"'";
	crm_db.executeUpdate(sql1) ;
	sql1="delete from crm_workflow where object_ID='"+reasonexact+"' and which_time='"+which_time+"'";
	crm_db.executeUpdate(sql1) ;
	Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql = "insert into crm_workflow(config_id,object_ID,describe1,describe2,which_time) values ('"+elem[0]+"','"+reasonexact+"','"+elem[1]+"','"+elem[2]+"','"+which_time+"')" ;
		crm_db.executeUpdate(sql) ;
		}
}

response.sendRedirect("draft/crm/invoice_ok.jsp?finished_tag=3");
}

}else{
response.sendRedirect("draft/crm/invoice_ok_b.jsp?order_ID="+reasonexact+"");

}
}else{
response.sendRedirect("draft/crm/invoice_ok.jsp?finished_tag=4");
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