package include.nseerTree;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;
import java.sql.*;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.*;
import java.util.*;
import java.text.*;
import include.nseer_cookie.*;
import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;
import include.nseer_cookie.copyFile;
import include.nseer_db.*;
import include.tree_index.Nseer;
import include.get_sql.getInsertSql;

public class NseerModuleTreeDB{
WebContext ctx = WebContextFactory.get();
HttpServletRequest request = ctx.getHttpServletRequest();//用DWR的对象创建request.
HttpSession session = ctx.getSession();//用DWR的对象创建session.
ServletContext application = session.getServletContext();//用session的对象创建application.
ServletContext context=session.getServletContext();//用session的对象创建context.
nseer_db db=new nseer_db((String)session.getAttribute("unit_db_name"));
Nseer n=new Nseer();
private String path=application.getRealPath("/");//得路径.

	public List getNodeInf(String pid,String tableName,String[] required_array,String[] field_array){//根据传入的节点id，表名，列名，以list形式返回所有子节点信息
		List nameList = (List)new java.util.ArrayList();
		String column_group="";
		for(int i=0;i<field_array.length;i++){
			column_group+=","+field_array[i];
		}
		String sql="select "+required_array[0]+","+required_array[3]+","+required_array[2]+column_group+" from "+tableName+" where "+required_array[1]+"='"+pid+"' order by id";
		try{		
		ResultSet rs =db.executeQuery(sql);
		String value_group="";
		while(rs.next()){
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
	public List getNodeInfBySearch(String key_word,String tableName,String[] required_array,String[] field_array){//根据传入的节点id，表名，列名，以list形式返回所有子节点信息
		List nameList = (List)new java.util.ArrayList();
		String column_group="";
		for(int i=0;i<field_array.length;i++){
			column_group+=","+field_array[i];
		}
		String sql="select "+required_array[0]+","+required_array[3]+","+required_array[2]+column_group+" from "+tableName+" order by id";
		try{
		ResultSet rs =db.executeQuery(sql);
		String value_group="";
		while(rs.next()){
			if(rs.getString(required_array[2]).indexOf(key_word)!=-1){
			for(int i=0;i<field_array.length;i++){
				value_group+="◎"+rs.getString(field_array[i]);
			}
			nameList.add(rs.getString(required_array[0])+"◎"+rs.getString(required_array[2])+"◎"+rs.getString(required_array[3])+"☆"+value_group.substring(1));
			}
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
	
public String insertNodeInf(String tableName,String category_id,String parent_id,String category_name,String[] data_array,String[] field_array,String[] chief_array,String reason,String hreflink,String picture) throws SQLException{//插入方法
String main_kind_name=tableName.substring(0,tableName.length()-5);
String onlyfile="";
		String data_group="";
		String field_group="";
		String finished_tag="";
		for(int i=0;i<chief_array.length-3;i++){
			field_group+=chief_array[i]+",";
		}
		data_group+="'"+category_id+"','"+parent_id+"','"+category_name+"',";
		for(int i=0;i<data_array.length;i++){
			if(i==0){data_group+="'"+data_array[i]+"',";}
			else{data_group+="'"+data_array[i]+"',";}
			field_group+=field_array[i]+",";
		}
/******为操作erp_update_d表做准备**********/
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
Double c_ver=0.00;
String sql_update="select ver from erp_update_t order by ver desc";
ResultSet rs_update=db.executeQuery(sql_update);
if(rs_update.next()){c_ver=rs_update.getDouble("ver");}
int update_tag=0;
String file_path="";
/****************/
String filePath="";
String sql="";
String chain_name="";
String sql13="select * from "+tableName+" where "+chief_array[0]+"='"+parent_id+"'";
ResultSet rs3=db.executeQuery(sql13);//查询父节点。
if(rs3.next()){
 chain_name=rs3.getString("chain_name")+"--"+category_name.substring(category_name.indexOf(" ")+1);
if(rs3.getString("file_path").equals("")){

filePath=main_kind_name+"/"+reason;//得路径
onlyfile=main_kind_name;//得单个文件的路径

sql = "insert into "+tableName+"("+field_group.substring(0,field_group.length()-1)+",file_path,chain_name,picture)values("+data_group.substring(0,data_group.length()-1)+",'"+main_kind_name+"/"+reason+"','"+chain_name+"','"+picture+"')";//执行sql语句
update_tag=1;
}else{
filePath=rs3.getString("file_path")+"/"+reason;
onlyfile=rs3.getString("file_path");
sql = "insert into "+tableName+"("+field_group.substring(0,field_group.length()-1)+",file_path,chain_name,picture)values("+data_group.substring(0,data_group.length()-1)+",'"+rs3.getString("file_path")+"/"+reason+"','"+chain_name+"','"+picture+"')";
file_path=rs3.getString("file_path");
update_tag=2;
}
}else{
filePath=main_kind_name+"/"+reason;
onlyfile=main_kind_name;
chain_name=category_name.substring(category_name.indexOf(" ")+1);
sql = "insert into "+tableName+"("+field_group.substring(0,field_group.length()-1)+",file_path,chain_name,picture)values("+data_group.substring(0,data_group.length()-1)+",'"+main_kind_name+"/"+reason+"','"+chain_name+"','"+picture+"')";
update_tag=3;
}
try{
finished_tag="200";
db.executeUpdate(sql);
/*****在erp_update_d表中插入一条记录********/
String[] fields=field_group.substring(0,field_group.length()-1).split(",");
String[] fields_value=data_group.substring(0,data_group.length()-1).split(",");
String fields_temp="";
for(int a=0;a<fields.length;a++){
	fields_temp+=" and "+fields[a]+"="+fields_value[a];
}
fields_temp=fields_temp.substring(4);
switch(update_tag){
	case 1:
	{		
		sql_update="select id from "+tableName+" where "+fields_temp+" and file_path='"+main_kind_name+"/"+reason+"' and chain_name='"+chain_name+"' and picture='"+picture+"' order by id desc";
		rs_update=db.executeQuery(sql_update);
		if(rs_update.next()){
		sql_update = "insert into erp_update_d(t_name,cols_name,cols_value,ver,register_time,row_id) values('"+tableName+"','㊣"+field_group.substring(0,field_group.length()-1).replaceAll(",", "㊣")+"㊣file_path㊣chain_name㊣picture','㊣"+data_group.substring(0,data_group.length()-1).replaceAll("'", "").replaceAll(",", "㊣")+"㊣"+main_kind_name+"/"+reason+"㊣"+chain_name+"㊣"+picture+"','"+c_ver+"','"+time+"','"+rs_update.getString("id")+"')";
		db.executeUpdate(sql_update);
		}
		break;
	}
	case 2:
	{
		sql_update="select id from "+tableName+" where "+fields_temp+" and file_path='"+file_path+"/"+reason+"' and chain_name='"+chain_name+"' and picture='"+picture+"' order by id desc";
		rs_update=db.executeQuery(sql_update);
		if(rs_update.next()){
		sql_update = "insert into erp_update_d(t_name,cols_name,cols_value,ver,register_time,row_id) values('"+tableName+"','㊣"+field_group.substring(0,field_group.length()-1).replaceAll(",", "㊣")+"㊣file_path㊣chain_name㊣picture','㊣"+data_group.substring(0,data_group.length()-1).replaceAll("'", "").replaceAll(",", "㊣")+"㊣"+file_path+"/"+reason+"㊣"+chain_name+"㊣"+picture+"','"+c_ver+"','"+time+"','"+rs_update.getString("id")+"')";
		db.executeUpdate(sql_update);
		}
		break;
	}
	case 3:
	{
		sql_update="select id from "+tableName+" where "+fields_temp+" and file_path='"+file_path+"/"+reason+"' and chain_name='"+chain_name+"' and picture='"+picture+"' order by id desc";
		rs_update=db.executeQuery(sql_update);
		if(rs_update.next()){
		sql_update = "insert into erp_update_d(t_name,cols_name,cols_value,ver,register_time,row_id) values('"+tableName+"','㊣"+field_group.substring(0,field_group.length()-1).replaceAll(",", "㊣")+"㊣file_path㊣chain_name㊣picture','㊣"+data_group.substring(0,data_group.length()-1).replaceAll("'", "").replaceAll(",", "㊣")+"㊣"+main_kind_name+"/"+reason+"㊣"+chain_name+"㊣"+picture+"','"+c_ver+"','"+time+"','"+rs_update.getString("id")+"')";
		db.executeUpdate(sql_update);
		}
		break;
	}
}
/*****************************************/
}catch(Exception ex){
ex.printStackTrace();	
}
			
String sql1="select "+chief_array[3]+" from "+tableName+" where "+chief_array[0]+"='"+parent_id+"'";
try{
ResultSet rs=db.executeQuery(sql1);//查询节点
if(rs.next()){
if(rs.getString(chief_array[3]).equals("0")){
String sql2="update "+tableName+" set "+chief_array[3]+"='1' where "+chief_array[0]+"='"+parent_id+"'";//更改标志位
db.executeUpdate(sql2);
/*****更新erp_update_d表条记录********/
sql_update="select id from "+tableName+" where "+chief_array[0]+"='"+parent_id+"' and "+chief_array[3]+"='1' order by id desc";
rs_update=db.executeQuery(sql_update);
if(rs_update.next()){
	String row_id=rs_update.getString("id");
	sql_update="select * from erp_update_d where t_name='"+tableName+"' and row_id='"+row_id+"'";
	rs_update=db.executeQuery(sql_update);
	if(rs_update.next()){
		String[] cols_name=rs_update.getString("cols_name").split("㊣");
		String[] cols_value=rs_update.getString("cols_value").split("㊣");
		String cols_temp="";
		int a=0;
		for(int i=0;i<cols_value.length;i++){
			if(cols_name[i].equals(chief_array[3])){
				cols_value[i]="1";
				a++;
			}
			cols_temp+="㊣"+cols_value[i];
		}
		if(a>0){
		sql_update="update erp_update_d set cols_value='"+cols_temp.substring(1)+"' where t_name='"+tableName+"' and row_id='"+row_id+"'";
		}else{
			sql_update="update erp_update_d set cols_name='"+rs_update.getString("cols_name")+"㊣"+chief_array[3]+"',cols_value='"+cols_temp.substring(1)+"㊣1' where t_name='"+tableName+"' and row_id='"+row_id+"'";			
		}
		db.executeUpdate(sql_update);
	}
}
/*****************************************/
}
}
db.close();
}catch(Exception ex){ex.printStackTrace();}						
if(reason.equals("")){
copyFile cp = new copyFile(path+"extend_src/nseer_extend2.jsp",path+onlyfile+"/"+hreflink);//执行文件拷贝
cp.setMakeDirs(false);
cp.copy();
String head_path="";
for(int i=0;i<onlyfile.split("/").length-1;i++){

head_path+="../";//遍历路径

}
CreateFile newfile=new CreateFile();
newfile.toFile(path+onlyfile+"/"+hreflink,"<%@include file=\"../include/head.jsp\"%>","<%@include file=\""+head_path+"include/head.jsp\"%>");
}else{
java.io.File file=new java.io.File(path+filePath);
java.io.File file1=new java.io.File(path+"WEB-INF/src/"+main_kind_name+"/"+reason);
java.io.File fileb=new java.io.File(path+main_kind_name+"/help/"+reason);
finished_tag=main_kind_name+"/"+reason;
if(file.exists()){
finished_tag="该模块已完成初始，请返回确认！";
}else{
file.mkdirs();//生成文件夹
file1.mkdirs();
fileb.mkdirs();

}
}
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
		try{
			/******为操作erp_update_d表做准备**********/
			java.util.Date now = new java.util.Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String time=formatter.format(now);
			Double c_ver=0.00;
			String sql_update="select ver from erp_update_t order by ver desc";
			ResultSet rs_update=db.executeQuery(sql_update);
			if(rs_update.next()){c_ver=rs_update.getDouble("ver");}
			/****************/
		List rsList = (List)new java.util.ArrayList();
		String sql1 = "select "+chief_array[0]+" from "+tableName+" where "+chief_array[1]+"='"+id+"' and reserved_tag!='1'";		
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
			String sql2 = "delete from "+tableName+" where "+chief_array[0]+"='"+pid+"' and reserved_tag!='1'";
			try{
				/*******删除erp_update_d表中的记录******/
				sql_update="select id from "+tableName+" where "+chief_array[0]+"='"+pid+"' and reserved_tag!='1'";
				rs_update=db.executeQuery(sql_update);
				if(rs_update.next()){
					sql_update="delete from erp_update_d where t_name='"+tableName+"' and row_id='"+rs_update.getString("id")+"'";
					db.executeUpdate(sql_update);
				}
				/***********************************/
				db.executeUpdate(sql2);
			}catch(Exception ex){
				ex.printStackTrace();
			}				
		}
		
		try{
			String pid="";
			String sql4="select "+chief_array[1]+" from "+tableName+" where "+chief_array[0]+"='"+id+"' and reserved_tag!='1'";
			ResultSet rs4=db.executeQuery(sql4);
			if(rs4.next()){
				pid=rs4.getString(chief_array[1]);
				
			}
            String sql31 = "select * from "+tableName+" where "+chief_array[0]+"='"+id+"' and reserved_tag!='1'";
			ResultSet rs41=db.executeQuery(sql31);
			if(rs41.next()){
                if(rs41.getString("hreflink").equals("")){
				delAllFile(path+rs41.getString("file_path"));//删除文件
				}else{

					File file = new File(path+rs41.getString("file_path")+rs41.getString("hreflink"));
					file.delete();//删除单个文件

				}

			}
			String sql3 = "delete from "+tableName+" where "+chief_array[0]+"='"+id+"' and reserved_tag!='1'";
			/*******删除erp_update_d表中的记录******/
			sql_update="select id from "+tableName+" where "+chief_array[0]+"='"+id+"' and reserved_tag!='1'";
			rs_update=db.executeQuery(sql_update);
			if(rs_update.next()){
				sql_update="delete from erp_update_d where t_name='"+tableName+"' and row_id='"+rs_update.getString("id")+"'";
				db.executeUpdate(sql_update);
			}
			/***********************************/
			db.executeUpdate(sql3);
			sql4="select id from "+tableName+" where "+chief_array[1]+"='"+pid+"' and reserved_tag!='1'";
			rs4=db.executeQuery(sql4);
			if(!rs4.next()){
				sql3 = "update "+tableName+" set "+chief_array[3]+"='0' where "+chief_array[0]+"='"+pid+"' and reserved_tag!='1'";
				db.executeUpdate(sql3);
				/*****更新erp_update_d表条记录********/
				sql_update="select id from "+tableName+" where "+chief_array[0]+"='"+pid+"' and "+chief_array[3]+"='0'  and reserved_tag!='1' order by id desc";
				rs_update=db.executeQuery(sql_update);
				if(rs_update.next()){
					String row_id=rs_update.getString("id");
					sql_update="select * from erp_update_d where t_name='"+tableName+"' and row_id='"+row_id+"'";
					rs_update=db.executeQuery(sql_update);
					if(rs_update.next()){
						String[] cols_name=rs_update.getString("cols_name").split("㊣");
						String[] cols_value=rs_update.getString("cols_value").split("㊣");
						String cols_temp="";
						int a=0;
						for(int i=0;i<cols_name.length;i++){
							if(cols_name[i].equals(chief_array[3])){
								cols_value[i]="0";
								a++;
							}
							cols_temp+="㊣"+cols_value[i];
						}
						if(a>0){
							sql_update="update erp_update_d set cols_value='"+cols_temp.substring(1)+"' where t_name='"+tableName+"' and row_id='"+row_id+"'";
						}else{
							sql_update="update erp_update_d set cols_name='"+rs_update.getString("cols_name")+"㊣"+chief_array[3]+"',cols_value='"+cols_temp.substring(1)+"㊣1' where t_name='"+tableName+"' and row_id='"+row_id+"'";			
						}
						db.executeUpdate(sql_update);
					}
				}
				/*****************************************/
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	public String deleteNodeInf(String id,String[] chief_array,String tableName){
		String finished_tag="";
		try{
		deleteTemp(id,chief_array,tableName);
		db.close();
		finished_tag="200";
		}catch(Exception ex){ex.printStackTrace();}
		return finished_tag;
	}
	public String[] getSingleNodeInf(String category_id,String tableName,String[] field_array,String[] chief_array){//根据传入的节点id，表名，列名，以list形式返回所有子节点信息
		String[] data_array=new String[field_array.length];
		String column_group="";
		for(int i=0;i<field_array.length;i++){
			column_group+=","+field_array[i];
		}
		String sql="select "+column_group.substring(1)+" from "+tableName+" where "+chief_array[0]+"='"+category_id+"' and reserved_tag!='1'";
		try{		
		ResultSet rs =db.executeQuery(sql);
		if(rs.next()){
			for(int i=0;i<field_array.length;i++){
				if(field_array[i].equals("file_id")){data_array[i]=rs.getString(field_array[i]);}
				else{data_array[i]=rs.getString(field_array[i]);}
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
			/*
		if(file_id.equals(file_id_hidden)||file_id.substring(0,file_id.length()-step_length).equals(file_id_hidden.substring(0,file_id_hidden.length()-step_length))){//如果编号没有修改.
			String sql = "update "+tableName+" set "+chief_array[2]+"='"+n.E(file_id+" "+file_name)+"',"+chief_array[4]+"='"+n.E(file_id)+"',"+chief_array[5]+"='"+n.E(file_name)+"' where "+chief_array[0]+"='"+category_id+"'";		
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
		}*/
		db.close();
			}catch(Exception ex){
				ex.printStackTrace();
			}
		return node_name;
	}

  public static void delAllFile(String filePath) {// 删除文件
		try {

			File file = new File(filePath);
			File[] fileList = file.listFiles();
			String dirPath = null;
			if (fileList != null) {
				for (int i = 0; i < fileList.length; i++) {
					if (fileList[i].isFile()) {
						fileList[i].delete();
					}
					if (fileList[i].isDirectory()) {
						dirPath = fileList[i].getPath();
						delAllFile(dirPath);
					}
				}
				file.delete();
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

}