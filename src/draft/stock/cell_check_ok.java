package draft.stock;
 
 
import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.Iterator;
import java.util.List;

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

public class cell_check_ok extends HttpServlet{

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

try{
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String register_ID=(String)session.getAttribute("human_IDD");//**************
String config_id=request.getParameter("config_id");//****************
String min_amount=request.getParameter("min_amount");
String max_amount=request.getParameter("max_amount");
String stock_amount=request.getParameter("stock_amount");
String design_ID=request.getParameter("design_ID");
String product_ID=request.getParameter("product_ID");
int num=Integer.parseInt(stock_amount);
String designer=request.getParameter("designer") ;
String bodyc = new String(request.getParameter("cell_describe").getBytes("UTF-8"),"UTF-8");
String cell_describe=exchange.toHtml(bodyc);
String register_time=request.getParameter("register_time") ;
String register=request.getParameter("register") ;
String serial_number_tag=request.getParameter("serial_number_tag");
//################################################################
List rsList = GetWorkflow.getList(stock_db, "stock_config_workflow", "07");
	String[] elem=new String[3];
//################################################################
int p=0;
int q=0;

for(int i=1;i<num;i++){
String tem_max_capacity_amount="max_capacity_amount"+i;
String tem_nick_name="nick_name"+i;
String tem_amount_unit="amount_unit"+i;
String tem_stock_ID="stock_ID"+i;
String stock_ID=request.getParameter(tem_stock_ID) ;
String max_capacity_amount=request.getParameter(tem_max_capacity_amount) ;
String nick_name=request.getParameter(tem_nick_name) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
if(max_capacity_amount.equals("")) max_capacity_amount="0";
		if(!validata.validata(max_capacity_amount)){
			p++;
		}else if(Double.parseDouble(max_capacity_amount)==0){
			q++;
			String sql5="select * from stock_balance_details where stock_ID='"+stock_ID+"' and product_ID='"+product_ID+"'";
			ResultSet rs5=stock_db.executeQuery(sql5);
			if(rs5.next()){
				p++;
			}
		}else if(Double.parseDouble(max_capacity_amount)<0){
			p++;
		}
		if(nick_name.indexOf("'")!=-1||nick_name.indexOf("\"")!=-1||nick_name.indexOf(",")!=-1||amount_unit.indexOf("'")!=-1||amount_unit.indexOf("\"")!=-1||amount_unit.indexOf(",")!=-1){
			p++;
		}
}
if(!validata.validata(min_amount)||!validata.validata(max_amount)){
p++;
}
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"stock_cell","design_ID",design_ID,"check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"stock_cell","design_ID",design_ID,"check_tag").equals("9")){

if(p==0&&q<num-1){

try{

if(rsList.size()==0){//55555555555555555555555555555555555555555555
String sql = "update stock_cell set register_time='"+register_time+"',register='"+register+"',designer='"+designer+"',cell_describe='"+cell_describe+"',min_amount='"+min_amount+"',max_amount='"+max_amount+"',check_tag='1',change_tag='0',serial_number_tag='"+serial_number_tag+"' where design_ID='"+design_ID+"'" ;
stock_db.executeUpdate(sql) ;
}else{

String sql = "update stock_cell set register_time='"+register_time+"',register='"+register+"',designer='"+designer+"',cell_describe='"+cell_describe+"',min_amount='"+min_amount+"',max_amount='"+max_amount+"',check_tag='0',change_tag='0',serial_number_tag='"+serial_number_tag+"' where design_ID='"+design_ID+"'" ;
stock_db.executeUpdate(sql);
Iterator ite=rsList.iterator();
while(ite.hasNext()){
elem=(String[])ite.next();
String nseer_sql = "insert into stock_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+design_ID+"','"+elem[1]+"','"+elem[2]+"')";
stock_db.executeUpdate(nseer_sql);
}

}

String sql4="select * from stock_cell where design_ID='"+design_ID+"'";
ResultSet rs4=stock_db.executeQuery(sql4);
if(rs4.next()){
		product_ID=rs4.getString("product_ID");
}
for(int i=1;i<num;i++){
	String tem_stock_name="stock_name"+i;
	String tem_stock_ID="stock_ID"+i;
	String tem_nick_name="nick_name"+i;
	String tem_max_capacity_amount="max_capacity_amount"+i;
	String tem_amount_unit="amount_unit"+i;
String stock_name=request.getParameter(tem_stock_name) ;
String stock_ID=request.getParameter(tem_stock_ID) ;
String nick_name=request.getParameter(tem_nick_name) ;
String max_capacity_amount=request.getParameter(tem_max_capacity_amount) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
if(!max_capacity_amount.equals("")&&Double.parseDouble(max_capacity_amount)!=0){
String sql3="select * from stock_cell_details where design_ID='"+design_ID+"' and stock_name='"+stock_name+"'";
ResultSet rs3=stock_db.executeQuery(sql3) ;
if(rs3.next()){
	String sql1 = "update stock_cell_details set details_number='"+i+"',nick_name='"+nick_name+"',max_capacity_amount='"+max_capacity_amount+"',amount_unit='"+amount_unit+"' where design_ID='"+design_ID+"' and stock_name='"+stock_name+"'" ;
	stock_db.executeUpdate(sql1) ;
}else{
	String sql2 = "insert into stock_cell_details(design_ID,details_number,stock_ID,stock_name,nick_name,max_capacity_amount,amount_unit) values ('"+design_ID+"','"+i+"','"+stock_ID+"','"+stock_name+"','"+nick_name+"','"+max_capacity_amount+"','"+amount_unit+"')" ;
	stock_db.executeUpdate(sql2) ;
}

if(rsList.size()==0){
String sql31="update stock_balance_details set max_capacity_amount='"+max_capacity_amount+"' where product_ID='"+product_ID+"' and stock_ID='"+stock_ID+"'";
String sql5="update stock_pre_gathering set max_capacity_amount='"+max_capacity_amount+"' where product_ID='"+product_ID+"' and stock_ID='"+stock_ID+"'";
stock_db.executeUpdate(sql31) ;
stock_db.executeUpdate(sql5) ;
String sql77="update design_file set serial_number_tag='"+serial_number_tag+"' where product_ID='"+product_ID+"'";
stock_db.executeUpdate(sql77);
}

}else if(max_capacity_amount.equals("")||Double.parseDouble(max_capacity_amount)==0){
	sql4 = "delete from stock_cell_details where design_ID='"+design_ID+"' and stock_ID='"+stock_ID+"'" ;
	stock_db.executeUpdate(sql4) ;
}
}

}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("draft/stock/cell_ok.jsp?finished_tag=5");
}else{
response.sendRedirect("draft/stock/cell_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("draft/stock/cell_ok.jsp?finished_tag=6");
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