<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>
<html>
<head>
	<title>test</title>
	<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
</head>
<body>
	<table>
		<tr>
			<td>아이디</td><td><input type="text" id="id"></td>
		</tr>
		<tr>
			<td>이메일</td><td><input type="text" id="email"></td>
		</tr>
		<tr>
			<td>인증</td><td><input type="text" id="authorization"></td>
		</tr>
		<tr>
			<td>사진</td><td><input type="text" id="photo"></td>
		</tr>
	</table>
	<button id="userPOST">userPost</button>
	<button id="userGET">userGET</button>
	<button id="userDELETE">userDELETE</button>
	<button id="userUPDATE">userUPDATE</button>

	<div id="userSection"></div>
	
	<script type="text/javascript">
		$(function(){
			var userData = function(){
				$('#userPOST').on('click',function(){
					var datas = {
						id : $('#id').val(),
						email : $('#email').val(),
						authorization : $('#authorization').val(),
						photo : $('#photo').val()
					};
					
					$.ajax({
						dataTyep : "json",
						type : "POST",
						url : "users",
						data : datas
					}).done(function(){
						id : $('#id').val('');
						email : $('#email').val('');
						authorization : $('#authorization').val('');
						photo : $('#photo').val('');
					});
				});
				
				$('#userGET').on('click',function(){
					$.ajax({
						dataType : "json",
						type : "GET",
						url : "users/"+4
					}).done(function(data){
						console.log(data);
					});
				});
				
				$('#userDELETE').on('click',function(){
					$.ajax({
						dataType : "json",
						type : "DELETE",
						url : "users/"+8
					}).done(function(data){
						console.log(data);
					});
				});
				
				$('#userUPDATE').on('click',function(){
					var datas = {
							id : $('#id').val(),
							email : $('#email').val(),
							authorization : $('#authorization').val(),
							photo : $('#photo').val()
					};
					
					$.ajax({
						dataType :"json",
						type : "PUT",
						url : "users/"+3,
						data : JSON.stringify(datas),
						headers: { 
					        'Accept': 'application/json',
					        'Content-Type': 'application/json' 
					    },
					}).done(function(data){
						console.log(data);
						id : $('#id').val('');
						email : $('#email').val('');
						authorization : $('#authorization').val('');
						photo : $('#photo').val('');
					});
				});
				
			}
			userData();
		});
	</script>
</body>
</html>
