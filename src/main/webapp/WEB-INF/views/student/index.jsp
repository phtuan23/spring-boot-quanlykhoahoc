<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html xmlns:th="http://www.thymeleaf.org">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@include file="../header.jsp"%>
<div class="content-wrapper">
	<section class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h1>Danh sách Sinh viên</h1>
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
					<div class="col-md-1">
						<h3 class="card-title">
							<a href="${request.contextPath}/student/create"class="btn btn-lg btn-dark">
								<i class="fa fa-plus-circle"></i>
							</a>
						</h3>
					</div>
					<div class="col-md-2">
						<select class="custom-select select-class">
						  <option selected>Chọn lớp</option>
						  <c:forEach items="${ classes }" var="c">
						  	<c:if test="${ c.students.size() > 0 }">
						  		<option value="${ c.id }" ${ classId == c.id ? 'selected' : '' }>${ c.name }</option>
						  	</c:if>
						  </c:forEach>
						</select>
					</div>
					<div class="col-md-9">
						<div class="card-tools float-right">
							<form id="form-search" action="${request.contextPath}/student/search" method="get">
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

			<c:if test="${ page.getContent().size() > 0 }">
				<div>
					<div class="card-body table-responsive p-0">
						<table class="table table-hover text-nowrap">
							<thead>
								<tr>
									<th>Mã sinh viên</th>
									<th>Tên Sinh viên</th>
									<th>Email</th>
									<th>Số điện thoại</th>
									<th>Địa chỉ</th>
									<th>Ngày sinh</th>
									<th>Giới tính</th>
									<th>Lớp</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${ page.getContent() }" var="s">
									<tr>
										<td>${ s.studentCode }</td>
										<td>${ s.name }</td>
										<td>${ s.email }</td>
										<td>${ s.phone }</td>
										<td>${ s.address }</td>
										<td>
											<fmt:formatDate value="${ s.birthday }" dateStyle="medium"/>
										</td>
										<td>${ s.gender ? "Nam" : "Nữ" }</td>
										<td>${ s.classroom.name }</td>
										<td class="text-right"><a
											href="student/${ s.id }/update"
											class="btn btn-warning btn-sm"><i class="fa fa-edit"></i></a>
											<a href="student/${ s.id }/delete"
											class="btn btn-danger btn-sm btn-delete"><i
												class="fa fa-trash"></i></a></td>
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
								<c:when test="${ classId != '' }">
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
			</c:if>
			
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
<c:if test="${ failed }">
	<script>
		Swal.fire('${failed}','', 'error');
	</script>
</c:if>
<script>
	$(document).on('click',".btn-delete",function(e){
		e.preventDefault();
		let url = "http://localhost:8080/" + $(this).attr("href");
		console.log(url)
		Swal.fire({
		  title: 'Bạn có chắc muốn xoá?',
		  showCancelButton: true,
		  confirmButtonText: 'Xoá',
		  cancelButtonText: "Huỷ"
		}).then((result) => {
		  if (result.isConfirmed) {
			  $.ajax({
				type:"get",
				url,
				success : res => {
					if(res == 200){
						Swal.fire('Xoá thành công','', 'success');
						$(".content").load(window.location.href + " .content>*");
					}else{
						Swal.fire('Không thể xoá dữ liệu hiện tại','', 'error');
					}
				}
			}); 
		  }
		})
	});
	
	$(document).on("submit","#form-search",function(e){
		e.preventDefault();
		let search = $("#search").val();
		let url = $(this).attr("action");
		window.location = url + "/" + search;
	});

	$(".select-class").change(function(){
		let classId = $(this).val();
		let url = "http://localhost:8080/student?classId=" + classId;
		window.location = url;
	});
</script>