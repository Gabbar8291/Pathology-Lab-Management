from django.shortcuts import render
from django.shortcuts import redirect

from django.http import HttpResponseRedirect
from django.urls import reverse

from django.views.decorators.cache import never_cache

import MySQLdb as mdb

import hashlib
import datetime
import dateutil.parser

from random import randint

db = mdb.connect('localhost','alluser','alluser','path_lab')
cur = db.cursor()

@never_cache
def load_home(request): #load dashboard for the user
	if "user" in request.session:
		return render(request,'user_home.html',{'text':request.session["user"]})
	else:
		return redirect('/')
@never_cache
def go_home(request): #goto home of the user
	#k = request.session['user']
	try:
		del request.session['user']
		return redirect('/')
	except:
		return redirect("/user/")
@never_cache
def book(request): #book a test form rendering
	if "user" not in request.session:
		return redirect('/')
	patients = []
	lt = []
	city = []
	try:
		ID = request.session["user"]
		cur.execute("select ID from nominee where UserID=%s union select ID from user where ID=%s",(ID,ID));
		patients = cur.fetchall()
	except:
		db.rollback()
		return render(request,'user_home.html',{'ERROR':'UNEXPECTED ERROR'})
	db.rollback()
	try:
		cur.execute("select ID from lab_test"); #select a lab and test ID
		lt = cur.fetchall()
	except:
		db.rollback()
		return render(request,'user_home.html',{'ERROR':'UNEXPECTED ERROR'})
	db.rollback()
	try:
		cur.execute("select distinct city from coll_centre"); #select city for collection
		city = cur.fetchall()
	except:
		db.rollback()
		return render(request,'user_home.html',{'ERROR':'UNEXPECTED ERROR'})
	db.rollback()

	mini = datetime.datetime.now()
	max_date = (mini + datetime.timedelta(days=7)).strftime("%Y-%m-%d") #get max time for which leave can be applied
	min_date = mini.strftime("%Y-%m-%d")

	try:
		print("hello")
		return render(request,'book_test.html',{'lts':lt,'pat':patients,'city':city,'min':min_date,'max':max_date})
	except:
		print("yo")
		return redirect('/user/')

@never_cache
def book_submit(request): # submit form entries for validation and and then insert into database
	if request.method!="POST":
		print('suarez')
		return redirect('/user/')
	if "user" not in request.session:
		return redirect('/')
	try:
		ltid = request.POST['lt']
		print(ltid)
		pat = request.POST['pati']
		print(pat)
		samp = request.POST['samp']
		print(samp)
		city = request.POST['ct']
		print(city)
		ndate = request.POST['ndate']
	except:
		print('messi')
		return redirect('/user/')
	uid = request.session['user']
	if samp=='home':
		home = "YES"
		venue = "NO"
	else:
		home = "NO"
		venue = "YES"
	rand_day = randint(1,5)
	print(ndate)
	nk = ndate + " 03:30:30"
	print(nk)
	nstamp = dateutil.parser.parse(nk)
	aux_date = nstamp + datetime.timedelta(days=rand_day)
	cdate = datetime.datetime.now()
	mdate = cdate + datetime.timedelta(days=7)
	val_date = mdate.strftime("%Y-%m-%d")
	curr_date = cdate.strftime("%Y-%m-%d")
	due_date = aux_date.strftime("%Y-%m-%d")
	reg_date = nstamp.strftime("%Y-%m-%d")
	if reg_date < curr_date or reg_date > val_date: #check date validations for booking test
		return render(request,'user_home.html',{'ERROR':'REG. DATE MUST BE WITHIN 7 DAYS FROM NOW'})
	try:
		cur.execute("select cost from lab_test where ID=%s",(ltid,))
	except Exception as e:
		db.rollback()
		return render(request,'user_home.html',{'ERROR':str(e)})
	db.rollback()
	cost = cur.fetchall()[0][0]
	int(cost)
	if home == "YES":
		cost = cost + 100
	try:
		cur.execute("select ID from agent where city=%s and working='YES'",(city,))
	except:
		db.rollback()
		return render(request,'user_home.html',{'MSG':"UNEXPECTED ERROR2"})
	db.rollback()
	agents = cur.fetchall()
	noa = len(agents)
	if noa==0:
		return render(request,'user_home.html',{'ERROR':'AGENT NOT AVAILABLE'})
	ind = randint(0,noa-1)
	ag = agents[ind][0]
	try:
		cur.execute('insert into reg_tests values(0,%s,%s,%s,%s,%s,%s,%s,%s,%s,0,"NO","NO","NO","NO","NO","NO","NO","NO")',
			(ltid,uid,pat,home,venue,ag,reg_date,due_date,cost,))
	except Exception as e:
		db.rollback()
		return render(request,'user_home.html',{'ERROR':str(e)})
	db.commit()
	try:
		return render(request,'user_home.html',{'ERROR':'REGISTRATION SUCCESSFUL'})
	except Exception as e:
		return render(request,'user_home.html',{'ERROR':str(e)})

