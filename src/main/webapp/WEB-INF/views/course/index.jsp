<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../header.jsp"%>
<div class="content-wrapper">
	<section class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h1><spring:message code="course" text="default"/> </h1>
				</div>
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a href="#"><spring:message code="home" text="default"/></a></li>
						<li class="breadcrumb-item active"><spring:message code="list" text="default"/></li>
					</ol>
				</div>
			</div>
		</div>
	</section>

	<section class="content">
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">
					<a href="${request.contextPath}/course/create"
						class="btn btn-sm btn-dark"><i class="fa fa-plus-circle"></i></a>
					<c:forEach items="${ categories }" var="c">
						<c:if test="${ c.courses.size() > 0 }">
							<a href="${request.contextPath}/course/category/${c.id}" class="btn btn-sm btn-dark">${ c.name }</a>
						</c:if>
					</c:forEach>
				</h3>

				<div class="card-tools">
					<form id="form-search" action="${request.contextPath}/course/search" method="get">
						<div class="input-group input-group" style="width: 250px;">
							<input type="text" id="search" class="form-control float-right"
								placeholder='<spring:message code="search" text="default"/>' value="${ search }">
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
								<th><spring:message code="course.image" text="default"/></th>
								<th><spring:message code="course.name" text="default"/></th>
								<th><spring:message code="course.session" text="default"/></th>
								<th><spring:message code="course.price" text="default"/></th>
								<th><spring:message code="status" text="default"/></th>
								<th><spring:message code="course category" text="default"/></th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${ page.getContent() }" var="c">
								<tr>
									<td>
										<img alt="???nh b??a" src="${ c.image }" width="120">
									</td>
									<td>${ c.name }</td>
									<td>${ c.session }</td>
									<td>
										<fmt:setLocale value="${pageContext.response.locale}"/>
										<fmt:formatNumber value="${ c.price }" type="currency" pattern="##,##0" currencyCode="VND"/>
									</td>
									<td>
										<c:choose>
											<c:when test="${ c.status == 1 }">
												<span class="badge badge-success">Hi???n th???</span>
											</c:when>
											<c:otherwise>
												<span class="badge badge-secondary">???n</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td>${ c.category.name }</td>
									<td class="text-right"><a
										href="${request.contextPath}/course/${ c.id }/update"
										class="btn btn-warning btn-sm"><i class="fa fa-edit"></i></a>
										<a href="course/${ c.id }/delete"
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
									class="page-link disable" href="?page=${ p - 1 }"
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
										<span class="sr-only">Previous</span>
								</a></li>
								<c:forEach end="${ page.getTotalPages() }" begin="1" var="i">
									<li class="page-item ${ p == i ? 'active' : '' }"><a class="page-link"
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
	$(document).on('click',".btn-delete",function(e){
		e.preventDefault();
		let url = "http://localhost:8080/" + $(this).attr("href");
		console.log(url)
		Swal.fire({
		  title: '<spring:message code="are you sure delete" text="default"/>',
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonText: 'Xo??',
		  cancelButtonText: "Hu???"
		}).then((result) => {
		  if (result.isConfirmed) {
			  $.ajax({
				type:"get",
				url,
				success : res => {
					if(res == 200){
						Swal.fire('<spring:message code="success delete" text="default"/>','', 'success');
						$(".content").load(window.location.href + " .content>*");
					}else{
						Swal.fire('Kh??ng th??? xo?? d??? li???u hi???n t???i','', 'error');
					}
				}
			}); 
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
