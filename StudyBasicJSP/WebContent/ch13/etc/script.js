function deleteSave() {
	var deleteform = document.deleteform;
	if(!deleteform.passwd.value) {
		alert("비밀번호를 입력허십시오.");
		deleteform.passwd.focus();
		return false;
	}
}

function writeSave(){
	var writeform = document.writeform;	//폼이름 
					
	if(!writeform.writer.value){		//input tag name
	  alert("작성자를 입력하십시요.");
	  writeform.writer.focus();
	  return false;
	}
	
	if(!writeform.subject.value){
	  alert("제목을 입력하십시요.");
	  writeform.subject.focus();
	  return false;
	}
	
	if(!writeform.content.value){
	  alert("내용을 입력하십시요.");
	  writeform.content.focus();
	  return false;
	}
        
	if(!writeform.passwd.value){
	  alert(" 비밀번호를 입력하십시요.");
	  writeform.passwd.focus();
	  return false;
	}
 };