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
				<div class="col-sm-2">
					<h1>Nhập điểm thi</h1>
				</div>
				<div class="col-sm-6">
					<c:if test="${ error != null }">
						<div class="alert alert-danger failed" role="alert">
						  ${ error }
						</div>
					</c:if>
					<h5 class="text-danger error"></h5>
				</div>
				<div class="col-sm-4">
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
				<div class="row">
					<div class="col-md-2">
						<select id="choose-class" class="custom-select custom-select">
							<option>--Chọn lớp--</option>
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
<%-- 									<c:if test="${  }"> --%>
										
<%-- 									</c:if> --%>
									<option value="${ s.id }" ${ subject.id == s.id ? 'selected' : '' }>${s.name}</option>
								</c:forEach>
							</select>
						</c:if>
					</div>
					<div class="col-md-8">
						<div class="card-tools text-right">
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
				</div>
			</div>
			<c:if test="${ classId != null && subject != null}">
				<div class="card-body">
					<div class="row">
						<div class="col-md-3">
							<h3>ID</h3>
						</div>
						<div class="col-md-3"><h3>Mã sinh viên</h3></div>
						<div class="col-md-3"><h3>Tên sinh viên</h3></div>
						<div class="col-md-3 text-right"><h3>Điểm</h3></div>
					</div>
					<hr/>
					<form action="" method="post" id="form-create">
						<input type="text" class="form-control form-control-lg subjectId" name="subjectId" value="${ subject.id }" readonly="readonly" hidden="hidden">
						<c:forEach items="${ students }" var="std">
							<div class="row">
								<div class="col-md-1">
									<div class="form-group">
										<input type="text" class="form-control form-control-lg studentId" name="studentId[]" value="${ std.id }" readonly="readonly">
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<input type="text" class="form-control form-control-lg studentCode" value="${ std.studentCode }" readonly="readonly">
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<input type="text" class="form-control form-control-lg" value="${ std.name }" readonly="readonly">
									</div>
								</div>
								<div class="col-md-5 text-right">
									<div class="form-group">
										<input type="text" name="score[]" class="form-control form-control-lg score" placeholder="Điểm thi" />
										<p class="text-danger errscore${ std.studentCode }">${ error }</p>
									</div>
								</div>
							</div>
						</c:forEach>
						<div class="row">
							<div class="col-md-12 text-right" style="padding-top: 30px;">
								<button type="submit" class="btn btn-lg btn-dark btn-submit">
									<i class="fa fa-check"></i>
								</button>
								<a href="${ pageContext.request.contextPath }/mark" class="btn btn-lg btn-dark"><i class="fa fa-window-close"></i></a>
							</div>
						</div>
					</form>
				</div>
			</c:if>
		</div>
	</section>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script>
	$(document).ready(function(){
		$("#choose-class").change(function(){
			classId = $(this).val();
 			let url = "http://localhost:8080/mark/create?classId=" + classId;
 			if(classId != ""){
				window.location = url;
			}
		});

		$("#choose-subject").change(function(){
			let subjectId = $(this).val();
			let url = "http://localhost:8080/mark/create?classId=${classId}&subjectId="+subjectId;
			if(subjectId != ""){
				window.location = url;
			}
		});

		$(document).on("submit", "#form-create", function(e){
			e.preventDefault();
			let studentId = [];
			let marks = [];
			let subjectId = $(".subjectId").val();

			$(".studentId").each(function(){
				studentId.push($(this).val());
			});

			$(".score").each(function(){
				marks.push($(this).val());
			});
			
			$.ajax({
				url : "http://localhost:8080/mark/create",
				type: "POST",
				data: {
					studentId,
					score : marks,
					subjectId
				},
				success: res => {
					if(res.success){
						window.location = "http://localhost:8080/mark";
					}else if(res.error){
						$(".error").text(res.error);
					}else{
						$.each(res, (index, value) => {
							$(".errscore"+index).text(value);
						});
					}
				}
			});
		});

		$(document).on("keyup", ".score", function(){
			let stdCode = $(this).closest("form").find(".studentCode").val();
			$(".errscore"+stdCode).text("");
		});
	});
</script>
<%@include file="../footer.jsp"%>
