/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
var  access_num1=0;

var nseer_hrefLink;
            updown=true
            num=0
            function drawup(item,top,doc,circle){
            temp=eval(item);
            tempon=eval(top)
            tempdoc=eval(doc)
            tempcircle=eval(circle);
            tem=parseInt(temp.style.top);
            tempcircle.style.display = "";
            if (num>15){
            tempdoc.style.display = "";
            }
            if(tem>(tempon-16)&&updown){
            num++
            temp.style.top=tem-1;
            Stop=setTimeout("drawup(temp,tempon,tempdoc,tempcircle)",data_length)
            }else{
            return
            }
            }
            function drawDown(item,top,doc,circle){
            temp=eval(item)
            tempdoc=eval(doc)
            tempcircle=eval(circle)
            clearTimeout(Stop)
            temp.style.top=top
            num=0
            tempdoc.style.display = "none";
            tempcircle.style.display = "none";
            }
            function ontxt(item,top,doc,circle){
            temp = eval(item);
            tempdoc = eval(doc);
            tempcircle = eval(circle)
            if (updown){
            temp.style.top = top-28;
            tempdoc.style.display = "";
            tempcircle.style.display = "";
            }
            }
            function drawReset(finish){
            if (finish==1){
            updown=false
            }else{
            updown=true
            }
            }

function Nseer_Pie_Div(nseerPieC,nseerPieW,nseerPieH,nseerPieXY){
this.Container=document.getElementById(nseerPieC);
this.width=nseerPieW+'px';
this.height=nseerPieH+'px';
this.caption=nseerPieXY;
this.background="<v:rect id='background' style='position:absolute;left:1px;top:1px;WIDTH:"+this.width+";HEIGHT:"+this.height+";' fillcolor='#EFEFEF' strokecolor='gray'>"+
                        //"<v:shadow on='t' type='single' color='silver' offset='4pt,4pt'/>"+
                        "</v:rect>";
this.nseerPieS=new Array();   //[name,qty,color]
this.Percent=new Array();
this.nseerSum=0;
this.Cake3d="<v:shapetype id='Cake_3D' coordsize='21600,21600' o:spt='95' adj='11796480,5400' path='al10800,10800@0@0@2@14,10800,10800,10800,10800@3@15xe'></v:shapetype>";
this.Text3d="<v:shapetype id='3dtxt' coordsize='21600,21600' o:spt='136' adj='10800' path='m@7,l@8,m@5,21600l@6,21600e'>"+
                    "<v:path textpathok='t' o:connecttype='custom' o:connectlocs='@9,0;@10,10800;@11,21600;@12,10800' o:connectangles='270,180,90,0'/>"+
                    "<v:textpath on='t' fitshape='t'/>"+
                    "<o:lock v:ext='edit' text='t' shapetype='t'/>"+
                    "</v:shapetype>";
this.draw=function(){
this.init();
this.drawdraw_div1();
this.drawPie();
}
}

