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
					<c:if test="${ err_data != null }">
						<div class="alert alert-danger failed" role="alert">
						  ${ err_data }
						</div>
					</c:if>
				</div>
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a href="#"><spring:message code="home" text="default"/></a></li>
						<li class="breadcrumb-item active"><spring:message code="update" text="default"/></li>
					</ol>
				</div>
			</div>
		</div>
	</section>

	<section class="content">
		<div class="card">
			<div class="card-header">
				<h3 class="card-title"><spring:message code="update" text="default"/></h3>
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
				<form:form action="" method="post" modelAttribute="course" enctype="multipart/form-data">
					<div class="row">
						<div class="col-md-8">
							<div class="form-group">
								<label for="exampleFormControlInput1"><spring:message code="course.image" text="default"/></label>
								<img id="image_course" alt="Ảnh khoá học" src="${ course.image }" width="100%" height="400px">
							</div>
							
							<div class="form-group">
								<label for="exampleFormControlInput1"><spring:message code="course.image" text="default"/></label>
								<form:textarea path="description" id="summernote"/>
								<form:errors cssClass="errors" path="description"/>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="exampleFormControlInput1"><spring:message code="course.image" text="default"/></label>
								<form:input type="text" class="form-control"
									path="name" id="name" placeholder="Tên Khoá học" />
								<form:errors cssClass="errors" path="name"/>
							</div>
							<div class="form-group">
								<label for="exampleFormControlInput1"><spring:message code="course.slug" text="default"/></label>
								<form:input type="text" class="form-control"
									path="slug" id="slug" placeholder="Tiêu đề" />
								<form:errors cssClass="errors" path="slug"/>
							</div>
							<label for=""><spring:message code="course.image" text="default"/></label>
							<div class="custom-file">
								  <input type="file" name="upload" class="custom-file-input" id="customFile">
								  <label class="custom-file-label" for="customFile">${course.image }</label>
								  <c:if test="${ err_image != null }">
								  	<p class="errors">
									  	<spring:message code="validate.course.image" text=""/>
									  </p>
								  </c:if>
							</div>
							<div class="form-group mt-3">
								<label for="exampleFormControlInput1"><spring:message code="course.session" text="default"/></label>
								<form:input type="text" class="form-control"
									path="session" placeholder="Số buổi học" />
								<form:errors cssClass="errors" path="session"/>
							</div>
							<div class="form-group">
								<label for="exampleFormControlInput1"><spring:message code="course.price" text="default"/></label>
								<form:input class="form-control"
									path="price" placeholder="Giá khoá học" />
								<form:errors cssClass="errors" path="price"/>
							</div>
							<div class="form-group">
								<label for="exampleFormControlSelect1"><spring:message code="course category" text="default"/></label>
								<form:select class="form-control" path="category.id">
									<form:options items="${ categories }" itemValue="id" itemLabel="name"/>
								</form:select>
							</div>
							<div class="form-group">
								<label for="exampleFormControlSelect1"><spring:message code="status" text="default"/></label>
								<form:select class="form-control" path="status">
									<form:option value="0"><spring:message code="hide" text="default"/></form:option>
									<form:option value="1"><spring:message code="publish" text="default"/></form:option>
								</form:select>
							</div>
							<div class="form-group">
								<label for="exampleFormControlInput1"><spring:message code="created" text="default"/></label>
								<form:input type="date" class="form-control date"
									path="created" />
								<form:errors cssClass="errors" path="created"/>
							</div>
							<div class="text-right" style="padding-top: 30px;">
								<button type="submit" class="btn btn-lg btn-dark">
									<i class="fa fa-check"></i>
								</button>
								<a href="${ pageContext.request.contextPath }/course" class="btn btn-lg btn-dark"><i class="fa fa-window-close"></i></a>
							</div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</section>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script>
	$(document).ready(function(){
		$("#name").keyup(function(){
			let title, slug;
			//Lấy text từ thẻ input title 
			title = $("#name").val();

			//Đổi chữ hoa thành chữ thường
			slug = title.toLowerCase();
			
		    //Đổi ký tự có dấu thành không dấu
		    slug = slug.replace(/á|à|ả|ạ|ã|ă|ắ|ằ|ẳ|ẵ|ặ|â|ấ|ầ|ẩ|ẫ|ậ/gi, 'a');
		    slug = slug.replace(/é|è|ẻ|ẽ|ẹ|ê|ế|ề|ể|ễ|ệ/gi, 'e');
		    slug = slug.replace(/i|í|ì|ỉ|ĩ|ị/gi, 'i');
		    slug = slug.replace(/ó|ò|ỏ|õ|ọ|ô|ố|ồ|ổ|ỗ|ộ|ơ|ớ|ờ|ở|ỡ|ợ/gi, 'o');
		    slug = slug.replace(/ú|ù|ủ|ũ|ụ|ư|ứ|ừ|ử|ữ|ự/gi, 'u');
		    slug = slug.replace(/ý|ỳ|ỷ|ỹ|ỵ/gi, 'y');
		    slug = slug.replace(/đ/gi, 'd');
		    //Xóa các ký tự đặt biệt
		    slug = slug.replace(/\`|\~|\!|\@|\#|\||\$|\%|\^|\&|\*|\(|\)|\+|\=|\,|\.|\/|\?|\>|\<|\/ /gi, '');
		    //Đổi khoảng trắng thành ký tự gạch ngang
		    slug = slug.replace(/ /gi, "-");
		    //Đổi nhiều ký tự gạch ngang liên tiếp thành 1 ký tự gạch ngang
		    //Phòng trường hợp người nhập vào quá nhiều ký tự trắng
		    slug = slug.replace(/\-\-\-\-\-/gi, '-');
		    slug = slug.replace(/\-\-\-\-/gi, '-');
		    slug = slug.replace(/\-\-\-/gi, '-');
		    slug = slug.replace(/\-\-/gi, '-');
		    //Xóa các ký tự gạch ngang ở đầu và cuối
		    slug = '@' + slug + '@';
		    slug = slug.replace(/\@\-|\-\@|\@/gi, '');
			//In slug ra textbox có id “slug”
			$("#slug").val(slug)
		});

		$("#customFile").change(function(){
			let file = $(this)[0].files[0];
			$(".custom-file-label").text(file.name);
			let reader = new FileReader();
			reader.onload = (e) => {
				$('#image_course').attr('src', e.target.result);
			}
			reader.readAsDataURL(file);
		});

		$('#summernote').summernote({
			height : 240
		});
	})
</script>
<%@include file="../footer.jsp"%>
