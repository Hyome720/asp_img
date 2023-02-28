<%
Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=localsqldb;UID=sa;PWD=1234;")

sql = "SELECT mem_id FROM MemberList WHERE mem_id = '" & request("mem_id") & "'"

Set rs = db.execute(sql)

if not rs.EOF then
    Response.Write("<script>alert('이미 존재하는 아이디입니다.');history.back();</script>")

else
    mem_name = Request("mem_name")
    mem_id = Request("mem_id")
    mem_pwd = Request("mem_pwd1")
    mem_ssn = Request("mem_ssn1") & "-" & Request("mem_ssn2")
    mem_sex = Request("mem_sex")
    mem_job = Request("mem_job")
    mem_email = Request("mem_email")
    mem_intro = Request("mem_intro")
    mem_intro = replace(mem_intro, "'", "''")

    sql = "INSERT INTO MemberList (mem_name, mem_id, mem_pwd, mem_ssn, mem_sex," 
    sql = sql & "mem_job, mem_email, mem_intro) VALUES"
    sql = sql & "('" & mem_name & "','"
    sql = sql & mem_id & "','"
    sql = sql & mem_pwd & "','"
    sql = sql & mem_ssn & "','"
    sql = sql & mem_sex & "','"
    sql = sql & mem_job & "','"
    sql = sql & mem_email & "','"
    sql = sql & mem_intro & "')"
    
    db.execute(sql)
%>
    <script>
        alert('회원가입을 축하드립니다. 로그인해주세요')
        location.href='login.asp?NewMember=<%=mem_id%>'
    </script>
<% end if %>
