/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 *
 *This program is distributed in the hope that it will be useful,
 *but WITHOUT ANY WARRANTY; without even the implied warranty of
 *MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *GNU General Public License for more details.
 *
 *You should have received a copy of the GNU General Public License
 *along with this program; if not, write to the Free Software
 *Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 *����ļ��Ƕ��ſƼ�ERP�������ɲ��֡�
 *��Ȩ���У�C��2006-2010 �������Ŵ�ҵ�Ƽ����޹�˾/http://www.nseer.com
 *
 *��һ��������������������������������������GNUͨ�ù������
 *֤���4�޸ĺ����·�����һ���򡣻��������֤�ĵڶ��棬���ߣ�������ѡ
 *�����κθ��µİ汾��
 *
 *������һ�����Ŀ����ϣ�������ã���û���κε���������û���ʺ��ض�Ŀ
 *�ĵ������ĵ���������ϸ����������GNUͨ�ù������֤��
 *��Ӧ���Ѿ��ͳ���һ���յ�һ��GNUͨ�ù������֤�ĸ��������û�У�
 *д�Ÿ�
 *The Free Software Foundation, Inc., 675 Mass Ave, Cambridge,
 *MA02139, USA
 */
package include.get_name_from_ID;

import java.sql.*;
import include.nseer_db.*;

public class ListPrice {
	//��ѯ�����Ϣ

	public double getPrice(String unit_db_name,String file_ID,String account_period) {
		nseer_db db=new nseer_db(unit_db_name);
		double price=0.0d;
		try{
			String sql="select * from finance_gl where file_ID='"+file_ID+"' and account_period='"+account_period+"'";
			ResultSet rs=db.executeQuery(sql);
		    if(rs.next()){
			price=rs.getDouble("current_balance_sum")/rs.getDouble("current_balance_amount");
			}
			db.close();		
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return price;
	}

}