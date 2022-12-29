# Flitsmeister app for LB Phone

## Installation
1. Grab the latest release from [Releases](https://github.com/chrisd1997/lb-phone-flitsmeister/releases)
2. Extract the zip to your resources folder
3. Copy the `ui/build/flitsmeister.png` to `lb-phone/ui/assets/img/icons/apps/`
4. All done 🎉

## Usage
### Exports
Using the `exports["flitsmeister-app"]:AddSpeedCameras()` function you'll be able to add your own speed cameras to the app.

An example of how to add a speed camera is provided below:
```
exports["flitsmeister-app"]:AddSpeedCameras({
	[1] = {
		['Coords'] = vector3(2526.224, 2719.912, 43.38318),
		['MaxSpeed'] = 80
	}
})
```