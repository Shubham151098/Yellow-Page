from django.shortcuts import render, redirect
from api.models import Events, Members, FieldName, ContactRegistration, CityName, EventCategory, EventRegistration, EveCat, EventForm, ContForm
from api.serializers import EventsSerializer,ContactRegistrationSerializer, MembersSerializer, FieldNameSerializer, CityNameSerializer, EventCategorySerializer, EventRegistrationSerializer, EveFormSerializer, ContFormSerializer
from rest_framework import viewsets
from rest_framework.views import APIView
from rest_framework import generics
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.decorators import api_view, parser_classes




# Create your views here.



class EventsViewSet(viewsets.ModelViewSet):
    queryset = Events.objects.all()
    serializer_class = EventsSerializer

class FieldNameViewSet(viewsets.ModelViewSet):
    queryset = FieldName.objects.all()
    serializer_class = FieldNameSerializer 

class MembersViewSet(viewsets.ModelViewSet):
    queryset = Members.objects.all()
    serializer_class = MembersSerializer 


class ContactRegistrationViewSet(viewsets.ModelViewSet):
    queryset = ContactRegistration.objects.all()
    serializer_class = ContactRegistrationSerializer 

class CityNameViewSet(viewsets.ModelViewSet):
    queryset = CityName.objects.all()
    serializer_class = CityNameSerializer


class EventCategoryViewSet(viewsets.ModelViewSet):
    queryset = EventCategory.objects.all()
    serializer_class = EventCategorySerializer




class EventRegistrationViewSet(viewsets.ModelViewSet):
    queryset = EventRegistration.objects.all()
    serializer_class = EventRegistrationSerializer


# ----------------------------------------------------------------

@api_view(['POST','GET'])
def register_event(request):
    if request.method == 'GET':
        events = EventForm.objects.all()
        serializer = EveFormSerializer(events, many=True)
        return Response(serializer.data)

    elif request.method == 'POST':
        serializer = EveFormSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'message': 'Event registration successful.'}, status=201)
        return Response(serializer.errors, status=400)
    
    #  ----------------------------------------------------------------

@api_view(['POST','GET'])
@parser_classes([MultiPartParser, FormParser])
def register_contact(request):
    if request.method == 'GET':
        contacts = ContForm.objects.all()
        serializer = ContFormSerializer(contacts, many=True)
        return Response(serializer.data)

    elif request.method == 'POST':
        serializer = ContFormSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'message': 'Contact registration successful.'}, status=201)
        return Response(serializer.errors, status=400)