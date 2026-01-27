# This file is used to deploy the stanpumpR Shiny app to shinyapps.io
# The app is packaged as an R package with the Shiny app code in the R/ directory
# and can be launched by calling the exported run_app() function

# Load the package
library(stanpumpR)

# Launch the app with production config
# For local development, you can create a config.yml file
config_file <- if (file.exists("config.yml")) "config.yml" else "config_production.yml"
run_app(config_file = config_file)
