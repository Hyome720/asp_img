
<%
response.codepage = 949
response.charset = "EUC-KR"
' response.CodePage = 65001
' response.charset = "UTF-8"
' request ��ü�� ���� �Ѿ�� ���� ������ ����
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

' connection �ν��Ͻ� ����
set db = Server.CreateObject("ADODB.Connection")
' DB ����
'db.Open("Provider=SQLOLEDB;Data Source=(local)\SQLEXPRESS;Initial Catalog=MyDB;Integrated Security=true;")
'db.Open("Driver={SQL Server};Server=(LocalDb)\MSSQLLocalDB;Database=MyDB;Integrated Security=true;")
'db.Open("Driver={SQL Server};(LocalDb)\MSSQLLocalDB;Initial Catalog=MyDB;Integrated Security=true")
'db.Open("Driver={SQL Server};Server=localsqldb;Initial Catalog=MyDB;Integrated Security=true")
db.Open("DSN=localsqldb;UID=sa;PWD=1234;")

' ���������� �ϴ� ������ ������
sql = "SELECT MAX(num) FROM  Board_Re"
' ���ڵ�� ��ü�� �ν��Ͻ� ����
set rs = Server.CreateObject("ADODB.Recordset")
' ������ ������ DB�����ؼ� ���ڵ�¿� ������ ����
rs.Open sql, db

if isNull(rs(0)) then
    number = 1
else
    number = rs(0) + 1
end if

' �亯�ϱ� �� ���
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

' db�� insert ������ ���� ������ �߰�
db.execute sql

rs.close
db.close
set rs = nothing
set db = nothing

response.redirect "list.asp"

Response.Write "your name is " & name & "<br>"
Response.Write "���� �ּҴ� " & email & "<br>"
Response.Write "Ȩ������ �ּҴ� " & homepage & "<br>"
Response.Write "�� ������ " & title & "<br>"
Response.Write "�� ������ " & board_content & "<br>"
Response.Write "��й�ȣ�� " & pwd & "<br>" 
%>
<html>
<body>
</body>
</html>