<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
if session("id") = "" then
    Response.Redirect("../default.asp")
end if %>

<%
Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=localsqldb;UID=sa;PWD=1234;")

sql = "SELECT * FROM MemberList WHERE mem_idx = '" & session("idx") & "'"

Set rs = db.execute(sql)

name = rs("mem_name")
id = rs("mem_id")
pwd = rs("mem_pwd")
ssn1 = left(rs("mem_ssn"), 6)
ssn2 = right(rs("mem_ssn2"), 7)
sex = rs("mem_sex")
job = rs("mem_job")
email = rs("mem_email")
intro = rs("mem_intro")

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        function sendIt() {
            let str
            str = document.registerForm.mem_name.value
            if (str == "") {
                alert("이름을 입력해주세요")
                document.registerForm.mem_name.focus()
                return true
            }

            str = document.registerForm.mem_id.value
            if (str == "" || str.length < 4) {
                alert("아이디를 입력하지 않으셨거나 4글자 미만입니다.")
                document.registerForm.mem_id.focus()
                return true
            }

            str = document.registerForm.mem_pwd1.value
            if (str == "" || str.length < 6) {
                alert("비밀번호를 입력하지 않으셨거나 6글자 미만입니다.")
                document.registerForm.mem_pwd1.focus()
                return true
            }

            if (document.registerForm.mem_pwd1.value != document.registerForm.mem_pwd2.value) {
                alert("비밀번호가 일치하지 않습니다. 다시 확인해주세요")
                document.registerForm.mem_pwd2.focus()
                return true
            }

            str = document.registerForm.mem_email.value
            if (str == "") {
                alert("메일 주소를 입력해주세요")
                document.registerForm.mem_email.focus()
                return true
            }

            const ssn1 = document.registerForm.mem_ssn1.value
            const ssn2 = document.registerForm.mem_ssn2.value

            if (ssn1.length != 6 || ssn2.length != 7) {
                alert("주민등록번호가 이상해요")
                document.registerForm.ssn1.focus()
                return true
            }

            document.registerForm.submit()
            return true
        }

        function onlyNumber() {
            if(event.keyCode < 48 || event.keyCode > 57) {
                event.returnValue = false
                alert('숫자만 입력가능합니다!')
                document.registerForm.focus.ssn1.focus()
            }
        }
    </script>
    <form name="registerForm" method="post" action="mem_edit_ok.asp">
        <h2>개인정보 수정</h2>
        <table>
            <tr>
                <td>
                    <p>사용자 ID</p>
                </td>
                <td>
                    <input type="text" name="id" value="id" disabled>
                </td>
            </tr>
            <tr>
                <td>
                    <p>이름</p>
                </td>
                <td>
                    <input type="text" name="name" value="name" maxlength="10">
                </td>
            </tr>
            <tr>
                <td>
                    <p>비밀번호</p>
                </td>
                <td>
                    <input type="password" name="pwd1" value="pwd" maxlength="20">
                </td>
            </tr>
            <tr>
                <td>
                    <p>비밀번호 확인</p>
                </td>
                <td>
                    <input type="password" name="pwd2" value="pwd" maxlength="20">
                </td>
            </tr>
            <tr>
                <td>
                    <p>주민등록번호</p>
                </td>
                <td>
                    <input type="text" name="ssn1" value="ssn1" maxlength="6" onKeyPress="onlyNumber()">
                    -
                    <input type="text" name="ssn2" value="ssn2" maxlength="7" onKeyPress="onlyNumber()">
                </td>
            </tr>
            <tr>
                <td>
                    <p>성별</p>
                </td>
                <td>
                    <input type="radio" name="sex" value="male" <% if sex="male" then %>checked<% end if %>>남자
                    <input type="radio" name="sex" value="female" <% if sex="female" then %>checked<% end if %>>여자
                </td>
            </tr>
            <tr>
                <td>
                    <p>직업</p>
                </td>
                <td>
                    <select name="job" size="1">
                        <option value="not" <% if job = "not" then %>selected<% end if %>>무슨 일을 하시나요?</option>
                        <option value="직장인" <% if job = "직장인" then %>selected<% end if %>>직장인</option>
                        <option value="학생" <% if job = "학생" then %>selected<% end if %>>학생</option>
                        <option value="무직" <% if job = "무직" then %>selected<% end if %>>무직</option>
                        <option value="대학원생" <% if job = "대학원생" then %>selected<% end if %>>대학원생</option>
                        <option value="교수" <% if job = "교수" then %>selected<% end if %>>교수</option>
                        <option value="기타" <% if job = "기타" then %>selected<% end if %>>기타</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <p>이메일 주소</p>
                </td>
                <td>
                    <input type="text" size="32" name="email" value="email" maxlength="30">
                </td>
            </tr>
            <tr>
                <td>
                    <p>이름</p>
                </td>
                <td>
                    <textarea name="intro" cols="30" rows="20" wrap="physical" value="intro"></textarea>
                </td>
            </tr>
            <div>
                <input type="button" value="회원 가입" name="B1" onClick="sendIt()">
                <input type="button" value="가입 취소" onClick="history.back()">
            </div>
        </table>
    </form>
</body>
</html>