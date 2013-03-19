package draft.stock;
 
import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.NseerId;
import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.text.SimpleDateFormat;
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
import validata.ValidataRecord;
import validata.ValidataTag;

public class transferGather_check_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
counter count=new counter(dbApplication);
ValidataTag vt=new ValidataTag();
ValidataRecord vr=new ValidataRecord();

try{
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String gather_ID=request.getParameter("gather_ID") ;
String product_amount=request.getParameter("product_amount") ;
String config_id=request.getParameter("config_id");//***********
String checker_ID=(String)session.getAttribute("human_IDD");//***********
String[] product_IDn=request.getParameterValues("product_ID") ;//########
String[] amountn=request.getParameterValues("amount") ;//########
int num=Integer.parseInt(product_amount);
String reasonexact=request.getParameter("reasonexact") ;
StringTokenizer tokenTO =null;
String stock_ID ="";
String stock_name="";
if(!reasonexact.equals("  /")){
tokenTO = new StringTokenizer(reasonexact,"/");        

            while(tokenTO.hasMoreTokens()) {
                stock_ID = tokenTO.nextToken();
				stock_name = tokenTO.nextToken();
		}
}else{
   tokenTO = new StringTokenizer(reasonexact,"/");        
     if(tokenTO.hasMoreTokens()) {
         stock_ID = tokenTO.nextToken();}
}
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String check_time=request.getParameter("check_time") ;
String checker=request.getParameter("checker") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String product_ID_group=",";

List rsList = GetWorkflow.getList(stock_db, "stock_config_workflow", "03");
String[] elem=new String[3];
int p=0;
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
if(num==0&&product_IDn.length==1){
	response.sendRedirect("draft/stock/transferGather_ok_c.jsp?gather_ID="+gather_ID+"");
}else{
	int m=0;
for(int i=1;i<=num;i++){
	String tem_product_ID="product_ID"+i;
	String product_ID=request.getParameter(tem_product_ID) ;
	if(product_ID_group.indexOf(product_ID)!=-1) m++;
}

if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"stock_transfer_gather","gather_ID",gather_ID,"check_tag").equals("9")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"stock_transfer_gather","gather_ID",gather_ID,"check_tag").equals("5")){

if(p==0){
if(m==0){

	String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);
String sqll = "update stock_transfer_gather set check_tag='1' where gather_ID='"+gather_ID+"'" ;
	stock_db.executeUpdate(sqll) ;
	
	String stock_gather_ID=NseerId.getId("stock/gather",(String)dbSession.getAttribute("unit_db_name"));
	String stock_pay_ID=NseerId.getId("stock/pay",(String)dbSession.getAttribute("unit_db_name"));

try{
double demand_amount=0.0d;
double cost_price_sum=0.0d;

for(int i=1;i<=num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_amount="amount"+i;
	String tem_cost_price="cost_price"+i;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String amount=request.getParameter(tem_amount) ;
if(amount.equals("")) amount="0";
String cost_price2=request.getParameter(tem_cost_price) ;
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}

	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amount);
	cost_price_sum+=subtotal;
	demand_amount+=Double.parseDouble(amount);
	String sql1 = "update stock_transfer_gather_details set product_ID='"+product_ID+"',product_name='"+product_name+"',amount='"+amount+"',cost_price='"+cost_price+"',subtotal='"+subtotal+"' where gather_ID='"+gather_ID+"' and details_number='"+i+"'" ;
	stock_db.executeUpdate(sql1) ;
	if(rsList.size()==0){
	String sql2="insert into stock_gather_details(gather_ID,details_number,product_ID,product_name,cost_price,subtotal,amount,ungather_amount) values('"+stock_gather_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+cost_price+"','"+subtotal+"','"+amount+"','"+amount+"')";
	stock_db.executeUpdate(sql2) ;
	String sql5="insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,cost_price,subtotal,amount,unpay_amount) values('"+stock_pay_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+cost_price+"','"+subtotal+"','"+amount+"','"+amount+"')";
	stock_db.executeUpdate(sql5) ;

	}
}
String[] cost_pricen=request.getParameterValues("cost_price") ;
product_IDn=request.getParameterValues("product_ID") ;
String[] product_namen=request.getParameterValues("product_name") ;
String[] amount_unitn=request.getParameterValues("amount_unit") ;
String[] product_describen=request.getParameterValues("product_describe") ;
amountn=request.getParameterValues("amount") ;
for(int i=1;i<product_IDn.length;i++){
	StringTokenizer tokenTO3 = new StringTokenizer(cost_pricen[i],",");        
String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
	if(!amountn[i].equals("")&&Double.parseDouble(amountn[i])!=0){
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amountn[i]);
	cost_price_sum+=subtotal;
	num++;
	demand_amount+=Double.parseDouble(amountn[i]);

	String sql1 = "insert into stock_transfer_gather_details(gather_ID,details_number,product_ID,product_name,product_describe,amount_unit,amount,cost_price,subtotal) values ('"+gather_ID+"','"+num+"','"+product_IDn[i]+"','"+product_namen[i]+"','"+product_describen[i]+"','"+amount_unitn[i]+"','"+amountn[i]+"','"+cost_price+"','"+subtotal+"')" ;
	stock_db.executeUpdate(sql1) ;
	if(rsList.size()==0){
	String sql2="insert into stock_gather_details(gather_ID,details_number,product_ID,product_name,cost_price,subtotal,amount,ungather_amount) values('"+stock_gather_ID+"','"+num+"','"+product_IDn[i]+"','"+product_namen[i]+"','"+cost_price+"','"+subtotal+"','"+amountn[i]+"','"+amountn[i]+"')";
	stock_db.executeUpdate(sql2) ;
	String sql5="insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,cost_price,subtotal,amount,unpay_amount) values('"+stock_pay_ID+"','"+num+"','"+product_IDn[i]+"','"+product_namen[i]+"','"+cost_price+"','"+subtotal+"','"+amountn[i]+"','"+amountn[i]+"')";
	stock_db.executeUpdate(sql5) ;

	}
	}
}
if(rsList.size()==0){
		String sql = "update stock_transfer_gather set reasonexact='"+reasonexact+"',register='"+register+"',register_time='"+register_time+"',check_time='"+check_time+"',checker='"+checker+"',remark='"+remark+"',demand_amount='"+demand_amount+"',cost_price_sum='"+cost_price_sum+"',check_tag='1' where gather_ID='"+gather_ID+"'" ;
		stock_db.executeUpdate(sql);
		if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"stock_gather","reasonexact",gather_ID)){
	String sql4="insert into stock_gather(gather_ID,reason,reasonexact,reasonexact_details,demand_amount,cost_price_sum,register,register_time) values('"+stock_gather_ID+"','内部调入','"+gather_ID+"','"+stock_name+"','"+demand_amount+"','"+cost_price_sum+"','"+checker+"','"+check_time+"')";
	stock_db.executeUpdate(sql4) ;
}
	if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"stock_pay","reasonexact",gather_ID)){
	String sql4="insert into stock_pay(pay_ID,reason,reasonexact,reasonexact_details,demand_amount,cost_price_sum,register,register_time) values('"+stock_pay_ID+"','内部调入','"+gather_ID+"','"+stock_name+"','"+demand_amount+"','"+cost_price_sum+"','"+checker+"','"+check_time+"')";
	stock_db.executeUpdate(sql4) ;
}
	}else{
		String sql = "update stock_transfer_gather set reasonexact='"+reasonexact+"',register='"+register+"',register_time='"+register_time+"',check_time='"+check_time+"',checker='"+checker+"',remark='"+remark+"',demand_amount='"+demand_amount+"',cost_price_sum='"+cost_price_sum+"',check_tag='0' where gather_ID='"+gather_ID+"'" ;
		stock_db.executeUpdate(sql);
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		String nseer_sql = "insert into stock_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+gather_ID+"','"+elem[1]+"','"+elem[2]+"')";
		stock_db.executeUpdate(nseer_sql);
		}
	}
}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("draft/stock/transferGather_ok.jsp?finished_tag=5");
}else{
response.sendRedirect("draft/stock/transferGather_ok.jsp?finished_tag=6");
}
}else{
response.sendRedirect("draft/stock/transferGather_ok.jsp?finished_tag=2");
}}else{
response.sendRedirect("draft/stock/transferGather_ok.jsp?finished_tag=7");
}
}
	stock_db.commit();
	stock_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}