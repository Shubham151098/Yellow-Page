from rest_framework import serializers
from api.models import Events, Members, FieldName, ContactRegistration, CityName, EventCategory, EventRegistration, EventForm, EveCat, ContForm



# Contact Registration section_______________________________________________________

# class CityNameSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = CityName
#         fields = '__all__'


# class ContactRegistrationSerializer(serializers.ModelSerializer):
#     city = CityNameSerializer(read_only=True, many=True)
#     rimage_url = serializers.SerializerMethodField('get_rimage_url')
#     def get_rimage_url(self, obj):
#         request = self.context.get('request')
#         rimage_url = obj.rimage.url
#         return request.build_absolute_uri(rimage_url)
#     class Meta:
#         model = ContactRegistration
#         fields = '__all__'

class CityNameSerializer(serializers.ModelSerializer):
    class Meta:
        model = CityName
        fields = ('id', 'city_name')

class ContactRegistrationSerializer(serializers.ModelSerializer):
    rcity = CityNameSerializer()

    class Meta:
        model = ContactRegistration
        fields = ('id', 'rname', 'remail', 'rcontacts', 'rcontacts_alternate',
                  'raddress', 'rcity', 'business_type', 'rimage', 'rdocument')





# Event Section Serializer____________________________________________________

class EventCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = EventCategory
        fields = ['event_category']

class EventsSerializer(serializers.ModelSerializer):
    category_type = EventCategorySerializer()
    eimage_url = serializers.SerializerMethodField('get_eimage_url')
    def get_eimage_url(self, obj):
        request = self.context.get('request')
        eimage_url = obj.eimage.url
        return request.build_absolute_uri(eimage_url)

    class Meta:
        model = Events
        fields=['eventname','category_type','organiser_name','event_contact','eaddress','edate','etime','edesc', 'eimage','eimage_url', 'booking_link','direction']


# Contact Section Serializer________________________________________________

class MembersSerializer(serializers.ModelSerializer): #Course
    class Meta:
        model = Members
        fields = '__all__'

class FieldNameSerializer(serializers.ModelSerializer):
    members = MembersSerializer(read_only=True, many=True) #Instructor
    def get_fimage_url(self, obj):
        request = self.context.get('request')
        fimage_url = obj.fimage.url
        return request.build_absolute_uri(fimage_url)
    class Meta:
        model = FieldName
        fields = '__all__'


# Event Registration Serializer________________________________________________



class EventRegistrationSerializer(serializers.ModelSerializer):
    event_image_url = serializers.SerializerMethodField('get_event_image_url')
    def get_event_image_url(self, obj):
        request = self.context.get('request')
        event_image_url = obj.event_image.url
        return request.build_absolute_uri(event_image_url)

    class Meta:
        model = EventRegistration
        fields='__all__'


# ----------------------------------------------------------------


class EveFormSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventForm
        fields = '__all__'

class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = EveCat
        fields = '__all__'

# ----------------------------------------------------------------

class ContFormSerializer(serializers.ModelSerializer):
    class Meta:
        model = ContForm
        fields = '__all__'