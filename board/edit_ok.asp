
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
board_idx = request("board_idx")

title = replace(title, "'", "'")
title = replace(title, "&", "&amp;")
title = replace(title, "<", "&lt;")
title = replace(title, ">", "&gt;")

board_content = replace(board_content, "'", "'")
board_content = replace(board_content, "&", "&amp;")
board_content = replace(board_content, "<", "&lt;")
board_content = replace(board_content, ">", "&gt;")

' connection 인스턴스 생성
Set db = Server.CreateObject("ADODB.Connection")
' DB 열기
db.Open("DSN=localsqldb;UID=sa;PWD=1234;")

' 현재 글의 비밀번호 가져오기 비밀번호를 체크
sql = "SELECT pwd FROM Board_Re WHERE board_idx = " & board_idx
Set rs = db.execute(sql)

' 비밀번호 비교
If Request("pwd") = rs("pwd") Then
    sql = "UPDATE Board_Re SET name = '" & name & "'"
    sql = sql & ", title = '" & title & "'"
    sql = sql & ", email = '" & email & "'"
    sql = sql & ", board_content = '" & board_content & "'"
    sql = sql & ", homepage = '" & homepage & "'"
    sql = sql & "WHERE board_idx = " & board_idx

    ' 데이터를 업데이트하고 리스트로 리다이렉트
    db.execute(sql)
    Response.Redirect("content.asp?idx=" & board_idx)
    
    else
    Response.Write("<script>alert('비밀번호가 틀렸습니다');history.back();</script>")
    End If
%>
<html>
<body>
</body>
</html>