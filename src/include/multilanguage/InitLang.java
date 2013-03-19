/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.multilanguage;

import javax.servlet.*;
import java.sql.*;
import java.util.*;
import include.nseer_db.*;

public class InitLang{

public void init(String unit_db_name,ServletContext application){
Hashtable tt=null;
String key="";
nseer_db_backup db=new nseer_db_backup(application);
nseer_db_backup db1=new nseer_db_backup(application);
try{
if(db.conn(unit_db_name)&&db1.conn(unit_db_name)){
String sq="select type_name from document_config_public_char where kind='语言类型' and type_name='chinese'";
ResultSet rse=db1.executeQuery(sq);
if(!rse.next()){
	sq="insert into document_config_public_char(kind,type_name) values('语言类型','chinese')";
	db1.executeUpdate(sq);
	sq ="ALTER TABLE  document_multilanguage ADD chinese varchar(200)  NOT NULL";
	db1.executeUpdate(sq) ;
}
String sql1="select type_name from document_config_public_char where kind='语言类型'";

ResultSet rs1=db1.executeQuery(sql1);
String lang="";
while(rs1.next()){
	lang=rs1.getString("type_name");
	String m="init";
String sql="select * from document_multilanguage where tablename!='erp' order by tablename";
ResultSet rs2=db.executeQuery(sql);

while(rs2.next()){
	if(!m.equals(rs2.getString("tablename"))){
		key="multilanguage_"+m+"_"+lang;
if(tt!=null) application.setAttribute(key,tt);
		m=rs2.getString("tablename");
		tt=new Hashtable();
if(rs2.getString(lang).equals("")){ tt.put(rs2.getString("name"),rs2.getString("name"));
}else{
tt.put(rs2.getString("name"),rs2.getString(lang));
}
	}else{
if(rs2.getString(lang).equals("")){ tt.put(rs2.getString("name"),rs2.getString("name"));
}else{
tt.put(rs2.getString("name"),rs2.getString(lang));
}
	}
}
key="multilanguage_"+m+"_"+lang;
if(tt!=null) application.setAttribute(key,tt);
}


sql1="select type_name from document_config_public_char where kind='语言类型'";

rs1=db1.executeQuery(sql1);
lang="";
while(rs1.next()){
	lang=rs1.getString("type_name");
	tt=new Hashtable();
String sql="select name,"+lang+" from document_multilanguage where tablename='erp'";
ResultSet rs2=db.executeQuery(sql);

while(rs2.next()){
if(rs2.getString(lang).equals("")){ tt.put(rs2.getString("name"),rs2.getString("name"));
}else{
tt.put(rs2.getString("name"),rs2.getString(lang));
}
}
key="multilanguage_erp_"+lang;
application.setAttribute(key,tt);
}
db.close();
db1.close();
} else {
				System.out.println("i am sorry!");
 		}
}catch(Exception e){

e.printStackTrace();

}


}

	

    
}