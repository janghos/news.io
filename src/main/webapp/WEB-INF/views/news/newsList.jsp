<%-- <%@ include file="../fix/header.jsp" %> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html>
<head>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
	
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
	
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>


<style>
div.aa {
   width: 370px;
   height: 60px;
   margin: 5px 5px;
}


.card-text {
	overflow: hidden; /* 탈출 글자 숨기기 */
	text-overflow: ellipsis; /* ... 말줄임표시 */
	white-space: nowrap;
	overflow: hidden;
}

.card {
   align: left;
   min-width: 380px;
   min-height: 680px;
   width: 380px;
   height:480px;
   margin: 30px 0px;
}
	
/*img {
  min-width: 360px;
  min-height: 240px;
  width: 480px;
  height: 240px;
  background-color: #e0e0e0;
}  이미지 사이즈 고정 */ 

#menubar{
	font-size : 16px;
	float:right;
	margin-right: 0px;
}	

#navbarDropdown{
	float:right;
	/* margin-right: 350px; */
}
	html, body {
   background: #ddd
}


</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>main</title>
</head>
<body class="container">
	<header class="container">
	

		<div class="w-75 mt-5 mx-auto"></div>
		<div>			
		
			
			 <!--로그인 x -->
			 <c:if test="${sessionScope.id == null }">
				 <div class="d-grid gap-2 d-md-flex justify-content-md-end" font-size-30>
				  <button class="btn btn-outline-primary" type="button" onclick="location.href='/news/login'">로그인</button>
					
			
			 </c:if>
			 <!-- 로그인 o  -->
			 <c:if test="${sessionScope.id != null }">
			 	   <c:set var="type" value="${sessionScope.type}"/>
			 	   
			 	   <c:choose>
			 	   
			 	   		<c:when test="${sessionScope.type == 'reporter' }">
					         
					          <a class="nav-link dropdown-toggle"  id="navbarDropdown"  role="button" data-bs-toggle="dropdown"></a>
					          	<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
						            <li><a class="dropdown-item" href="/news/modify_repoter">개인정보	수정</a></li>
						            <li><a class="dropdown-item" href="insert">등록하기</a></li>
						            <li><a class="dropdown-item" href="logout">로그아웃</a></li>			            			            
					          	</ul>
						         <span class="badge text-bg-secondary" id="menubar">
							        "${sessionScope.id }"님 환영합니다.
								</span>
							
			 	   		</c:when>
			 	   		
			 	   		<c:when test="${sessionScope.type == 'user' }">			 	   			
					          	<a class="nav-link dropdown-toggle"  id="navbarDropdown"  role="button" data-bs-toggle="dropdown" aria-expanded="false"></a>
					          	<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
						            <li><a class="dropdown-item" href="/news/modify_user">개인정보 수정</a></li>					            
						            <li><a class="dropdown-item" href="logout">로그아웃</a></li>			            			            
					          	</ul>
						        <span class="badge text-bg-secondary" id="menubar">		
									"${sessionScope.id }"님 환영합니다.
								</span>
							
			 	   		</c:when>
			 	   </c:choose>
			</c:if>
			 
		</div>
		<h2>
			    <a href="/news/list"><img src="/img/vendor_logo_intro.png" alt="로고" width="300px" height="50px"></a>
		</h2>
		<hr />
	</header>
	<section>
		<div class="container"> <!-- 뉴스 간격 조정 container -->
		<article>
				<div class="row">
					<c:forEach var="i" items="${newslist }" varStatus="status">
  
			
						<div class="col">
							<div class="card" onclick ="location.href='/news/hit/${i.aid }'">
							<p class="text-end">
								<c:if test="${sessionScope.type == 'reporter' }">
									<c:if test="${sessionScope.id == i.writer }">
									<a href="/news/delete/${i.aid }" class="btn btn-danger">x</a>
									</c:if>					
								</c:if>
							</p>
							<div class="a">
							<img src="${i.img }" class="card-img-top"  alt="이미지 가져올 수 없음 ">							
							</div>
							<hr>
							<div class="card-body ">
								<h3 class="card-title">${i.title }</h3>
								<hr>
								 <p class="text-end">조회수 : ${i.hit }</p>
								<p class="text-end" >${i.writer } 기자</p>
								
									<div class="container">
										<div class="nowrap overflow ellipsis">
											<!--말줄이기 위한 코드  -->
											<p class="card-text">${i.content}</p>
										</div>
									</div>
								
								</div>
							</div>
						</div>						
					</c:forEach>
			</div>
		</article>
		</div>	
	</section>
	<footer class="text-center">
	Copyleft © JANGHO CORP. All rights allowed.
	</footer>

</body>
</html>