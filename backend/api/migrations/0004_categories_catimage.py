# Generated by Django 4.1.7 on 2023-03-29 08:22

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("api", "0003_categories_contacts"),
    ]

    operations = [
        migrations.AddField(
            model_name="categories",
            name="catimage",
            field=models.ImageField(null=True, upload_to=""),
        ),
    ]