gcloud builds submit --config cloudmigrate.yaml

gcloud run deploy lol-doku-backend-service --region australia-southeast1 --image gcr.io/loldoku-be/lol-doku-backend-service

gcloud run jobs create djangomigrate
   --image gcr.io/loldoku-be/lol-doku-backend-service \
   --command "python3 manage.py migrate" --execute-now

gcloud beta run jobs execute djangomigrate