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
					<h1>Danh sách Đăng ký Khoá học</h1>
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
				<h3 class="card-title">
				</h3>

				<div class="card-tools">
					<form id="form-search" action="${request.contextPath}/register-course/search" method="get">
						<div class="input-group input-group" style="width: 250px;">
							<input type="text" id="search" class="form-control float-right"
								placeholder="Tìm kiếm">
							<div class="input-group-append">
								<button type="submit" class="btn btn-default">
									<i class="fas fa-search"></i>
								</button>
							</div>
						</div>
					</form>
				</div>
			</div>

			<div id="main-data">
				<div class="card-body table-responsive p-0">
					<table class="table table-hover text-nowrap">
						<thead>
							<tr>
								<th>Họ tên</th>
								<th>Email</th>
								<th>Địa chỉ</th>
								<th>Số điện thoại</th>
								<th>Lời nhắn</th>
								<th>Khoá học</th>
								<th>Trạng thái</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${ page.getContent() }" var="rc">
								<tr>
									<td>${ rc.name }</td>
									<td>${ rc.email }</td>
									<td>${ rc.address }</td>
									<td>${ rc.phone }</td>
									<td>${ rc.message }</td>
									<td>${ rc.course.name }</td>
									<td>
										<select class="custom-select status" id="${ rc.id }">
										  <option value="0" ${ rc.status == 0 ? 'selected' : '' }>Huỷ đăng ký</option>
										  <option value="1" ${ rc.status == 1 ? 'selected' : '' }>Đang chờ tư vấn</option>
										  <option value="2" ${ rc.status == 2 ? 'selected' : '' }>Đã xác nhận đăng ký</option>
										  <option value="3" ${ rc.status == 3 ? 'selected' : '' }>Đã nhập học</option>
										</select> 										
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
	$(".status").change(function(){
		let id = $(this).attr("id");
		let status = $(this).val();
		let url = "http://localhost:8080/register-course/update/"+id+"/"+ status;
		$.ajax({
			url,
			type: "GET",
			success: res => {
				if(res == 200){
					Swal.fire('Cập nhật thành công','', 'success');
				}else{
					Swal.fire('Không thể cập nhật dữ liệu hiện tại','', 'success');
				}
			}
		});
	});
	
	$(document).on("submit","#form-search",function(e){
		e.preventDefault();
		let search = $("#search").val();
		let url = $(this).attr("action");
		window.location = url + "/" + search;
	});
</script>
