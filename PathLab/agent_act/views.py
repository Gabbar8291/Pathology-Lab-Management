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
def load_home2(request): #loads agent dashboard
	if "agent" in request.session:
		return render(request,'agent_home.html',{'text':request.session["agent"]})
	else:
		return redirect('/')

@never_cache
def go_home2(request): #go to home
	#k = request.session['agent']
	try:
		del request.session['agent']
		return redirect('/')
	except:
		return redirect("/agent/")

@never_cache
def menu(request):
	return redirect('/agent/')

@never_cache
def view_t(request): # view the tests that have been assigned to that user
	if "agent" not in request.session:
		return redirect('/')
	records = []
	try:
		ID = request.session["agent"]
		cur.execute("select ID,LTID,PatientID,RegDate,DueDate,homesmap,venuesamp from reg_tests where AgentID=%s and rep_gen='NO' order by RegDate DESC",(ID,));
		records = cur.fetchall()
	except Exception as e:
		db.rollback()
		return render(request,'agent_home.html',{'ERROR':str(e)})
	db.rollback()
	if(len(records)==0):
		return render(request,'view_tests.html',{'ERROR':'NO TESTS AVAILABLE'})
	else:
		return render(request,'view_tests.html',{'records':records})

@never_cache
def track_t(request): # tracking of tests
	if "agent" not in request.session:
		return redirect('/')
	records = []
	try:
		ID = request.session["agent"]
		cur.execute("select ID,PatientID,AgentID,RegDate,DueDate,Cost,paid,sampling,samp_pack,samp_ship,samp_dest,test_start,test_comp,rep_gen from reg_tests where AgentID=%s and rep_gen='NO'",(ID,));
		records = cur.fetchall()
	except Exception as e:
		db.rollback()
		return render(request,'agent_home.html',{'ERROR':str(e)})
	db.rollback()
	if(len(records)==0):
		return render(request,'agent_track.html',{'ERROR':'NO TESTS TO TRACK'})
	else:
		return render(request,'agent_track.html',{'records':records})

@never_cache
def sel_test(request): # select test for updation of tracking and payment details
	if "agent" not in request.session:
		return redirect('/')
	testid = []
	try:
		ID = request.session["agent"]
		cur.execute("select ID from reg_tests where AgentID=%s and rep_gen='NO'",(ID,));
		testid = cur.fetchall()
	except:
		db.rollback()
		print('xavi')
		return render(request,'agent_home.html',{'ERROR':'UNEXPECTED ERROR'})
	db.rollback()
	if len(testid)==0:
		try:
			return render(request,'agent_home.html',{'ERROR':'NO TESTS TO UPDATE'})
		except:
			print('neymar')
			return redirect('/agent/')
	else:
		try:
			return render(request,'update_test.html',{'records':testid})
		except:
			print('iniesta')
			return redirect('/agent/')

@never_cache
def update_d(request): # select update details for the test
	if request.method!="POST":
		return redirect('/agent/')
	if "agent" not in request.session:
		return redirect('/')
	try:
		ID = request.POST['pat']
		sampling = request.POST['sampling']
		packed = request.POST['pack']
		shipped = request.POST['ship']
		dest = request.POST['dest']
		teststr = request.POST['teststr']
		testcomp = request.POST['testcomp']
		repgen = request.POST['repgen']
		paid = request.POST['paid']
	except Exception as e:
		return render(request,'agent_home.html',{'ERROR':str(e)})
	try:
		int(paid)
	except Exception as e:
		return render(request,'agent_home.html',{'ERROR':str(e)})
	try:
		cur.execute("update reg_tests set sampling=%s,samp_pack=%s,samp_ship=%s,samp_dest=%s,test_start=%s,test_comp=%s,rep_gen=%s,paid=%s where ID=%s",
			(sampling,packed,shipped,dest,teststr,testcomp,repgen,paid,ID))
	except Exception as e:
		db.rollback()
		return render(request,'agent_home.html',{'ERROR':str(e)})
	try:
		cur.execute("update reg_tests set pay_comp='YES' where paid=cost")
	except Exception as e:
		db.rollback()
		return render(request,'agent_home.html',{'ERROR':str(e)})
	db.commit()
	try:
		return render(request,'agent_home.html',{'ERROR':'RECORDS UPDATED !!!!'})
	except Exception as e:
		return redirect('/agent/')

