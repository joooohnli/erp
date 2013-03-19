/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
*/

function ie7(){
var browser=navigator.appName  
var b_version=navigator.appVersion  
var version=b_version.split(";");  
var trim_Version=version[1].replace(/[ ]/g,"");  
if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE7.0")  
{  
//alert("IE 7.0");  

return true;
} else{
return false;
} 

/*
else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE6.0")  
{  
alert("IE 6.0");  
}  
*/
}
var sels1;
function HideOverSels()
{
 sels1 = document.getElementsByTagName('select'); 
    for (var i = 0; i < sels1.length; i++) 
	{
		sels1[i].style.visibility = 'hidden';
	}
}
function VisiOverSels()
{
    for (var i = 0; i < sels1.length; i++) 
	{
		if(sels1[i].id!='print_type'){
		sels1[i].style.visibility = 'visible';
		}
	}	
}

function loadCover(d_id){//加载遮罩，参数d_id为要在遮罩上面的层的id
var max;
	var cover_id=d_id+'_N_covers';
  var divs=document.getElementsByTagName("div");
  for(var i=0,max=0;i<divs.length;i++){
	  max=Math.max(max,divs[i].style.zIndex||0);
	  }
    var d_N_covers = document.createElement("div");
    d_N_covers.className='N_covers1';
    d_N_covers.style.width = document.body.offsetWidth;
    d_N_covers.style.height =document.body.offsetHeight;
	d_N_covers.setAttribute('nseer1','111');
	d_N_covers.style.zIndex=max+1;
	d_N_covers.style.left='0px';
    d_N_covers.id = cover_id;
	document.getElementById(d_id).style.zIndex=max+3;
    if (document.body.offsetLeft > 0){
    d_N_covers.style.marginLeft = document.body.offsetLeft + "px";
	}
	//alert(ie7());
	if(!ie7()){

	HideOverSels();//过滤select隐藏

	}
	/*
	//if (window.ActiveXObject){
	var d_N_iframe = document.createElement('iframe');
	d_N_iframe.src='javascript:false;';
	d_N_iframe.style.cssText='position:absolute;visibility:inherit;top:0px;left:0px;width:100%;height:100%;z-index:-1;filter=\'progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)\';';
	d_N_covers.appendChild(d_N_iframe);
	//}
	*/
	document.body.appendChild(d_N_covers);
}
function unloadCover(d_id){//卸载遮罩，参数d_id为要在遮罩上面的层的id
var cover_id=d_id+'_N_covers';
if(document.getElementById(cover_id)!==null&&document.getElementById(cover_id)!=='undefined'){
	var divs=document.getElementsByTagName("div");
	var n=0;
	 for(var i=0;i<divs.length;i++){
if(divs[i].nseer1!=''&&divs[i].nseer1!=null&&divs[i].nseer1!='undefined'){
n++;
}
	  }

document.body.removeChild(document.getElementById(cover_id));
if(n==1){
	if(!ie7()){

VisiOverSels();//过滤select显示
	}
}
}
}

var setGradient = (function(){
	 
	//private variables;
	var p_dCanvas = document.createElement('canvas');
	var p_useCanvas =  !!( typeof(p_dCanvas.getContext) == 'function');
	var p_dCtx = p_useCanvas?p_dCanvas.getContext('2d'):null;
	var p_isIE = /*@cc_on!@*/false;
	 
	
	 //test if toDataURL() is supported by Canvas since Safari may not support it
	
   try{   p_dCtx.canvas.toDataURL() }catch(err){
          p_useCanvas = false ;
   };
         
	if(p_useCanvas){
	   
	   return function (dEl , sColor1 , sColor2 , bRepeatY ){
			
			if(typeof(dEl) == 'string') dEl =  document.getElementById(dEl);
			if(!dEl) return false;
			var nW = dEl.offsetWidth;
			var nH = dEl.offsetHeight;
			p_dCanvas.width = nW;
			p_dCanvas.height = nH;
			
		
			var dGradient;
			var sRepeat;
			// Create gradients
			if(bRepeatY){
				dGradient = p_dCtx.createLinearGradient(0,0,nW,0);
				sRepeat = 'repeat-y';
			}else{
				dGradient = p_dCtx.createLinearGradient(0,0,0,nH);
				sRepeat = 'repeat-x';
			}		
			
			dGradient.addColorStop(0,sColor1);
			dGradient.addColorStop(1,sColor2);				
			
			p_dCtx.fillStyle = dGradient ; 
			p_dCtx.fillRect(0,0,nW,nH);
			var sDataUrl = p_dCtx.canvas.toDataURL('image/png');
			
			with(dEl.style){
				backgroundRepeat = sRepeat;
				backgroundImage = 'url(' + sDataUrl + ')';
				backgroundColor = sColor2;    
			};
	   }
	}else if(p_isIE){
		
		p_dCanvas = p_useCanvas = p_dCtx =  null;		
		return function (dEl , sColor1 , sColor2 , bRepeatY){
			if(typeof(dEl) == 'string') dEl =  document.getElementById(dEl);
			if(!dEl) return false;
			dEl.style.zoom = 1;
			var sF = dEl.currentStyle.filter;
			dEl.style.filter += ' ' + ['progid:DXImageTransform.Microsoft.gradient(	GradientType=',  +(!!bRepeatY ),',enabled=true,startColorstr=',sColor1,', endColorstr=',sColor2,')'].join('');
		    
		};
	
	}else{
		
		p_dCanvas = p_useCanvas = p_dCtx =  null;
		return function(dEl , sColor1 , sColor2  ){
			
			if(typeof(dEl) == 'string') dEl =  document.getElementById(dEl);
			if(!dEl) return false;
			with(dEl.style){
				 backgroundColor = sColor2; 
			};
			//alert('your browser does not support gradient effet');
		}
	}
})();
