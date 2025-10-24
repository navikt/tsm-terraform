### Github repo for tsm terraform

the terraform service account need these permissions
```shell
gcloud services enable serviceusage.googleapis.com --project PROJECT
```


``` shell
gcloud projects add-iam-policy-binding PROJECT\
  --member="serviceAccount:SA_ACCOUNT_EMAIL"\
  --role="roles/secretmanager.admin"
```

``` shell
gcloud projects add-iam-policy-binding PROJECT\
  --member="serviceAccount:SA_ACCOUNT_EMAIL"\
  --role="roles/storage.admin"
```

``` shell
gcloud projects add-iam-policy-binding PROJECT \
  --member="serviceAccount:SA_ACCOUNT_EMAIL" \
  --role="roles/monitoring.notificationChannelEditor"
```

``` shell
gcloud projects add-iam-policy-binding PROJECT \
  --member="serviceAccount:SA_ACCOUNT_EMAIL" \
  --role="roles/monitoring.alertPolicyEditor"
```


``` shell
gcloud projects add-iam-policy-binding PROJECT \
  --member="serviceAccount:SA_ACCOUNT_EMAIL" \
  --role="roles/logging.admin"
```
