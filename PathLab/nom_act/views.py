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


#nominee has only one functionality and that is to track a test he/she is registered for
#the function track1 implements this functionality


@never_cache
def load_home3(request):
	if "nomi" in request.session:
		return render(request,'nom_home.html',{'text':request.session["nomi"]})
	else:
		return redirect('/')
@never_cache
def go_home3(request):
	#k = request.session['nomi']
	try:
		del request.session['nomi']
		return redirect('/')
	except:
		return redirect("/nom/")


@never_cache
def menu(request):
	return redirect('/nom/')

@never_cache
def track1(request):
	if "nomi" not in request.session:
		return redirect('/')
	records = []
	try:
		ID = request.session["nomi"] # find deatils of tests with patient id equals nominee id
		cur.execute("select ID,PatientID,AgentID,RegDate,DueDate,Cost,paid,sampling,samp_pack,samp_ship,samp_dest,test_start,test_comp,rep_gen from reg_tests where PatientID=%s and rep_gen='NO'",(ID,));
		records = cur.fetchall()
	except Exception as e:
		db.rollback()
		return render(request,'nom_home.html',{'ERROR':str(e)})
	db.rollback()
	if(len(records)==0):
		return render(request,'nom_track.html',{'ERROR':'NO TESTS TO TRACK'})
	else:
		return render(request,'nom_track.html',{'records':records})
# Create your views here.
