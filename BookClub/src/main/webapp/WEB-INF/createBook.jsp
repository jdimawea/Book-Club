<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
</head>
<body>
	<div class="container mt-5">
		<a href="/logout"> Logout</a>
		<h1>Add a Book to Your Shelf!</h1>
		<form:form action="/books/new" method="POST" modelAttribute="book"
			class="form">
			<div>
				<form:label path="title" class="form-label">Title </form:label>
				<form:input path="title" class="form-control" />
				<form:errors path="title" class="text-danger" />
			</div>

			<div>
				<form:label path="author" class="form-label">Author </form:label>
				<form:input path="author" class="form-control" />
				<form:errors path="author" class="text-danger" />
			</div>
			<div>
				<form:label path="thoughts" class="form-label">My thoughts </form:label>
				<form:textarea path="thoughts" cols="30" rows="5"
					class="form-control"></form:textarea>
				<form:errors path="author" class="text-danger" />
			</div>
			<button class="btn btn-primary">Submit</button>
		</form:form>
	</div>
</body>
</html>