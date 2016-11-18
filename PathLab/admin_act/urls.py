from django.conf.urls import include, url

from . import views

urlpatterns = [
	url(r'^$',views.load_home1,name='load_home1'),
	url(r'^sign_out/$',views.go_home1,name='go_home1'),
	url(r'^reg/$',views.reg,name='reg'),
	url(r'^menu/$',views.menu,name='menu_admin'),
	url(r'^ag_regcheck/$',views.regcheck,name='regcheck'),
	url(r'^update/$',views.up_ag,name='up_ag'),
	url(r'^updet/$',views.updet,name='updet'),
	url(r'^update_ch/$',views.updatech,name='updatech'),
	url(r'^agv/$',views.agv,name='agv'),
	url(r'^agshow/$',views.agshow,name='agshow'),
	url(r'^rmag/$',views.rmag,name='rmag'),
	url(r'^removeagent/$',views.rmagent,name='rmagent'),
	url(r'^sanction/$',views.sanction,name='sanction'),
	url(r'^approve/$',views.approve,name='recall'),
	url(r'^viewleaves/$',views.vileaves,name='vileaves')
]