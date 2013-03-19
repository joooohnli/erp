function ajax_validation(valuea,valueb,valuec,url,tothis){


var formName=document.getElementById(valuea);
var form=document.getElementById('firstKindRegister');

//alert(form.action);

var Namevalue=encodeURIComponent(formName.value);

var xmlhttp;

if (window.XMLHttpRequest)
		{
		xmlhttp=new XMLHttpRequest();
		}
		// code for IE
		else if (window.ActiveXObject)
		{
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		if(xmlhttp) {
			xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState==4)
				{
					try {
						if(xmlhttp.status==200) {
var loadingDiv=document.getElementById('loaddiv');

loadingDiv.innerHTML ='';

loadingDiv.innerHTML=xmlhttp.responseText;

var text=xmlhttp.responseText+'123';

//alert(text);

if(parseInt(text)==123){

loadingDiv.style.display='none';

}else{
loadingDiv.style.display='block';

if (window.ActiveXObject) {
 var   txtRange   =   tothis.createTextRange();   
          txtRange.moveStart(   "character",   tothis.value.length);   
          txtRange.moveEnd(   "character",   0   );   
          txtRange.select();   }
loadingDiv.innerHTML='<font color=#ffffff style="font-weight :bold;">'+xmlhttp.responseText+'</font>';



}


//loadingDiv.innerHTML =xmlhttp.responseText;

}
						else {
							loadingDiv.innerHTML = "There is something wrong ".fontcolor("red")
							 + xmlhttp.status + "=" + xmlhttp.statusText;
							
						}
					} catch(exception) {
							loadingDiv.innerHTML = "There is something wrong! ".fontcolor("red")
							 + exception;
                         
					}
				}

			};
//alert(Namevalue);
		xmlhttp.open("POST", url, true);
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		//alert(valuea+'='+Namevalue);
		xmlhttp.send('IDD=true&'+valuea+'='+Namevalue+'&valueb='+valueb+'&valuec='+valuec);
				
					   
			

		} else {
	        loadingDiv.innerHTML =
			  "Can't create XMLHttpRequest object, please check your web browser.";
		}


}