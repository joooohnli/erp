function toolTip(msg,obj,fg, bg){
	if(toolTip.arguments.length < 1){
		if(document.getElementById('nseer_dup_div')!=null&&document.getElementById('nseer_dup_div')!='undefined'){
			document.body.removeChild(document.getElementById('nseer_dup_div'));
		}
	}else{
		var h = obj.offsetHeight;
		var x=obj.offsetLeft,y=obj.offsetTop;   
		while(obj=obj.offsetParent){ 
			x+=obj.offsetLeft;   
			y+=obj.offsetTop;
		}
		var dup_div=document.createElement('div');
		dup_div.id='nseer_dup_div';
		dup_div.style.position='absolute';
		dup_div.style.top=y-h;
		dup_div.style.left=x;
		if(!fg) fg = '#000000';
		if(!bg) bg = '#FFFFE1';
		var content='<table id="msg1" name="msg1" cellspacing="0" cellpadding="1" bgcolor="'+fg+'" class="trans_msg"><td>' +'<table cellspacing="0" cellpadding="3" bgcolor="'+bg+'"><td><div align="center"><font face="Arial" width=100% color="'+fg+'">'+msg+'&nbsp;</font></div></td></table></td></table>';
		dup_div.innerHTML=content;
		document.body.appendChild(dup_div);
	}
}
var obj1;
 var _t='abcdefghigklmnopqrstuvwxyz';
function treeToolTip(msg,obj,fg, bg){

if(msg==null&&obj1!=null){

document.getElementById('nseer_dup_div').style.display='none';

}
	
if(obj1==null&&obj!=null){
		var h = obj.offsetHeight;
		var x=obj.offsetLeft,y=obj.offsetTop;   
		while(obj=obj.offsetParent){ 
			x+=obj.offsetLeft;   
			y+=obj.offsetTop;
		}
		var dup_div=document.createElement('div');
		dup_div.id='nseer_dup_div';
		dup_div.style.position='absolute';
		dup_div.style.top=y-h+20;
		dup_div.style.left=x+20;
		if(!fg) fg = '#000000';
		if(!bg) bg = '#FFFFE1';
		var content='<table id="msg1" name="msg1" cellspacing="0" cellpadding="1" bgcolor="'+fg+'" class="trans_msg"><td>' +'<table cellspacing="0" cellpadding="3" bgcolor="'+bg+'"><td><div align="center"><font style="font-size: 12px;" width=100% color="'+fg+'">'+msg+'&nbsp;</font></div></td></table></td></table>';
		dup_div.innerHTML=content;
		document.body.appendChild(dup_div);
		obj1=dup_div;
}
if(obj1!=null&&obj!=null){
		var h = obj.offsetHeight;
		var x=obj.offsetLeft,y=obj.offsetTop;   
		while(obj=obj.offsetParent){ 
			x+=obj.offsetLeft;   
			y+=obj.offsetTop;
		}
        var dup_div=document.getElementById('nseer_dup_div');
		dup_div.style.position='absolute';
		dup_div.style.top=y-h+20;
		dup_div.style.left=x+20;
		if(!fg) fg = '#000000';
		if(!bg) bg = '#FFFFE1';
		var content='<table id="msg1" name="msg1" cellspacing="0" cellpadding="1" bgcolor="'+fg+'" class="trans_msg"><td>' +'<table cellspacing="0" cellpadding="3" bgcolor="'+bg+'"><td><div align="center"><font style="font-size: 12px;" width=100% color="'+fg+'">'+msg+'&nbsp;</font></div></td></table></td></table>';
		dup_div.innerHTML=content;
		dup_div.style.display='block';
		obj1=dup_div;
}


}

/*
function changeFlash(obj){

document.getElementById('flashtitle').innerHTML='<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="6" height="10"><param name="movie" value="images/orchid1.swf"><param name="quality" value="high"><embed src="images/orchid.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="6" height="10"></embed></object>&nbsp;';


}
*/
function nseer_alarm(){
this.main_id='01';
this.callname="nseer_alarm";
var dh = this;
var delay=30000;
var itl=window.setInterval(this.callname+".changeFlash()",delay);
var xmlHttp;
function createXMLHttpRequest(){ 
if(window.ActiveXObject){
xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
} else if(window.XMLHttpRequest){ 
xmlHttp = new XMLHttpRequest(); }
}

this.changeFlash=function (this_value,index){
var file='CountAlarm?main_id='+this.main_id;
createXMLHttpRequest();
xmlHttp.open("GET", file+ "&&c="+ Math.random(), true);
xmlHttp.send(null);
xmlHttp.onreadystatechange = function (){
if(xmlHttp.readyState == 4){ 
if(xmlHttp.status == 200 || xmlHttp.status == 0){
clearInterval(itl)	;
var str=xmlHttp.responseText;
if(str.length>10){
document.getElementById('flashtitle').innerHTML=xmlHttp.responseText;
itl=setInterval(dh.callname+".changeFlash()", delay);
				}
			}
		}

	}
}

}