Nseer_Pie_Div.prototype.init=function(){
this.nseerSum=0;
for(var i=0;i<this.nseerPieS.length;i++){
this.nseerSum+=this.nseerPieS[i][1];
}
for(var i=0;i<this.nseerPieS.length;i++){
this.Percent[i]=this.nseerPieS[i][1]/this.nseerSum;//document.writeln(this.Percent[i])
}
}
Nseer_Pie_Div.prototype.drawdraw_div1=function(){
var nseer_div_pie=document.createElement("v:group");
nseer_div_pie.style.position='absolute';
nseer_div_pie.style.top='3px';
nseer_div_pie.style.left='2px';
nseer_div_pie.style.width=this.width;
nseer_div_pie.style.height=this.height;
nseer_div_pie.coordsize='21000,11500';
this.Container.innerHTML=this.Cake3d+this.Text3d+this.background;
this.Container.appendChild(nseer_div_pie);//alert(this.Container.innerHTML)
this.drawdraw_pie1(nseer_div_pie);//alert(this.Container.innerHTML)
}
Nseer_Pie_Div.prototype.drawdraw_pie1=function(nseer_div_pie){
var nseer_pie=document.createElement("v:rect");
nseer_pie.style.position='relative';
nseer_pie.style.top='100px';
nseer_pie.style.left='500px';
nseer_pie.style.width='20000px';
nseer_pie.style.height='1000px';
nseer_pie.stroked='false';
var captiontb=document.createElement("v:TextBox");
captiontb.inset='0pt,0pt,0pt,0pt';
captiontb.innerHTML="<table width='100%' border='0' align='center' cellspacing='0'><tr><td align='center' valign='middle'>"+
                                "<div style='font-size:12pt; '><B>"+this.caption+"</B></div>"+
                                "</td></tr></table>" ;
nseer_pie.appendChild(captiontb);
var nseer_pie_area=document.createElement("v:rect");
nseer_pie_area.style.position='relative';
nseer_pie_area.style.top='1200px';
nseer_pie_area.style.left='500px';
nseer_pie_area.style.width='20000px';
nseer_pie_area.style.height='10000px';
nseer_pie_area.strokecolor='#888';
nseer_pie_area.fillcolor='#9fc';
nseer_pie_area.onmouseover='drawReset(1)';
nseer_pie_area.onmouseout='drawReset(0)';
var fillStyle="<v:fill rotate='t' angle='-45' focus='100%' type='gradient'/>";
nseer_pie_area.innerHTML=fillStyle;
var nseer_pie_gg=document.createElement("v:rect");
nseer_pie_gg.style.position='relative';
nseer_pie_gg.style.top='1200px';
nseer_pie_gg.style.left='12800px';
nseer_pie_gg.style.width='7650px';
nseer_pie_gg.style.height='10000px';
nseer_pie_gg.fillcolor='#9cf';
nseer_pie_gg.stroked='t';
nseer_pie_gg.strokecolor='#09f';
    fillStyle="<v:fill rotate='t' angle='-175' focus='100%' type='gradient'/>"+
                "<v:shadow on='t' type='single' color='silver' offset='1pt,1pt'/>";
nseer_pie_gg.innerHTML=fillStyle;
var nseer_pie_pie=document.createElement("v:rect");
nseer_pie_pie.style.position='relative';
nseer_pie_pie.style.top='1250px';
nseer_pie_pie.style.left='13000px';
nseer_pie_pie.style.width='4300px';
nseer_pie_pie.style.height='400px';
nseer_pie_pie.fillcolor='#afc';
nseer_pie_pie.stroked='f';
nseer_pie_pie.strokecolor='#000';
    fillStyle="<v:TextBox inset='2pt,0pt,0pt,0pt' style='font-size:10pt;'>"+
                "<div align='left'><font color='#000'>库存药品总数(件):"+this.nseerSum+"</font></div></v:TextBox>";
nseer_pie_pie.innerHTML=fillStyle;
nseer_div_pie.appendChild(nseer_pie);
nseer_div_pie.appendChild(nseer_pie_area);
nseer_div_pie.appendChild(nseer_pie_gg);
nseer_div_pie.appendChild(nseer_pie_pie);

var nseer_aa=1;
var jj=0;
for(var i=0;i<this.nseerPieS.length;i++){
if(nseer_aa>12){topx=1800+jj*768;jj++;}else{topx=1800+i*768;}	
//topx=1800+i*768;
var nseer_pie_bgcolor=document.createElement("v:rect");
nseer_pie_bgcolor.id='circle'+(i+1);
nseer_pie_bgcolor.style.position='relative';
nseer_pie_bgcolor.style.top=topx+'px';
nseer_pie_bgcolor.style.display='none';
if(nseer_aa>12){nseer_pie_bgcolor.style.left='16800px';}else{nseer_pie_bgcolor.style.left='12800px';}	

nseer_pie_bgcolor.style.width='3700px';
nseer_pie_bgcolor.style.height='800px';
nseer_pie_bgcolor.fillcolor='#efefef';
nseer_pie_bgcolor.strokecolor=this.nseerPieS[i][2];
    fillStyle="<v:fill opacity='.6' color2='fill darken(118)' o:opacity2='.6' rotate='t' method='linear sigma' focus='100%' type='gradient'/>";
nseer_pie_bgcolor.innerHTML=fillStyle;
var nseer_pie_xx=document.createElement("v:rect");
nseer_pie_xx.style.position='relative';
nseer_pie_xx.style.top=(topx+50)+'px';
if(nseer_aa>12){nseer_pie_xx.style.left='17000px';}else{nseer_pie_xx.style.left='13000px';}	
nseer_pie_xx.style.width='600px';
nseer_pie_xx.style.height='700px';
nseer_pie_xx.fillcolor=this.nseerPieS[i][2];
nseer_pie_xx.stroked='f';
var nseer_pie_xxDoc=document.createElement("v:rect");
nseer_pie_xxDoc.style.position='relative';
nseer_pie_xxDoc.style.top=(topx+50)+'px';
if(nseer_aa>12){nseer_pie_xxDoc.style.left='17800px';}else{nseer_pie_xxDoc.style.left='14000px';}	
nseer_pie_xxDoc.style.width='3250px';
nseer_pie_xxDoc.style.height='800px';
nseer_pie_xxDoc.filled='f';
nseer_pie_xxDoc.stroked='f';
if(i<this.nseerPieS.length-1){
	fillStyle="<v:TextBox inset='0pt,3pt,0pt,0pt' style='font-size:10pt;'><div align='left'>"+this.nseerPieS[i][0]+"(件):"+this.nseerPieS[i][1]+"</div></v:TextBox>";
}else{
	fillStyle="<v:TextBox inset='0pt,3pt,0pt,0pt' style='font-size:10pt;'><div align='left'>"+this.nseerPieS[i][0]+"(件):"+this.nseerPieS[i][1]+"</div></v:TextBox>";
}
nseer_pie_xxDoc.innerHTML=fillStyle;
nseer_div_pie.appendChild(nseer_pie_bgcolor);
nseer_div_pie.appendChild(nseer_pie_xx);
nseer_div_pie.appendChild(nseer_pie_xxDoc);
nseer_aa++;
}
}

