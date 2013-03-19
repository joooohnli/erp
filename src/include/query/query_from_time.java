/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.query;


public class query_from_time {
	private String sql="";
	private String timea="";
	private String timeb="";
	public String query_from_time(String timea,String timeb){
		this.timea=timea;
		this.timeb=timeb;
		if(!timea.equals("")) timea=timea+" 00:00:00";

		if(!timeb.equals("")) timeb=timeb+" 23:59:59";

		if(!timea.equals("")&&timeb.equals("")){

			sql="select distinct static_report_ID,register,static_report_time from stock_balance_static_report where static_report_time>='"+timea+"' order by static_report_time desc";

		}else if(!timea.equals("")&&!timeb.equals("")){

			sql="select distinct static_report_ID,register,static_report_time from stock_balance_static_report where static_report_time>='"+timea+"' and static_report_time<='"+timeb+"' order by static_report_time desc";
		}
	else if(timea.equals("")&&!timeb.equals("")){

			sql="select distinct static_report_ID,register,static_report_time from stock_balance_static_report where static_report_time<='"+timeb+"' order by static_report_time desc";
		}

		else if(timea.equals("")&&timeb.equals("")){

			sql="select distinct static_report_ID,register,static_report_time from stock_balance_static_report order by static_report_time desc";
		}
		return sql;
	}
}

	