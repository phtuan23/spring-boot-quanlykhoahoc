<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="../header.jsp"%>
<style>
	.errors{
		color: red;
		padding-top: 2px;
		padding: 4px
	}
</style>
<div class="content-wrapper">
	<section class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<c:if test="${ failed != null }">
						<div class="alert alert-danger failed" role="alert">
						  ${ failed }
						</div>
					</c:if>
					
				</div>
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a href="#"><spring:message code="home"/></a></li>
						<li class="breadcrumb-item active"><spring:message code="update"/></li>
					</ol>
				</div>
			</div>
		</div>
	</section>

	<section class="content">
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">Thêm mới Người dùng</h3>
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
				<form:form action="" method="post" modelAttribute="user">
					<div class="row"> 
						<div class="col-md-6">
							<div class="form-group">
								<label for="exampleFormControlInput1"><spring:message code="fullname" text="Fullname"/></label>
								<form:input class="form-control form-control-lg"
									path="name"  placeholder="..." />
								<form:errors cssClass="errors" path="name"/>
							</div>
							<div class="form-group">
								<label for="exampleFormControlInput1"><spring:message code="phone"/></label>
								<form:input class="form-control form-control-lg"
									path="phone"  placeholder="..." />
								<form:errors cssClass="errors" path="phone"/>
							</div>
							<div class="form-group">
								<label for="exampleFormControlInput1"><spring:message code="address"/></label>
								<form:input class="form-control form-control-lg"
									path="address"  placeholder="..." />
								<form:errors cssClass="errors" path="address"/>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="exampleFormControlInput1"><spring:message code="email"/></label>
								<form:input class="form-control form-control-lg"
									path="email"  placeholder="..."/>
								<form:errors cssClass="errors" path="email"/>
								<c:if test="${ err_email != null }">
									<p class="text-danger"> ${ err_email }</p>
								</c:if>
							</div>
							<div class="form-group">
								<label for="exampleFormControlInput1"><spring:message code="username"/></label>
								<form:input class="form-control form-control-lg"
									path="username" placeholder="..."/>
								<form:errors cssClass="errors" path="username"/>
								<c:if test="${ err_username != null }">
									<p class="text-danger"> ${ err_username }</p>
								</c:if>
							</div>
							<div class="form-group">
								<label for="exampleFormControlInput1"><spring:message code="password"/></label>
								<form:input type="password" class="form-control form-control-lg"
									path="password" placeholder="..."/>
								<form:errors cssClass="errors" path="password"/>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="exampleFormControlSelect1"><spring:message code="role"/></label>
								<select class="form-control form-control-lg" name="roleId" >
									<c:forEach items="${ roles }" var="r">
										<option value="${ r.id }" ${ user.userRoles.get(0).role.id == r.id ? 'selected' : ''  }>${ r.name }</option>								
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="col-md-6 text-right" style="padding-top: 30px;">
							<button type="submit" class="btn btn-lg btn-dark">
								<i class="fa fa-check"></i>
							</button>
							<a href="" class="btn btn-lg btn-dark"><i class="fa fa-window-close"></i></a>
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
		
	})
</script>
<%@include file="../footer.jsp"%>
