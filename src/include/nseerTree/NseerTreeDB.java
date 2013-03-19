/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.nseerTree;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;
import include.nseer_db.*;
import include.get_sql.getInsertSql;

public class NseerTreeDB{
	WebContext ctx = WebContextFactory.get();
	HttpServletRequest request=ctx.getHttpServletRequest();
	HttpSession session=request.getSession();
	nseer_db db=new nseer_db((String)session.getAttribute("unit_db_name"));

	public List getNodeInf(String pid,String tableName,String[] required_array,String[] field_array,String conditions){//根据传入的节点id，表名，列名，以list形式返回所有子节点信息
		List nameList = (List)new java.util.ArrayList();
		String column_group="";
		for(int i=0;i<field_array.length;i++){
			column_group+=","+field_array[i];
		}
		if(!conditions.equals("")){conditions="and "+conditions+" ";}
		String sql="select "+required_array[0]+","+required_array[3]+","+required_array[2]+column_group+" from "+tableName+" where "+required_array[1]+"='"+pid+"' "+conditions+"order by "+required_array[4];
		try{		
		ResultSet rs =db.executeQuery(sql);
		String value_group="";
		while(rs.next()){
			value_group="";
			for(int i=0;i<field_array.length;i++){
				value_group+="◎"+rs.getString(field_array[i]);
			}
			if(field_array.length==0){value_group="◎";}
			nameList.add(rs.getString(required_array[0])+"◎"+rs.getString(required_array[2])+"◎"+rs.getString(required_array[3])+"☆"+value_group.substring(1));
		}
		db.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return nameList;
	}
	public List getNodeInfBySearch(String key_word,String tableName,String[] required_array,String[] field_array){//根据传入的节点id，表名，列名，以list形式返回所有子节点信息
		List nameList = (List)new java.util.ArrayList();
		String column_group="";
		for(int i=0;i<field_array.length;i++){
			column_group+=","+field_array[i];
		}
		String sql="select "+required_array[0]+","+required_array[3]+","+required_array[2]+column_group+" from "+tableName+" where "+required_array[2]+" like '%"+key_word+"%' and "+required_array[0]+"!='0' order by "+required_array[4];
		try{
		ResultSet rs =db.executeQuery(sql);
		String value_group="";
		while(rs.next()){
			value_group="";
			for(int i=0;i<field_array.length;i++){
				value_group+="◎"+rs.getString(field_array[i]);
			}
			nameList.add(rs.getString(required_array[0])+"◎"+rs.getString(required_array[2])+"◎"+rs.getString(required_array[3])+"☆"+value_group.substring(1));
		}
		db.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return nameList;
	}
	public String getNodeName(String tableName,String category_id){
		String sql = "select max("+category_id+") from "+tableName;
		String nodeName="";
		try{		
			ResultSet rs =db.executeQuery(sql);
			if(rs.next()){
				nodeName=(rs.getInt("max("+category_id+")")+1)+"";
			}
			db.close();
			}catch(Exception ex){
				ex.printStackTrace();
			}
		return nodeName;
	}
	
	public String insertNodeInf(String tableName,String category_id,String parent_id,String category_name,String[] data_array,String[] field_array,String[] chief_array){//添加节点
		String data_group="";
		String field_group="";
		String finished_tag="";
		for(int i=0;i<chief_array.length-4;i++){
			field_group+=chief_array[i]+",";
		}
		data_group+="'"+category_id+"','"+parent_id+"','"+category_name+"',";
		for(int i=0;i<data_array.length;i++){
			data_group+="'"+data_array[i]+"',";
			field_group+=field_array[i]+",";
		}		
		String sql = "insert into "+tableName+"("+field_group.substring(0,field_group.length()-1)+")values("+data_group.substring(0,data_group.length()-1)+")";
		try{
			finished_tag="200";
			db.executeUpdate(sql);
			}catch(Exception ex){
				ex.printStackTrace();	
			}
			
			String sql1="select "+chief_array[3]+" from "+tableName+" where "+chief_array[0]+"='"+parent_id+"'";
			try{
				ResultSet rs=db.executeQuery(sql1);
				if(rs.next()){
					if(rs.getString(chief_array[3]).equals("0")){
					String sql2="update "+tableName+" set "+chief_array[3]+"='1' where "+chief_array[0]+"='"+parent_id+"'";
					
					db.executeUpdate(sql2);
					}
				}
				/*以下为添加chain_name*/
				String chain_name=category_name.substring(category_name.indexOf(" ")+1);
				while(!parent_id.equals("0")){
					sql1="select "+chief_array[1]+","+chief_array[5]+" from "+tableName+" where "+chief_array[0]+"='"+parent_id+"'";
					rs=db.executeQuery(sql1);
					if(rs.next()){
						chain_name=rs.getString(chief_array[5])+"-"+chain_name;
						parent_id=rs.getString(chief_array[1]);
					}
				}
				sql1="update "+tableName+" set chain_name='"+chain_name+"',chain_id='"+category_name.substring(0,category_name.indexOf(" "))+"' where "+chief_array[0]+"='"+category_id+"'";
				db.executeUpdate(sql1);
				/*添加chain_name结束，记得此时parent_id已为0*/
				db.close();
			}catch(Exception ex){ex.printStackTrace();}
			
			return finished_tag;
	}
	
	
	public String getFileId(String tableName,String[] chief_array,String parent_id,int step_length){//生成II级或之后的编号
		String file_ID="";
		String temp="";
		for(int i=0;i<step_length;i++){
			temp+="0";
		}
		temp="1"+temp;
		try{
	        String sqla = "select "+chief_array[0]+","+chief_array[4]+" from "+tableName+" where "+chief_array[1]+"='"+parent_id+"' order by "+chief_array[0]+" desc";
	        ResultSet rs =db.executeQuery(sqla);
				if(rs.next()){
					String str=rs.getString(chief_array[4]);
					int in1=0;
					String str2=str.substring(str.length()-step_length);
					in1=Integer.parseInt(temp)+Integer.parseInt(str2)+1;
					file_ID=str.substring(0,str.length()-step_length)+(in1+"").substring(1);
				}else{
				   sqla = "select "+chief_array[4]+" from "+tableName+" where "+chief_array[0]+"='"+parent_id+"'";
					rs =db.executeQuery(sqla);
				if(rs.next()){
					file_ID=rs.getString(chief_array[4])+((Integer.parseInt(temp)+1)+"").substring(1);//生成编号
				}
				}
			db.close();
				}catch(Exception ex){
					ex.printStackTrace();
				}
			return file_ID;
		}
	
	public void deleteTemp(String id,String[] chief_array,String tableName){		
		List rsList = (List)new java.util.ArrayList();
		String sql1 = "select "+chief_array[0]+" from "+tableName+" where "+chief_array[1]+"='"+id+"'";		
		try{
			ResultSet rs=db.executeQuery(sql1);
			while(rs.next()){
				rsList.add(rs.getString(chief_array[0]));
			}		
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
			String pid=(String)ite.next();
			deleteTemp(pid,chief_array,tableName);
			String sql2 = "delete from "+tableName+" where "+chief_array[0]+"='"+pid+"'";
			try{
				db.executeUpdate(sql2);
			}catch(Exception ex){
				ex.printStackTrace();
			}				
		}
		
		try{
			String pid="";
			String sql4="select "+chief_array[1]+" from "+tableName+" where "+chief_array[0]+"='"+id+"'";
			ResultSet rs4=db.executeQuery(sql4);
			if(rs4.next()){
				pid=rs4.getString(chief_array[1]);
			}
			String sql3 = "delete from "+tableName+" where "+chief_array[0]+"='"+id+"'";
			db.executeUpdate(sql3);
			sql4="select id from "+tableName+" where "+chief_array[1]+"='"+pid+"'";
			rs4=db.executeQuery(sql4);
			if(!rs4.next()){
				sql3 = "update "+tableName+" set "+chief_array[3]+"='0' where "+chief_array[0]+"='"+pid+"'";
				db.executeUpdate(sql3);
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}		
	}
	public String deleteNodeInf(String id,String[] chief_array,String tableName){
		String finished_tag="";
		try{
		String sql1 = "select "+chief_array[0]+" from "+tableName+" where "+chief_array[0]+"='"+id+"' and "+chief_array[6]+"='0' and "+chief_array[3]+"='0'";		
			ResultSet rs=db.executeQuery(sql1);
			if(rs.next()){
			deleteTemp(id,chief_array,tableName);
			finished_tag="200";
			}else{
				finished_tag="100";
			}
		db.close();
		
		}catch(Exception ex){ex.printStackTrace();}
		return finished_tag;
	}
	public String[] getSingleNodeInf(String category_id,String tableName,String[] field_array,String[] chief_array){//根据传入的节点id，表名，列名，以list形式返回所有子节点信息
		String[] data_array=new String[field_array.length];
		String column_group="";
		for(int i=0;i<field_array.length;i++){
			column_group+=","+field_array[i];
		}
		String sql="select "+column_group.substring(1)+" from "+tableName+" where "+chief_array[0]+"='"+category_id+"'";
		try{		
		ResultSet rs =db.executeQuery(sql);
		if(rs.next()){
			for(int i=0;i<field_array.length;i++){
				data_array[i]=rs.getString(field_array[i]);
			}
		}
		db.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return data_array;
	}
	
	
	
	
	public String changeNodeInf(String tableName,String category_id,String file_id,String file_id_hidden,String file_name,String[] chief_array,int step_length){//此方法起修改节点作用/
		String node_name="";
		try{
		if(file_id.equals(file_id_hidden)||file_id.substring(0,file_id.length()-step_length).equals(file_id_hidden.substring(0,file_id_hidden.length()-step_length))){//如果编号没有修改.
			String sql = "update "+tableName+" set "+chief_array[2]+"='"+file_id+" "+file_name+"',"+chief_array[4]+"='"+file_id+"',"+chief_array[5]+"='"+file_name+"' where "+chief_array[0]+"='"+category_id+"'";		
			db.executeUpdate(sql);	
		}else{//如果编号修改.
			String parent_ID=file_id.substring(0,file_id.length()-step_length);
			String sqla="select "+chief_array[0]+" from "+tableName+" where "+chief_array[4]+"='"+parent_ID+"'";
			ResultSet rs=db.executeQuery(sqla);		
		if(rs.next()){
			node_name=rs.getString(chief_array[0]);
		}
		String sql = "update "+tableName+" set "+chief_array[2]+"='"+file_id+" "+file_name+"',"+chief_array[1]+"='"+node_name+"',"+chief_array[4]+"='"+file_id+"',"+chief_array[5]+"='"+file_name+"' where "+chief_array[0]+"='"+category_id+"'";
		db.executeUpdate(sql);		
		
		sql="update "+tableName+" set "+chief_array[3]+"='1' where "+chief_array[0]+"='"+node_name+"'";
		db.executeUpdate(sql);
		String pid1="";
		sqla="select "+chief_array[0]+" from "+tableName+" where "+chief_array[4]+"='"+file_id_hidden.substring(0,file_id_hidden.length()-step_length)+"'";
		rs=db.executeQuery(sqla);
		if(rs.next()){
		pid1=rs.getString(chief_array[0]);		
		sqla="select id from "+tableName+" where "+chief_array[1]+"='"+pid1+"'";
		rs=db.executeQuery(sqla);
		if(!rs.next()){
			sql="update "+tableName+" set "+chief_array[3]+"='0' where "+chief_array[4]+"='"+file_id_hidden.substring(0,file_id_hidden.length()-step_length)+"'";
			db.executeUpdate(sql);
		}
		}
		}
		/*以下为添加chain_name*/
		String chain_name="";
		String sql1="select chain_name from "+tableName+" where "+chief_array[0]+"='"+category_id+"'";
		ResultSet rs=db.executeQuery(sql1);
		if(rs.next()){
			chain_name=rs.getString("chain_name");
		}
		if(chain_name.indexOf("-")!=-1){
			chain_name=chain_name.substring(0,chain_name.lastIndexOf("-"))+"-"+file_name;
		}else{
			chain_name=file_name;
		}	
		sql1="update "+tableName+" set chain_name='"+chain_name+"' where "+chief_array[0]+"='"+category_id+"'";
		db.executeUpdate(sql1);
		db.close();
			}catch(Exception ex){
				ex.printStackTrace();
			}
		return node_name;
	}

	public void changeNodeAttribute(String tableName,String file_id,String[] field_array,String[] data_array){//此方法起修改节点属性作用/
		try{
		String sql="update "+tableName+" set ";
		for(int i=0;i<field_array.length;i++){
			sql=sql+field_array[i]+"='"+data_array[i]+"',";
		}
		sql=sql.substring(0,sql.length()-1)+" where file_id='"+file_id+"'";
		db.executeUpdate(sql);
			db.close();
			}catch(Exception ex){
				ex.printStackTrace();
			}
	}
}