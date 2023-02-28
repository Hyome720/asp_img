<%
Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=localsqldb;UID=sa;PWD=1234;")

sql = "DELETE FROM MemberList"
sql = sql & " WHERE mem_idx = '" & session("idx") & "'"

db.execute(sql)

Response.Redirect("goodbye.asp")
%>
