from meta.models import DataUpdate
from rest_framework import serializers

class DataUpdateSerializer(serializers.ModelSerializer):
    data_update_date = serializers.CharField(source='date')

    class Meta:
        model = DataUpdate
        fields = ['data_update_date']