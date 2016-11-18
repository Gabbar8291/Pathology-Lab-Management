from django.conf.urls import include, url

from . import views

urlpatterns = [
	url(r'^$',views.load_home3,name='load_home3'),
	url(r'^menu/$',views.menu,name='menu'),
	url(r'^track1/$',views.track1,name='track1'),
	url(r'^sign_out/$',views.go_home3,name='go_home3')
]