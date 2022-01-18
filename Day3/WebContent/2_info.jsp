<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.db.Dbconn" %>
<%
   if(session.getAttribute("userid")== null){
%>
      <script>
      alert('로그인 후 이용하세요');
      location.href='./2_login_t.jsp'
      </script>
<%
   }else{
    String userid="";
    String name="";
    String idx="";
    String hp="";
    String email="";
    String hobby="";
    String[] hobbyArr=null;
    String ssn1="";
    String ssn2="";
    String zipcode="";
    String address1="";
    String address2="";
    String address3="";
    if(session.getAttribute("userid")!= null){
       userid=(String)session.getAttribute("userid");
       name=(String)session.getAttribute("name");
       idx=(String)session.getAttribute("idx");
       }
    
// DB연결
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs= null;

String sql = "";

try{
   conn = Dbconn.getConnection();
   if(conn != null){
      sql ="select mem_hp, mem_email, mem_hobby, mem_ssn1, mem_ssn2, mem_zipcode, mem_address1, mem_address2, mem_address3 from tb_member where mem_userid=?";
      pstmt= conn.prepareStatement(sql);
      pstmt.setString(1, userid);
      rs= pstmt.executeQuery();
      
      if(rs.next()){
         hp=rs.getString("mem_hp");
         email=rs.getString("mem_email");
         ssn1=rs.getString("mem_ssn1");
         ssn2=rs.getString("mem_ssn2");
         hobby=rs.getString("mem_hobby");
         hobbyArr= hobby.split(" ");
         zipcode=rs.getString("mem_zipcode");
         address1=rs.getString("mem_address1");
         address2=rs.getString("mem_address2");
         address3=rs.getString("mem_address3");
         
      }
      
   }
}catch(Exception e){
   e.printStackTrace();
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>정보수정</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    
    <script src="./js/info.js"></script>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
</head>
<body>
    <h2>정보수정</h2>
    <form action="./2_info_ok.jsp" method="post" name="regform" id="regform"
        onsubmit="return sendit()">
        <p>아이디 : <%=userid %></p>
        <p>비밀번호 : <input type="password" name="userpw" id="userpw" maxlength="20"></p>
        <p>비밀번호 확인 : <input type="password" name="userpw_re" id="userpw_re" maxlength="20"></p>
        <p>이름 : <input type="text" name="name" id="name" value=<%=name%>></p>
        <p>휴대폰 번호 : <input type="text" name="hp" id="hp" value=<%=hp%>></p>
        <p>이메일 : <input type="text" name="email" id="email" value=<%=email%>></p>
        <p>취미 : <label>드라이브<input type="checkbox" name="hobby" value="드라이브"
        <%
           for(int i=0; i<hobbyArr.length; i++){
              if(hobbyArr[i].equals("드라이브")){
                 out.print("checked");
              }
           }
        %>
        
        ></label>
            <label>영화감상<input type="checkbox" name="hobby" value="영화감상"
                    <%
           for(int i=0; i<hobbyArr.length; i++){
              if(hobbyArr[i].equals("영화감상")){
                 out.print("checked");
              }
           }
              %>
        
            ></label>
            <label>쇼핑<input type="checkbox" name="hobby" value="쇼핑"
                    <%
           for(int i=0; i<hobbyArr.length; i++){
              if(hobbyArr[i].equals("쇼핑")){
                 out.print("checked");
              }
           }
              %>
        
            ></label>
            <label>게임<input type="checkbox" name="hobby" value="게임"
                    <%
           for(int i=0; i<hobbyArr.length; i++){
              if(hobbyArr[i].equals("게임")){
                 out.print("checked");
              }
           }
           %>
        ></label>
            <label>운동<input type="checkbox" name="hobby" value="운동"
                    <%
           for(int i=0; i<hobbyArr.length; i++){
              if(hobbyArr[i].equals("운동")){
                 out.print("checked");
              }
           }
        %>
        ></label>
        </p>
        <p>주민등록번호 : <%=ssn1%> - <%=ssn2%>
             </p>
        <p>우편번호 : <input type="text" name="zipcode" id="sample6_postcode" value=<%=zipcode%>>
            <input type="button" value="우편번호 검색" onclick="sample6_execDaumPostcode()"></p>
        <p>주소 : <input type="text" name="address1" id="sample6_address" value=<%=address1%>></p>
        <p>상세주소 : <input type="text" name="address2" id="sample6_detailAddress" value=<%=address2%>></p>
        <p>참고항목 : <input type="text" name="address3" id="sample6_extraAddress" value=<%=address3%>></p>
        <p><input type="submit" value="수정완료"> <input type="reset" value="다시작성"> <input type="button" value="뒤로" onclick="history.back()"></p>
        
    </form>
</body>
</html>
<%
   }
%>