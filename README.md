### Github repo for tsm terraform

the terraform principal need the following permissions

### Prerequisites
```shell
PROJECT=your-project //update this
PRINCIPAL="your-principal" // update this
gcloud services enable serviceusage.googleapis.com --project $PROJECT
```

### Iam bindings
``` shell
gcloud projects add-iam-policy-binding $PROJECT --role="roles/editor" --member="$PRINCIPAL"
```


``` shell
gcloud projects add-iam-policy-binding $PROJECT --role="roles/storage.admin" --member="$PRINCIPAL"
```

``` shell
gcloud projects add-iam-policy-binding $PROJECT --role="roles/secretmanager.admin" --member="$PRINCIPAL"
```