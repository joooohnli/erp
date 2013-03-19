/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.nseer_cookie;

import java.sql.*;
import include.nseer_db.*;

public class getArryFromValue{
private String[] aa=new String[1];

public String[] getArryFromOneValue(String dbName,String table,String field1,String field2,String value,String field_type){
nseer_db db=new nseer_db(dbName);

try{
	String sql="";
	if(field_type.equals("0")){
		sql="select "+field1+" from "+table+" where "+field2+"='"+value+"' order by id";
	}else{
		sql="select "+field1+" from "+table+" where "+field2+"='"+value+"' and fieldType_tag='1' order by id";
	}
ResultSet rs=db.executeQuery(sql);

int i=0;
while(rs.next()){
i++;


}
aa=new String[i];
rs.first();
for(int j=0;j<i;j++){
aa[j]=rs.getString(field1);
rs.next();


}
}catch(Exception e) {
	e.printStackTrace();
}

db.close();
return aa;



}
}
