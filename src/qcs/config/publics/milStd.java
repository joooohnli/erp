package qcs.config.publics;

import java.sql.*;
import java.util.Iterator;
import java.util.List;

import include.nseer_db.nseer_db_backup1;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

public class milStd{
	WebContext ctx = WebContextFactory.get();
	HttpServletRequest request=ctx.getHttpServletRequest();
	HttpSession session=request.getSession();
	ServletContext application=session.getServletContext();
	nseer_db_backup1 qcs_db = new nseer_db_backup1(application);
	public List getTypeGroup(String group_id){
		List<String[]> list=(List)(new java.util.ArrayList());
		try{
		if(qcs_db.conn((String)session.getAttribute("unit_db_name"))){
		String sql="select type_id,type_name,sample_amount from qcs_config_mil_std where group_id='"+group_id+"'";
		ResultSet rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			String[] array=new String[3];
			array[0]=rs.getString("type_id");
			array[1]=rs.getString("type_name");
			array[2]=rs.getString("sample_amount");
			list.add(array);
		}
		qcs_db.commit();
		qcs_db.close();
		}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return list;
	}
	public List getValue(String type_id,String group_id){
		List<String> list1=(List)(new java.util.ArrayList());
		List<String[]> list2=(List)(new java.util.ArrayList());
		try{
		String group_column="";
		if(qcs_db.conn((String)session.getAttribute("unit_db_name"))){
		String sql="select type_id from qcs_config_public_char where kind='AQL'";
		ResultSet rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			list1.add(rs.getString("type_id"));
		}
		
		sql="select * from qcs_config_mil_std where group_id='"+group_id+"' and type_id='"+type_id+"'";
		rs=qcs_db.executeQuery(sql);
		if(rs.next()){
			for(int i=0;i<list1.size();i++){
			String[] array=new String[3];
			array[0]=list1.get(i);
			array[1]=rs.getString("aql"+list1.get(i).replace(".","p")+"_ac");
			array[2]=rs.getString("aql"+list1.get(i).replace(".","p")+"_re");
			list2.add(array);
			}
		}
		qcs_db.commit();
		qcs_db.close();
		}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return list2;
	}
	
}
