# Generated by Django 4.1.7 on 2023-04-13 11:09

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ("api", "0011_events_eimage"),
    ]

    operations = [
        migrations.RemoveField(
            model_name="events",
            name="eimage",
        ),
    ]
