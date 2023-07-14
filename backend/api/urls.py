from django.contrib import admin
from django.urls import path, include
from api import views
from rest_framework import routers


router = routers.DefaultRouter(trailing_slash=False)
router.register("eventsdetails",views.EventsViewSet)
router.register("fieldsdetails",views.FieldNameViewSet)
router.register("membersdetails",views.MembersViewSet)
router.register("contactregistrationdetails",views.ContactRegistrationViewSet)
router.register("citynamedetails",views.CityNameViewSet)
router.register("eventcategorydetails",views.EventCategoryViewSet)
router.register("eventregistrationdetails",views.EventRegistrationViewSet)


urlpatterns = [
    path("",include(router.urls)),
    

]


    # path("fieldsdetails/",include(router.urls)),
    # path("membersdetails/",include(router.urls)),
    # path("contactregistrationdetails/",include(router.urls)),
    # path("citynamedetails/",include(router.urls)),
    # path("eventcategorydetails/",include(router.urls)),
    # path("eventregistrationdetails/",include(router.urls)),
# http://127.0.0.1:8000/api/categoriesdetails/categoriesdetails