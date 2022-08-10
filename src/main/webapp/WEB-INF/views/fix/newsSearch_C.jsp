<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
	crossorigin="anonymous"></script>
<title>회원정보 찾기</title>
<script>
	
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
								<h4>회원정보 찾기</h4>
							</div>
						</div>

						<!-- form -> method가 post여서 button onclick 작동 x-->
						<div class="col" id="reporter">
							<form method="post" name="loginForm"
								onsubmit="submitLoginForm(this); return false;">


								<c:if test="${sessionScope.id != null }">
									<c:set var="type" value="${sessionScope.type}" />

									<c:choose>

										<c:when test="${sessionScope.type == 'reporter' }">
											<span class="form-group" id="menubar"> ID :
												${sessionScope.id } <br> PW : ${sessionScope.pw }
											</span>
											</li>
										</c:when>
									</c:choose>
								</c:if>
								
								<br><br><br>

								<div class="col-md-12 text-lg-end ">
									<button type="button" onClick="location='login'" class=" btn btn-block mybtn btn-danger tx-tfm">로그인화면으로 가기</button>
								</div>
							</form>

						</div>

					</div>
				</div>
			</div>



		</div>
	</div>
	<hr>
	<div class="col-md-12 ">
		<!--  <div class="login-or">
              <hr class="hr-or">
          </div>
               <div class="form-group">
                 <p class="text-center"> 회원이 아니신가요? <a href="" id="signup">회원가입 </a></p>
              </div> -->

	</div>
	</div>
</body>
</html>