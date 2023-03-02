<%
path = "C:\inetpub\wwwroot\asp_img\img\"

Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=localsqldb;UID=sa;PWD=1234;")

sql = "SELECT pwd, file_name FROM Board_Img WHERE board_idx = " & Request("idx")
Set rs = db.execute(sql)

filespec = path & rs("file_name")

if request("pwd") = rs("pwd") then
    sql = "DELETE FROM Board_Img WHERE board_idx = " & request("idx")
    db.execute sql

    Set fso = Server.CreateObject("Scripting.FileSystemObject")

    if rs("file_name") = "" or isNull(rs("file_name")) then
    
    else
        fso.DeleteFile(filespec)
    end if
    response.redirect "list.asp"
else
    response.write("<script>alert('비밀번호가 틀렸는데용');history.back();</script>")
end if
%>

