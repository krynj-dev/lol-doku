# Generated by Django 5.0.4 on 2024-05-11 06:27

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('puzzles', '0001_initial'),
        ('rules', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='puzzlerule',
            name='rule',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='assoc_puzzles', to='rules.rule'),
        ),
    ]
