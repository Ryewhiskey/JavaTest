//判断文件后缀 
function vfile_accept(value){
	str = value.toLowerCase();
	lens = str.length;
	extname = str.substring(str.indexOf(".") , lens);
	if(extname.toLowerCase()!=".flv" && extname.toLowerCase()!=".mp4"){		
		return false;
	}
	return true;
}

function ofile_accept(value){
	str = value.toLowerCase();
	lens = str.length;
	extname = str.substring(str.indexOf(".") , lens);
	if(extname.toLowerCase()!=".doc" && extname.toLowerCase()!=".docx" && extname.toLowerCase()!=".ppt" && extname.toLowerCase()!=".pptx" && extname.toLowerCase()!=".xls" && extname.toLowerCase()!=".xlsx" && extname.toLowerCase()!=".zip" && extname.toLowerCase()!=".pdf"){		
		return false;
	}
	return true;
}

function tfile_accept(value){
	str = value.toLowerCase();
	lens = str.length;
	extname = str.substring(str.indexOf(".") , lens);
	if(extname.toLowerCase()!=".jpg" && extname.toLowerCase()!=".png" && extname.toLowerCase()!=".jpeg" && extname.toLowerCase()!=".gif" && extname.toLowerCase()!=".bmp" ){		
		return false;
	}
	return true;
}

//判断日期yyyy-mm-dd
function isDate(str){ 
	var reg = /^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$/
	if (reg.test(str)){return true;}else{return false;}
}
//判断电话
function checkPhone( strPhone ) { 
	var phoneRegWithArea = /^[0][1-9]{2,3}-[0-9]{5,8}$/; 
	var phoneRegNoArea = /^[1-9]{1}[0-9]{5,8}$/; 
	if( strPhone.length > 9 ) {
	    if( phoneRegWithArea.test(strPhone) ){return true; }else{return false;}
	}else{
	    if(phoneRegNoArea.test(strPhone)){return true; }else{return false;}
	}
}
//判断数值
function isNumber( s ){ 
	var regu = /^[0-9]+$/; 
	var reg = new RegExp(regu); 
	if (reg.test(s)) { 
		return true; 
	}else{ 
		return false; 
	} 
} 
//判断实数
function isDouble(s)    
{    
         var reg=/^\d+(\.\d+)?$/; 
         var re = new RegExp(reg); 
     	if (re.test(s)) { 
     		return true; 
     	}else{ 
     		return false; 
     	} 
             
}    
//移动电话
function checkMobile( s ){ 
	var regu =/^[1][3,5,8][0-9]{9}$/; 
	var re = new RegExp(regu); 
	if (re.test(s)) { 
		return true; 
	}else{ 
		return false; 
	} 
} 
//空格串
function checkWhite( s ){ 
	var regu =/^[ ]+$/; 
	var re = new RegExp(regu); 
	if (re.test(s)) { 
		return true; 
	}else{ 
		return false; 
	} 
} 

//判断EMAIL
function checkEmail(strEmail) { 
	//var emailReg = /^[_a-z0-9]+@([_a-z0-9]+\.)+[a-z0-9]{2,3}$/; 
	var emailReg = /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/; 
	if( emailReg.test(strEmail) ){ return true; }else{ return false; } 
}
//去左空格;
function ltrim(s){
    return s.replace(/^\s*/g,"");
}
//去右空格;
function rtrim(s){
    return s.replace(/\s*$/g,"");
}
//去左右空格;
function trim(s){
    return rtrim(ltrim(s));
}
//限制长度
function maxlen(s,i){
	if(s.length>i) return true;
	return false;
	
}
function minlen(s,i){
	if(s.length<i) return true;
	return false;
	
}
//字符串为字母数字组合串
function IsDigit(cCheck) { 
	return (('0'<=cCheck) && (cCheck<='9')); 
} 
function IsAlpha(cCheck) { 
	return ((('a'<=cCheck) && (cCheck<='z')) || (('A'<=cCheck) && (cCheck<='Z')))
} 
function check_pwd(pwd) 
{ 	
	var id=0,ia=0;
	if( minlen(pwd,8) ) {
		alert("密码的长度不能少于8位");
		return false;
	}
	for (nIndex=0; nIndex<pwd.length; nIndex=nIndex+1) { 
		cCheck = pwd.charAt(nIndex);
		if(IsDigit(cCheck)) id=1;
		if(IsAlpha(cCheck)) ia=1;		
	}	
	if (id!=1 || ia!=1)
	{ 
		alert("密码必须同时包括字母和数字"); 
		//document.form1.username.focus(); 
		return false; 
	} 
	return true; 
} 
function todate(str)
{
	var s="";
	s = str.substr(0,4)+"-"+str.substr(4,2)+"-"+str.substr(6,2);
	return s;
}

//校验身份证号码
var powers=new Array("7","9","10","5","8","4","2","1","6","3","7","9","10","5","8","4","2");    
var parityBit=new Array("1","0","X","9","8","7","6","5","4","3","2");    
var sex="male";    
//校验身份证号码的主调用   
function isvalidId(obj){    
    var _id=obj.value;    
    if(_id=="") return false;    
    var _valid=false;    
    if(_id.length==15){    
    	_valid=validId15(_id);    
    }else if(_id.length==18){    
    	_valid=validId18(_id);    
    }    
    if(!_valid){    	   
        obj.focus();    
        return false;    
    }
    return true;
 }        
//校验18位的身份证号码    

function validId18(_id){    
     _id=_id+"";    
    var _num=_id.substr(0,17);    
    var _parityBit=_id.substr(17);    
    var _power=0;    
    for(var i=0;i< 17;i++){    
        //校验每一位的合法性 
        if(_num.charAt(i)<'0'||_num.charAt(i)>'9'){    
            return false;    
            break;    
         }   
     }    
      
    return true;    
 }    
//校验15位的身份证号码   
function validId15(_id){    
     _id=_id+"";    
    for(var i=0;i<_id.length;i++){    
        //校验每一位的合法性
        if(_id.charAt(i)<'0'||_id.charAt(i)>'9'){    
            return false;    
            break;    
         }    
     }    
    var year=_id.substr(6,2);    
    var month=_id.substr(8,2);    
    var day=_id.substr(10,2);    
      
    //校验年份位 
    if(year<'01'||year >'90')return false;    
    //校验月份
    if(month<'01'||month >'12')return false;    
    //校验日  
    if(day<'01'||day >'31')return false;    
      
    return true;    
 }    