@never_cache
def menu(request):
	return redirect('/user/')

@never_cache
def prev(request): #view previous tests
	if "user" not in request.session:
		return redirect('/')
	records = []
	try:
		ID = request.session["user"]
		cur.execute("select ID,PatientID,AgentID,RegDate,DueDate,Cost from reg_tests where UserID=%s and rep_gen='YES'",(ID,));
		records = cur.fetchall()
	except Exception as e:
		db.rollback()
		return render(request,'user_home.html',{'ERROR':str(e)})
	db.rollback()
	if(len(records)==0):
		return render(request,'prev.html',{'ERROR':'NO HISTORY FOUND'})
	else:
		return render(request,'prev.html',{'records':records})


@never_cache
def track(request): # track tests
	if "user" not in request.session:
		return redirect('/')
	records = []
	try:
		ID = request.session["user"]
		cur.execute("select ID,PatientID,AgentID,RegDate,DueDate,Cost,paid,sampling,samp_pack,samp_ship,samp_dest,test_start,test_comp,rep_gen from reg_tests where UserID=%s and rep_gen='NO'order by RegDate DESC",(ID,));
		records = cur.fetchall()
	except Exception as e:
		db.rollback()
		return render(request,'user_home.html',{'ERROR':str(e)})
	db.rollback()
	if(len(records)==0):
		return render(request,'track.html',{'ERROR':'NO TESTS TO TRACK'})
	else:
		return render(request,'track.html',{'records':records})


@never_cache
def update(request): # update profile
	if "user" not in request.session:
		return redirect('/')
	try:
		ID = request.session["user"]
		cur.execute("select * from user where ID=%s",(ID,))
		l = cur.fetchall()
	except:
		db.rollback()
		return redirect('/user/')
	db.rollback()
	d = {}
	d['ID'] = l[0][0]
	d['fname'] = l[0][1]
	d['lname'] = l[0][2]
	d['dob'] = l[0][3]
	d['age'] = l[0][4]
	d['hno'] = l[0][6]
	d['street'] = l[0][7]
	d['local'] = l[0][8]
	d['adline'] = l[0][9]
	d['lamark'] = l[0][10]
	d['city'] = l[0][11]
	d['state'] = l[0][12]
	d['pin'] = l[0][13]
	d['phno'] = l[0][14]
	d['eid'] = l[0][15]
	try:
		return render(request,'update_form.html',d)
	except Exception as e:
		return redirect('/user/')

