# Generated by Django 5.0.4 on 2024-05-07 06:07

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('game', '0002_game_finalised'),
    ]

    operations = [
        migrations.RenameField(
            model_name='game',
            old_name='finalised',
            new_name='status',
        ),
    ]