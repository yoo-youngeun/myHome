<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajax</title>
</head>
<body>
	<h2>Ajax</h2>
	<button onclick="sendRequest()">요청 보내기</button>
	<p id="text"></p>
	<script>
		function sendRequest() {
			const xhr = new XMLHttpRequest();
			xhr.open('GET', '1_ajax_ok.jsp?userid=apple&userpw=1111', true);
			xhr.send();
			
			//XMLHttpRequest.DONE : 4(완료), xhr.status : 200(정상접근)
			xhr.onreadystatechange = funtion() {//콜백함수 .객체생성, open send 응답오면 호출 
				if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
					document.getElementById('text').innerHTML = xhr.responseText;//서버에서 전달된 메시지 받아서 #text에 찍어주기
				} 
			}
		}
	</script>
	
</body>
</html>