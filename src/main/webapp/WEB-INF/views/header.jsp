<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><spring:message code="Course Manager"/></title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.2.1/sweetalert2.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
<link rel="stylesheet" href="/admin/dist/css/adminlte.min.css" />
</head>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
		<nav
			class="main-header navbar navbar-expand navbar-white navbar-light">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
			</ul>
		</nav>

		<aside class="main-sidebar sidebar-dark-primary elevation-4">
			<a href="" class="brand-link"> <img
				src="/admin/dist/img/AdminLTELogo.png" alt="AdminLTE Logo"
				class="brand-image img-circle elevation-3" style="opacity: .8">
				<span class="brand-text font-weight-light">
					<spring:message code="administration" text="default"/>
				</span>
			</a>
			
			<div class="sidebar">
				<div class="user-panel mt-3 pb-3 mb-3 d-flex">
					<div class="image">
						<img src="/admin/dist/img/user2-160x160.jpg"
							class="img-circle elevation-2" alt="User Image">
					</div>
					<div class="info">
						<a href="#" class="d-block">
							Admin
						</a>
						<a href="${request.contextPath}/logout" class="d-block mt-3"><i class="fa fa-sign-out-alt"></i> <spring:message code="logout" text="default"/></a>
						<a href="${request.contextPath}/?language=en" class="d-block mt-3"><i class="fa fa-globe"></i> <spring:message code="english" text="default"/></a>
						<a href="${request.contextPath}/?language=vi" class="d-block mt-3"><i class="fa fa-globe"></i> <spring:message code="vietnamese" text="default"/></a>
					</div>
				</div>
				<nav class="mt-2">
					<ul class="nav nav-pills nav-sidebar flex-column"
						data-widget="treeview" role="menu" data-accordion="false">
						<li class="nav-item">
							<a href="${request.contextPath}/users" class="nav-link"><i class="nav-icon fas fa-user-cog"></i>
								<p><spring:message code="user" text="default"/></p>
							</a>
						</li>
						<li class="nav-item">
							<a href="${request.contextPath}/category" class="nav-link"><i class="nav-icon fas fa-user-cog"></i>
								<p><spring:message code="course category" text="default"/></p>
							</a>
						</li>
						<li class="nav-item">
							<a href="${request.contextPath}/course" class="nav-link"><i class="nav-icon fas fa-user-cog"></i>
								<p><spring:message code="course" text="default"/></p>
							</a>
						</li>
						<li class="nav-item">
							<a href="${request.contextPath}/class" class="nav-link"><i class="nav-icon fas fa-user-cog"></i>
								<p><spring:message code="class" text="default"/></p>
							</a>
						</li>
						<li class="nav-item">
							<a href="${request.contextPath}/student" class="nav-link"><i class="nav-icon fas fa-user-cog"></i>
								<p><spring:message code="student" text="default"/></p>
							</a>
						</li>
						<li class="nav-item">
							<a href="${request.contextPath}/subject" class="nav-link"><i class="nav-icon fas fa-user-cog"></i>
								<p><spring:message code="subject" text="default"/></p>
							</a>
						</li>
						<li class="nav-item">
							<a href="${request.contextPath}/mark" class="nav-link"><i class="nav-icon fas fa-user-cog"></i>
								<p><spring:message code="mark" text="default"/></p>
							</a>
						</li>
						<li class="nav-item">
							<a href="${request.contextPath}/register-course" class="nav-link"><i class="nav-icon fas fa-user-cog"></i>
								<p><spring:message code="register course manager" text="default"/></p>
							</a>
						</li>
					</ul>
				</nav>
			</div>
		</aside>