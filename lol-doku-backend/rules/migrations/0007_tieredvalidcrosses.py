# Generated by Django 5.0.4 on 2024-05-03 03:53

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('rules', '0006_alter_rule_valid_players'),
    ]

    operations = [
        migrations.CreateModel(
            name='TieredValidCrosses',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('primary', models.ManyToManyField(related_name='primary_valid_crosses', to='rules.rule')),
                ('rule', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='parent_rule', to='rules.rule')),
                ('secondary', models.ManyToManyField(related_name='secondary_valid_crosses', to='rules.rule')),
            ],
        ),
    ]