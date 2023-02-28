<%
Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=localsqldb;UID=sa;PWD=1234;")

sql = "SELECT pwd FROM Board_Re WHERE board_idx = " & Request("idx")
Set rs = db.execute(sql)

if request("pwd") = rs("pwd") then
    sql = "DELETE FROM Board_Re WHERE board_idx = " & request("idx")
    db.execute sql
    response.redirect "list.asp"
else
    response.write("<script>alert('비밀번호가 틀렸는데용');history.back();</script>")
end if
%>

