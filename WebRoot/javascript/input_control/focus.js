
window.onload=function (){
var sfEls = document.getElementsByTagName('INPUT');
var ccc;
for (var i=0; i<sfEls.length; i++) {
		sfEls[i].onfocus=function() {
			 ccc=this.style.width;
			this.className+=" sffocus";
		}
		sfEls[i].onblur=function() {
            
             this.style.width=49;
			 this.className='';
			
		}
	}
}er.prototype = {
    
};],
	['Overijsel'],
	['Utrecht'],
	['Zeeland'],
	['Zuid-Holland']
    ];
u.TextItem.superclass.onRender.apply(this,arguments);}});
