<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<title>뉴스 관리 앱</title>
<style>


</style>
</head>
<body>
<div class="container w-75 mt-5 mx-auto">
	<h2 class="text-center">${news.title }</h2>
	<br>
	<div class="text-end"> ${news.date }</div>

	<hr />
<div class="card w-75 mx-auto">
	<div class="text-end">조회수 : ${news.hit }</div>
	<img class="card-img-top text-center w-50 mx-auto" src="${news.img }">
	<div class="card-body">
			<p class="card-text">${news.content }</p>
	<!--게시글 작성자 기자만 수정 가능  -->
	<c:if test="${sessionScope.id == news.writer }">
	<c:if test="${sessionScope.type == 'reporter' }">
			<button class="btn btn-outline-info mb-3" type="button"
				data-bs-toggle="collapse" data-bs-target="#reForm"
				aria-expanded="false" aria-controls="reForm">뉴스수정</button>
	</c:if>
	</c:if>
			<div class="collapse" id="reForm">
				<div class="card card-body">
					<form method="post" action="/news/rece/${news.aid }"
						enctype="multipart/form-data">
						<input type="hidden" name="aid" value="${news.aid}" /> <label
							class="form-label">제목</label> <input type="text" name="title"
							class="form-control" value="${news.title }" /> <label
							class="form-label">이미지</label> <input type="file" name="file"
							class="form-control" /> <label class="form-label">기사 내용</label>
						<textarea cols="50" rows="5" name="content" class="form-control">${news.content }</textarea>
						<button type="submit" class="btn btn-success mt-3">수정</button>
					</form>
				</div>
			</div>                                                                                                                                                                                                    

			<form method="post" action="/news/comment/${news.aid }"
						enctype="multipart/form-data">
						<c:if test="${sessionScope.id !=null }">
						<input type="hidden" name="aid"  value= "${news.aid}"/> 
						<label class="form-label">작성자</label> 
						<input type="text" name="id" class="form-control" value="${sessionScope.id }" readonly /> 
						<label class="form-label">댓글</label> 
						<input type="text" name="com" class="form-control" placeholder="null" value="null" /> 
						<button type="submit" class="btn btn-info mt-3">댓글 등록</button>
						</c:if>
					</form>
					<br>
			<ul class="list-group w-50 mx-auto">
				<c:forEach var="comment" items="${commentList }" varStatus="status">
					<li class="list-group-item list-group-item-primary">
						<p>ID : <strong>${comment.id }</strong></p>
						<p class="text-end">${comment.com }</p>
					</li>
				</c:forEach>
			</ul>
		
			<hr />
			<a href="/news/list" class="btn btn-primary">  메인페이지로 </a>
			<hr />
			
			<div>
				<!-- 목록 출력 -->
				<ul class="list-group">		
				<c:forEach var="i" items="${newslist}" varStatus="status">		
					<li class="list-group-itme list-group-item-action
						d-flex justify-content-between ">
						<a href="/news/hit/${i.aid }" style="margin: 1px 1px 1px 100px" class="text-decoration-none" >
							[${status.count}] ${i.title} ${news.date}
						</a>		
					</li>									
				</c:forEach>
				</ul>
			</div> 
			
		</div>
</body>
</html>





