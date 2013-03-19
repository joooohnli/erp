

var site = {};

var preload = "<span id='img1'></span><span id='img2'></span>";

site.head = function(title, subtitle){
	return	"<div class='head'><table class='page' align='center'><tr>" +
			"<td class='title'>&nbsp;</td>" +
			"<td class='subtitle'>" + preload + subtitle + "</td>" +
			"</tr></table></div>";
}

site.menu = function(left, right){
	return	"<div class='menu'><table class='page' align='center'><tr>" +
			"<td class='left'>" + left + "</td>" +
			"<td class='right'>" + right + "</td>" +
			"</tr></table></div>";
}

site.main = function(){
	return	"<div class='body'><table class='page' align='center'><col class='main'/><col class='right'/><tr><td class='main'>";
}

site.foot = function(){
	return	"</td></tr></table></div>";
}

site.copyright = function(message){
	return	"<div class='copyright'><table class='page' align='center'><tr>" +
			"<td>" + message + "</td>" +
			"</tr></table></div>";
}


site.reference = function(){
	return "";
}

site.tutorial = site.reference;


site.adjustFonts = function(){
	try {
		if (window.navigator.userAgent.match("Linux")) {
			document.body.style.font = "menu";
		}
	}
	catch(error){
	}
}

site.example = function(source){
	return "";
}



var $header = {toString: function(){

	site.adjustFonts();

	var s = "";
	s += site.head("ActiveWidgets", "Professional JavaScript GUI tools");
	s += site.menu(	"<a href='readme.htm'>Readme</a>|" +
					"<a href='changelog.htm'>Change Log</a>",
					"<a href='http://www.activewidgets.com/messages/'>Support Forum</a>|" +
					"<a href='http://www.activewidgets.com/grid.howto/'>Tutorial</a>|" +
					"<a href='http://www.activewidgets.com/active.controls.grid/'>Reference</a>|" +
					"<a href='http://www.activewidgets.com/download/'>Download</a>|" +
					"<a href='http://www.activewidgets.com/licenses/'>Buy</a>|" +
					"<a href='http://www.activewidgets.com/company/'>Contacts</a>");

	s += site.main();

	return s;
}};


var $column = {toString: function(){
	return "</td><td class='right'>";
}};

var $reference = {toString: function(){
	return 	site.reference();
}};

var $tutorial = {toString: function(){
	return 	site.tutorial();
}};

var $footer = {toString: function(){
	var s = "";
	s += site.foot();
	s += site.copyright("Copyright &copy; 2003-2005 ActiveWidgets Ltd. All Rights Reserved.");
	return s;
}};

