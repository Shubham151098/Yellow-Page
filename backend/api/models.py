from django.db import models
from api.validators import validate_file_extension

# Create your models here.

# Model for Events:____________________________________________________________________

class EventCategory(models.Model):
    event_category = models.CharField(max_length=100)

    def __str__(self):
        return self.event_category


class Events(models.Model):
    eventname=models.CharField(max_length=20)
    organiser_name=models.CharField(max_length=100)
    category_type = models.ForeignKey(EventCategory, on_delete=models.CASCADE, related_name='eventCategories')
    event_contact=models.CharField(max_length=10)
    eaddress=models.CharField(max_length=50)
    edate=models.DateField()
    etime=models.TimeField()
    edesc=models.CharField(max_length=200)
    eimage = models.ImageField(upload_to="images/events/")
    booking_link = models.CharField(max_length=200)
    direction = models.CharField(max_length=500)

    def __str__(self):
        return self.eventname
    
    # def __str__(self):
    #     return self.category_type

# Model for Contacts:________________________________________________________________

class FieldName(models.Model):
    fname = models.CharField(max_length=100)
    fimage = models.ImageField(upload_to="images/", blank=True, null=True)

    def __str__(self):
        return self.fname

class Members(models.Model):
    mname = models.CharField(max_length=100)
    mnumber = models.IntegerField()
    maddress = models.CharField(max_length=100, null=True)
    mfield = models.ForeignKey(FieldName, on_delete=models.CASCADE, related_name='members')

    def __str__(self):
        return self.mname
    
# Model for Contact Registration:__________________________________________


class CityName(models.Model):
    city_name = models.CharField(max_length=100)

    def __str__(self):
        return self.city_name



class ContactRegistration(models.Model):
    rname = models.CharField(max_length=100)
    remail = models.EmailField(max_length=100, blank=True, null=True)
    rcontacts = models.CharField(max_length=15, null=True)
    rcontacts_alternate = models.CharField(max_length=10, null=True)
    raddress = models.TextField()
    rcity = models.ForeignKey(CityName, on_delete=models.CASCADE, related_name='cityName')
    business_type = models.ForeignKey(FieldName, on_delete=models.CASCADE, related_name='businessName')
    rimage = models.ImageField(upload_to="images/contactRegistration/", blank=True, null=True)
    rdocument = models.FileField(blank=False, null=True,upload_to="documents/",validators=[validate_file_extension])

    def __str__(self):
        return self.rname
    
    def __str__(self):
        return self.rcity
    
    def __str__(self):
        return self.business_type
    


# Model for Event Registration:__________________________________________




class EventRegistration(models.Model):
    event_name=models.CharField(max_length=20)
    category_type = models.ForeignKey(EventCategory, on_delete=models.CASCADE, related_name='eventCategories_type', null=True)
    event_organiser = models.CharField(max_length=100, null=True)
    event_contact  = models.CharField(max_length=10, null=True)
    event_address=models.CharField(max_length=50)
    edate=models.DateField()
    event_time=models.TimeField()
    event_desc=models.CharField(max_length=200)
    event_image = models.ImageField(upload_to="images/eventsRegistration/", blank=True, null=True)
    booking_link = models.CharField(max_length=200, null=True)
    direction = models.CharField(max_length=500, null=True)

    def __str__(self):
        return self.event_name


# _________________________________________________________


# class EventCategory(models.Model):
#     event_category = models.CharField(max_length=100)

#     def __str__(self):
#         return self.event_category



class EveCat(models.Model):
    name = models.CharField(max_length=255)

    def __str__(self):
        return self.name

class EventForm(models.Model):
    event_name = models.CharField(max_length=255)
    event_organiser = models.CharField(max_length=255)
    event_contact = models.CharField(max_length=255)
    event_address = models.CharField(max_length=255)
    edate = models.DateField()
    event_time = models.TimeField()
    event_desc = models.TextField()
    event_image = models.ImageField(upload_to='events/', null=True, blank=True)
    booking_link = models.CharField(max_length=255)
    direction = models.CharField(max_length=500)
    category_type = models.ForeignKey(EventCategory, on_delete=models.CASCADE)

    def __str__(self):
        return self.event_name
    


# _____________________________________________________


class ContForm(models.Model):
    name = models.CharField(max_length=255)
    email = models.CharField(max_length=255)
    contact = models.CharField(max_length=10)
    alternate_contact = models.CharField(max_length=10)
    address = models.CharField(max_length=200)
    city = models.ForeignKey(CityName, on_delete=models.CASCADE)
    business_type = models.ForeignKey(FieldName, on_delete=models.CASCADE)
    image = models.ImageField(upload_to='events/', null=True, blank=True)
    document = models.FileField(upload_to="documents/", validators=[validate_file_extension])

    def __str__(self):
        return self.name