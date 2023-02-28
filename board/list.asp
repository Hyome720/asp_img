<% 
response.codepage = 949
response.charset = "EUC-KR"
%>
<%
' 페이지 지정
' default 페이지를 첫 페이지로 지정
' 넘어오는 페이지가 있다면 그 번호로 세팅
' 이 번호가 Absolutepage로 지정
if request("page") = "" then
    page = 1
else
    page = request("page")
end if

' connection 인스턴스 생성
Set db = Server.CreateObject("ADODB.Connection")
' DB 열기
db.Open("DSN=localsqldb;UID=sa;PWD=1234;")
' 모든 데이터 가져오기
sql = "SELECT * from Board_Re ORDER BY ref DESC, re_step ASC"
' 레코드셋 개체의 인스턴스 생성
Set rs = Server.CreateObject("ADODB.Recordset")
' 페이지 사이즈 지정. 레코드셋 오픈 전에 지정
rs.pageSize = 5
' 지정 쿼리로 DB연결하고 레코드셋에 저장
rs.Open sql, db, 1
%>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/list.css">
    <title>게시판</title>
</head>
<body>
    <div style="text-align: center;">
        <div>
            <form method="post" action="search_result.asp">
                <table>
                    <tr>
                        <td>
                            <span>검색</span>
                        </td>
                        <select name="search">
                            <option value="title">제목</option>
                            <option value="name">글쓴이</option>
                            <option value="board_content">내용</option>
                        </select>
                        <input type="text" name="searchString">
                        <input type="submit" value="검색">
                    </tr>
                </table>
            </form>
        </div>
        <hr>
        <p style="color: #004080">
            <strong>
                <%=session("table")%> List
            </strong>
            &nbsp;
            &nbsp;
            &nbsp;
            <a href="write.asp">
                <img src="https://img.freepik.com/free-vector/illustration-of-document-icon_53876-37007.jpg?w=1380&t=st=1677052922~exp=1677053522~hmac=5f8645b7a869e81c30d37d18ee7ea86d6ac8fbed6e250759cf90abe5ae812e86" width="40px">
                글 작성하기
            </a>
        </p>
    </div>
    <% 
    if rs.BOF or rs.EOF then
    %>
    <p>데이터가 없습니다ㅏㅏㅏㅏㅏㅏㅏ.</p>
    <% else 
        ' 총 페이지수 변수에 할당
        totalPage = rs.pageCount
        rs.absolutePage = page
    %>
        <div style="text-align: center;">
            <table class="list-table">
                <tr>
                    <td class="list-td-04">
                        제목
                    </td>
                    <td class="list-td-02">
                        글쓴이
                    </td>
                    <td class="list-td-02">
                        날짜
                    </td>
                    <td class="list-td-01">
                        조회수
                    </td>
                </tr>
                <% i = 1
                Do Until rs.EOF or i > rs.pageSize %>
                <tr>
                    <td class="list-td-04" style="color: black !important; background-color: #fff !important; text-align: left">
                        <% 
                        if rs("re_level") > 0 then
                        wid = 5 * rs("re_level") & px
                        %>
                        <img src="../img/white.png" width="<%=wid%>" height="14px">
                        <img src="../img/answer.png">
                        <% end if %>
                        <a href="content.asp?idx=<%=rs("board_idx")%>">
                            <%=rs("title")%>
                        </a>
                    </td>
                    <td class="list-td-02" style="color: black !important; background-color: #fff !important;">
                        <a href="mailto:<%=rs("email")%>">
                            <%=rs("name")%>
                        </a>
                    </td>
                    <td class="list-td-02" style="color: black !important; background-color: #fff !important;"><%=rs("writeday")%></td>
                    <td class="list-td-01" style="color: black !important; background-color: #fff !important;"><%=rs("readnum")%></td>
                </tr>
                <%
                ' 다음 레코드로 이동
                rs.MoveNext 
                i = i + 1
                ' 레코드 끝까지 Loop 돌기
                loop 
                %>
                <% end if %>
            </table>
            <hr>
            <% if page <> 1 then %>
            &lt; <a href="list.asp?page=<%=page - 1%>">이전 페이지</a> &gt;
            <% end if %>
            <% if Cint(page) <> Cint(totalPage) then %>
            &lt; <a href="list.asp?page=<%=page + 1%>">다음 페이지</a> &gt;
            <% end if %>
            <br>
            <%=page%> 페이지 / <%=totalPage%> 페이지
        </div>
</body>
</html>

<%
' 사용한 개체들 모두 반납 - 데이터 절약
rs.Close
db.Close
Set rs= Nothing
Set db = Nothing
%>