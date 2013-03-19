function ifr(url,w,h,id){
	document.write('<iframe id="ssg_ifr" name="ssg_ifr" width="'+w+'" height="'+h+'" border="0" frameborder="0" scrolling="no" src="'+url+'"></iframe>');
	window.onscroll=function (){
		if(document.getElementById(id).style.display!='none'){
			document.getElementById(id).style.top=(document.body.scrollTop+document.body.clientHeight-document.getElementById(id).offsetHeight)+"px";
		}
	}
}