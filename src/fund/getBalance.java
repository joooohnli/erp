/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package fund;

import java.sql.*;
import include.nseer_db.*;

public class getBalance {
	//查询条件信息
  private String sql="";

  private ResultSet rs=null;
  private double cost_price_sum=0.0d;

	public double balance(String unit_db_name,String first_ID,String first_name,String currency_name) {
		nseer_db dba=new nseer_db(unit_db_name);
		try{
			sql="select * from fund_balance_details where fund_chain_ID='"+first_ID+"' and fund_chain_name='"+first_name+"' and currency_name='"+currency_name+"'";
			rs=dba.executeQuery(sql);
			if(rs.next()){
				cost_price_sum=rs.getDouble("cost_price_sum");
			}else{
				cost_price_sum=0;
			}
			dba.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return cost_price_sum;
	}

}