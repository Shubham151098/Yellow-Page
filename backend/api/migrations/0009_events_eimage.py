# Generated by Django 4.1.7 on 2023-04-13 11:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("api", "0008_fieldname_members"),
    ]

    operations = [
        migrations.AddField(
            model_name="events",
            name="eimage",
            field=models.ImageField(blank=True, null=True, upload_to="images/"),
        ),
    ]
