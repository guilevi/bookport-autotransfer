cp -R .hammerspoon ~/
cp -R .bport ~/
chmod +x bport
cp bport /usr/local/bin
echo Files copied.
echo To begin, add
echo require\(\'bookport\'\)
echo to your Hammerspoon init.lua, then reload Hammerspoon