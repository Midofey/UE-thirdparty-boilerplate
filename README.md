## Unreal Engine Third Party Boilerplate Plugin
Boilerplate for including a third party library (Steamworks, MySQL, Discord SDK, PS5 SDK, etc.) into Unreal Engine 5 as a plugin.

## Setup
1. Clone this repository inside a **Plugins** folder of an unreal engine project:
```
git clone https://github.com/Midofey/UE-thirdparty-boilerplate
```
2. CD into the directory
```
cd UE-thirdparty-boilerplate
```
3. Run SetPluginName.bat and follow the instructions on screen
```
SetPluginName.bat
```
4. Add any static/dynamic libraries into the corresponding platform inside the directory Source/ThirdParty/(LibraryName)/Release/(Platform)
5. Add any include header files inside the directory Source/ThirdParty/(LibraryName)/Include

You are now ready to add any code inside the main module and interact with the third party plugin you just added.
