from django.db import models

# Create your models here.
class DataUpdate(models.Model):
    date = models.DateField(null=False, blank=False)
    app = models.CharField(max_length=32, null=False, blank=False)

