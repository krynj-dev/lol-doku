# Generated by Django 5.0.4 on 2024-05-01 15:48

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('teams', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='team',
            name='becomes',
            field=models.CharField(blank=True, max_length=100),
        ),
        migrations.AlterField(
            model_name='team',
            name='came_from',
            field=models.CharField(blank=True, max_length=100),
        ),
        migrations.AlterField(
            model_name='team',
            name='image',
            field=models.CharField(blank=True, max_length=150),
        ),
    ]