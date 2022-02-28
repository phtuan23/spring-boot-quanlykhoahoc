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
				<h3 class="card-title">Thêm mới Sinh viên</h3>
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
				<form:form action="" method="post" modelAttribute="student">
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="exampleFormControlInput1">Mã sinh viên</label>
								<form:input class="form-control stdCode"
									path="studentCode" placeholder="Mã sinh viên" />
								<form:errors cssClass="errors" path="studentCode"/>
							</div>
							<div class="form-group">
								<label for="exampleFormControlInput1">Tên sinh viên</label>
								<form:input class="form-control"
									path="name" id="name" placeholder="Tên sinh viên" />
								<form:errors cssClass="errors" path="name"/>
							</div>
							<div class="form-group">
								<label for="exampleFormControlInput1">Email</label>
								<form:input class="form-control"
									path="email" id="email" placeholder="Email" />
								<form:errors cssClass="errors" path="email"/>
							</div>
							<div class="form-group">
								<label for="exampleFormControlInput1">Địa chỉ</label>
								<form:input class="form-control"
									path="address" placeholder="Địa chỉ" />
								<form:errors cssClass="errors" path="address"/>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="exampleFormControlInput1">Số điện thoại</label>
								<form:input class="form-control stdPhone"
									path="phone" placeholder="Số điện thoại" />
								<form:errors cssClass="errors" path="phone"/>
							</div>
							<div class="form-group">
								<label for="exampleFormControlInput1">Ngày sinh</label>
								<form:input type="date" class="form-control"
									path="birthday"  />
								<form:errors cssClass="errors" path="birthday"/>
							</div>
							<div class="form-group">
								<label for="exampleFormControlInput1">Giới tính</label>
								<form:select class="form-control" path="gender">
									<form:option value="0">Nữ</form:option>
									<form:option value="1">Nam</form:option>
								</form:select>
								<form:errors cssClass="errors" path="gender"/>
							</div>
							<div class="form-group">
								<label for="exampleFormControlInput1">Lớp</label>
								<form:select class="form-control" path="classroom.id">
									<form:options items="${ classes }" itemValue="id" itemLabel="name"/>
								</form:select>
								<form:errors cssClass="errors" path="gender"/>
							</div>
							<div class="text-right" style="padding-top: 30px;">
								<button type="submit" class="btn btn-lg btn-dark">
									<i class="fa fa-check"></i>
								</button>
								<a href="${ pageContext.request.contextPath }/class" class="btn btn-lg btn-dark"><i class="fa fa-window-close"></i></a>
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
	$("#email").val(slug + "@gmail.com")
});

	let num = Math.floor((Math.random() * 100000) + 1);
	let stdCode = "B" + num;
	let numPhone = Math.floor((Math.random() * 1000000000) + 1);
	let stdPhone = "0" + numPhone;
	$(".stdCode").val(stdCode);
	$(".stdPhone").val(stdPhone)
</script>
<%@include file="../footer.jsp"%>
