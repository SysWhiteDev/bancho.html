
# bancho.html
bancho.html aims to be an alternative frontend for bancho.py-based servers.

## Roadmap
- [x] Leaderboards
- [ ] User profiles
- [ ] Authentication
- [ ] Admin + Owner panel
- [ ] Internal API

## Requirements
- Node.js >= 18
- Linux | Ubuntu 22.04 LTS recommended
- [bancho.py](https://github.com/osuAkatsuki/bancho.py) server

## Building
We have a very simple but effective [build script](https://github.com/SysWhiteDev/bancho.html/blob/main/build.sh). We use this custom script to automatically set up **.env** support for configuration purposes.

### Build via build script
Simply run the commands below in the project root (in a Linux OS):
```
sudo chmod +x ./build.sh
sudo ./build.sh
```

### Build manually
Attention: We recommend automatic building via the script for inexperienced users! (Although it is not hard to build bancho.html manually)

**Step 1**: Install all dependencies
```
npm install
```
**Step 2**: Run Nuxt's build
```
npm run build
```
**Step 3**: Go to the built directory (.output) and install the dotenv Node.js package
```
cd ./.output/server
npm i dotenv --save
```
**Step 4**: Copy the .env.example file from the project root
```
cp ../../.env.example ./
```
**Step 5**: Add a start script in package.json

Add the following code at line 4
```
"scripts": {
	"production": "node -r dotenv/config ./index.mjs"
},
```
Your package.json should look like this:
```
{
"name": "nitro-output",
"version": "0.0.0",
"scripts": {
	"production": "node -r dotenv/config ./index.mjs"
},
"bundledDependencies": {
...
```
**Step 6**: Congratulations! You have manually built bancho.html, you may now run the websever via `npm run production`

## Installation
```
This section has not been written yet.
```

### Credits
- [Cmyui](https://github.com/cmyui/) | Creator of [bancho.py](https://github.com/osuAkatsuki/bancho.py)
- [Tree](https://github.com/how-to-do-frontend) | General help
- [Nuxt Discord server](https://discord.gg/nuxt) | General frontend help.