@never_cache
def patient(request): # select patient and then view its details
	if "agent" not in request.session:
		return redirect('/')
	pat = []
	try:
		ID = request.session["agent"]
		cur.execute("select distinct PatientID from reg_tests where AgentID=%s and rep_gen='NO'",(ID,));
		pat = cur.fetchall()
	except:
		db.rollback()
		print('xavi')
		return render(request,'agent_home.html',{'ERROR':'UNEXPECTED ERROR'})
	db.rollback()
	if len(pat)==0:
		try:
			return render(request,'agent_home.html',{'ERROR':'NO PATIENT DETAILS'})
		except:
			print('neymar')
			return redirect('/agent/')
	else:
		try:
			return render(request,'pats.html',{'records':pat})
		except:
			print('iniesta')
			return redirect('/agent/')

@never_cache
def display(request): #display the details of the selected patient
	if request.method!="POST":
		print('bale')
		return redirect('/agent/')
	if "agent" not in request.session:
		return redirect('/')
	try:
		ID = request.POST['pat']
	except Exception as e:
		return render(request,'agent_home.html',{'ERROR':str(e)})
	try:
		cur.execute("select Fname,Lname,emailid,phno,Hno,Street,Locality,City,State from user where ID=%s",(ID,))
		user = cur.fetchall()
	except Exception as e:
		db.rollback()
		return render(request,'agent_home.html',{'ERROR':str(e)})
	db.rollback()
	try:
		cur.execute("select Fname,Lname,emailid,phno,Hno,Street,Locality,City,State from nominee where ID=%s",(ID,))
		nomin = cur.fetchall()
	except Exception as e:
		db.rollback()
		return render(request,'agent_home.html',{'ERROR':str(e)})
	db.rollback()
	if len(user)==0 and len(nomin)==0:
		try:
			return render(request,'agent_home.html',{'ERROR':'PATIENT DETAILS NOT FOUND'})
		except:
			print('morata')
			return redirect('/agent/')
	if len(user)!=0:
		try:
			return render(request,'dis_det.html',{'records':user})
		except:
			print('ronaldo')
			return redirect('/agent/')
	if len(nomin)!=0:
		try:
			return render(request,'dis_det.html',{'records':nomin})
		except:
			print('BBC')
			return redirect('/agent/')
	print('MSN')
	return redirect('/agent/')

@never_cache
def leave(request): # render page for leave request
	if "agent" not in request.session:
		return redirect('/')
	try:
		return render(request,'leave.html')
	except:
		return redirect('/')


@never_cache
def validate(request):#validate the leave request and then apply for leave
	if request.method!="POST":
		return redirect('/agent/')
	if "agent" not in request.session:
		return redirect('/')
	try:
		stdate = request.POST['start']
		endate = request.POST['end']
	except:
		try:
			return render(request,'agent_home.html',{'ERROR':'BOTH DATES REQUIRED'})
		except:
			return redirect('/agent/')
	try:
		stdate = stdate + " 03:30:30"
		endate = endate + " 03:30:30"
		cdate = datetime.datetime.now()
		curr_date = cdate.strftime("%Y-%m-%d")
		mmdate = cdate + datetime.timedelta(days=15)
		sstamp = dateutil.parser.parse(stdate)
		estamp = dateutil.parser.parse(endate)
		start = sstamp.strftime("%Y-%m-%d")
		end = estamp.strftime("%Y-%m-%d")
		maxd = mmdate.strftime("%Y-%m-%d")
	except:
		return render(request,'agent_home.html',{'ERROR':'WRONG DATES'})
	if start<curr_date or end<curr_date or start>maxd or end>maxd or end<start: #validation includes meeting specific criteria on start and end date
		try:
			return render(request,'agent_home.html',{'ERROR':'WRONG DATES'})
		except:
			return redirect('/agent/')
	try:
		ID = request.session["agent"]
	except:
		return redirect('/agent/')
	try:
		str(end)
		str(start)
		cur.execute("insert into app_leaves values(%s,%s,%s)",(ID,start,end))
	except:
		db.rollback()
		return render(request,'agent_home.html',{'ERROR':'ONLY ONE LEAVE ALLOWED AT A TIME'})
	db.commit()
	try:
		return render(request,'agent_home.html',{'ERROR':'LEAVE REGISTERED'})
	except:
		return redirect('/agent/')





