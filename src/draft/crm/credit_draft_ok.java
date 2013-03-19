package draft.crm;


import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import java.io.* ;
import include.nseer_cookie.*;
import include.nseer_db.*;
import java.text.*;
import validata.ValidataNumber;
import validata.ValidataRecord;
import validata.ValidataTag;


public class credit_draft_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
PrintWriter out=response.getWriter();


nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))&&crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){

FileKind  FileKind = new  FileKind();
ValidataNumber validata= new  ValidataNumber();
ValidataRecord vr= new   ValidataRecord();

counter  count= new   counter(dbApplication);
ValidataTag  vt= new  ValidataTag();
String register_ID=(String)dbSession.getAttribute("human_IDD");
String config_id=request.getParameter("config_id");
String pay_ID=request.getParameter("pay_ID") ;
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
String payer_name=request.getParameter("payer_name") ;
String payer_ID=request.getParameter("payer_ID") ;
String reason=request.getParameter("reason") ;
String not_return_tag=request.getParameter("not_return_tag") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String demand_return_time=request.getParameter("demand_return_time") ;
String check_time=request.getParameter("check_time") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String sales_name=request.getParameter("sales_name");
String sales_ID=request.getParameter("sales_ID");
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);
String[] product_IDn=request.getParameterValues("product_ID") ;
String[] amountn=request.getParameterValues("amount") ;
if(num==0&&product_IDn.length==1){
	response.sendRedirect("draft/crm/credit_ok_a.jsp?pay_ID="+pay_ID);
}else{
int p=0;
int n=0;
String product_ID_group=",";
for(int i=1;i<=num;i++){
	String tem_amount="amount"+i;
String amount=request.getParameter(tem_amount) ;
if(amount.equals("")) amount="0";
	if(!validata.validata(amount)){
			p++;
		}
}
for(int j=1;j<product_IDn.length;j++){
	product_ID_group+=product_IDn[j]+",";
		if(!validata.validata(amountn[j])){
			p++;
		}
}
for(int i=1;i<=num;i++){
	String tem_product_ID="product_ID"+i;
	String product_ID=request.getParameter(tem_product_ID) ;
	if(product_ID_group.indexOf(product_ID)!=-1) n++;
}
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"stock_apply_pay","pay_ID",pay_ID,"check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"stock_apply_pay","pay_ID",pay_ID,"check_tag").equals("9")){
if(p==0){
try{
if(n==0){
String sqll = "" ;
String[] aaa1=FileKind.getKind((String)dbSession.getAttribute("unit_db_name"),"crm_file","customer_ID",payer_ID);


double demand_amount=0.0d;
double list_price_sum=0.0d;
double cost_price_sum=0.0d;


for(int i=1;i<=num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_available_amount="available_amount"+i;
	String tem_amount="amount"+i;
	String tem_list_price="list_price"+i;
	String tem_cost_price="cost_price"+i;
	String tem_type="type"+i;
	String tem_amount_unit="amount_unit"+i ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String available_amount=request.getParameter(tem_available_amount) ;
String amount=request.getParameter(tem_amount) ;
if(amount.equals("")) amount="0";
String list_price2=request.getParameter(tem_list_price) ;
String cost_price=request.getParameter(tem_cost_price) ;
String type=request.getParameter(tem_type) ;
StringTokenizer tokenTO3 = new StringTokenizer(list_price2,","); 
String list_price="";
            while(tokenTO3.hasMoreTokens()) {
                String list_price1 = tokenTO3.nextToken();
		list_price +=list_price1;
		}
String amount_unit=request.getParameter(tem_amount_unit) ;
	double list_price_subtotal=Double.parseDouble(list_price)*Double.parseDouble(amount);
	list_price_sum+=list_price_subtotal;
	double cost_price_subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amount);
	cost_price_sum+=cost_price_subtotal;
	demand_amount+=Double.parseDouble(amount);
	String sql1 = "update stock_apply_pay_details set amount='"+amount+"',list_price='"+list_price+"',list_price_subtotal='"+list_price_subtotal+"',cost_price='"+cost_price+"',subtotal='"+cost_price_subtotal+"' where pay_ID='"+pay_ID+"' and details_number='"+i+"'" ;
	stock_db.executeUpdate(sql1) ;

}
String[] cost_pricen=request.getParameterValues("cost_price") ;
String[] list_pricen=request.getParameterValues("list_price") ;
String[] product_namen=request.getParameterValues("product_name") ;
String[] product_describen=request.getParameterValues("product_describe") ;
String[] amount_unitn=request.getParameterValues("amount_unit") ;
String[] typen=request.getParameterValues("type") ;
for(int i=1;i<product_IDn.length;i++){
StringTokenizer tokenTO3 = new StringTokenizer(list_pricen[i],",");        
String list_price="";
            while(tokenTO3.hasMoreTokens()) {
                String list_price1 = tokenTO3.nextToken();
		list_price +=list_price1;
		}
	if(!amountn[i].equals("")&&Double.parseDouble(amountn[i])!=0){
	double list_price_subtotal=Double.parseDouble(list_price)*Double.parseDouble(amountn[i]);
	list_price_sum+=list_price_subtotal;
	double subtotal=Double.parseDouble(cost_pricen[i])*Double.parseDouble(amountn[i]);
	cost_price_sum+=subtotal;
	demand_amount+=Double.parseDouble(amountn[i]);
	num++;
	String sql1 = "insert into stock_apply_pay_details(payer_chain_ID,payer_chain_name,sales_ID,sales_name,payer_ID,payer_name,payer_type,pay_ID,details_number,product_ID,product_name,product_describe,amount,amount_unit,list_price,list_price_subtotal,cost_price,subtotal,type) values ('"+aaa1[0]+"','"+aaa1[1]+"','"+sales_ID+"','"+sales_name+"','"+payer_ID+"','"+payer_name+"','销售赊货','"+pay_ID+"','"+num+"','"+product_IDn[i]+"','"+product_namen[i]+"','"+product_describen[i]+"','"+amountn[i]+"','"+amount_unitn[i]+"','"+list_price+"','"+list_price_subtotal+"','"+cost_pricen[i]+"','"+subtotal+"','"+typen[i]+"')" ;
	stock_db.executeUpdate(sql1) ;

	}
}

	String sql = "update stock_apply_pay set reason='"+reason+"',register='"+register+"',register_time='"+register_time+"',demand_return_time='"+demand_return_time+"',checker='"+checker+"',remark='"+remark+"',demand_amount='"+demand_amount+"',list_price_sum='"+list_price_sum+"',cost_price_sum='"+cost_price_sum+"',not_return_tag='"+not_return_tag+"' where pay_ID='"+pay_ID+"'" ;
	stock_db.executeUpdate(sql) ;


response.sendRedirect("draft/crm/credit_ok.jsp?finished_tag=0");
}else{
	
response.sendRedirect("draft/crm/credit_ok.jsp?finished_tag=7&pay_ID="+pay_ID+"");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}else{
	
response.sendRedirect("draft/crm/credit_ok.jsp?finished_tag=2&pay_ID="+pay_ID+"");
}}else{
	

response.sendRedirect("draft/crm/credit_ok.jsp?finished_tag=3");
}
}
stock_db.commit();
crm_db.commit();
stock_db.close();
crm_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}
