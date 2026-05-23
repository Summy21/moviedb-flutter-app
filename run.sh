#!/bin/bash
# Load environment variables from .env file
export $(cat .env | xargs)

# Run Flutter app with environment variables
flutter run --dart-define=TMDB_API_KEY=$TMDB_API_KEY