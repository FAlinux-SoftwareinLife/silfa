<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>
<html>
<head>
	<title>test</title>
	<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
</head>
<body>
		
	<button id="userPOST">userPost</button>
	<button id="userGET">userGET</button>
	<button id="userDELETE">userDELETE</button>
	<button id="userUPDATE">userUPDATE</button>

<br>
<br>

	<button id="filePOST">filePOST</button>
	<button id="fileGET">fileGET</button>
	<button id="fileDELETE">fileDELETE</button>
	<button id="fileUPDATE">fileUPDATE</button>
	
	
	<div id="userSection"></div>
	
	<script type="text/javascript">
		$(function(){
			var userData = function(){
				$('#userPOST').on('click',function(){
					var datas = {
						userId : 'test03',
						email :  'test01',
						authorize :  'test01',
						photo :  'test01',
						language :  'test01',
						gender :  'test01'
					};
					
					$.ajax({
						dataTyep : "json",
						type : "POST",
						url : "users",
						data : datas
					}).done(function(data){
						console.log(data);
					});
				});
				
				$('#userGET').on('click',function(){
					$.ajax({
						dataType : "json",
						type : "GET",
						url : "users/"+'aaa'
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
							userId : 'aaa',
							email :  'aaa',
							authorize :  'aaa',
							photo :  'aaa',
							language :  'aaa',
							gender :  'aaa'
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
					});
				});
			
				$('#filePOST').on('click',function(){
					var datas = {
						userId : 'test03',
						fileId : 'test02',
						fileName : 'test01',
						modifiedDate :'test01',
						thumbnail : 'test01',
						fileType : 'test01'
						
					};
					
					$.ajax({
						dataTyep : "json",
						type : "POST",
						url : "files",
						data : datas
					}).done(function(data){
						console.log(data);
					});
				});
				
				$('#fileGET').on('click',function(){
					$.ajax({
						dataType : "json",
						type : "GET",
						url : "files/"+'test01',
					}).done(function(data){
						console.log(data);
					});
				});
				
				$('#fileDELETE').on('click',function(){
					$.ajax({
						dataType : "json",
						type : "DELETE",
						url : "files/"+'test02'
					}).done(function(data){
						console.log(data);
					});
				});
				
				$('#fileUPDATE').on('click',function(){
					var datas = {
							fileId : 'test02',
							fileName : 'updateTest01',
							modifiedDate :'updateTest01',
							thumbnail : 'updateTest01',
							fileType : 'updateTest01'
						};
					
					$.ajax({
						dataType :"json",
						type : "PUT",
						url : "files/"+'test02',
						data : JSON.stringify(datas),
						headers: { 
					        'Accept': 'application/json',
					        'Content-Type': 'application/json' 
					    },
					}).done(function(data){
						console.log(data);
					});
				});
			}
			userData();
		});
	</script>
</body>
</html>