Nseer_Pie_Div.prototype.drawPie=function(){

	var mm =180;
	var oo = data_length;
	var pp;
	var kk;
	var ll=0;
	var jj=0;
	iii=parseInt(this.height);
	ttt=parseInt(this.width);


for(var i=0;i<this.nseerPieS.length;i++){

var  nn= 360 * this.Percent[i] /2;
	pp = mm + nn;
	if (pp>= 360)
		pp = pp - 360;
	kk = ( -11796480 * this.Percent[i] + 5898240 );

	var uuu = Math.PI * 2 * ( 180 - ( pp - 180 ) ) / 360;
	var rr = iii / 2;
	var doc_xx = ll + iii / 8 - 30 + rr + rr * Math.sin(uuu) * 0.7;
	var doc_yy = jj + iii / 14 - 39 + rr + rr * Math.cos(uuu) * 0.7 * 0.5;
var nseer_make_pie=document.createElement("div");
var height1='20px';
nseer_make_pie.style.cursor='hand';
var id_name=this.nseerPieS[i][3]+"^_^"+this.nseerPieS[i][0];
nseer_make_pie.innerHTML="<v:shape id='cake"+(i+1)+"' type='#Cake_3D'"+
" style='position:absolute;left:"+(ll + iii / 9)+"px;top:"+(jj + iii / 14)+"px;WIDTH:"+iii+"px;HEIGHT:"+iii+"px;rotation:"+pp+";z-index:"+oo+"' adj='"+kk+",0'"+
" fillcolor='"+this.nseerPieS[i][2]+"' onclick='view_info1(\""+id_name+"\")' onmouseover='drawup(cake"+(i+1)+","+(jj + iii / 14)+",doc"+(i+1)+",circle"+(i+1)+")'; onmouseout='drawDown(cake"+(i+1)+","+(jj + iii / 14)+",doc"+(i+1)+",circle"+(i+1)+");'>"+
"<v:fill opacity='60293f' color2='fill lighten(120)' o:opacity2='60293f' rotate='t' angle='-135' method='linear sigma' focus='100%' type='gradient'/>"+
"<o:extrusion v:ext='view' on='t' backdepth='16' rotationangle='60' viewpoint='0,0'viewpointorigin='0,0' skewamt='0' lightposition='-50000,-50000' lightposition2='50000'/>"+
"</v:shape>";
//alert("onclick='view_info1("+this.nseerPieS[i][0]+")'");

if(this.nseerPieS[i][0]==0)height1='60px';
							//alert(this.nseerPieS[i][0]);
nseer_make_pie.innerHTML+="<v:shape id='doc"+(i+1)+"' type='#3dtxt'  style='position:absolute;left:"+doc_xx+"px;top:"+doc_yy+"px;z-index:2000;display:none;width:100; height:"+height1+";'"+
                            " fillcolor='red' onmouseover='ontxt(cake"+(i+1)+","+(jj + iii / 14)+",doc"+(i+1)+",circle"+(i+1)+")'>"+
                            "<v:fill opacity='60293f' color2='fill lighten(120)' o:opacity2='60293f' rotate='t'  method='linear sigma' focus='100%' type='gradient'/>"+
                            "<v:textpath style='v-text-kern:t;font-size:20pt;' trim='t' fitpath='t'  string='"+this.nseerPieS[i][0]+" 的总件数:"+this.nseerPieS[i][1]+"，占比例:"+nseerMakeCircle(this.Percent[i]*100,2)+"%'/> "+
                           // "<o:extrusion v:ext='view' on='t' lightposition='0,0' lightposition2='0,0'/>"+
                            "</v:shape>";
                            //alert(nseer_make_pie.innerHTML)
this.Container.appendChild(nseer_make_pie);

    mm= mm + nn * 2;

    if (mm >= 360)
	    mm = mm - 360;

    if (mm > 180)
	    oo = oo + 1;
    else
	    oo = oo - 1;



access_num1++;
//alert(access_num);


}
} 
function  nseerMakeCircle(num,n)  
{  
           num  =  Math.round  (num*Math.pow(10,n))/Math.pow(10,n);  
           return  num;  
}
function view_info1(product_id_name){
	var vheight = window.screen.height-200;
	var vwidth =  window.screen.width-200;
//	alert(product_id_name);
	var id_name=product_id_name.split("^_^");
	var file="../analyse/queryBalance.jsp?product_ID="+id_name[0]+"&&product_name="+id_name[1];
	window.open(file,"","height="+vheight+",width="+vwidth+",top =0,left=0,toolbar=no,location=no,scrollbars=yes,status=no,menubar=no,resizable=yes");	
}
