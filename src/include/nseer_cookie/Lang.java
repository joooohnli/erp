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

public class Lang{

	private String[] b;

public String[] getLangs(String db){
try{
nseer_db nseerA=new nseer_db(db);
int i=0;
String[] a=new String[10000];
String sql="select * from document_config_public_char where kind='语言类型' order by id";
ResultSet rs=nseerA.executeQuery(sql);
while(rs.next()){
a[i]=rs.getString("type_name");
i++;
}
b=new String[i];
for(int j=0;j<i;j++){
	b[j]=a[j];
}
nseerA.close();
}catch(Exception ex){ex.printStackTrace();}
return b;
}
}