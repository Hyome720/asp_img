파일을 업로드 하는 과정에서 write.asp 파일의 폼의 속성 중
ENCTYPE을 평소에는 명시하지 않고 default 값으로 이용하는데
파일을 업로드 하기 위해서는 ENCTYPE="multipart/form-data"를
이용해야 했다. 그 과정에서 에러는 발생하지 않으나 input="text"
안의 값이 제대로 전송되지 않는 것을 발견했고,
Set uploadform = Server.CreateObject("DEXT.FileUpload")로 정의한 뒤
uploadform("원하는 column")의 형식으로 입력해주어야 한다는 것을 알았다.
