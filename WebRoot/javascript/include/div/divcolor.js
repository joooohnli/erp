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
 