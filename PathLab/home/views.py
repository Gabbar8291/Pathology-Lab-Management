from django.shortcuts import render
from django.shortcuts import redirect

from django.http import HttpResponseRedirect
from django.urls import reverse

from django.views.decorators.cache import never_cache

import MySQLdb as mdb

import hashlib
import datetime

from random import randint

db = mdb.connect('localhost','alluser','alluser','path_lab')
cur = db.cursor()


#this page mainly contains the functions that are being used to implement
# the functionality of the green bar that appears on every page
# each button has its own uniue feature 


@never_cache
def index(request):
	try:
		return render(request,"start.html")
	except:
		return HttpResponse("Page Not Found")

@never_cache
def menuhom(request):
	return redirect('/')

@never_cache
def lab(request):
	try:
		cur.execute('select distinct TestId from lab_test')
		ID = cur.fetchall()
	except Exception as e:
		db.rollback()
		print(str(e))
		return redirect('/')
	db.rollback()
	print('we')
	try:
		return render(request,'lab.html',{'records':ID})
	except:
		return redirect('/')


@never_cache
def tid_sub(request):
	if request.method!="POST":
		redirect('/')
	try:
		ID = request.POST['tid']
	except:
		redirect('/')
	try:
		print(ID)
		cur.execute('select * from lab_test where TestID=%s',(ID,))
		records = cur.fetchall()
	except:
		return redirect('/')
	try:
		return render(request,'showlt.html',{'records':records})
	except:
		return redirect('/')


@never_cache
def cent(request):
	try:
		cur.execute('select City from coll_centre union select City from labs')
		city = cur.fetchall()
	except Exception as e:
		db.rollback()
		print(str(e))
		return redirect('/')
	db.rollback()
	print('we')
	try:
		return render(request,'cent1.html',{'records':city})
	except:
		return redirect('/')
@never_cache
def cent_show(request):
	if request.method!="POST":
		redirect('/')
	try:
		ID = request.POST['city']
		cur.execute('select * from coll_centre where City=%s',(ID,))
		records = cur.fetchall()
	except:
		return redirect('/')	
	try:
		cur.execute('select * from labs where City=%s',(ID,))
		records1 = cur.fetchall()
	except:
		return redirect('/')
	try:
		return render(request,'cent2.html',{'records':records,'records1':records1})
	except:
		return redirect('/')

@never_cache
def tetnam(request):
	try:
		cur.execute('select distinct Type from tests')
		records = cur.fetchall()
	except:
		db.rollback()
		return redirect('/')
	db.rollback()
	try:
		return render(request,'seltype.html',{'records':records})
	except:
		return redirect('/')
@never_cache
def testty(request):
	if request.method!="POST":
		redirect('/')
	try:
		ID = request.POST['tid']
		cur.execute('select * from tests where Type=%s',(ID,))
		records = cur.fetchall()
	except:
		return redirect('/')
	try:
		return render(request,'seltype1.html',{'records':records})
	except:
		return redirect('/')

@never_cache
def aginfo(request):
	try:
		cur.execute('select ID from agent where working="YES" or working="L"')
		ag = cur.fetchall()
	except:
		db.rollback()
		return redirect('/')
	db.rollback()
	try:
		return render(request,'selag.html',{'records':ag})
	except:
		return redirect('/')
@never_cache
def agent_show(request):
	if request.method!="POST":
		redirect('/')
	try:
		ID = request.POST['aid']
		cur.execute('select ID,FName,LName,emailid,phno,City from agent where ID=%s',(ID,))
		records = cur.fetchall()
	except Exception as e:
		print(str(e))
		return redirect('/')
	try:
		return render(request,'showag.html',{'records':records})
	except:
		return redirect('/')



@never_cache
def contact(request):
	try:
		return render(request,'contact_us.html')
	except:
		return redirect('/') 
