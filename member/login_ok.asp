<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=localsqldb;UID=sa;PWD=1234;")

Set rs = Server.CreateObject("ADODB.Recordset")
sql = "SELECT mem_idx, mem_id, mem_name, mem_pwd, mem_email FROM MemberList"
sql = sql & " WHERE mem_id = '" & request("mem_id") & "'"

rs.Open sql, db

if (rs.EOF or rs.BOF) then
%>
<script>
    alert("등록되지 않은 아이디 입니다. 아이디를 확인해주세요")
    history.back()
</script>

<% else
    if rs("mem_pwd") <> request("mem_pwd") then
%>
    <script>
        alert("비밀번호가 일치하지 않습니다. 비밀번호를 확인해주세요.")
        history.back()
    </script>

    <% else
        session("idx") = rs("mem_idx")
        session("id") = rs("mem_id")
        session("name") = rs("mem_name")
        session("email") = rs("mem_email")
        Response.Redirect("../default.asp")
    end if
end if %>