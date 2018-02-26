tts=hs.speech.new()
volpath="/Volumes/SDBCPRESENT" --Path to your BookPort volume
queuepath=os.getenv("HOME").."/bookport" --Path where UBT places your files

volwatch=hs.fs.volume.new(function(type, data)
	if type==hs.fs.volume.didMount then
		volpath=data.path
		beginBookportTransfer()
		bpPathwatch:start()
		volwatch:stop()
	end
end)

usbwatch=hs.usb.watcher.new(function(data)
	if data.productName=='TTSMP3Player' then
		if data.eventType=='added' then
		tts:speak("BookPort connected. Waiting for mount.")
		volwatch:start()
	else
		tts:speak("Bookport disconnected.")
		bpPathwatch:stop()
	end
	end
end)

function beginBookportTransfer()
	success, output, raw = hs.osascript.applescript([[
	tell application "finder"
	if items of (POSIX file "/Users/guillemleon/bookport" as alias) is {} then
		say "Queue directory is empty."
		return false
		else
			say "Transferring files..."
			move every file of folder (POSIX file "/Users/guillemleon/bookport") to (POSIX file "]]..volpath..[[") with replacing
			delete every file of folder (POSIX file "/Users/guillemleon/bookport")
			say "Transfer complete."
			return true
			end if
			end tell
	]])
end

bpPathwatch=hs.pathwatcher.new(queuepath, function(paths, flags)
	for k, v in pairs(flags) do
		if(v.itemCreated==true) then
			os.execute("sleep 2")
			beginBookportTransfer()
			break
	end
end
end)

usbwatch:start()