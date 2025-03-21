### Github repo for tsm terraform

the terraform service account need these permissions

``` shell
gcloud projects add-iam-policy-binding YOUR_PROJECT_ID\
--member="serviceAccount:YOUR_SERVICE_ACCOUNT_EMAIL"\
--role="roles/secretmanager.admin"
```

``` shell
gcloud projects add-iam-policy-binding YOUR_PROJECT_ID\
--member="serviceAccount:YOUR_SERVICE_ACCOUNT_EMAIL"\
--role="roles/storage.admin"
```
