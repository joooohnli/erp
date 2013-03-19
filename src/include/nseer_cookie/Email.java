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

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

public class Email{

public void send(String[] emailbox,String smtp,String from,String passwd,String subject,String content){

try{
	Properties props = new Properties();//也可用Properties props = System.getProperties(); 
    props.put("mail.smtp.host","smtp.sina.com.cn");//存储发送邮件服务器的信息
    props.put("mail.smtp.auth","true");//同时通过验证
            
    Session s = Session.getDefaultInstance(props,null);//根据属性新建一个邮件会话
	s.setDebug(true);

    MimeMessage msg = new MimeMessage(s);//由邮件会话新建一个消息对象

	InternetAddress fromAddress = new InternetAddress("yhuser@sina.com");
    msg.setFrom(fromAddress);//设置发件人

            
    for(int i=0;i<emailbox.length;i++){
		InternetAddress toAddress = new InternetAddress(emailbox[i]);
		msg.addRecipient(Message.RecipientType.BCC,toAddress);
		}////*****//////////

	msg.setSubject(subject);//设置主题
	BodyPart bp=new MimeBodyPart();
	bp.setContent(content,"text/html;charset=UTF-8");
	Multipart mp=new MimeMultipart();
	mp.addBodyPart(bp);
	msg.setContent(mp);//设置信件内容
    msg.setSentDate(new Date());//设置发信时间
                
            
    msg.saveChanges();//存储邮件信息
    Transport transport=s.getTransport("smtp");
    transport.connect("smtp.sina.com.cn","yhuser@sina.com","123456");//以smtp方式登录邮箱
    transport.sendMessage(msg,msg.getAllRecipients());
}catch(Exception ex){ex.printStackTrace();};
}

}