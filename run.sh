#!/bin/bash

# Close 8080 & 8081 ports
lsof -ti:8080 | xargs -r kill -9
lsof -ti:8081 | xargs -r kill -9

# Test first
cd backend
./mvnw test

# Start backend in the background
./mvnw spring-boot:run &

# Wait for a moment to ensure backend starts properly
sleep 5

# Start frontend in the foreground
cd ../frontend
npm install
npm run serve