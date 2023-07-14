# Generated by Django 4.1.7 on 2023-04-24 07:18

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("api", "0015_members_maddress"),
    ]

    operations = [
        migrations.CreateModel(
            name="Registration",
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
                ("rname", models.CharField(max_length=20)),
                ("raddress", models.CharField(max_length=100)),
                ("rcontact", models.CharField(max_length=100)),
                ("rwork", models.CharField(max_length=100)),
            ],
        ),
    ]
