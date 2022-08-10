<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section class="bg-light">
			<article>	
				<div class="container py-4 " id="addForm">
					<div class="card card-body">
				<h2>뉴스 등록하기</h2>
				<hr>
						<form method="post" action="/news/add" enctype="multipart/form-data">
							<label class="form-label">제목</label> 
							<input type="text"	name="title" class="form-control" /> 
							<label class="form-label">작성자</label>
							<input type="text" name="writer" class="form-control" value="${sessionScope.id }" readonly/>
							 <label	class="form-label">이미지</label> <input type="file" name="file"
								class="form-control" /> <label class="form-label">기사 내용</label>
							<textarea cols="50" rows="5" name="content" class="form-control"></textarea>
							<button type="submit" class="btn btn-success mt-3">저장</button>
							<button type="button" class="btn btn-success mt-3" onClick="location.href='/news/list';"> << Back </button>
						</form>
					</div>
				</div>
			</article>
	</section>
</body>
</html>