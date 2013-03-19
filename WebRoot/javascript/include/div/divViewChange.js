/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
try{
 var n_D=new Nseer_DivViewChange('n_D');
 document.onmousedown=function (e){n_D.initDrag(e);}
 document.onmouseup=function (e){n_D.dragimg(e);}
 document.body.onmousemove=function (e){n_D.mouseStyle(e);}
 function Nseer_DivViewChange(name){
    this.Version = "NSEER ERP V7.0-js1.0";
	this.name=name;
    this.onmousedown = document.onmousedown;
    this.onmousemove = document.onmousemove;
    this.onmouseup = document.onmouseup;
    this.onselectstart = document.onselectstart;
	this.dE=document.getElementById&&!document.all;
	this.mouse_tag=0;
	this.isdrag=false;
	this.oDragObj=null;
	this.nseerZindex=0;
	this.port_X=0;
	this.port_Y=0;
	this.port_X1=0;
	this.port_Y1=0;
	this.left1=0;
	this.top1=0;
	this.tag=0;
	this.min_tag=0;
	this.max_tag=0;
	this.data=new Array();
	this.v=0;
	this.db_max_return=0;
	this.def=0;
	this.nseerDef=0;
	this.scrollW=document.body.scrollWidth;

	this.detachEvent=function(){//注销事件
		document.onselectstart=this.onselectstart;
	}
	this.coverSelect=function(div){//注销事件
		var n_iframe=document.createElement('iframe');
		n_iframe.src="javascript:false";
		n_iframe.style.cssText="position:absolute;visibility:inherit;top:0px;left:0px;width:100%;height:100%;z-index:-1;filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)'";
		div.appendChild(n_iframe);
	}
	this.initDrag=function (e){//初始化层方法开始
		e=e||window.event;//区分ie和firefox的event
		this.mouse_tag=1;
		var oDragHandle = this.dE ? e.target : e.srcElement; 
		var topElement = "HTML"; 
		while (oDragHandle.tagName != topElement && oDragHandle.getAttribute("nseerDef") != "dragAble"&&oDragHandle.getAttribute("nseerDef") != "dragonly"){//在ie和firfox都可以使用getAttribute获取自定义属性
			oDragHandle = this.dE ? oDragHandle.parentNode : oDragHandle.parentElement;
		} 
		if(oDragHandle.getAttribute("nseerDef")!=null&&oDragHandle.getAttribute("nseerDef")!='undefined'){
			if(oDragHandle.getAttribute("nseerDef")=="dragAble"){this.nseerDef=1;}
			if(oDragHandle.getAttribute("nseerDef")=="dragonly"){this.nseerDef=2;}
			if(this.nseerDef==1||this.nseerDef==2){
			this.isdrag = true;
			this.oDragObj = oDragHandle; 
			//*********************************************
			//this.oDragObj.style.zIndex=++this.nseerZindex;
			this.oDragObj.style.overflow='hidden';
			this.port_X1=e.clientX;
			this.port_Y1=e.clientY;
			var x12=parseInt(this.getStyle(this.oDragObj,"left","left"))+parseInt(this.getStyle(this.oDragObj,"width","width"));
			var y12=parseInt(this.getStyle(this.oDragObj,"top","top"))+parseInt(this.getStyle(this.oDragObj,"height","height"));
			this.left1=parseInt(this.getStyle(this.oDragObj,"left","left"));
			this.top1=parseInt(this.getStyle(this.oDragObj,"top","top"));
			this.loadDiv(this.oDragObj,0,e);
			//*****************************
			if(this.tag==0){
				document.onselectstart=this.onselectstart;
			}else{
				document.onselectstart = function() { return false;};
			}
			eval('document.onmousemove=function (e){'+this.name+'.moveMouse(e);}');
			return false;
			}
		}
	}
	this.loadDiv=function (obj,t,e){//点下鼠标时改变鼠标样式同时置标识位
		e=e||window.event;
		var nseer_r=obj;
		var w = obj.offsetWidth;
		var h = obj.offsetHeight;
		var x = obj.offsetLeft;
		var y = obj.offsetTop;
		while(obj=obj.offsetParent){
			x += obj.offsetLeft;
			y += obj.offsetTop;
		}
		if(this.nseerDef==1){
		if(parseInt(e.clientX)>parseInt(x)&&parseInt(e.clientX)<parseInt(x)+10&&parseInt(e.clientY)<parseInt(y)+h-15&&parseInt(e.clientY)>parseInt(y)+15){//左侧边界
			if(t!=0){
				nseer_r.style.cursor='e-resize';
			}else{
				this.tag=8;//左侧边界
			}
		}else if(parseInt(e.clientX)<parseInt(x)+15&&parseInt(e.clientY)<parseInt(y)+15){
			if(t!=0){ 
				nseer_r.style.cursor='nw-resize';//左上角
			}else{
				this.tag=7;//左上角
			}
		}else if(parseInt(e.clientX)<parseInt(x)+w&&parseInt(e.clientX)>parseInt(x)+w-10&&parseInt(e.clientY)<parseInt(y)+h-15&&parseInt(e.clientY)>parseInt(y)+15){//右侧边界
			if(t!=0){
				nseer_r.style.cursor='e-resize';
			}else{
				this.tag=1;//右侧边界
			}
		}else if(parseInt(e.clientX)>parseInt(x)+w-5&&parseInt(e.clientY)<parseInt(y)+5){
			if(t!=0){
				nseer_r.style.cursor='ne-resize';//右上角
			}else{
				this.tag=5;//右上角
			}
		}else if(parseInt(e.clientY)<parseInt(y)+5&&parseInt(e.clientX)<parseInt(x)+w-15&&parseInt(e.clientX)>parseInt(x)+15){
			if(t!=0){
				nseer_r.style.cursor='s-resize';////上侧边界
			}else{
				this.tag=6;//上侧边界
			}
		}else if(parseInt(e.clientX)<parseInt(x)+15&&parseInt(e.clientY)>parseInt(y)+h-15){
			if(t!=0){
				nseer_r.style.cursor='ne-resize';//左下角
			}else{
				this.tag=9;//左下角
			}
		}else if(parseInt(e.clientY)<parseInt(y)+h+5&&parseInt(e.clientY)>parseInt(y)+h-5&&parseInt(e.clientX)<parseInt(x)+w-15&&parseInt(e.clientX)>parseInt(x)+15){
			if(t!=0){
				nseer_r.style.cursor='s-resize';//下边界
			}else{
				this.tag=2;//下侧边界
			}
		}else if(parseInt(e.clientX)>parseInt(x)+w-15&&parseInt(e.clientY)>parseInt(y)+h-15){
			if(t!=0){
				nseer_r.style.cursor='nw-resize';//右下角
			}else{
				this.tag=3;//右下角
			}
		}else if(parseInt(e.clientY)>parseInt(y)+10&&parseInt(e.clientY)<parseInt(y)+33&&parseInt(e.clientX)<parseInt(x)+parseInt(w)-70&&parseInt(e.clientX)>parseInt(x)){
			if(t!=0){
				nseer_r.style.cursor='move';//移动区域
			}else{
				this.tag=4;
			}
		}else{
			if(t!=0){
				nseer_r.style.cursor='default';//中间区域
			}else{
				this.tag=0;
			}
		}
		}else if(this.nseerDef==2){
			if(parseInt(e.clientY)>parseInt(y)+10&&parseInt(e.clientY)<parseInt(y)+33&&parseInt(e.clientX)<parseInt(x)+parseInt(w)-70&&parseInt(e.clientX)>parseInt(x)){
			if(t!=0){
				nseer_r.style.cursor='move';//移动区域
			}else{
				this.tag=4;
			}
		}else{
			if(t!=0){
				nseer_r.style.cursor='default';//中间区域
			}else{
				this.tag=0;
			}
		}
		}
	}
	this.moveMouse=function (e){//根据鼠标点下时给tag赋的不同值对当前层进行不同操作
		if(this.isdrag==true&&this.max_tag==0){
			e=e||window.event;
			var x12=parseInt(this.getStyle(this.oDragObj,"left","left"))+parseInt(this.getStyle(this.oDragObj,"width","width"));
			var y12=parseInt(this.getStyle(this.oDragObj,"top","top"))+parseInt(this.getStyle(this.oDragObj,"height","height"));
			if(this.tag==0){
				this.port_X=e.clientX;
				this.port_Y=e.clientY;
				document.body.scrollTop=0;
				document.body.scrollLeft=0;
				this.left1=parseInt(this.getStyle(this.oDragObj,"left","left"));
				this.top1=parseInt(this.getStyle(this.oDragObj,"top","top"));
			}
			if(this.tag==1){
				this.port_X=e.clientX;
				this.port_Y=e.clientY;
				document.body.scrollTop=0;
				document.body.scrollLeft=0;
				if(this.port_X>0&&this.port_X>parseInt(this.left1)) this.oDragObj.style.width=this.port_X-parseInt(this.left1)+2;
			}
			if(this.tag==8){
				this.port_X=e.clientX;
				this.port_Y=e.clientY;
				document.body.scrollTop=0;
				document.body.scrollLeft=0;
				if(this.port_X>0&&this.port_X<x12){
					this.oDragObj.style.left=this.port_X-2;
					this.oDragObj.style.width=x12-this.port_X+2;
				}
			}
			if(this.tag==2){
				this.port_X=e.clientX;
				this.port_Y=e.clientY;
				document.body.scrollTop=0;
				document.body.scrollLeft=0;
				if(this.port_Y>0&&this.port_Y>parseInt(this.top1)) this.oDragObj.style.height=this.port_Y-parseInt(this.top1);
			}
			if(this.tag==6){
				this.port_X=e.clientX;
				this.port_Y=e.clientY;
				document.body.scrollTop=0;
				document.body.scrollLeft=0;
				if(this.port_Y>0&&this.port_Y<y12){
					this.oDragObj.style.top=this.port_Y-2;
					this.oDragObj.style.height=y12-this.port_Y+2;
				}
			}
			if(this.tag==3){
				this.port_X=e.clientX;
				this.port_Y=e.clientY;
				document.body.scrollTop=0;
				document.body.scrollLeft=0;
				if(this.port_X>0&&this.port_Y>0&&this.port_X>parseInt(this.left1)&&this.port_Y>parseInt(this.top1)){
					this.oDragObj.style.width=this.port_X-parseInt(this.left1);
					this.oDragObj.style.height=this.port_Y-parseInt(this.top1);
				}
			}
			if(this.tag==5){
				this.port_X=e.clientX;
				this.port_Y=e.clientY;
				document.body.scrollTop=0;
				document.body.scrollLeft=0;
				if(this.port_X>0&&this.port_Y>0&&this.port_X>parseInt(this.left1)&&this.port_Y<y12){
					this.oDragObj.style.top=this.port_Y-2;
					this.oDragObj.style.width=this.port_X-parseInt(this.left1)+2;
					this.oDragObj.style.height=y12-this.port_Y+2;
				}
			}
			if(this.tag==7){
				this.port_X=e.clientX;
				this.port_Y=e.clientY;
				document.body.scrollTop=0;
				document.body.scrollLeft=0;
				if(this.port_X>0&&this.port_Y>0&&this.port_X<x12&&this.port_Y<y12){
					this.oDragObj.style.top=this.port_Y-2;
					this.oDragObj.style.left=this.port_X-2;
					this.oDragObj.style.width=x12-this.port_X+2;
					this.oDragObj.style.height=y12-this.port_Y+2;
				}
			}
			if(this.tag==9){
				this.port_X=e.clientX;
				this.port_Y=e.clientY;
				document.body.scrollTop=0;
				document.body.scrollLeft=0;
				if(this.port_X>0&&this.port_Y>0&&this.port_Y>parseInt(this.top1)&&this.port_X<x12){
					this.oDragObj.style.left=this.port_X-2;
					this.oDragObj.style.width=x12-this.port_X+2;
					this.oDragObj.style.height=this.port_Y-this.top1+2;
				}
			}
			if(this.tag==4){
				this.port_X=e.clientX;
				this.port_Y=e.clientY;
				document.body.scrollTop=0;
				document.body.scrollLeft=0;
				this.oDragObj.style.left=(this.left1+this.port_X-this.port_X1)<0?"0px":this.left1+this.port_X-this.port_X1+"px";
				this.oDragObj.style.top=(this.top1+this.port_Y-this.port_Y1)<0?"0px":this.top1+this.port_Y-this.port_Y1+'px';
				if(parseInt(this.oDragObj.style.left)+parseInt(this.getStyle(this.oDragObj,"width","width"))>document.body.clientWidth){
					this.oDragObj.style.left=document.body.clientWidth-parseInt(this.getStyle(this.oDragObj,"width","width"));
				}
				if((document.body.clientHeight-parseInt(this.getStyle(this.oDragObj,"height","height")))<parseInt(this.getStyle(this.oDragObj,"top","top"))){
					this.oDragObj.style.top=document.body.clientHeight-parseInt(this.getStyle(this.oDragObj,"height","height"));
				}
			}
			return false;
		}
	} 
	this.getStyle=function (elem,IE,FF){//获取定义在css文件里的样式属性值
		return navigator.appName=="Microsoft Internet Explorer"?elem.currentStyle[IE]:document.defaultView.getComputedStyle(elem, "").getPropertyValue(FF);
	}
	this.dragimg=function (e){//抬起鼠标时
		this.mouse_tag=0;
		if(this.oDragObj!=null){
			//this.oDragObj.style.zIndex=++this.nseerZindex;
		}
		this.isdrag=false;
		this.detachEvent();
	}
	this.mouseStyle=function (e){//在body内move鼠标时更改鼠标样式
		e=e||window.event;
		if(this.mouse_tag==0){
			var x12;
			var y12;
			var port_X;
			var port_Y;
			var oDragHandle1 = this.dE?e.target : event.srcElement;
			var topElement = "HTML";
			while (oDragHandle1.tagName != topElement && oDragHandle1.getAttribute("nseerDef") != "dragAble"&&oDragHandle1.getAttribute("nseerDef") != "dragonly") {
				oDragHandle1 = this.dE?oDragHandle1.parentNode:oDragHandle1.parentElement;
			}
			if(oDragHandle1.getAttribute("nseerDef")!=null&&oDragHandle1.getAttribute("nseerDef")!='undefined'){
			if(oDragHandle1.getAttribute("nseerDef")=="dragAble"){this.nseerDef=1;}
			if(oDragHandle1.getAttribute("nseerDef")=="dragonly"){this.nseerDef=2;}
			if(this.nseerDef==1||this.nseerDef==2){
				eval('oDragHandle1.ondblclick=function(e){'+this.name+'.doubleClickDiv(e);}');
				x12=parseInt(this.getStyle(oDragHandle1,"left","left"))+parseInt(this.getStyle(oDragHandle1,"width","width"));
				y12=parseInt(this.getStyle(oDragHandle1,"top","top"))+parseInt(this.getStyle(oDragHandle1,"height","height"));
				port_X=e.clientX;
				port_Y=e.clientY;
				this.top1=parseInt(this.getStyle(oDragHandle1,"top","top"));
				this.left1=parseInt(this.getStyle(oDragHandle1,"left","left"));
			}
			}
			this.loadDiv(oDragHandle1,1,e);
		}
	}
	this.mmcMouseStyle=function(obj){//当鼠标放在放大缩小等按钮时，改变样式
		obj.style.cursor='hand';
	}
	this.maxDiv=function (){
		if(this.nseerDef==2){return false;}
		this.max_tag=1;
		if(this.min_tag==0){//得初始时的坐标,宽度,高度.
			var t=this.getStyle(this.oDragObj,"top","top");
			var l=this.getStyle(this.oDragObj,"left","left");
			var w=this.getStyle(this.oDragObj,"width","width");
			var h=this.getStyle(this.oDragObj,"height","height");
			var string_data=t+'#'+l+'#'+w+'#'+h;
			this.def=this.v;
			this.data[this.v]=string_data;
			this.v++;
		}
		this.oDragObj.style.top='0px';//最大化
		this.oDragObj.style.left='0px';
		this.oDragObj.style.width=document.body.clientWidth;
		this.oDragObj.style.height=document.body.clientHeight;
		//********************************************************
		var oDragObj_childNodes=this.oDragObj.getElementsByTagName('div');
		for(var i=0;i<oDragObj_childNodes.length;i++){
			if(oDragObj_childNodes[i].id=='expand'){
				oDragObj_childNodes[i].style.backgroundImage='url(/erp/javascript/include/div/images/return.gif)';
				eval('oDragObj_childNodes[i].onclick=function(){'+this.name+'.returnDiv()}');
			}
			if(oDragObj_childNodes[i].id=='collapse'){
				oDragObj_childNodes[i].style.backgroundImage='url(/erp/javascript/include/div/images/collapse.gif)';
				eval('oDragObj_childNodes[i].onclick=function(){'+this.name+'.minDiv();}');
			}
		}
	}
	this.returnDiv=function (){
		this.min_tag=0;
		this.max_tag=0;
		var s=this.def;
		//alert(this.data);
		var da=this.data[s].split('#');
		this.oDragObj.style.top=da[0];
		this.oDragObj.style.left=da[1];
		this.oDragObj.style.width=da[2];
		this.oDragObj.style.height=da[3];
		var oDragObj_childNodes=this.oDragObj.getElementsByTagName('div');
		for(var i=0;i<oDragObj_childNodes.length;i++){
			if(oDragObj_childNodes[i].id=='expand'){
				oDragObj_childNodes[i].style.backgroundImage='url(/erp/javascript/include/div/images/expand.gif)';
				eval('oDragObj_childNodes[i].onclick=function(){'+this.name+'.maxDiv();}');
			}
		}
	}
	this.returnDiv1=function (){//点击最小化后点击还原时执行
		this.min_tag=0;
		this.max_tag=0;
		var s=this.def;
		var da=this.data[s].split('#');
		this.oDragObj.style.top=da[0];
		this.oDragObj.style.left=da[1];
		this.oDragObj.style.width=da[2];
		this.oDragObj.style.height=da[3];
		var oDragObj_childNodes=this.oDragObj.getElementsByTagName('div');
		for(var i=0;i<oDragObj_childNodes.length;i++){
			if(oDragObj_childNodes[i].id=='collapse'){
				oDragObj_childNodes[i].style.backgroundImage='url(/erp/javascript/include/div/images/collapse.gif)';
				eval('oDragObj_childNodes[i].onclick=function(){'+this.name+'.minDiv();}');
			}
		}
	}
	this.minDiv=function (s){
		this.min_tag=1;
		var ss=s||40;
		if(this.max_tag==0){
			var t=this.getStyle(this.oDragObj,"top","top");
			var l=this.getStyle(this.oDragObj,"left","left");
			var w=this.getStyle(this.oDragObj,"width","width");
			var h=this.getStyle(this.oDragObj,"height","height");
			var string_data=t+'#'+l+'#'+w+'#'+h;
			this.def=this.v;
			this.data[this.v]=string_data;
			this.v++;
		}
		this.oDragObj.style.height=ss+'px';
		this.oDragObj.style.overflow='hidden';
		this.oDragObj.style.width=ss*10+'px';
		var oDragObj_childNodes=this.oDragObj.getElementsByTagName('div');
		for(var i=0;i<oDragObj_childNodes.length;i++){
			if(oDragObj_childNodes[i].id=='collapse'){
				oDragObj_childNodes[i].style.backgroundImage='url(/erp/javascript/include/div/images/return.gif)';
				eval('oDragObj_childNodes[i].onclick=function(){'+this.name+'.returnDiv1();}');
			}
			if(oDragObj_childNodes[i].id=='expand'){
				oDragObj_childNodes[i].style.backgroundImage='url(/erp/javascript/include/div/images/expand.gif)';
				eval('oDragObj_childNodes[i].onclick=function(){'+this.name+'.maxDiv();}');
			}
		}
	}
	this.closeDiv=function (closeType){//关闭该层
	unloadCover(this.oDragObj.id);
		if(closeType=='remove'){
			try{
			if (window.ActiveXObject){document.body.removeChild(document.getElementById(this.oDragObj.id));}else{this.oDragObj.oparentNode.removeChild(document.getElementById(this.oDragObj.id));}
			}catch(e){}
		}
		else if(closeType=='hidden'){this.oDragObj.style.display='none';}
		else if(closeType=='reconfirm'){}
	}
	this.doubleClickDiv=function (e){//双击层顶部特殊区域最大化和最小化
		e=e||window.event;
		var t=parseInt(this.getStyle(this.oDragObj,"top","top"));
		var l=parseInt(this.getStyle(this.oDragObj,"left","left"));
		var w=parseInt(this.getStyle(this.oDragObj,"width","width"));
		var h=parseInt(this.getStyle(this.oDragObj,"height","height"));
		var port_X1=e.clientX;
		var port_Y1=e.clientY;
		var x12=l+w;
		if(port_Y1>(t+5)&&port_Y1<(t+25)&&port_X1>(l+5)&&port_X1<(x12-5)){
			if(this.db_max_return==0){
				this.maxDiv();
				this.db_max_return=1;
			}else if(this.db_max_return==1){
				this.returnDiv();
				this.db_max_return=0;
			}
		}
	}
 }
 var _d=_t.length-5;
 }catch(e){}