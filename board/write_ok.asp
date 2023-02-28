
<%
response.codepage = 949
response.charset = "EUC-KR"
' response.CodePage = 65001
' response.charset = "UTF-8"
' request 개체를 통해 넘어온 값을 변수에 저장
name = request("name")
email = request("email")
homepage = request("homepage")
title = request("title")
pwd = request("pwd")
board_content = request("board_content")

title = replace(title, "'", "'")
title = replace(title, "&", "&amp;")
title = replace(title, "<", "&lt;")
title = replace(title, ">", "&gt;")

board_content = replace(board_content, "'", "'")
board_content = replace(board_content, "&", "&amp;")
board_content = replace(board_content, "<", "&lt;")
board_content = replace(board_content, ">", "&gt;")

' connection 인스턴스 생성
set db = Server.CreateObject("ADODB.Connection")
' DB 열기
'db.Open("Provider=SQLOLEDB;Data Source=(local)\SQLEXPRESS;Initial Catalog=MyDB;Integrated Security=true;")
'db.Open("Driver={SQL Server};Server=(LocalDb)\MSSQLLocalDB;Database=MyDB;Integrated Security=true;")
'db.Open("Driver={SQL Server};(LocalDb)\MSSQLLocalDB;Initial Catalog=MyDB;Integrated Security=true")
'db.Open("Driver={SQL Server};Server=localsqldb;Initial Catalog=MyDB;Integrated Security=true")
db.Open("DSN=localsqldb;UID=sa;PWD=1234;")

' 가져오려고 하는 데이터 쿼리문
sql = "SELECT MAX(num) FROM  Board_Re"
' 레코드셋 개체의 인스턴스 생성
set rs = Server.CreateObject("ADODB.Recordset")
' 지정한 쿼리로 DB연결해서 레코드셋에 데이터 저장
rs.Open sql, db

if isNull(rs(0)) then
    number = 1
else
    number = rs(0) + 1
end if

' 답변하기 일 경우
if request("board_idx") <> "" then

    ref = Cint(request("ref"))
    re_step = Cint(request("re_step"))
    re_level = Cint(request("re_level"))

    sqlString = "UPDATE Board_Re SET re_step = re_step + 1"
    sqlString = sqlString & " WHERE ref = " & ref & " AND re_step > " & re_step
    db.execute(sqlString)

    re_step = re_step + 1
    re_level = re_level + 1

else

    ref = number
    re_step = 0
    re_level = 0

end if

sql = "INSERT INTO Board_Re (name, email, homepage, title, board_content, num,"
sql = sql & "readnum, writeday, ref, re_step, re_level, pwd) VALUES "
sql = sql & "('" & name & "'"
sql = sql & ",'" & email & "'"
sql = sql & ",'" & homepage & "'"
sql = sql & ",'" & title & "'"
sql = sql & ",'" & board_content & "'"
sql = sql & "," & number
sql = sql & ",0,'" & date() & "'"
sql = sql & "," & ref
sql = sql & "," & re_step
sql = sql & "," & re_level
sql = sql & ",'" & pwd & "')"

' db에 insert 쿼리를 보내 데이터 추가
db.execute sql

rs.close
db.close
set rs = nothing
set db = nothing

response.redirect "list.asp"

Response.Write "your name is " & name & "<br>"
Response.Write "메일 주소는 " & email & "<br>"
Response.Write "홈페이지 주소는 " & homepage & "<br>"
Response.Write "글 제목은 " & title & "<br>"
Response.Write "글 내용은 " & board_content & "<br>"
Response.Write "비밀번호는 " & pwd & "<br>" 
%>
<html>
<body>
</body>
</html>