<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Get Token</title>
	</head>
	<body>
		<h3 align="center">获取Token</h3>
		<hr color="red">
		<form action="${pageContext.request.contextPath}/oauth2/token" method="post">
			<table border="1" align="center">
				<tr>
					<td align="right">client_id</td>
					<td align="left"><input name="client_id"></td>
				</tr>
				<tr>
					<td align="right">client_secret</td>
					<td align="left"><input name="client_secret"></td>
				</tr>
				<tr>
					<td align="right">grant_type</td>
					<td align="left"><input name="grant_type" value="client_credentials"></td>
				</tr>
				<tr>
					<td align="right">scope</td>
					<td align="left"><input name="scope" value="read write"></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="获取Token"></td>
				</tr>
			</table>
		</form>
	</body>
</html>