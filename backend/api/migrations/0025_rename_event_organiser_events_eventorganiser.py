# Generated by Django 4.1.7 on 2023-04-26 12:21

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ("api", "0024_alter_events_event_contact_eventregistration"),
    ]

    operations = [
        migrations.RenameField(
            model_name="events",
            old_name="event_organiser",
            new_name="eventOrganiser",
        ),
    ]
