# Generated by Django 4.1.7 on 2023-04-03 08:29

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("api", "0006_alter_categories_catimage"),
    ]

    operations = [
        migrations.AlterField(
            model_name="categories",
            name="catimage",
            field=models.ImageField(blank=True, null=True, upload_to="images/"),
        ),
    ]
