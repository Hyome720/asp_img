<%
name = request("name")
pwd = request("pwd1")
ssn = request("ssn1") & "-" & request("ssn2")
sex = request("sex")
job = request("job")
email = request("email")

intro = request("intro")
intro = replace(intro, "'", "''")

Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=locasqldb;UID=sa;PWD=1234;")

sql = "UPDATE MemberList SET mem_name = '" & name & "'"
sql = sql & ", mem_pwd = '" & pwd & "'"
sql = sql & ", mem_ssn = '" & ssn & "'"
sql = sql & ", mem_sex = '" & sex & "'"
sql = sql & ", mem_job = '" & job & "'"
sql = sql & ", mem_email = '" & email & "'"
sql = sql & " WHERE mem_idx = '" & session("idx") & "'"

db.execute(sql)
%>
<script>
alert("정보 수정이 완료되었습니다.")
location.href="../default.asp"
</script>