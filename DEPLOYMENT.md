# Deploying stanpumpR to shinyapps.io

This guide explains how to deploy the stanpumpR Shiny app to shinyapps.io.

## Quick Start

For those familiar with R and shinyapps.io deployment:

```r
# 1. Set up your shinyapps.io credentials (one-time setup)
library(rsconnect)
rsconnect::setAccountInfo(name='<ACCOUNT>', token='<TOKEN>', secret='<SECRET>')

# 2. Install dependencies and the package
devtools::install_deps(dependencies = TRUE)
devtools::install()

# 3. Deploy from the repository root (where app.R is)
rsconnect::deployApp(
  appName = "stanpumpR",
  appTitle = "stanpumpR - PK/PD Simulation",
  forceUpdate = TRUE
)
```

## Prerequisites

1. An account on [shinyapps.io](https://www.shinyapps.io/)
2. R installed locally (version 4.1 or higher)
3. The `rsconnect` package installed: `install.packages("rsconnect")`
4. The repository cloned locally

## Setup

The repository is configured for deployment with:
- `app.R` - Entry point that loads the package and calls `run_app()`
- `config_production.yml` - Configuration file with production-safe defaults (no secrets)

For local development, you can create a `config.yml` file (which is git-ignored) with your custom settings. The `app.R` will use `config.yml` if it exists, otherwise it falls back to `config_production.yml`.

## Deployment Steps

### 1. Configure rsconnect with your shinyapps.io account

Run this once to set up your credentials:

```r
library(rsconnect)
rsconnect::setAccountInfo(
  name='<ACCOUNT>',
  token='<TOKEN>',
  secret='<SECRET>'
)
```

You can find your token and secret at: https://www.shinyapps.io/admin/#/tokens

### 2. Install package dependencies

From the repository root directory:

```r
# Install devtools if needed
install.packages("devtools")

# Install all package dependencies
devtools::install_deps(dependencies = TRUE)
```

### 3. Build and install the package locally

This is important - shinyapps.io needs to be able to install the package:

```r
# Build and install the package
devtools::install()
```

### 4. Deploy to shinyapps.io

From the repository root directory (where `app.R` is located):

```r
library(rsconnect)

# Deploy the app
rsconnect::deployApp(
  appName = "stanpumpR",  # You can change this name
  appTitle = "stanpumpR - PK/PD Simulation",
  forceUpdate = TRUE
)
```

### 5. Configure environment (Optional)

If you need to modify the configuration after deployment:

1. Edit the `config_production.yml` file in the repository (for production defaults)
2. Or create/edit a `config.yml` file for local testing (this file is git-ignored)
3. Redeploy using the command in step 4

Note: The `config_production.yml` file contains safe defaults without any secrets. If you need to add email functionality or other features requiring credentials, you should configure these through environment variables or shinyapps.io application settings rather than committing secrets to the repository.

## Alternative: Using RStudio

If you're using RStudio:

1. Open the repository in RStudio
2. Make sure the package is built and installed (`devtools::install()`)
3. Open `app.R`
4. Click the "Publish" button in the top-right corner of the editor
5. Select "Publish Application" and follow the wizard

## Troubleshooting

### Package not found error
If you get an error that the `stanpumpR` package cannot be found:
- Make sure you've run `devtools::install()` before deploying
- Verify all dependencies are installed with `devtools::install_deps(dependencies = TRUE)`

### Config file errors
If you get errors about the config file:
- The `config_production.yml` file should be present in the repository
- Check that it has valid YAML syntax
- For local development, you can create a `config.yml` file based on `config.yml.sample`
- The default values in `config_production.yml` should work for deployment

### Memory or timeout issues
- shinyapps.io free tier has memory limits
- Consider upgrading your plan if needed
- Optimize the app by removing unnecessary data or computations

## Notes

- The `app.R`, `config_production.yml`, and `DEPLOYMENT.md` files are excluded from the R package build (via `.Rbuildignore`) but are included in the repository for deployment purposes
- You can test the app locally before deploying by running `source("app.R")` from the repository root
- For local development with custom config, create a `config.yml` file (it's git-ignored) - the app will use it automatically
- The app uses the `run_app()` function from the `stanpumpR` package, which is defined in `R/app_run.R`
