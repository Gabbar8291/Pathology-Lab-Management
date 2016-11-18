from django.shortcuts import render  #use of library functions
from django.shortcuts import redirect

from django.http import HttpResponseRedirect
from django.urls import reverse

from django.views.decorators.cache import never_cache

import MySQLdb as mdb

import hashlib #to store password in hashed manner
import datetime

from random import randint

db = mdb.connect('localhost','alluser','alluser','path_lab') # connector to MySQL
cur = db.cursor()

@never_cache
def load_home1(request): #loads the dashboard for admin
	if "admin" in request.session:
		return render(request,'admin_home.html',{'text':request.session["admin"]})
	else:
		return redirect('/')

@never_cache
def go_home1(request): #redirects admin to dashboard from any page
	#k = request.session['admin']
	try:
		del request.session['admin']
		return redirect('/')
	except:
		return redirect("/admin_act/")

@never_cache
def menu(request):
	return redirect('/admin_act/')

@never_cache
def reg(request): #open html page to register an agent
	if "admin" in request.session:
		return render(request,'reg_agent.html')
	else:
		return redirect('/')

@never_cache
def regcheck(request): # checks the authenticity of values entered and registers the agent
	if request.method!="POST":
		print('login')
		return redirect('/admin_act/')
	if "admin" not in request.session:
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
		return render(request,'reg_agent.html',{'ERROR':'FEILDS MARKED RED ARE NECESSARY'})
	lname = request.POST['lname']
	age = request.POST['age']
	lmark = request.POST['lmark']
	addline = request.POST['addline']
	pincode = request.POST['pin']
	if len(login.split(' '))>1: # conditions on various fields
		return render(request,'reg_agent.html',{'ERROR':'SPACE NOT ALLOWED IN USER ID'})
	if repwd!=passwd:
		return render(request,'reg_agent.html',{'ERROR':'PASSWORDS DO NOT MATCH'})
	if len(passwd)<8 or len(passwd)>20:
		return render(request,'reg_agent.html',{'ERROR':'PASSWORD LENGTH MUST BE >=8 and <=20'})
	if len(pincode)!=0 and len(pincode)!=6:
		return render(request,'reg_agent.html',{'ERROR':'INVALID PINCODE'})
	try:
		int(pincode)
		int(age)
	except Exception as e:
		return render(request,'reg_agent.html',{'ERROR':str(e)})
	hashfunc = hashlib.md5()
	hashfunc.update(passwd.encode('utf-8'))
	passwd = hashfunc.hexdigest()
	gender.lower()
	try:
		cur.execute('insert into agent values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,"YES")',(login,fname,lname,dob,age,gender,hno,
			street,local,addline,lmark,city,state,pincode,phno,eid,passwd))
	except Exception as e:
		db.rollback()
		return render(request,'reg_agent.html',{'ERROR':str(e)}) #try excep blocks to catch every possible error
	db.commit()
	try:
		return render(request,'admin_home.html',{'ERROR':'AGENT REGISTERED !!!'})
	except Exception as e:
		return redirect('/')

@never_cache
def up_ag(request): 
	if "admin" not in request.session: #rebders page for updating profile
		return redirect('/')
	try:
		cur.execute("select ID from agent where working='YES' or working='L'")
		agent = cur.fetchall()
	except Exception as e:
		db.rollback()
		return render(request,'admin_home',{'ERROR':str(e)})
	db.rollback()
	try:
		return render(request,'sel_ag.html',{'records':agent})
	except:
		return redirect('/admin_act/')

@never_cache
def updet(request): # update the profile of an agent 
	if "admin" not in request.session: #checks for authentic users
		return redirect('/')
	try:
		ID = request.POST["agen"]
		cur.execute("select * from agent where ID=%s",(ID,))
		l = cur.fetchall()
	except:
		db.rollback()
		return redirect('/admin_act/')
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
		return render(request,'update_agent.html',d)
	except Exception as e:
		return redirect('/admin_act/')

@never_cache
def updatech(request): #appends the updated profile after checking authenticity
	if request.method!="POST":
		return redirect('/admin_act/');
	if "admin" not in request.session:
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
		return render(request,'admin_home.html',{'ERROR':'FEILDS MARKED RED ARE NECESSARY'})
	lname = request.POST['lname']
	age = request.POST['age']
	lmark = request.POST['lmark']
	addline = request.POST['addline']
	pincode = request.POST['pin']
	if len(pincode)!=0 and len(pincode)!=6:
		return render(request,'admin_home.html',{'ERROR':'INVALID PINCODE'})
	try:
		if(len(pincode)==6):
			pincode = int(pincode)
		if len(age)>0:
			age = int(age)
	except Exception as e:
		return render(request,'admin_home.html',{'ERROR':str(e)})
	try:
		cur.execute("update agent set Hno=%s,street=%s,locality=%s,city=%s,state=%s,phno=%s,age=%s,landmark=%s,AddLine=%s,pincode=%s where ID=%s",
		(hno,street,local,city,state,phno,age,lmark,addline,pincode,login))
	except Exception as e:
		db.rollback()
		return render(request,'admin_home.html',{'ERROR':str(e)})
	db.commit()
	try:
		return render(request,'admin_home.html',{'ERROR':"PROFILE UPDATED"})
	except:
		return redirect('/admin_act/')

