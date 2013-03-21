/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package design.file;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.*;
import java.io.*;
import include.nseer_db.*;
import include.nseer_cookie.*;
import include.operateDB.CdefineUpdate;
import validata.ValidataNumber;

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
		nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
		nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
		ValidataNumber validata = new ValidataNumber();
		counter count = new counter(dbApplication);
		try {

			if (design_db.conn((String) dbSession.getAttribute("unit_db_name"))) {
				String list_price2 = request.getParameter("list_price");
				StringTokenizer tokenTO4 = new StringTokenizer(list_price2, ",");
				String list_price = "";
				while (tokenTO4.hasMoreTokens()) {
					String list_price1 = tokenTO4.nextToken();
					list_price += list_price1;
				}
				String cost_price2 = request.getParameter("cost_price");
				StringTokenizer tokenTO5 = new StringTokenizer(cost_price2, ",");
				String cost_price = "";
				while (tokenTO5.hasMoreTokens()) {
					String cost_price1 = tokenTO5.nextToken();
					cost_price += cost_price1;
				}
				int n = 0;
				if (!validata.validata(list_price)
						|| Double.parseDouble(list_price) < 0) {
					n++;
				}
				if (!validata.validata(cost_price)
						|| Double.parseDouble(cost_price) < 0) {
					n++;
				}
				if (n == 0) {
					String responsible_person = request.getParameter("select4");
					String responsible_person_ID = "";
					String responsible_person_name = "";
					if (!responsible_person.equals("")) {
						responsible_person_ID = responsible_person.split("/")[0];
						responsible_person_name = responsible_person.split("/")[1];
					}
					String fileKind_chain = request
							.getParameter("fileKind_chain");
					String chain_id = Divide1.getId(fileKind_chain);
					String chain_name = Divide1.getName(fileKind_chain);

					String sql2 = "select * from design_config_file_kind where chain_id='"
							+ chain_id + "'";
					ResultSet rs2 = design_db.executeQuery(sql2);
					if (!chain_id.equals("")) {
						String product_ID = NseerId.getId(getClass()
								.getResource("").toString(), (String) dbSession
								.getAttribute("unit_db_name"));
						String product_name = request
								.getParameter("product_name");
						String factory_name = request
								.getParameter("factory_name");
						/* String type = request.getParameter("type"); */
						// added by john
						String product_specification = request
								.getParameter("product_specification");
						String product_batch_number = request
								.getParameter("product_batch_number");
						String product_packing_unit = request
								.getParameter("product_packing_unit");
						String product_dispensing_unit = request
								.getParameter("product_dispensing_unit");
						String product_medical_insurance_categories = request
								.getParameter("product_medical_insurance_categories");
						String product_prescription_marks = request
								.getParameter("product_prescription_marks");

						String product_class = request
								.getParameter("product_class");
						String product_nick = request
								.getParameter("product_nick");
						String twin_name = request.getParameter("twin_name");
						String twin_ID = request.getParameter("twin_ID");
						String personal_unit = request
								.getParameter("personal_unit");
						String personal_value = request
								.getParameter("personal_value");
						if (personal_value.equals(""))
							personal_value = "0.0";
						personal_value = personal_value.replaceAll(",", "");
						String warranty = request.getParameter("warranty");
						String lifecycle = request.getParameter("lifecycle");
						String amount_unit = request
								.getParameter("amount_unit");
						String register = request.getParameter("register");
						String register_time = request
								.getParameter("register_time");
						String bodyc = new String(request.getParameter(
								"provider_group").getBytes("UTF-8"), "UTF-8");
						String provider_group = exchange.toHtml(bodyc);
						String bodya = new String(request.getParameter(
								"product_describe").getBytes("UTF-8"), "UTF-8");
						String product_describe = exchange.toHtml(bodya);
						try {
							String sqll = "select * from design_file where product_ID='"
									+ product_ID
									+ "' and product_name='"
									+ product_name + "'";
							ResultSet rset = design_db.executeQuery(sqll);
							if (rset.next()) {

								response
										.sendRedirect("design/file/register_ok_a.jsp");
							} else {
								// added by john
								String type = "采购";
								String sql = "insert into design_file(type,chain_id,chain_name,product_ID,product_name,factory_name,product_class,product_specification,product_batch_number,product_packing_unit,product_dispensing_unit,product_medical_insurance_categories,product_prescription_marks,twin_name,twin_ID,personal_unit,personal_value,warranty,lifecycle,product_nick,list_price,cost_price,real_cost_price,register,register_time,provider_group,product_describe,check_tag,modify_tag,excel_tag,excel_tag2,excel_tag3,excel_tag4,responsible_person_name,responsible_person_ID,amount_unit) values ('"
										+ type
										+ "','"
										+ chain_id
										+ "','"
										+ chain_name
										+ "','"
										+ product_ID
										+ "','"
										+ product_name
										+ "','"
										+ factory_name
										+ "','"
										+ product_class
										+ "','"
										+ product_specification
										+ "','"
										+ product_batch_number
										+ "','"
										+ product_packing_unit
										+ "','"
										+ product_dispensing_unit
										+ "','"
										+ product_medical_insurance_categories
										+ "','"
										+ product_prescription_marks
										+ "','"
										+ twin_name
										+ "','"
										+ twin_ID
										+ "','"
										+ personal_unit
										+ "','"
										+ personal_value
										+ "','"
										+ warranty
										+ "','"
										+ lifecycle
										+ "','"
										+ product_nick
										+ "','"
										+ list_price
										+ "','"
										+ cost_price
										+ "','"
										+ cost_price
										+ "','"
										+ register
										+ "','"
										+ register_time
										+ "','"
										+ provider_group
										+ "','"
										+ product_describe
										+ "','0','0','1','1','1','1','"
										+ responsible_person_name
										+ "','"
										+ responsible_person_ID
										+ "','"
										+ amount_unit + "')";
								design_db.executeUpdate(sql);
								/*****************************************************/
								CdefineUpdate CdefineUpdate = new CdefineUpdate();
								sql = CdefineUpdate.update("design_file",
										"product_ID", product_ID, request);
								design_db.executeUpdate(sql);
								/*****************************************************/
								String sql1 = "update design_config_file_kind set delete_tag='1' where file_ID='"
										+ chain_id + "'";
								design_db.executeUpdate(sql1);// delete_tag为1说明分类被使用
								List rsList = GetWorkflow.getList(design_db,
										"design_config_workflow", "01");
								if (rsList.size() == 0) {
									sql = "update design_file set check_tag='1' where product_ID='"
											+ product_ID + "'";
									design_db.executeUpdate(sql);
									
									if (!type.equals("物料")) {// 电子商务的销售信息发布
										List rsList1 = GetWorkflow.getList(
												design_db,
												"ecommerce_config_workflow",
												"01");
										sql = "delete from ecommerce_workflow where object_ID='"
												+ product_ID
												+ "' and type_id='01'";
										design_db.executeUpdate(sql);
										if (rsList1.size() == 0) {
											sql = "update design_file set excel_tag='3' where product_ID='"
													+ product_ID + "'";
											design_db.executeUpdate(sql);
										} else {
											Iterator ite1 = rsList1.iterator();
											while (ite1.hasNext()) {
												String[] elem = (String[]) ite1
														.next();
												sql = "insert into ecommerce_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"
														+ elem[0]
														+ "','"
														+ product_ID
														+ "','"
														+ elem[1]
														+ "','"
														+ elem[2] + "','01')";
												design_db.executeUpdate(sql);
											}
										}
									}
									if (type.equals("物料")
											|| type.equals("外购商品")) {// 电子商务的采购信息发布
										List rsList1 = GetWorkflow.getList(
												design_db,
												"ecommerce_config_workflow",
												"03");
										sql = "delete from ecommerce_workflow where object_ID='"
												+ product_ID
												+ "' and type_id='03'";
										design_db.executeUpdate(sql);
										if (rsList1.size() == 0) {
											sql = "update design_file set excel_tag2='3' where product_ID='"
													+ product_ID + "'";
											design_db.executeUpdate(sql);
										} else {
											Iterator ite1 = rsList1.iterator();
											while (ite1.hasNext()) {
												String[] elem = (String[]) ite1
														.next();
												sql = "insert into ecommerce_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"
														+ elem[0]
														+ "','"
														+ product_ID
														+ "','"
														+ elem[1]
														+ "','"
														+ elem[2] + "','03')";
												design_db.executeUpdate(sql);
											}
										}
									}
									if (type.equals("委外部件")) {// 电子商务的委外信息发布
										List rsList1 = GetWorkflow.getList(
												design_db,
												"ecommerce_config_workflow",
												"04");
										sql = "delete from ecommerce_workflow where object_ID='"
												+ product_ID
												+ "' and type_id='04'";
										design_db.executeUpdate(sql);
										if (rsList1.size() == 0) {
											sql = "update design_file set excel_tag3='3' where product_ID='"
													+ product_ID + "'";
											design_db.executeUpdate(sql);
										} else {
											Iterator ite1 = rsList1.iterator();
											while (ite1.hasNext()) {
												String[] elem = (String[]) ite1
														.next();
												sql = "insert into ecommerce_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"
														+ elem[0]
														+ "','"
														+ product_ID
														+ "','"
														+ elem[1]
														+ "','"
														+ elem[2] + "','04')";
												design_db.executeUpdate(sql);
											}
										}
									}
									if (!type.equals("物料")
											&& !type.equals("服务型产品")) {// 电子商务的配送信息发布
										List rsList1 = GetWorkflow.getList(
												design_db,
												"ecommerce_config_workflow",
												"05");
										sql = "delete from ecommerce_workflow where object_ID='"
												+ product_ID
												+ "' and type_id='05'";
										design_db.executeUpdate(sql);
										if (rsList1.size() == 0) {
											sql = "update design_file set excel_tag4='3' where product_ID='"
													+ product_ID + "'";
											design_db.executeUpdate(sql);
										} else {
											Iterator ite1 = rsList1.iterator();
											while (ite1.hasNext()) {
												String[] elem = (String[]) ite1
														.next();
												sql = "insert into ecommerce_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"
														+ elem[0]
														+ "','"
														+ product_ID
														+ "','"
														+ elem[1]
														+ "','"
														+ elem[2] + "','05')";
												design_db.executeUpdate(sql);
											}
										}
									}
								}
								else {
									Iterator ite = rsList.iterator();
									while (ite.hasNext()) {
										String[] elem = (String[]) ite.next();
										sql = "insert into design_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"
												+ elem[0]
												+ "','"
												+ product_ID
												+ "','"
												+ elem[1]
												+ "','"
												+ elem[2] + "','01')";
										design_db.executeUpdate(sql);
									}
								}
								response
										.sendRedirect("design/file/register_choose_attachment.jsp?product_ID="
												+ product_ID + "");
							}
						} catch (Exception ex) {
							ex.printStackTrace();
						}

					} else {

						response.sendRedirect("design/file/register_ok_b.jsp");
					}
				} else {

					response.sendRedirect("design/file/register_ok_c.jsp");
				}
				design_db.commit();
				design_db.close();
			} else {
				response.sendRedirect("error_conn.htm");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}