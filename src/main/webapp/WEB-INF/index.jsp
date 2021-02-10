<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
			<p class="title">Welcome Please Login Or Register!</p>
		</div>

		<section>
			<div class="columns">

				<div class="column">
					<div class="buttons has-addons is-centered">
						<h1 class="title">Register</h1>
					</div>
					

					<form:form method="POST" action="/registration"
						modelAttribute="user">
						<table class="mytable">

							<tr>
								<td class="primary"><form:label path="name">Name:</form:label></td>
								<td class="primary"><form:input path="name"
										class="input" /></td>
							</tr>
							<tr>
								<td class="primary"><form:label path="email">Email:</form:label></td>
								<td class="primary"><form:input path="email"
										class="input" /></td>
							</tr>

							<tr>
								<td class="primary"><form:label path="password">Password:</form:label></td>
								<td class="primary"><form:input path="password"
										type="password" class="input" /></td>
							</tr>
							<tr>
								<td class="primary"><form:label
										path="passwordConfirmation">Password Confirmation:</form:label></td>
								<td class="primary"><form:input
										path="passwordConfirmation" type="password" class="input" /></td>
							</tr>
						</table>
						<div class="btn btn-primary">
							<input type="submit" value="Register!" class="button" />
						</div>
					</form:form>
					
					<p class="subtitle is-danger">
						<form:errors path="user.*" />
					</p>
				</div>

				<div class="column">
					<div class="buttons has-addons is-centered">
						<h1 class="title">Login</h1>
					</div>

					<form method="post" action="/login">
						<table class="mytable">
							<tr>
								<td class="primary"><label for="email">Email</label></td>
								<td class="primary"><input type="text" id="email"
									name="email" class="input" /></td>
							</tr>
							<tr>
								<td class="primary"><label for="password">Password</label></td>
								<td class="primary"><input type="password"
									id="password" name="password" class="input" /></td>
							</tr>
						</table>
						<div class="btn btn-primary">
							<input type="submit" value="Login" class="button" />
						</div>
					</form>
					<p class="subtitle">
						<c:out value="${error}" />
					</p>
				</div>
			</div>
		</section>
	</div>
</body>
</html>