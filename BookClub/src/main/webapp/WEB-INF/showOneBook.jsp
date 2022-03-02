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
<title>Show One</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
</head>
<body>
	<div class="container mt-5">
		<h1>${book.title}</h1>
		<a href="/books"> back to the shelves</a>
		<c:choose>
			<c:when test="${book.user.id == userId}">
				<h4>
					<span class="text-danger">You</span> read
				</h4>
			</c:when>
			<c:otherwise>
				<h4>
					<span class="text-danger">${book.user.userName}</span> read
				</h4>
			</c:otherwise>
		</c:choose>
		<h4>
			<span class="text-primary">${book.title}</span> by <span
				class="text-success">${book.author}</span>
		</h4>
		<c:choose>
			<c:when test="${book.user.id == userId}">
				<h6>Here are your thoughts...</h6>
			</c:when>
			<c:otherwise>
				<h6>Here are ${book.user.userName}'s thoughts:</h6>
			</c:otherwise>
		</c:choose>
		<p class="border rounded-3 p-3">${book.thoughts}</p>
		<c:choose>
			<c:when test="${book.user.id == userId}">
				<a href="/books/${book.id}/edit" class="btn btn-primary">Edit</a>
			</c:when>
		</c:choose>
	</div>
</body>
</html>