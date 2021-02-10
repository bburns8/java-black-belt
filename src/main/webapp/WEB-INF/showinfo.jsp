<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TV Shows</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.1/css/bulma.min.css">
</head>
<body>

	<div class="container">
		<div class="notification">
			<h1 class="title">
				<c:out value="${show.name}" />
			</h1>
		</div>
		<div>
			<a href="/shows">Dashboard</a> | <a href="/logout">Logout</a>
		</div>
		<div>
			<h1 class="subtitle">
				Network:
				<c:out value="${show.instructor}" />
			</h1>
			<h1 class="subtitle">Users who rated this show </h1>
		</div>

		<table class="table">
			<thead class="dashtable">
				<tr>
					<td>Name</td>
					<td>Rating</td>
					<td>Action</td>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${show.getUsers()}" var="user">
					<tr>
						<td>${user.name}</td>
						<td>${show.capacity} / 5</td>

						<c:choose>
						<c:when test="${user.getId() == currentUser.getId()}">
							<c:choose>
							<c:when test="${show.getUsers().indexOf(currentUser)!= -1}">
								<td><a href="/shows/${show.id}/remove">Remove Rating</a></td>
							</c:when>
							<c:otherwise>
									<td><a href="/shows/${show.id}/add">Add</a></td>
							</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<td></td>
						</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>

			</tbody>
		</table>


		<a href="/shows/${show.id}/edit" class="btn btn-primary">Edit |</a> <a href="/shows/delete/${show.id}" class="btn btn-primary">Delete</a>


	</div>
</body>
</html>