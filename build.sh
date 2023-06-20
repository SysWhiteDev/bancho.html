#!/bin/bash

# Define colors
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Removing eventual existing builds...${NC}"
rm -rf ./.output

echo -e "${GREEN}Installing dependencies${NC}"
npm install

echo -e "${GREEN}Starting nuxt build...${NC}"
npm run build

echo -e "${GREEN}Switching to built directory${NC}"
cd ./.output/server

echo -e "${GREEN}Installing dotenv${NC}"
npm i dotenv --save

echo -e "${GREEN}Adding .env file${NC}"
cp ../../.env.example ./

echo -e "${GREEN}Adding start script...${NC}"
sed -i '4s/.*/"scripts": {\n  "production": "node -r dotenv\/config .\/index.mjs"\n},/' package.json

echo -e "${GREEN}Build completed, check logs for evetual errors.${NC}"
echo -e "The server files are in the '.output' folder, to run the server, go to the 'server' folder and run 'npm run production'"