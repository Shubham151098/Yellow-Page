# Generated by Django 4.1.7 on 2023-05-02 07:46

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("api", "0028_alter_events_booking_link_alter_events_category_type_and_more"),
    ]

    operations = [
        migrations.AlterField(
            model_name="contactregistration",
            name="rimage",
            field=models.ImageField(
                blank=True, null=True, upload_to="images/contactRegistration/"
            ),
        ),
    ]