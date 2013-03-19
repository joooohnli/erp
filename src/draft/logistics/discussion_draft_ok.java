package draft.logistics;

import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup;
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
import validata.ValidataTag;

public class discussion_draft_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup erp_db = null;
	
public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
PrintWriter out=response.getWriter();
session=request.getSession();
ValidataNumber validata = new ValidataNumber();
ValidataTag vt = new ValidataTag();

nseer_db_backup1 logistics_db = new nseer_db_backup1(dbApplication);

if(logistics_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String discussion_ID=request.getParameter("discussion_ID") ;
String provider_ID=request.getParameter("provider_ID") ;
String provider_name=request.getParameter("provider_name") ;
String demand_contact_person=request.getParameter("demand_contact_person") ;
String demand_contact_person_tel=request.getParameter("demand_contact_person_tel") ;
String demand_contact_person_fax=request.getParameter("demand_contact_person_fax") ;
String demand_pay_time=request.getParameter("demand_pay_time") ;
String register=request.getParameter("register") ;
String register_id=request.getParameter("register_id") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);

int n=0;
for(int i=1;i<=num;i++){
	String tem_amount="amount"+i;
	String tem_off_discount="off_discount"+i;
	String tem_list_price="list_price"+i;
String amount=request.getParameter(tem_amount) ;
String off_discount=request.getParameter(tem_off_discount) ;
String list_price2=request.getParameter(tem_list_price) ;
StringTokenizer tokenTO2 = new StringTokenizer(list_price2,",");     

String list_price="";
            while(tokenTO2.hasMoreTokens()) {
                String list_price1 = tokenTO2.nextToken();
		list_price +=list_price1;
		}
		if(!validata.validata(amount)||!validata.validata(off_discount)||!validata.validata(list_price)){
			n++;
		}
}

if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"logistics_discussion","discussion_ID",discussion_ID,"check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"logistics_discussion","discussion_ID",discussion_ID,"check_tag").equals("9")){
if(n==0){
String sql = "update logistics_discussion set discussion_ID='"+discussion_ID+"',provider_ID='"+provider_ID+"',provider_name='"+provider_name+"',demand_contact_person='"+demand_contact_person+"',demand_contact_person_tel='"+demand_contact_person_tel+"',demand_contact_person_fax='"+demand_contact_person_fax+"',demand_pay_time='"+demand_pay_time+"',register='"+register+"',register_id='"+register_id+"',remark='"+remark+"' where discussion_ID='"+discussion_ID+"'" ;
	logistics_db.executeUpdate(sql) ;

try{
int service_count=0;
int stock_number=0;
double sale_price_sum=0.0d;
double cost_price_sum=0.0d;
for(int i=1;i<=num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;
	String tem_off_discount="off_discount"+i;
	String tem_list_price="list_price"+i;
	String tem_cost_price="cost_price"+i;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount1=request.getParameter(tem_amount) ;
String off_discount=request.getParameter(tem_off_discount) ;
String list_price2=request.getParameter(tem_list_price) ;
StringTokenizer tokenTO2 = new StringTokenizer(list_price2,",");        
String list_price="";
            while(tokenTO2.hasMoreTokens()) {
                String list_price1 = tokenTO2.nextToken();
		list_price +=list_price1;
		}
String cost_price2=request.getParameter(tem_cost_price) ;
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
	double subtotal=Double.parseDouble(list_price)*(1-Double.parseDouble(off_discount)/100)*Double.parseDouble(amount1);
	double cost_price_after_discount_sum=Double.parseDouble(cost_price)*Double.parseDouble(amount1);
	sale_price_sum+=subtotal;
	cost_price_sum+=cost_price_after_discount_sum;
	
	String sql1 = "update logistics_discussion_details set product_ID='"+product_ID+"',product_name='"+product_name+"',product_describe='"+product_describe+"',list_price='"+list_price+"',amount='"+amount1+"',cost_price='"+cost_price+"',off_discount='"+off_discount+"',subtotal='"+subtotal+"' where discussion_ID='"+discussion_ID+"' and details_number='"+i+"'" ;
	logistics_db.executeUpdate(sql1) ;

String product_type="";
String sql16="select * from design_file where product_ID='"+product_ID+"'";
ResultSet rs16=logistics_db.executeQuery(sql16);
if(rs16.next()){
	product_type=rs16.getString("type");
}
if(product_type.equals("物料")||product_type.equals("外购商品")){
	stock_number+=1;
}else if(product_type.equals("商品")||product_type.equals("部件")||product_type.equals("委外部件")){
	stock_number+=1;
}else if(product_type.equals("服务型产品")){
service_count++;
}
}
String sql2="update logistics_discussion set sale_price_sum='"+sale_price_sum+"',cost_price_sum='"+cost_price_sum+"' where discussion_ID='"+discussion_ID+"'";
		logistics_db.executeUpdate(sql2);
	
}
catch (Exception ex){
ex.printStackTrace();
}
	response.sendRedirect("draft/logistics/discussion_choose_attachment.jsp?discussion_ID="+discussion_ID+"");
}else{
	response.sendRedirect("draft/logistics/discussion_ok.jsp?finished_tag=4");
}
}else{
	response.sendRedirect("draft/logistics/discussion_ok.jsp?finished_tag=1");
}

	logistics_db.commit();
	logistics_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}