/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
var n_A=new Nseer_Alert('n_A');
function Nseer_Alert(name){
	this.callname='n_A';
    this.Version = "NSEER ERP V7.0-js1.0";
	this.name=name;
	this.EndV=1;
	this.StartV=1;
	this.Inc=0.1;
	this.timer;
	this.timer1=0;
	this.divShow=function (a) {
	if(document.getElementById('nseer_note_div')==null||document.getElementById('nseer_note_div')=='undefined'){
	var u=window.location.href.split('://')[1].split('?')[0].split('/');
	var url='';
	for(var i=0;i<u.length-3;i++){url+='../';}
	var note_div=document.createElement('div');
	note_div.id='nseer_note_div';
	note_div.style.position='absolute';
	note_div.style.top='-100px';
	note_div.style.left='45%';
	note_div.style.width='350px';
	note_div.innerHTML="<div style=\"position:absolute;right:100px;width:300px;height:80px;background:#F0F3F5\"><TABLE width=\"100%\" height=\"100%\" border=\"0\" align=\"center\" cellPadding=\"0\" cellSpacing=\"0\"><TBODY><TR><TD width=\"1%\" height=\"1%\"><IMG  src=\""+url+"images/bg_0ltop.gif\"></TD><TD width=\"100%\" background=\""+url+"images/bg_01.gif\"></TD><TD width=\"1%\" height=\"1%\"><IMG  src=\""+url+"images/bg_0rtop.gif\"></TD>   </TR><TR><TD  background=\""+url+"images/bg_03.gif\"></TD><TD><div style=\"height:50px;text-align:center;color:red;\">"+a+"</div><span style=\"position:absolute;top:2px;right:7px;width:18px;height:18px;cursor:hand;\" onclick=\""+this.name+".divHidden()\"><img src=\""+url+"images/gb.gif\" border=\"0\" width=17px;height=17px></span></div></div> </TD><TD  background=\""+url+"images/bg_04.gif\"></TD></TR><TR><TD width=\"1%\" height=\"1%\"><IMG  src=\""+url+"images/bg_0lbottom.gif\" ></TD><TD background=\""+url+"images/bg_02.gif\"></TD><TD width=\"1%\" height=\"1%\"><IMG  src=\""+url+"images/bg_0rbottom.gif\"></TD> </TR></TBODY></TABLE></div>";
	document.body.appendChild(note_div);
	}
	var note_div1=document.getElementById('nseer_note_div');
	if(note_div1.style.top=="") {note_div1.style.top="-100px";}
	if (parseInt(note_div1.style.top)<0) {
		this.StartV = this.StartV + this.Inc;
		MidV = Math.sin(this.StartV) + 1;
		this.EndV = Math.pow(MidV,5);
		var top=parseInt(note_div1.style.top)+this.EndV;
		note_div1.style.top = top +"px";
		window.setTimeout("eval("+this.name+".divShow())",70);
	} else {
		window.setTimeout("eval("+this.name+".divHidden())",3000);
		this.StartV =1;
		this.EndV = 1;
		this.Inc = 0.1;
	}
}
	this.divHidden=function(time_delay){
	var note_div2=document.getElementById('nseer_note_div');
	if(note_div2!=null&&note_div2!='undeifned'){
	if (parseInt(note_div2.style.top)>-100) {
			this.StartV = this.StartV + this.Inc;
			MidV = Math.sin(this.StartV) + 1;
			this.EndV = Math.pow(MidV,5);
			var top=parseInt(note_div2.style.top)-this.EndV;
			note_div2.style.top = top +"px";
		this.timer=window.setTimeout("eval("+this.name+".divHidden())",50);
		this.timer1=this.timer1+this.timer;
	}else{
	document.body.removeChild(note_div2);
		this.StartV =1;
		this.EndV = 1;
		this.Inc = 0.1;
		this.timer1=0;
	}
	}
}
}