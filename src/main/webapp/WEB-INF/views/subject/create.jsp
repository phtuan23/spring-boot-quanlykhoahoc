<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../header.jsp"%>
<style>
	.errors{
		color: red;
		padding: 2px;
		padding-top: 2px
	}
</style>
<div class="content-wrapper">
	<section class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<c:if test="${ error != null }">
						<div class="alert alert-danger failed" role="alert">
						  ${ error }
						</div>
					</c:if>
				</div>
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
						<li class="breadcrumb-item active">Thêm mới</li>
					</ol>
				</div>
			</div>
		</div>
	</section>

	<section class="content">
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">Thêm mới Môn học</h3>
				<div class="card-tools">
					<button type="button" class="btn btn-tool"
						data-card-widget="collapse" title="Collapse">
						<i class="fas fa-minus"></i>
					</button>
					<button type="button" class="btn btn-tool"
						data-card-widget="remove" title="Remove">
						<i class="fas fa-times"></i>
					</button>
				</div>
			</div>
			<div class="card-body">
				<form:form action="" method="post" modelAttribute="subject">
					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label for="exampleFormControlInput1">Tên Môn học</label>
								<form:input type="text" class="form-control"
									path="name" placeholder="Tên Môn học" />
								<form:errors cssClass="errors" path="name"/>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="exampleFormControlInput1">Ngày tạo</label>
								<form:input type="date" class="form-control date"
									path="created" />
								<form:errors cssClass="errors" path="created"/>
							</div>
						</div>
						<div class="col-md-4">
							<div class="text-right" style="padding-top: 30px;">
								<button type="submit" class="btn btn-lg btn-dark">
									<i class="fa fa-check"></i>
								</button>
								<a href="${ pageContext.request.contextPath }/subject" class="btn btn-lg btn-dark"><i class="fa fa-window-close"></i></a>
							</div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</section>
</div>

<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script> -->
<%@include file="../footer.jsp"%>
