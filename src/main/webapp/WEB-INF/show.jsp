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
				<%-- <c:out value="${user.name}" /> --%>
				Create a new Show
			</h1>
		</div>
		<div>
			<a href="/shows">Dashboard</a> | <a href="/logout">Logout</a>
		</div>
				
		<section>
			<div class="primary">
				<div class="primary">

					<form:form method="POST" action="/shows/new" modelAttribute="show">
						<table>
							<tr>
								<td><form:label path="name">Title:</form:label></td>
								<td><form:input path="name" class="input" /></td>
								<td><form:errors path="name" /></td>
							</tr>
								
							<tr>
								<td><form:label path="instructor">Network:</form:label></td>
								<td><form:input path="instructor" class="input" /></td>
								<td><form:errors path="instructor" /></td>
							</tr>
							<tr>
								<td><form:label path="capacity">Rating:</form:label></td>
								<td><form:input path="capacity" class="input" type="number"/></td>
								<td><form:errors path="capacity" /></td>
							</tr>
						</table>
						<div class="btn btn-primary">
							<input type="submit" value="Create" class="btn btn-primary" />
						</div>
					</form:form>
					<%-- <p>
						<form:errors path="task.*"></form:errors>
					</p> --%>
					<%-- <p><c:out value="${errors}"/></p> --%>

				</div>
				<div class="column"></div>
			</div>

		</section>
		
		
	</div>
</body>
</html>