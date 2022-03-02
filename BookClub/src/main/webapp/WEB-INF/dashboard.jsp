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
<title>Dashboard</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
</head>
<body>
	<div class="container mt-5">
		<h1>Welcome, ${user.userName}!</h1>
		<p>Books from everyone's shelves</p>
		<a href="/logout" class="btn btn-primary"> Logout</a> <a href="/books/new"
			class="btn btn-primary"> Add a book to my shelf</a>
		<table class="table table-striped">
			<thead>
				<tr>
					<td>ID</td>
					<td>Title</td>
					<td>Author Name</td>
					<td>Posted by</td>
					<td>Action</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="book" items="${allBooks }">
					<tr>
						<td>${book.id }</td>
						<td><a href="/books/${book.id}"><c:out
									value="${book.title }" /></a></td>
						<td>${book.author }</td>
						<td>${book.user.userName }</td>
						<c:choose>
							<c:when test="${book.user.id == userId}">
								<td>
									<form action="/delete/${book.id}" method="POST">
										<input type="hidden" name="_method" value="delete" />
										<button class="btn btn-danger">Delete</button>
									</form>
								</td>
							</c:when>
						</c:choose>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>