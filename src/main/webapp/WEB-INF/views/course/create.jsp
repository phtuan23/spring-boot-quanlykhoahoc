<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
						<li class="breadcrumb-item active"><spring:message code="create" text="default"/></li>
					</ol>
				</div>
			</div>
		</div>
	</section>

	<section class="content">
		<div class="card">
			<div class="card-header">
				<h3 class="card-title"><spring:message code="create" text="default"/><spring:message code="course" text="default"/></h3>
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
								<label for="exampleFormControlInput1"><spring:message code="course.name" text="default"/></label>
								<form:input type="text" class="form-control"
									path="name" id="name" />
								<form:errors cssClass="errors" path="name"/>
							</div>
							<div class="form-group">
								<label for="exampleFormControlInput1"><spring:message code="course.slug" text="default"/></label>
								<form:input type="text" class="form-control"
									path="slug" id="slug"  />
								<form:errors cssClass="errors" path="slug"/>
							</div>
							<div class="form-group">
								<label for="exampleFormControlInput1"><spring:message code="course.description" text="default"/></label>
								<form:textarea path="description" id="summernote"/>
								<form:errors cssClass="errors" path="description"/>
							</div>
						</div>
						<div class="col-md-4">
							<label for=""><spring:message code="course.image" text="default"/></label>
							<div class="custom-file">
								  <input type="file" name="upload" class="custom-file-input" id="customFile">
								  <label class="custom-file-label" for="customFile"><spring:message code="course.image" text="default"/></label>
								  <c:if test="${ err_image != null }">
								  	<p class="errors">
									  	<spring:message code="validate.course.image" text=""/>
									  </p>
								  </c:if>
							</div>
							<div class="form-group mt-3">
								<label for="exampleFormControlInput1"><spring:message code="course.session" text="default"/></label>
								<form:input type="text" class="form-control"
									path="session"  />
								<form:errors cssClass="errors" path="session"/>
							</div>
							<div class="form-group">
								<label for="exampleFormControlInput1"><spring:message code="course.price" text="default"/></label>
								<form:input class="form-control"
									path="price"  />
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
			//L???y text t??? th??? input title 
			title = $("#name").val();

			//?????i ch??? hoa th??nh ch??? th?????ng
			slug = title.toLowerCase();
			
		    //?????i k?? t??? c?? d???u th??nh kh??ng d???u
		    slug = slug.replace(/??|??|???|???|??|??|???|???|???|???|???|??|???|???|???|???|???/gi, 'a');
		    slug = slug.replace(/??|??|???|???|???|??|???|???|???|???|???/gi, 'e');
		    slug = slug.replace(/i|??|??|???|??|???/gi, 'i');
		    slug = slug.replace(/??|??|???|??|???|??|???|???|???|???|???|??|???|???|???|???|???/gi, 'o');
		    slug = slug.replace(/??|??|???|??|???|??|???|???|???|???|???/gi, 'u');
		    slug = slug.replace(/??|???|???|???|???/gi, 'y');
		    slug = slug.replace(/??/gi, 'd');
		    //X??a c??c k?? t??? ?????t bi???t
		    slug = slug.replace(/\`|\~|\!|\@|\#|\||\$|\%|\^|\&|\*|\(|\)|\+|\=|\,|\.|\/|\?|\>|\<|\/ /gi, '');
		    //?????i kho???ng tr???ng th??nh k?? t??? g???ch ngang
		    slug = slug.replace(/ /gi, "-");
		    //?????i nhi???u k?? t??? g???ch ngang li??n ti???p th??nh 1 k?? t??? g???ch ngang
		    //Ph??ng tr?????ng h???p ng?????i nh???p v??o qu?? nhi???u k?? t??? tr???ng
		    slug = slug.replace(/\-\-\-\-\-/gi, '-');
		    slug = slug.replace(/\-\-\-\-/gi, '-');
		    slug = slug.replace(/\-\-\-/gi, '-');
		    slug = slug.replace(/\-\-/gi, '-');
		    //X??a c??c k?? t??? g???ch ngang ??? ?????u v?? cu???i
		    slug = '@' + slug + '@';
		    slug = slug.replace(/\@\-|\-\@|\@/gi, '');
			//In slug ra textbox c?? id ???slug???
			$("#slug").val(slug)
		});

		$("#customFile").change(function(){
			let file = $(this)[0].files[0];
			$(".custom-file-label").text(file.name)
		});

		$('#summernote').summernote({
			height : 240
		});
	})
</script>
<%@include file="../footer.jsp"%>
