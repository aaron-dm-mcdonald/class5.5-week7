resource "google_storage_bucket" "sample" {
 name          = "superduperuniquenname"
 location      = "us"
 storage_class = "nearline"
 labels = {
   "env" = "tf_env"
   "dept" = "compliance"
 }
 uniform_bucket_level_access = true

 lifecycle_rule {
   condition { 
     age = 10
   }
   action {
     type = "SetStorageClass"
     storage_class = "coldline"
   }
 }
  retention_policy {
    is_locked = true
    retention_period = 777600
  }
}

resource "google_storage_bucket_object" "horse-y" {
  bucket = google_storage_bucket.sample.name
  name = "brown-horse"
  source = "horse.jpeg"
}


