# Generated by Django 5.0.4 on 2024-05-07 05:03

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('game', '0001_initial'),
        ('players', '0005_load_player_data'),
        ('rules', '0009_add_crosses'),
    ]

    operations = [
        migrations.CreateModel(
            name='CorrectPlayerGuess',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('guess_count', models.IntegerField(default=1)),
                ('player', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='correct_guesses_player', to='players.player')),
                ('roster', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='correct_guesses_roster', to='game.gameroster')),
                ('x', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='x_correct_guesses', to='rules.rule')),
                ('y', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='y_correct_guesses', to='rules.rule')),
            ],
            options={
                'unique_together': {('x', 'y', 'player', 'roster')},
            },
        ),
    ]