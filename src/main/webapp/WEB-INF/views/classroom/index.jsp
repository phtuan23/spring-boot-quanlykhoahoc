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
					<h1>Lớp học</h1>
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
					<a href="${request.contextPath}/class/create"
						class="btn btn-sm btn-dark"><i class="fa fa-plus-circle"></i></a>
				</h3>

				<div class="card-tools">
					<form id="form-search" action="${request.contextPath}/class/search" method="get">
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
								<th>Tên lớp</th>
								<th>Trạng thái</th>
								<th>Ngày tạo</th>
								<th>Số sinh viên</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${ page.getContent() }" var="c">
								<tr>
									<td>${ c.name }</td>
									<td>
										<c:choose>
											<c:when test="${ c.status }">
												<span class="badge badge-success">Hiển thị</span>
											</c:when>
											<c:otherwise>
												<span class="badge badge-secondary">Ẩn</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<fmt:formatDate value="${ c.created }" dateStyle="medium"/>
									</td>
									<td>${ c.students.size() }</td>
									<td class="text-right"><a
										href="${request.contextPath}/class/${ c.id }/update"
										class="btn btn-warning btn-sm"><i class="fa fa-edit"></i></a>
										<a href="${request.contextPath}/class/${ c.id }/delete"
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
							<ul class="pagination">
								<li class="page-item ${ p == 1 ? 'disabled' : '' }"><a
									class="page-link disable" href=""
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
										<span class="sr-only">Previous</span>
								</a></li>
								<c:forEach end="${ page.getTotalPages() }" begin="1" var="i">
									<li class="page-item"><a class="page-link"
									href="${request.contextPath}/class/${i}">${ i }</a></li> 
								</c:forEach>
 								<li class="page-item ${ p == page.getTotalPages() ? 'disabled' : '' }">
 									<a class="page-link" href="" aria-label="Next">
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
<c:if test="${ failed }">
	<script>
		Swal.fire('${failed}','', 'error');
	</script>
</c:if>
<script>
	$(document).on('click',".btn-delete",function(e){
		e.preventDefault();
		let url = $(this).attr("href");
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
	})
</script>