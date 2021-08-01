from flask import Flask,request,url_for,jsonify,send_from_directory
import hashlib
import os
from werkzeug.utils import secure_filename
from datetime import date
import pymysql.cursors
conn=cursor=None
UPLOAD_FOLDER = 'profile_pict'
uploadpath=os.path.join(os.getcwd(),UPLOAD_FOLDER)

app = Flask(__name__)
app.config['UPLOAD_EXTENSIONS'] = ['.jpg', '.png','jpeg']
app.config['UPLOAD_FOLDER']  = uploadpath
def openDb():
    global conn,cursor
    conn=pymysql.connect(host="localhost",user="root",password="",database="gohealth")
    cursor=conn.cursor(pymysql.cursors.DictCursor)
def closeDb():
    cursor.close()
    conn.close()
app=Flask(__name__)
@app.route('/')
def index():
    openDb()
    closeDb()
    return "hola"
@app.route('/exercises')
def execises():
    listworkout=[]
    sql="Select * from exercise"
    openDb()
    cursor.execute(sql)
    result=cursor.fetchall()
    for item in result:
        listworkout.append(item)
    closeDb()
    return jsonify(listworkout)
@app.route('/auth/login', methods=['POST'])
def login():
   map=request.form
   password=hashlib.sha1(map['password'].encode()).hexdigest()
   sql="select count(*) as result,email,id as uid from useraccount where email=%s AND password=%s"
   val=(map['email'],password)
   openDb()
   cursor.execute(sql,val)
   result = cursor.fetchone()
   result['message']="Login Success" if result['result']==1 else "login not success"
   if(result['result']==1):
       result['data']={
           "email":result['email'],
           "uid":result['uid'],
       }
   closeDb()
   return result

@app.route('/auth/register', methods=['POST'])
def register():
   map=request.form
   sql="select count(*) as result from useraccount where email=%s"
   val=(map['email'])
   openDb()
   cursor.execute(sql,val)
   result=cursor.fetchone()
   if (result['result']>0):
       closeDb()
       result['message']="email has been used"
       result['result']=0
       return jsonify(result)
   else:
       password=hashlib.sha1(map['password'].encode()).hexdigest()
       sql="INSERT INTO `useraccount`"
       sql+="(`email`, `password`, `name`, `gender`, `DOB`, `height`, `weight`)"
       sql+=" VALUES (%s,%s,%s,%s,%s,%s,%s)"
       val=(map['email'],password,map['name'],map['gender'],map['DOB'],map['height'],map['weight'])
       cursor.execute(sql,val)
       conn.commit()
       sql="select count(*) as result,email,id as uid from useraccount where email=%s AND password=%s"
       val=(map['email'],password)
       cursor.execute(sql,val)
       result = cursor.fetchone()
       if(result['result']==1):
            result['data']={
                "email":result['email'],
                "uid":result['uid'],
            }
       closeDb()
       result['result']=1
       result['message']="register success"
       return jsonify(result)

@app.route('/profile/<id>/photo/update', methods=['POST'])
def updatepp(id):  
    if 'file' in request.files:
        uploaded_file = request.files['file']
        if uploaded_file.filename=='':
            return jsonify({'message':"no photo attached",'result':False}) 
        else: 
            openDb()
            sql="SELECT profilepict FROM `useraccount` WHERE id=%s"
            cursor.execute(sql,id)
            filename=(cursor.fetchone())['profilepict']
            if filename!='':
                os.remove(os.path.join(uploadpath,filename))
            filename=secure_filename(uploaded_file.filename)
            uploaded_file.save(os.path.join(uploadpath, filename))
            sql="UPDATE `useraccount` SET profilepict=%s WHERE id=%s"
            cursor.execute(sql,(filename,id))
            conn.commit()
            closeDb()
            return jsonify({
                'message':"profile photo has changed",
                'data':filename,
                'result':True
            })
    else:
        return jsonify({'message':"no photo attached",'result':False}) 
@app.route('/profile/<id>/detail')
def getProfile(id):
   sql="SELECT email,id,name,gender,DOB,height,weight,profilepict FROM `useraccount` WHERE id=%s"
   openDb()
   cursor.execute(sql,(id))
   data=cursor.fetchone()
   closeDb()
   return jsonify(data)
@app.route('/profile/<id>/update', methods=['POST'])
def updateProfile(id):
   map=request.form
   password=hashlib.sha1(map['password'].encode()).hexdigest()
   sql="UPDATE `useraccount` SET email=%s,password=%s,name=%s WHERE id=%s"
   val=(map['email'],password,map['name'],id)
   openDb()
   cursor.execute(sql,val)
   conn.commit()
   closeDb()
   return {
       'message':"profile has updated",
       'result':True
   }
@app.route('/bmi/<id>/history')
def history(id):
    history=[]
    sql="Select * from historybmi where id=%s"
    openDb()
    cursor.execute(sql,(id))
    result=cursor.fetchall()
    for item in result:
        history.append(item)
    return jsonify(history)

@app.route('/bmi/<id>/update', methods=['POST'])
def bmi(id):
        height=float(request.form['height'])/100
        weight=float(request.form['weight'])
        bmi=weight/(height*height)
        result="obese"
        if ( bmi < 18.5):
            result="underweight"
        elif(bmi<25) :
                result="normal"
        elif( bmi<30) :
                result="overweight"
        openDb()
        sql="INSERT INTO `historybmi`(`id`, `bmi`, `date`) VALUES (%s,%s,%s)"
        val=(id,bmi,str(date.today()))
        cursor.execute(sql,val)
        conn.commit()
        sql="UPDATE `useraccount` SET `height`=%s,`weight`=%s WHERE id=%s"
        val=(request.form['height'],request.form['weight'],id)
        cursor.execute(sql,val)
        conn.commit()
        data={
            'bmi':bmi,
            'result':result
        }
        closeDb()
        return jsonify(data)
@app.route('/profile/photo/<filename>')
def geturlfile(filename):
    return send_from_directory(UPLOAD_FOLDER, filename)
if __name__=="__main__":
    app.run(host="192.168.43.150", port=80,debug=True,)