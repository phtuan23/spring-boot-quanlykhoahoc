<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html xmlns:th="http://www.thymeleaf.org">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../header.jsp"%>
<div class="content-wrapper">
	<section class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h1>Điểm thi</h1>
				</div>
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
						<li class="breadcrumb-item active">Danh sách</li>
					</ol>
				</div>
			</div>
		</div>
	</section>

	<section class="content">
		<div class="card">
			<div class="card-header">
				<div class="row">
					<div class="col-md-2">
						<h3 class="card-title">
							<a href="${request.contextPath}/mark/create"
								class="btn btn-sm btn-dark"><i class="fa fa-plus-circle"></i> Nhập điểm thi</a>
						</h3>
					</div>
					<div class="col-md-2">
						<select id="choose-class" class="custom-select custom-select">
							<option value="">--Chọn lớp--</option>
							<c:forEach items="${ classes }" var="c">
								<c:if test="${ c.students.size() > 0 }">
									<option value="${ c.id }" ${ classId == c.id ? 'selected' : '' }>${ c.name }</option>														
								</c:if>
							</c:forEach>
						</select>
					</div>
					<div class="col-md-2">
					<c:if test="${ classId != null }">
						<select id="choose-subject" class="custom-select custom-select">
							<option>--Môn thi--</option>
							<c:forEach items="${ subjects }" var="s">
								<option value="${ s.id }" ${ subjectId == s.id ? 'selected' : '' }>${s.name}</option>
							</c:forEach>
						</select>				
					</c:if>
					</div>
					<div class="col-md-6">
						<div class="card-tools text-right">
							<form id="form-search" action="${request.contextPath}/mark/search" method="get">
								<div class="input-group input-group" style="width: 250px;">
									<input type="text" id="search" class="form-control float-right"
										placeholder="Tìm kiếm" value="${ search }">
									<div class="input-group-append">
										<button type="submit" class="btn btn-default">
											<i class="fas fa-search"></i>
										</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
				

				
			</div>

			<div id="main-data">
				<div class="card-body table-responsive p-0">
					<table class="table table-hover text-nowrap">
						<thead>
							<tr>
								<th>Mã sinh viên</th>
								<th>Tên Sinh viên</th>
								<th>Lớp</th>
								<th>Môn học</th>
								<th>Điểm</th>
								<th class="text-right">Cập nhật</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${ page.getContent() }" var="s">
									<tr>
										<td>${ s.student.studentCode }</td>
										<td>${ s.student.name }</td>
										<td>${ s.student.classroom.name }</td>
										<td>${ s.subject.name }</td>
										<td>${ s.score }</td>
										<td class="text-right float-right">
											<form class="form-inline" action="" method="get" id="form-update">
												<div class="form-group">
													 <input class="form-control subjectId" value="${ s.subject.id }" name="subjectId" hidden="hidden">
													  <input class="form-control studentId" name="studentId" value="${ s.student.id }" hidden="hidden">
												    <input class="form-control mark" name="mark" placeholder="Cập nhật Điểm">
												  </div>
											 </form>
										</td>
									</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- /.card-body -->
				<div class="card-footer">
					<nav aria-label="Page navigation example" style='float: right;'>
						<nav aria-label="Page navigation example">
							<c:choose>
								<c:when test="${ classId != null && subjectId != null }">
									<ul class="pagination">
										<li class="page-item ${ p == 1 ? 'disabled' : '' }"><a
											class="page-link disable" href="?classId=${ classId }&subjectId=${ subjectId }&page=${ p - 1 }"
											aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
												<span class="sr-only">Previous</span>
										</a></li>
										<c:forEach end="${ page.getTotalPages() }" begin="1" var="i">
											<li class="page-item"><a class="page-link"
											href="?classId=${ classId }&subjectId=${ subjectId }&page=${ i }">${ i }</a></li> 
										</c:forEach>
		 								<li class="page-item ${ p == page.getTotalPages() ? 'disabled' : '' }">
		 									<a class="page-link" href="?classId=${ classId }&subjectId=${ subjectId }&page=${ p + 1 }" aria-label="Next">
												<span aria-hidden="true">&raquo;</span> <span class="sr-only">Next</span>
											</a>
										</li>
									</ul>
								</c:when>
								<c:when test="${ classId != null }">
									<ul class="pagination">
										<li class="page-item ${ p == 1 ? 'disabled' : '' }"><a
											class="page-link disable" href="?classId=${ classId }&page=${ p - 1 }"
											aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
												<span class="sr-only">Previous</span>
										</a></li>
										<c:forEach end="${ page.getTotalPages() }" begin="1" var="i">
											<li class="page-item"><a class="page-link"
											href="?classId=${ classId }&page=${ i }">${ i }</a></li> 
										</c:forEach>
		 								<li class="page-item ${ p == page.getTotalPages() ? 'disabled' : '' }">
		 									<a class="page-link" href="?classId=${ classId }&page=${ p + 1 }" aria-label="Next">
												<span aria-hidden="true">&raquo;</span> <span class="sr-only">Next</span>
											</a>
										</li>
									</ul>
								</c:when>
								<c:otherwise>
									<ul class="pagination">
										<li class="page-item ${ p == 1 ? 'disabled' : '' }"><a
											class="page-link disable" href="?page=${ p - 1 }"
											aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
												<span class="sr-only">Previous</span>
										</a></li>
										<c:forEach end="${ page.getTotalPages() }" begin="1" var="i">
											<li class="page-item"><a class="page-link"
											href="?page=${ i }">${ i }</a></li> 
										</c:forEach>
		 								<li class="page-item ${ p == page.getTotalPages() ? 'disabled' : '' }">
		 									<a class="page-link" href="?page=${ p + 1 }" aria-label="Next">
												<span aria-hidden="true">&raquo;</span> <span class="sr-only">Next</span>
											</a>
										</li>
									</ul>
								</c:otherwise>
							</c:choose>
						</nav>
					</nav>
				</div>
			</div>
		</div>
	</section>
</div>
<%@include file="../footer.jsp"%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<c:if test="${ success != null }">
	<script>
		Swal.fire('${success}','', 'success');
	</script>
</c:if>
<c:if test="${ failed != null }">
	<script>
		Swal.fire('${failed}','', 'error');
	</script>
</c:if>
<script>
	$(document).on("submit","#form-search",function(e){
		e.preventDefault();
		let search = $("#search").val();
		let url = $(this).attr("action");
		window.location = url + "/" + search;
	});

	$(document).on("change", ".mark", function(e){
		e.preventDefault();
		let data = $(this).closest("form").serialize();
		console.log(data);
	});

	$("#choose-class").change(function(){
		classId = $(this).val();
			let url = "http://localhost:8080/mark?classId=" + classId;
			if(classId != ""){
				window.location = url;
			}
	});

	$("#choose-subject").change(function(){
		let subjectId = $(this).val();
		let url = "http://localhost:8080/mark?classId=${classId}&subjectId="+subjectId;
		if(subjectId != ""){
			window.location = url;
		}
	});
</script>
