/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.apply_gather;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.*;
import java.io.*;
import include.nseer_db.*;
import java.text.*;
import include.nseer_cookie.*;
import validata.ValidataNumber;
import validata.ValidataRecord;
import validata.ValidataTag;

public class register_ok extends HttpServlet {

	public synchronized void service(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		HttpSession dbSession = request.getSession();
		JspFactory _jspxFactory = JspFactory.getDefaultFactory();
		PageContext pageContext = _jspxFactory.getPageContext(this, request,
				response, "", true, 8192, true);
		ServletContext dbApplication = dbSession.getServletContext();

		ServletContext application;
		HttpSession session = request.getSession();
		nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
		ValidataNumber validata = new ValidataNumber();
		counter count = new counter(dbApplication);
		ValidataRecord vr = new ValidataRecord();
		try {
			String time = "";
			java.util.Date now = new java.util.Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			time = formatter.format(now);
			String mod = request.getRequestURI();
			if (stock_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				String product_amount = request.getParameter("product_amount");
				int num = Integer.parseInt(product_amount);
				int p = 0;
				for (int i = 1; i < num; i++) {
					String tem_amount = "amount" + i;
					String amount = request.getParameter(tem_amount);
					if (!validata.validata(amount)) {
						p++;
					}
				}
				if (p == 0) {
					String gather_ID = request.getParameter("gather_ID");
					if (gather_ID.equals("")) {
					}
					String gatherer_name = request
							.getParameter("gatherer_name");
					String gatherer_ID = request.getParameter("gatherer_ID");
					String reason = request.getParameter("reason");
					String not_return_tag = request
							.getParameter("not_return_tag");
					String register = request.getParameter("register");
					String register_time = request
							.getParameter("register_time");
					String demand_return_time = request
							.getParameter("demand_return_time");
					String bodyb = new String(request.getParameter("remark")
							.getBytes("UTF-8"), "UTF-8");
					String remark = exchange.toHtml(bodyb);
					try {
						String stock_gather_ID = NseerId
								.getId("stock/gather", (String) dbSession
										.getAttribute("unit_db_name"));
						String pay_ID = NseerId
								.getId("stock/pay", (String) dbSession
										.getAttribute("unit_db_name"));

						int filenum = count.readTime1((String) dbSession
								.getAttribute("unit_db_name"), mod);
						count.writeTime1((String) dbSession
								.getAttribute("unit_db_name"), mod);

						gather_ID = NseerId.getId(getClass().getResource("")
								.toString(), (String) dbSession
								.getAttribute("unit_db_name"));
						String sql3 = "delete from stock_apply_gather where gather_ID='"
								+ gather_ID + "'";
						stock_db.executeUpdate(sql3);
						String sql4 = "delete from stock_apply_gather_details where gather_ID='"
								+ gather_ID + "'";
						stock_db.executeUpdate(sql4);
						String sql = "insert into stock_apply_gather(gather_ID,gatherer_name,gatherer_ID,reason,register_time,demand_return_time,remark,register,check_tag,excel_tag,not_return_tag) values ('"
								+ gather_ID
								+ "','"
								+ gatherer_name
								+ "','"
								+ gatherer_ID
								+ "','"
								+ reason
								+ "','"
								+ register_time
								+ "','"
								+ demand_return_time
								+ "','"
								+ remark
								+ "','"
								+ register
								+ "','0','2','" + not_return_tag + "')";
						stock_db.executeUpdate(sql);
						double cost_price_sum = 0.0d;
						double demand_amount = 0.0d;

						List rsList = GetWorkflow.getList(stock_db,
								"stock_config_workflow", "01");
						String[] elem = new String[3];

						for (int i = 1; i < num; i++) {
							String tem_product_name = "product_name" + i;
							String tem_product_ID = "product_ID" + i;
							String tem_product_describe = "product_describe"
									+ i;
							String tem_amount = "amount" + i;
							String tem_cost_price = "cost_price" + i;
							String tem_amount_unit = "amount_unit" + i;
							String product_name = request
									.getParameter(tem_product_name);
							String product_ID = request
									.getParameter(tem_product_ID);
							String product_describe = request
									.getParameter(tem_product_describe);
							String amount = request.getParameter(tem_amount);
							String amount_unit = request
									.getParameter(tem_amount_unit);
							String cost_price2 = request
									.getParameter(tem_cost_price);
							StringTokenizer tokenTO3 = new StringTokenizer(
									cost_price2, ",");
							String cost_price = "";
							while (tokenTO3.hasMoreTokens()) {
								String cost_price1 = tokenTO3.nextToken();
								cost_price += cost_price1;
							}
							if (!amount.equals("")
									&& Double.parseDouble(amount) != 0) {
								double subtotal = Double
										.parseDouble(cost_price)
										* Double.parseDouble(amount);
								cost_price_sum += subtotal;
								demand_amount += Double.parseDouble(amount);
								String sql1 = "insert into stock_apply_gather_details(gather_ID,details_number,product_ID,product_name,product_describe,amount,amount_unit,cost_price,subtotal) values ('"
										+ gather_ID
										+ "','"
										+ i
										+ "','"
										+ product_ID
										+ "','"
										+ product_name
										+ "','"
										+ product_describe
										+ "','"
										+ amount
										+ "','"
										+ amount_unit
										+ "','"
										+ cost_price + "','" + subtotal + "')";
								stock_db.executeUpdate(sql1);
								if (rsList.size() == 0) {
									String sql2 = "insert into stock_gather_details(gather_ID,details_number,product_ID,product_name,cost_price,subtotal,amount,ungather_amount) values('"
											+ stock_gather_ID
											+ "','"
											+ i
											+ "','"
											+ product_ID
											+ "','"
											+ product_name
											+ "','"
											+ cost_price
											+ "','"
											+ subtotal
											+ "','"
											+ amount
											+ "','" + amount + "')";
									stock_db.executeUpdate(sql2);
									if (not_return_tag.equals("0")
											&& !reason.equals("库存初始")) {
										sql3 = "insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,cost_price,subtotal,amount,unpay_amount) values('"
												+ pay_ID
												+ "','"
												+ i
												+ "','"
												+ product_ID
												+ "','"
												+ product_name
												+ "','"
												+ cost_price
												+ "','"
												+ subtotal
												+ "','"
												+ amount
												+ "','"
												+ amount + "')";
										stock_db.executeUpdate(sql3);
									}
								}
							}
						}
						if (rsList.size() == 0) {
							String nseer_sql = "update stock_apply_gather set cost_price_sum='"
									+ cost_price_sum
									+ "',demand_amount='"
									+ demand_amount
									+ "',check_tag='1' where gather_ID='"
									+ gather_ID + "'";
							stock_db.executeUpdate(nseer_sql);
							if (!vr.validata((String) dbSession
									.getAttribute("unit_db_name"),
									"stock_gather", "reasonexact", gather_ID)) {// 88888888
								sql4 = "insert into stock_gather(gather_ID,reason,reasonexact,reasonexact_details,demand_amount,cost_price_sum,register,register_time) values('"
										+ stock_gather_ID
										+ "','"
										+ reason
										+ "','"
										+ gather_ID
										+ "','"
										+ gatherer_name
										+ "','"
										+ demand_amount
										+ "','"
										+ cost_price_sum
										+ "','"
										+ register
										+ "','"
										+ register_time
										+ "')";
								stock_db.executeUpdate(sql4);
							}
							if (not_return_tag.equals("0")
									&& !reason.equals("库存初始")) {
								if (!vr.validata((String) dbSession
										.getAttribute("unit_db_name"),
										"stock_pay", "reasonexact", gather_ID)) {
									String sql5 = "insert into stock_pay(pay_ID,reason,reasonexact,reasonexact_details,demand_amount,cost_price_sum,register,register_time) values('"
											+ pay_ID
											+ "','"
											+ reason
											+ "','"
											+ gather_ID
											+ "','"
											+ gatherer_name
											+ "','"
											+ demand_amount
											+ "','"
											+ cost_price_sum
											+ "','"
											+ register
											+ "','" + register_time + "')";
									stock_db.executeUpdate(sql5);
								}
							}
						} else {
							String nseer_sql = "update stock_apply_gather set cost_price_sum='"
									+ cost_price_sum
									+ "',demand_amount='"
									+ demand_amount
									+ "',check_tag='0' where gather_ID='"
									+ gather_ID + "'";
							stock_db.executeUpdate(nseer_sql);
							Iterator ite = rsList.iterator();
							while (ite.hasNext()) {
								elem = (String[]) ite.next();
								nseer_sql = "insert into stock_workflow(config_id,object_ID,describe1,describe2) values ('"
										+ elem[0]
										+ "','"
										+ gather_ID
										+ "','"
										+ elem[1] + "','" + elem[2] + "')";
								stock_db.executeUpdate(nseer_sql);
							}
						}
					} catch (Exception ex) {
						ex.printStackTrace();
					}
					response
							.sendRedirect("stock/apply_gather/register_ok_a.jsp");
				} else {
					response
							.sendRedirect("stock/apply_gather/register_ok_b.jsp");
				}
				stock_db.commit();
				stock_db.close();
			} else {
				response.sendRedirect("error_conn.htm");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}