@never_cache
def update_check(request): # update profile validations
	if request.method!="POST":
		return redirect('/user/');
	if "user" not in request.session:
		return redirect('/')
	try:
		login = request.POST['id']
		fname = request.POST['fname']
		dob = request.POST['dob']
		hno = request.POST['hno']
		street = request.POST['street']
		local = request.POST['local']
		city = request.POST['city']
		state = request.POST['state']
		phno = request.POST['phno']
		eid = request.POST['eid']
	except:
		return render(request,'user_home.html',{'ERROR':'FEILDS MARKED RED ARE NECESSARY'})
	lname = request.POST['lname']
	age = request.POST['age']
	lmark = request.POST['lmark']
	addline = request.POST['addline']
	pincode = request.POST['pin']
	if len(pincode)!=0 and len(pincode)!=6:
		return render(request,'user_home.html',{'ERROR':'INVALID PINCODE'})
	try:
		if(len(pincode)==6):
			pincode = int(pincode)
		if len(age)>0:
			age = int(age)
	except Exception as e:
		return render(request,'user_home.html',{'ERROR':str(e)})
	try:
		cur.execute("update user set Hno=%s,street=%s,locality=%s,city=%s,state=%s,phno=%s,age=%s,landmark=%s,AddLine=%s,pincode=%s where ID=%s",
		(hno,street,local,city,state,phno,age,lmark,addline,pincode,login))
	except Exception as e:
		db.rollback()
		return render(request,'user_home.html',{'ERROR':str(e)})
	db.commit()
	try:
		return render(request,'user_home.html',{'ERROR':"PROFILE UPDATED"})
	except:
		return redirect('/user/')


@never_cache
def reg_nomi(request): #render nominee registration form
	if "user" in request.session:
		return render(request,'reg_nomi.html')
	else:
		return redirect('/')

@never_cache
def rn_check(request): #register nominee
	if request.method!="POST":
		return redirect('/user/')
	if "user" not in request.session:
		return redirect('/')
	try:
		login = request.POST['id']
		fname = request.POST['fname']
		dob = request.POST['dob']
		hno = request.POST['hno']
		gender = request.POST['gender']
		street = request.POST['street']
		local = request.POST['local']
		city = request.POST['city']
		state = request.POST['state']
		phno = request.POST['phno']
		eid = request.POST['eid']
		passwd = request.POST['passwd']
		repwd = request.POST['repwd']
	except:
		return render(request,'reg_nomi.html',{'ERROR':'FEILDS MARKED RED ARE NECESSARY'})
	lname = request.POST['lname']
	age = request.POST['age']
	lmark = request.POST['lmark']
	addline = request.POST['addline']
	pincode = request.POST['pin']
	if len(login.split(' '))>1:
		return render(request,'reg_nomi.html',{'ERROR':'SPACE NOT ALLOWED IN USER ID'})
	if repwd!=passwd:
		return render(request,'reg_nomi.html',{'ERROR':'PASSWORDS DO NOT MATCH'})
	if len(passwd)<8 or len(passwd)>20:
		return render(request,'reg_nomi.html',{'ERROR':'PASSWORD LENGTH MUST BE >=8 and <=20'})
	if len(pincode)!=0 and len(pincode)!=6:
		return render(request,'reg_nomi.html',{'ERROR':'INVALID PINCODE'})
	try:
		int(pincode)
		int(age)
	except Exception as e:
		return render(request,'reg_nomi.html',{'ERROR':str(e)})
	hashfunc = hashlib.md5()
	hashfunc.update(passwd.encode('utf-8'))
	passwd = hashfunc.hexdigest()
	gender.lower()
	try:
		uid = request.session["user"]
		cur.execute('insert into nominee values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)',(login,uid,fname,lname,dob,age,gender,hno,
			street,local,addline,lmark,city,state,pincode,phno,eid,passwd))
	except Exception as e:
		db.rollback()
		return render(request,'reg_nomi.html',{'ERROR':str(e)})
	db.commit()
	try:
		return render(request,'user_home.html',{'ERROR':'NOMINEE REGISTERED !!!'})
	except Exception as e:
		return redirect('/')

@never_cache
def look(request): # look at registerd nominees
	if "user" not in request.session:
		return redirect('/')
	records = []
	try:
		ID = request.session["user"]
		cur.execute("select ID,FName,LName,DOB,emailid,phno from nominee where UserID=%s",(ID,));
		records = cur.fetchall()
	except Exception as e:
		db.rollback()
		return render(request,'user_home.html',{'ERROR':str(e)})
	db.rollback()
	if(len(records)==0):
		return render(request,'display_nom.html',{'ERROR':'NO NOMINEES REGISTERED'})
	else:
		return render(request,'display_nom.html',{'records':records})





# Create your views here.
