

```buildoutcfg

# Build and push image to Google Container Register
gcloud builds submit --config cloudbuild.yaml .

# Build and push image to Google Container Register
# Start image with argument (test image)
gcloud builds submit --config cloudbuild_test.yaml .

```