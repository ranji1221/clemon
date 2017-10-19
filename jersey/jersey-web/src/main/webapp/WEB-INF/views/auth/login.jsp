<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Jersey Open Flatform</title>
	</head>
	<body>
		<h3 align="center">login</h3>
		<hr color="red">
		<form action="${pageContext.request.contextPath}/login" method="post">
			<table border="1" align="center">
				<tr>
					<td align="right">username</td>
					<td align="left"><input name="username"></td>
				</tr>
				<tr>
					<td align="right">password</td>
					<td align="left"><input type="password" name="password"></td>
				</tr>
				<tr>
					<td align="right">validateCode</td>
					<td colspan="2" align="left">
						<input type="text" id="captcha" name="captcha" maxlength="4" />  
						<img src="captcha" onclick="this.src='captcha?d='+new Date().getTime()"/>  
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="获取Token"></td>
				</tr>
			</table>
		</form>
	</body>
</html>