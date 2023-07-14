from django.contrib import admin
from api.models import Events, FieldName, Members, ContactRegistration, CityName, EventCategory, EventRegistration, EveCat, EventForm, ContForm

# Register your models here.
# admin.site.register(Categories)
# admin.site.register(Contacts)

class EventCategoryAdmin(admin.ModelAdmin):
    list_display = ['event_category']
admin.site.register(EventCategory, EventCategoryAdmin)

class EventsAdmin(admin.ModelAdmin):
    list_display = ['eventname', 'edate', 'etime', 'eaddress']
    list_filter = ['eaddress', 'edate', 'etime']
admin.site.register(Events, EventsAdmin)


class FieldsAdmin(admin.ModelAdmin):
    list_display = ['fname', 'fimage']
admin.site.register(FieldName, FieldsAdmin)


class MembersAdmin(admin.ModelAdmin):
    list_display = ['mname', 'mnumber', 'maddress', 'mfield']
    list_filter = ('maddress','mfield' )
admin.site.register(Members, MembersAdmin)

class ContactRegistrationAdmin(admin.ModelAdmin):
    list_display = ['rname']
admin.site.register(ContactRegistration, ContactRegistrationAdmin)


class CityNameAdmin(admin.ModelAdmin):
    list_display = ['city_name']
admin.site.register(CityName, CityNameAdmin)



class EventRegistrationAdmin(admin.ModelAdmin):
    list_display = ['event_name']
admin.site.register(EventRegistration, EventRegistrationAdmin)


class EveCatRegistrationAdmin(admin.ModelAdmin):
    list_display = ['name']
admin.site.register(EveCat, EveCatRegistrationAdmin)

class EveFormRegistrationAdmin(admin.ModelAdmin):
    list_display = ['event_name']
admin.site.register(EventForm, EveFormRegistrationAdmin)

class ContFormRegistrationAdmin(admin.ModelAdmin):
    list_display = ['name']
admin.site.register(ContForm, ContFormRegistrationAdmin)