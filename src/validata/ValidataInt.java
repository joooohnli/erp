package validata;

public class ValidataInt{
	  public boolean bool ;
	  public boolean flag ;
	  public ValidataInt(){
	  	
	  	}
	  public boolean validata(String s){
	 	   
	      int x =0;
	      int y=0;
		  if(!s.equals("")){
	  	   char[] chars = s.toCharArray();
           if(chars[0] =='-'||(chars[0] >='0'&&chars[0] <='9')){
           	x++;
           }
             for(int i=1;i<chars.length;i++){
          	   if((chars[i] >='0'&&chars[i] <='9')){
                  	x++;
                  }
                }
                 if(x == chars.length&&y<=1){ 
                    flag = true; 
                    }else{
                    	flag=false;
                    	}
	  }else{
			flag=false;
	  }
         return flag;
   }   		
}
