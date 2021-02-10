<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
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
				Welcome,
				<c:out value="${user.name}" />
			</h1>
		</div>
		<div>
			TV Shows | <a href="/logout">Logout</a>
		</div>
		
		<table class="table">
			<thead class="dashtable">
				<tr>
					<td>Show</td>
					<td>Network</td>
					<td>Your Rating</td>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${shows}" var="show">
				<tr>
					<td><a href="/shows/${show.id}">${show.name}</a></td>
					<td>${show.instructor}</td>
					<td>${show.capacity} / 5</td>
					<td>
					<c:choose>
						<c:when test="${show.getUsers().indexOf(user)!= -1}">
							Rating already posted
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${show.getUsers().size() == show.capacity}">
									Full
								</c:when>
								<c:otherwise>
									<a href="/shows/add/${show.id}">Submit Rating</a>
								</c:otherwise>
							</c:choose>	
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>

		<div class="primary">
			<a href="/shows/new" class="btn btn-primary">Add Show</a>
		</div>

	</div>
</body>
</html>