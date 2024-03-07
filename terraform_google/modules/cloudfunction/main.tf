# Define the Cloud Function
resource "google_cloudfunctions_function" "ghack_" {
  name        = "my-function"
  description = "My Cloud Function"
  runtime     = "nodejs14"

  entry_point = "myFunction"
  source_archive_bucket = "your-source-bucket"
  source_archive_object = "path/to/function.zip"

  # Define the HTTP trigger
  trigger_http = true

  # Prevent the function from being deleted
  lifecycle {
    prevent_destroy = true
  }

  # Define the environment variables
  environment_variables = {
    SERVICE_ACCOUNT_REGEX = "A"  # Add your regex pattern here
  }
}