@never_cache
def agv(request): # view agent work details rendering part
	if "admin" not in request.session: 
		return redirect('/')
	try:
		cur.execute("select ID from agent")
		agent = cur.fetchall()
	except Exception as e:
		db.rollback()
		return render(request,'admin_home',{'ERROR':str(e)})
	db.rollback()
	try:
		return render(request,'get_ag1.html',{'records':agent})
	except:
		return redirect('/admin_act/')

@never_cache
def agshow(request): #actual part to view agent work details
	if request.method!="POST":
		return redirect('/admin_act/')
	if "admin" not in request.session:
		return redirect('/')
	try:
		ID = request.POST['agen']
	except Exception as e:
		return render(request,'admin_home',{'ERROR':str(e)})
	try:
		cur.execute("select count(*) from reg_tests where AgentID=%s",(ID,))
		count = cur.fetchall()[0][0]
	except:
		db.rollback()
		return render(request,'admin_home.html',{'ERROR':'UNEXPECTED ERROR'})
	db.rollback()
	try:
		cur.execute("select AgentID,ID,PatientID,LTID,RegDate,DueDate,rep_gen from reg_tests where AgentID=%s order by DueDate DESC",(ID,))
		records = cur.fetchall()
	except:
		db.rollback()
		return render(request,'admin_home.html',{'ERROR':'UNEXPECTED ERROR'})
	db.rollback()
	if count==0:
		return render(request,'admin_home.html',{'ERROR':'NO DATA FOUND'})
	else:
		try:
			return render(request,'showper.html',{'ERROR':'NUMBER OF RECORDS = '+str(count),'records':records})
		except:
			return redirect('/admin_act/')

@never_cache
def rmag(request): # remove an agent that no longer works for the firm
	if "admin" not in request.session:
		return redirect('/')
	try:
		cur.execute("select ID from agent where working='YES' or working='L'")
		agent = cur.fetchall()
	except Exception as e:
		db.rollback()
		return render(request,'admin_home',{'ERROR':str(e)})
	db.rollback()
	try:
		return render(request,'seldel.html',{'records':agent})
	except:
		return redirect('/admin_act/')

@never_cache
def rmagent(request):
	if request.method!="POST":
		return redirect('/admin_act/')
	if "admin" not in request.session:
		return redirect('/')
	try:
		ID = request.POST['agen']
		pws = request.POST['pass']
		ID1 = request.session["admin"]
	except:
		return render(request,'admin_home',{'ERROR':'ALL FIELDS REQUIRED'})
	hashfunc = hashlib.md5()
	hashfunc.update(pws.encode('utf-8'))
	pswd = hashfunc.hexdigest()
	try:
		cur.execute("select count(*) from admin where ID=%s and password=%s",(ID1,pswd))
		count = cur.fetchall()[0][0]
	except:
		db.rollback()
		return render(request,'admin_home.html',{'ERROR':'UNEXPECTED ERROR'})
	db.rollback()
	if count == 0:
		try:
			return render(request,'admin_home.html',{'ERROR':'AUTHENTICATION FAILED'})
		except:
			return redirect('/admin_act/')
	try:
		cur.execute("select count(*) from reg_tests where AgentID=%s and rep_gen='NO'",(ID,))
		count = cur.fetchall()[0][0]
	except:
		db.rollback()
		return render(request,'admin_home.html',{'ERROR':'UNEXPECTED ERROR'})
	db.rollback()
	if count == 0:
		try:
			cur.execute("update agent set working='NO' where ID=%s",(ID,))
		except:
			db.rollback()
			return render(request,'admin_home.html',{'ERROR':'UNEXPECTED ERROR'})
		db.commit()
	try:
		return render(request,'admin_home.html',{'ERROR':'AGENT DELETED'})
	except:
		return redirect('/admin_act/')



@never_cache
def sanction(request):
	if "admin" not in request.session:
		return redirect('/')
	try:
		cur.execute('select a.ID from app_leaves a, agent b where a.ID=b.ID and b.working="YES"')
		ag = cur.fetchall()
	except Exception as e:
		print(str(e))
		db.rollback()
		return redirect('/admin_act/')
	db.rollback()
	try:
		return render(request,'sanction.html',{'records':ag})
	except Exception as e:
		print(str(e))
		return redirect('/admin_act/')

@never_cache
def approve(request):
	if "admin" not in request.session:
		return redirect('/')
	try:
		ID = request.POST['aid']
		cur.execute('update agent set working="L" where ID=%s',(ID,))
		cur.execute('insert into sanc values(%s)',(ID,))
	except:
		db.rollback()
		return redirect('/admin_act/')
	db.commit()
	try:
		return render(request,'admin_home.html',{'ERROR':'LEAVE SANCTIONED'})
	except:
		return redirect('/admin_act/')

@never_cache
def vileaves(request):
	if "admin" not in request.session:
		return redirect('/admin_act/')
	try:
		cur.execute('select * from app_leaves')
		records = cur.fetchall()
	except Exception as e:
		print(str(e))
		db.rollback()
		return redirect('/admin_act/')
	db.rollback()
	try:
		return render(request,'recall.html',{'records':records})
	except Exception as e:
		print(str(e))
		return redirect('/admin_act/')

