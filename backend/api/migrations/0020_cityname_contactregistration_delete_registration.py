# Generated by Django 4.1.7 on 2023-04-26 08:26

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("api", "0019_remove_contacts_ccategory_delete_categories_and_more"),
    ]

    operations = [
        migrations.CreateModel(
            name="CityName",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("city_name", models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name="ContactRegistration",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("rname", models.CharField(max_length=100)),
                ("remail", models.EmailField(blank=True, max_length=100, null=True)),
                ("rcontacts", models.CharField(max_length=15, null=True)),
                ("rcontacts_alternate", models.CharField(max_length=10, null=True)),
                ("raddress", models.TextField()),
                (
                    "rimage",
                    models.ImageField(blank=True, null=True, upload_to="images/"),
                ),
                (
                    "business_type",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="businessName",
                        to="api.fieldname",
                    ),
                ),
                (
                    "rcity",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="cityName",
                        to="api.cityname",
                    ),
                ),
            ],
        ),
        migrations.DeleteModel(
            name="Registration",
        ),
    ]
