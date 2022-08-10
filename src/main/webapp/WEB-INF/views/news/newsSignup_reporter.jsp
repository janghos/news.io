<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>기자 회원가입</title>
 <!-- Bootstrap CSS -->
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
 integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <style>
    .bg-light{
        height: 1053px;
        padding-top:55px;
        padding-bottom:75px;
    }
    .flex-fill.mx-xl-5.mb-2{
        margin: 0 auto;
        width : 700px;
        padding-right: 7rem;
        padding-left: 7rem;
    }
    .container.py-4{
        margin: 0 auto;
        width : 503px;
    }
    .d-grid.gap-2{
        padding-top: 30px;
    }
    
    .bir_yy,.bir_mm,.bir_dd{
        width:160px;
        display:table-cell;
    }
    .bir_mm+.bir_dd, .bir_yy+.bir_mm{
        padding-left:10px;
    }
    </style>
    <script type="text/javascript">
     	function submitJoinForm(form){
     		
     		var f = document.myForm;
     		
			form.r_id.value = form.r_id.value.trim();
     		if(form.r_id.value.length == 0){
     			alert('회원가입 아이디를 입력해주세요.');
     			form.r_id.focus();
     			return false;
     		}
     		     
     		
     		
     		form.r_id.value = form.r_id.value.trim();
     		if(form.r_id.value.length < 4){
     			alert('로그인 아이디를 4자 이상 입력해주세요.');
     			form.r_id.focus();
     			return false;
     		}
     		
     		form.r_id.value = form.r_id.value.toLowerCase();
     		
     		if(form.r_pw.value.length == 0){
     			alert('회원가입 비밀번호를 입력해주세요.');
     			form.r_pw.focus();
     			return false;
     		}     		
     		
     		     		
     		form.r_pwcheck.value = form.r_pwcheck.value.trim();
     		if(form.r_pwcheck.value.length == 0){
     			alert('회원가입 비밀번호를 확인을 입력해주세요.');
     			form.r_pwcheck.focus();
     			return false;
     		}
     		
     		if(form.r_pw.value != form.r_pwcheck.value){
     			alert('회원가입 비밀번호가 일치하지 않습니다.');
     			return false;
     		}
     		
     		form.r_name.value = form.r_name.value.trim();
     		if(form.r_name.value.length == 0){
     			alert('로그인 이름을 입력해주세요.');
     			form.r_name.focus();
     			return false;
     		}     	     
     		
     		if(form.r_name.value.length < 2){
     			alert('로그인 이름을 2자 이상 입력해주세요.');
     			form.r_name.focus();
     			return false;
     		}	
          	
     		f.action="/news/r_join"
     		f.submit();
     	}
     	
    	function checkFormReporter(form) {
    		var f = document.rForm;
    		var a1 = form.r_id.value;
    		var num = document.getElementsByName("reporterID").length;
    		var count=0;
    		
    		
    		for (var i = 0; i < num; i++) {
    			if (form.r_id.value == document.getElementsByName("reporterID")[i].value) {
    				count++;
    			}		
    		}
    		if(count>0){
    			alert("중복입니다.")
    		}
    		else{
    			alert("계속 진행해주세요! 중복이 아닙니다!")
    		}
    			
    		f.action = "redirect:/news/readReporter";
    		f.submit();
    	}
    </script>   
    </head>
    
   <section class="bg-light">
   	<h2>
		<a href="/news/list"><img src="/img/vendor_logo_intro.png"
			alt="로고" width="300px" height="50px"></a>
	</h2>
	<hr>
        <div class="container py-4">
            <div class="row align-items-center justify-content-between">
                
                <a class="navbar-brand h1 text-center">
                    <span class="text-danger h4">기자</span><span class="text-dark h4"> 회원가입</span>               
                    
                </a>
            </div>
            <form method=post name="rForm" onsubmit="checkFormReporter(this);">
			<label for="r_id" class="form-label mt-4">아이디(중복체크)</label> <input
				type="text" class="form-control" id="r_id" name="r_id"
				placeholder="사용하실 아이디를 입력하세요." maxlength="20">
			<button type="submit" class="btn btn-block mybtn btn-danger tx-tfm">아이디 중복확인</button>
		</form>
			<c:forEach var="i" items="${reporterList}" varStatus="status">
				<input type="hidden" id="reporterID" name="reporterID" value="${i.r_id}" />
			</c:forEach>
			<br>
            <form method=post name="myForm"  onsubmit="submitJoinForm(this); return false;">
                
                
                <div class="form-group">
                       <label for="r_id" class="form-label mt-4">아이디</label>
                    <input type="text" class="form-control" name="r_id"  placeholder="사용하실 아이디를 입력하세요." maxlength="20">
                </div>
                <div class="form-group has-success">
                    <label class="form-label mt-4" for="inputValid">비밀번호</label>
                    <input type="password" class="form-control" name="r_pw" placeholder="최대 20자" maxlength="20" >
            	</div>
             
			<div class="form-group has-success">
		        <label class="form-label mt-4" for="inputValid">비밀번호확인</label>
		        <input type="password" class="form-control" name="r_pwcheck" id="inputValid" maxlength="20" >
	    	</div>
				
			<div class="form-group">
				<label for="r_name" class="form-label mt-4">이름</label> 
				<input type="text" class="form-control" name="r_name" placeholder="필수 입력" maxlength="20">
			</div>
	    		
			<div class="form-group">
				<label for="r_email" class="form-label mt-4">이메일</label> 
				<input type="email" class="form-control" name="r_email" placeholder="필수 입력" maxlength="30">
			</div>
    
			<div class="bir_wrap">
				<label class="form-label mt-4">생년월일 ex) 19930517</label> 
				<input type="text" class="form-control" name="r_birthday" placeholder="YYYYMMDD" maxlength="8">
			</div>
                
			<div class="form-group">
				<label for="r_group" class="form-label mt-4">소 속</label> 
				<input type="text" class="form-control" name="r_group" placeholder="필수 입력" maxlength="20">
			</div>
                    
                <div class="call">
                    <label for="exampleInputEmail1" class="form-label mt-4">연락처</label>
				<input type="text" class="form-control"	name="r_phonenumber" placeholder="- 빼고 입력" maxlength="11">
             	</div>  
             	     
                <div class="d-grid gap-2">
                    <button class="btn btn-block mybtn btn-danger tx-tfm" type="submit">가입하기</button>

                </div>
    
            </form>
        </div>
    </section>
    
    

</html>