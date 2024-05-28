require("config")

-- SmoothieOS Startup Function
-- Used to initialise system

version = "A2"
id = os.getComputerID()

term.setBackgroundColor(bg)
term.setTextColor(txt)

-- "flags" variable can be set to a string,
-- and the flag will be appended at runtime.

local label = os.getComputerLabel()
flags = "debug"

if label==nil then
 os.setComputerLabel("SmoothieOS")
end

-- Modem can be set in config (/smoothieos/config.lua)

if modem then
 rednet.open(modem)
end

os.pullEvent = os.pullEventRaw

term.clear()
term.setCursorPos(1,1)
print("smoothieOS Now Loading...")
textutils.slowPrint("=========================")
sleep(1)

if passcodeRequired==true then
 term.clear()
 term.setCursorPos(1,1)
 term.write("Enter Passcode ==> ")
 
 local input = read()
 
 if input==passcode then
  shell.run("/smoothieos/interface.lua " .. flags)
 else
  print("Incorrect!")
  sleep(1)
  os.reboot()
 end
else
 shell.run("/smoothieos/interface.lua " .. flags)
end
