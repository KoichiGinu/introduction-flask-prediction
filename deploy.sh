# variables
PROJECT_ID=help-me-abe-san
SERVICE=intro-prediction

# set GCP project
gcloud config set project help-me-abe-san

# container registry
docker build -t asia.gcr.io/$PROJECT_ID/$SERVICE .
docker push asia.gcr.io/$PROJECT_ID/$SERVICE:latest
gcloud builds submit --tag asia.gcr.io/$PROJECT_ID/$SERVICE:latest .

# cloudrun
gcloud run deploy $SERVICE --image asia.gcr.io/$PROJECT_ID/$SERVICE:latest --platform managed --region asia-northeast1
