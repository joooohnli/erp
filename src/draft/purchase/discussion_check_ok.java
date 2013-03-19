package draft.purchase;


import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.* ;
import java.util.*;
import java.io.* ;
import include.nseer_cookie.exchange;
import include.nseer_db.*;
import include.nseer_cookie.counter;
import validata.*;
import include.get_rate_from_ID.getRateFromID;
import include.nseer_cookie.*;


public class discussion_check_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;


public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{//实例化
PrintWriter out=response.getWriter();
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);
if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))){
counter count= new  counter(dbApplication);
	ValidataNumber validata= new ValidataNumber();
	ValidataRecord vr= new ValidataRecord();
	ValidataTag vt = new ValidataTag();
	getRateFromID getRateFromID= new getRateFromID();
String discussion_ID=request.getParameter("discussion_ID") ;
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"purchase_discussion","discussion_ID",discussion_ID,"check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"purchase_discussion","discussion_ID",discussion_ID,"check_tag").equals("9")){
String changer=request.getParameter("changer") ;
String changer_ID=request.getParameter("changer_ID") ;

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
if(n==0){
double sale_price_sum_old=0.0d;
String provider_ID=request.getParameter("provider_ID") ;
String provider_name=request.getParameter("provider_name") ;
String demand_contact_person=request.getParameter("demand_contact_person") ;
String demand_contact_person_tel=request.getParameter("demand_contact_person_tel") ;
String demand_contact_person_fax=request.getParameter("demand_contact_person_fax") ;
String demand_pay_time=request.getParameter("demand_pay_time") ;
String change_time=request.getParameter("change_time") ;

String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);

try{
	String sql16="select * from purchase_discussion where discussion_ID='"+discussion_ID+"'";
	ResultSet rs16=purchase_db.executeQuery(sql16) ;
	if(rs16.next()){
		sale_price_sum_old=rs16.getDouble("sale_price_sum");
	}
	String sql = "update purchase_discussion set discussion_ID='"+discussion_ID+"',provider_ID='"+provider_ID+"',provider_name='"+provider_name+"',demand_contact_person='"+demand_contact_person+"',demand_contact_person_tel='"+demand_contact_person_tel+"',demand_contact_person_fax='"+demand_contact_person_fax+"',demand_pay_time='"+demand_pay_time+"',remark='"+remark+"',check_tag='0',discussion_tag='0',modify_tag='1' where discussion_ID='"+discussion_ID+"'" ;

	purchase_db.executeUpdate(sql) ;
double pay_amount_sum=0.0d;
double sale_price_sum=0.0d;
double cost_price_sum=0.0d;
n=1;
for(int i=1;i<=num;i++){
	double amount1=0.0d;
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;
	String tem_off_discount="off_discount"+i;
	String tem_list_price="list_price"+i;
	String tem_cost_price="cost_price"+i;
	String tem_amount_unit="amount_unit"+i ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount=request.getParameter(tem_amount) ;
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
String amount_unit=request.getParameter(tem_amount_unit) ;
	double subtotal=Double.parseDouble(list_price)*(1-Double.parseDouble(off_discount)/100)*Double.parseDouble(amount);
	double cost_price_after_discount_sum=Double.parseDouble(cost_price)*Double.parseDouble(amount);
	sale_price_sum+=subtotal;
	cost_price_sum+=cost_price_after_discount_sum;
	pay_amount_sum+=Double.parseDouble(amount);
	String sql1 = "update purchase_discussion_details set list_price='"+list_price+"',amount='"+amount+"',amount_unit='"+amount_unit+"',cost_price='"+cost_price+"',off_discount='"+off_discount+"',subtotal='"+subtotal+"' where discussion_ID='"+discussion_ID+"' and details_number='"+i+"'" ;
	purchase_db.executeUpdate(sql1) ;
}

List rsList = GetWorkflow.getList(purchase_db, "purchase_config_workflow", "02");
	if(rsList.size()==0){
		String sql2="update purchase_discussion set sale_price_sum='"+sale_price_sum+"',cost_price_sum='"+cost_price_sum+"',modify_tag='0',discussion_tag='1',discussion_status='等待',check_tag='1' where discussion_ID='"+discussion_ID+"'";
		purchase_db.executeUpdate(sql2) ;
	}else{
		String sql2="delete from purchase_workflow where object_ID='"+discussion_ID+"'";
		purchase_db.executeUpdate(sql2) ;
		sql2="update purchase_discussion set check_tag='0',discussion_tag='0',modify_tag='1',sale_price_sum='"+sale_price_sum+"',cost_price_sum='"+cost_price_sum+"' where discussion_ID='"+discussion_ID+"'";
		purchase_db.executeUpdate(sql2) ;
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql2 = "insert into purchase_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+discussion_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		purchase_db.executeUpdate(sql2) ;
		}
	}
}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("draft/purchase/discussion_choose_attachment.jsp?discussion_ID="+discussion_ID+"");
	}else{		
response.sendRedirect("draft/purchase/discussion_ok_a.jsp?discussion_ID="+discussion_ID+"");
}
}else{		
response.sendRedirect("draft/purchase/discussion_ok_b.jsp?discussion_ID="+discussion_ID+"");
}
purchase_db.commit();
purchase_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){ex.printStackTrace();}
}
}