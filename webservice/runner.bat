for /F "tokens=14" %%i in ('"ipconfig | findstr IPv4"') do flask run --host=%%i --port=80
