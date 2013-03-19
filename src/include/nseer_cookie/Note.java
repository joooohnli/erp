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

import com.xuanwu.esms.client.*;

public class Note {

	/**
	 * @param args
	 */
	public void send(String userName,String password,String cell,String message){
		Client client = new Client("sendmsgconfig.xml");
		int rePost = client.post(userName,password,cell,message);
	}

	public static void main(String[] args) throws Exception{
		Client client = new Client("sendmsgconfig.xml");
		String userName = "XX";   //帐号
		String password = "XX";   //密码
		/**
		 * 修改密码
		 */
		/*
		int ca = client.modifyPassword(userName, password, newPassword);
		switch (ca) {
		case 0:
			System.out.println("恭喜！密码修改成功");
			break;
		case -6:
			System.out.println("用户名或密码错误！");
			break;
		default:
			System.out.println("数据库更新失败");
			break;
		}*/
		/**
		 * 获得余额信息
		 */
		/*int result = client.getRemainFee(userName, password);
		if (result == -6) {
			System.out.println("用户名或密码错误！");
		} else if (result == -100) {
			System.out.println("程序发生异常！");
		} else {
			System.out.println("用户" + userName + "的余额为：" + result + "分");
		}*/
		/**
		 * 获取账号相关信息
		 */
		/*ConfigInfo configInfo = client.getConfigInfo(userName, password);
		if (!configInfo.getIsUserOrPassdTrue()) {
			System.out.println("用户名或密码错误!");
		} else {
			System.out.println("用户" + userName);
			System.out.println("简称为:" + configInfo.getUserBrief());
			System.out.println("余额为：" + configInfo.getRemainFee() + "分");
			System.out.println("报警余额为：" + configInfo.getAlertFee() + "分");
			String[] cn = configInfo.getCanumberStr();
			for (int i = 0; i < cn.length; i++) {
				System.out.println(cn[i]); // 打印每组特服号字符串
			}
			IPInfo[] ipf = configInfo.getIpif();// 获取IP地址信息组
			if (ipf != null) {
				for (int i = 0; i < ipf.length; i++) {
					System.out.println("IP Address:" + ipf[i].getIP()); // 获取IP地址
					System.out.println("Port:" + ipf[i].getPort()); // 获取端口号
				}
			}
		}*/
		/**
		 * 获取上行信息
		 */
		/*
		MOMsg[] mm = client.getMOMessage(userName, password);
		if (mm == null)
			System.out.println("用户名或密码错误！"); 
		else if(mm[0].getId() == 0){
			System.out.println("没有上行信息");
		}
		else {
			for (int i = 0; i < mm.length; i++)// 数组长度代表上行记录数
			{
				System.out.println("getId:" + mm[i].getId());// MOLOG表里面的记录ID
				System.out.println("getSrcterminalid:"
						+ mm[i].getSrcterminalid());// 获取发送者号码
				System.out.println("getMsgcontent:" +mm[i].getMsgcontent());
				//System.out.println("getMsgcontent:" + new String(mm[i].getMsgcontent().getBytes("UTF-8"),"iso-8859-1"));// 获取内容
				System.out.println("getDestid:" + mm[i].getDestid());// 获取上行端口
				System.out.println("getReceivetime:" + mm[i].getReceivetime());// 获取接收时间
				System.out.println("IsUserOrPassdTrue:"
						+ mm[i].getIsUserOrPassdTrue());// 帐号或密码是否有错
			}
		}*/

		/**
		 * 发送信息
		 */
		int rePost = client.post(userName,password,"13800138000","玄武测试");
		System.out.println(rePost);
		/**
		 * 获取配置信息
		 */
		/*SendMsgConfig sendMsgConfig = client.getSendMsgConfig();
		System.out.println("Host:"+sendMsgConfig.getHost());
		System.out.println("Password:"+sendMsgConfig.getPassword());
		System.out.println("Port:"+sendMsgConfig.getPort());
		System.out.println("ProxyIP:"+sendMsgConfig.getProxyIP());
		System.out.println("ProxyPass:"+sendMsgConfig.getProxyPass());
		System.out.println("ProxyPort:"+sendMsgConfig.getProxyPort());
		*/
	}

}
