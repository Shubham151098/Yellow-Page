# Generated by Django 4.1.7 on 2023-06-22 05:07

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0030_remove_eventregistration_event_image'),
    ]

    operations = [
        migrations.AddField(
            model_name='eventregistration',
            name='event_image',
            field=models.ImageField(blank=True, null=True, upload_to='images/eventsRegistration/'),
        ),
    ]
