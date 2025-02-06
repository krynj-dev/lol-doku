gcloud builds submit --config cloudmigrate.yaml

gcloud run deploy lol-doku-backend-service --region australia-southeast1 --image gcr.io/loldoku-be/lol-doku-backend-service
