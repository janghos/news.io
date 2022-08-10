<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<title>로그인</title>
<script>
     	function submitLoginForm(form){
     		     
     		var r = document.loginForm;
     		
     		form.ID.value = form.ID.value.trim();
     		if(form.ID.value.length == 0){
     			alert('아이디를 입력해주세요.');
     			form.ID.focus();
     			return false;
     		}
     		
     		form.password.value = form.password.value.trim();
     		if(form.password.value.length == 0){
     			alert('비밀번호를 입력해주세요.');
     			form.password.focus();
     			return false;
     		}
     		
     		r.action="/news/r_login"
       		r.submit();
     		
     	}
     	
     	function submitUserLoginForm(form){
		     
     		var u = document.login;
     		
     		form.ID.value = form.ID.value.trim();
     		if(form.ID.value.length == 0){
     			alert('아이디를 입력해주세요.');
     			form.ID.focus();
     			return false;
     		}
     		
     		form.password.value = form.password.value.trim();
     		if(form.password.value.length == 0){
     			alert('비밀번호를 입력해주세요.');
     			form.password.focus();
     			return false;
     		}
     		
     		u.action="/news/u_login"
         	u.submit();
     	}
     	
    </script>   
</head>

<body>
	
	<br>
	<br>
	<br>
	<br>
	<h2>
		<a href="/news/list"><img src="/img/vendor_logo_intro.png"
			alt="로고" width="300px" height="50px"></a>
	</h2>
    <div class="container mx-auto">    
        <hr>
        <div class="row">
            <div class="col-md-5 mx-auto">
                <div id="first">
                    <div class="myform form ">
                        <div class="logo mb-3">
                            <div class="col-md-12 text-center">
                                <h4>기자 회원</h4>
                            </div>
                            </div>
							
						<!-- form -> method가 post여서 button onclick 작동 x--> 
                           <div class="col" id="reporter">      
                            <form method="post" name="loginForm" onsubmit="submitLoginForm(this); return false;">
                 
                               <div class="form-group">
                                  <label for="exampleInputEmail1">REPORTER ID</label>
                                  <input type="text" name="ID"  class="form-control" id="ID" aria-describedby="IDHelp" placeholder="아이디를 입력하세요.">
                                </div>
                 
                                <div class="form-group">
                                   <label for="exampleInputEmail1">Password</label>
                                   <input type="password" name="password" id="password"  class="form-control" aria-describedby="emailHelp" placeholder="비밀번호를 입력하세요.">
                                </div>
                             
                                <div class="col-md-12 text-lg-end ">
                                   <button type="submit" class=" btn btn-block mybtn btn-danger tx-tfm">Login</button>
                                   <button type="button" onClick =  "location='readReporter'" class=" btn btn-block mybtn btn-danger tx-tfm">기자 회원가입</button>
                                </div>
                            </form> 
                                   
                        </div>
                        
                    </div>
                </div>
            </div>
            
            
            <div class="col-md-5 mx-auto">
                <div id="first">
                    <div class="myform form ">
                        <div class="logo mb-3">
                            <div class="col-md-12 text-center">
                                <h4>일반 회원</h4>
                            </div>
                        </div>
						
						<form method="post" name="login" onsubmit="submitUserLoginForm(this); return false;">
                        <div class="form-group2">
                            <label for="InputEmail1">USER ID</label>
                            <input type="text" name="ID"  class="form-control" id="ID" aria-describedby="IDHelp" placeholder="아이디를 입력하세요.">
                          </div>
           
                          <div class="form-group2">
                             <label for="InputEmail1">Password</label>
                             <input type="password" name="password" id="password"  class="form-control" aria-describedby="emailHelp" placeholder="비밀번호를 입력하세요.">
                          </div>
                       
                          <div class="col-md-12 text-lg-end ">
                             <button type="submit" class=" btn btn-block mybtn btn-primary tx-tfm">Login</button>
                             <button type="button" onClick = "location='readUser'" class=" btn btn-block mybtn btn-primary tx-tfm">일반 회원가입</button>
                          </div>
                      </form> 
                          
                  </div>   
                </div>
            </div>
        </div>
		<div class="col-md-12 ">
			<div class="login-or">
				<hr class="hr-or">
			</div>
			<div class="form-group">
				<p class="text-center">
					<a href='search' id="signup"> 아이디/비밀번호 찾기 </a>
				</p>
			</div>
         
           </div>
	       </div>
</body>
</html>