package include.work;

import include.nseer_cookie.MathString;
import include.nseer_cookie.UserInfo;
import include.nseer_cookie.UnitInfo;
import include.nseer_db.*;
import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.*;
import include.operateXML.*;

public class Work extends HttpServlet
{	
    public void service(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
    {
    	HttpSession session = request.getSession(true);
    	ServletContext application=session.getServletContext();
        nseer_db_backup1 erp_db=new nseer_db_backup1(application);
    	nseer_db_backup1 dbm=new nseer_db_backup1(application);
    	UnitInfo unitinfo=new UnitInfo();
		ServletContext context=session.getServletContext();
		String path=context.getRealPath("/");
    	String count="";
        response.setContentType("text/html; charset=UTF-8");
        String username = request.getParameter("username").toLowerCase();
        String passwd = request.getParameter("passwd");
		String language = request.getParameter("language");
		String ui = request.getParameter("ui");
		String ip = request.getRemoteAddr();
        Date date = new Date();
        SimpleDateFormat simpledateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String s = simpledateformat.format(date);
		String ss=formatter.format(date);
		int user_amount=0;
		String use_expiry="";
		String register_time="";
		int expiry_period=0;
		String field_type="";
		if(username.indexOf("_")!=-1){
		String unit_id=username.substring(0,username.indexOf("_"));
        if(language.equals("")) language=(String)session.getAttribute("language");
		if(language==null) language="chinese";
		try{
		if(!unitinfo.getDbName(unit_id).equals("")){
if(erp_db.conn(unitinfo.getDbName(unit_id))&&dbm.conn("mysql")){
		String unit_name = request.getParameter("unit_name");
		if(unit_name!=null){
			if(unit_name.equals("")) unit_name="恩信科技开源ERP用户";
			String sql="update unit_info set unit_name='"+unit_name+"',active_tag='1' where unit_id='"+unit_id+"'";
			dbm.executeUpdate(sql);
		}
		String sqlm="select * from unit_info where unit_id='"+unit_id+"'";
		ResultSet rsm=dbm.executeQuery(sqlm);
		if(rsm.next()){
			user_amount=rsm.getInt("user_amount");
			use_expiry=rsm.getString("use_period");
			register_time=rsm.getString("register_time");
			expiry_period=rsm.getInt("expiry_period");
			field_type=rsm.getString("field_type");
		}
		java.util.Date date1 = formatter.parse(register_time);
		java.util.Date date2 = formatter.parse(use_expiry);
		long Time=(date1.getTime()/1000)+60*60*24*expiry_period;
		date1.setTime(Time*1000);
        if(application.getAttribute(unit_id) == null)
        {
            application.setAttribute(unit_id, "0");
            count = (String)application.getAttribute(unit_id);
        } else
        {
            count = (String)application.getAttribute(unit_id);
        }		
                String s1 = "select * from security_users where name='" + username + "' and passwd='" + passwd + "' and forbid_tag='0'";
                ResultSet resultset = erp_db.executeQuery(s1);
				if(Integer.parseInt(count)<MathString.getCount(unitinfo.getDbName(unit_id)))
                {
                if(resultset.next()&&username.equals(resultset.getString("name"))&&passwd.equals(resultset.getString("passwd")))
                {
                        String s2 = resultset.getString("tagc");
                        String s3 = resultset.getString("human_name");
                        String s4 = resultset.getString("human_ID");
                        
                            application.setAttribute(username , username);//防止重复登陆
                            session.setAttribute("usernamec", username);
                            session.setAttribute("tagc", s2);
                            session.setAttribute("realeditorc", s3);
                            session.setAttribute("human_IDD", s4);
                            session.setAttribute("userName", username);
							session.setAttribute("unit_db_name", unitinfo.getDbName(unit_id));
							session.setAttribute("unit_name", unitinfo.getUnitName(unit_id));
							session.setAttribute("unit_id", unit_id);
							session.setAttribute("field_type", field_type);
                            TtoXml.createListXml(path+"xml/include/listPage/"+username+session.getId()+".xml",s3,username,unitinfo.getDbName(unit_id));
                            String s6 = "insert into security_alive_access(chain_ID,chain_name,human_ID,human_name,editor,modulec,time1,modulei) values('"+resultset.getString("chain_ID")+"','"+resultset.getString("chain_name")+"','" + s4 + "','" + s3 + "','" + username + "','" + s2 + "','" + s + "','" + ip + "')";
                            erp_db.executeUpdate(s6);//保存登陆记录
                            String s7 = "select * from security_alive_access where human_name='" + s3 + "' and modulec='" + s2 + "' and time1='" + s + "'";
                            ResultSet resultset1 = erp_db.executeQuery(s7);
							resultset1.next();
                            session.setAttribute("idc", resultset1.getString(1));
                            session.setAttribute("USERC", new UserInfo(unit_id,username, session.getId(), resultset1.getString("id")));
                            count = String.valueOf(Integer.parseInt(count) + 1);
                            application.setAttribute(unit_id, count);

                     String sql_lang="update security_users set language='"+language+"' where human_ID='"+s4+"'";
                     erp_db.executeUpdate(sql_lang);
					 if(request.getParameter("remember")!=null)
						{
						Cookie cookie=new Cookie("rem_userName", request.getParameter("username")); 
						cookie.setMaxAge(360*24*60*60); 
						response.addCookie(cookie); 
						}		
							if(ui.equals("0")){
                            response.sendRedirect("main/index.jsp");
							}else if(ui.equals("1")){
								response.sendRedirect("main/index1.jsp");
							}else{
								response.sendRedirect("security/workspace/workspace.jsp");
							}               
                }else{
                    response.sendRedirect("home/check1.jsp");
                }
				 }else{
                    response.sendRedirect("home/check5.jsp");
                }
	erp_db.commit();
    dbm.commit();
	erp_db.close();
    dbm.close();
			}else{
                response.sendRedirect("home/check6.jsp");
                }
		}else{
		    response.sendRedirect("home/check1.jsp");
		}
			}catch(Exception exception){
                exception.printStackTrace();
            }		
			}else{
                    response.sendRedirect("home/check1.jsp");
                }
    }
}
