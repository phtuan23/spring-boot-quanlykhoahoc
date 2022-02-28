<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
	<div class="content-wrapper">
		<section class="content-header">
			<div class="container-fluid">
				<div class="row mb-2">
					<div class="col-sm-6">
						<h1><spring:message code="home" text="default"/></h1>
					</div>
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="#"><spring:message code="home" text="default"/></a></li>
							<li class="breadcrumb-item active">Demo</li>
						</ol>
					</div>
				</div>
			</div>
		</section>

		<section class="content">
			<div class="card">
				<div class="card-header">
					<h3 class="card-title"><spring:message code="home" text="default"/></h3>
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
				<div class="card-body"><spring:message code="home" text="default"/></div>
				<div class="card-footer"><spring:message code="home" text="default"/></div>
			</div>
		</section>
	</div>
<%@include file="footer.jsp" %>