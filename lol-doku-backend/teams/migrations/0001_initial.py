# Generated by Django 5.0.4 on 2024-05-01 15:15

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Team',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('becomes', models.CharField(max_length=100)),
                ('came_from', models.CharField(max_length=100)),
                ('highest_level', models.CharField(max_length=30)),
                ('image', models.CharField(max_length=150)),
                ('name', models.CharField(max_length=100)),
                ('op', models.CharField(max_length=100)),
                ('region', models.CharField(max_length=30)),
                ('short', models.CharField(max_length=5)),
            ],
        ),
        migrations.CreateModel(
            name='TeamAlternateName',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('alternate_name', models.CharField(max_length=50)),
                ('team_op', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='alternate_names', to='teams.team')),
            ],
        ),
        migrations.CreateModel(
            name='TeamSisterTeam',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('sister_team_name', models.CharField(max_length=50)),
                ('team_op', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='sister_teams', to='teams.team')),
            ],
        ),
    ]