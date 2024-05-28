require("config")

monitor = peripheral.wrap(mon)

monitor.setTextScale(1)
monitor.clear()

local mn = monitor

--Get Computer ID
local computerID = os.getComputerID()

--Func to get uptime
local function getUpTime()
 local secs = os.clock()
 local mins = math.floor(secs / 60)
 local hrs = math.floor(mins / 60)
 secs = secs % 60
 mins = mins % 60
 return string.format("%02d:%02d:%02d", hrs, mins, math.floor(secs))
end

--Func to get disk usage
local function getDiskUsage()
 local totalSize = fs.getCapacity("/")
 local usedSize = fs.getFreeSpace("/")
 local percent = (usedSize / totalSize) * 100
 return string.format("%d/%d KB (%.2f%%)", usedSize / 1024, totalSize / 1024, percent)
end

--Func to get running app
local function getCurrentProgram()
 return shell.getRunningProgram()
end

--Func to display stats
local function displayStats()
 monitor.clear()
 monitor.setCursorPos(1,1)
 mn.setTextColor(colors.yellow)
 monitor.write("ID: " .. computerID)
 
 monitor.setCursorPos(1,2)
 mn.setTextColor(colors.lime)
 monitor.write("Uptime: " .. getUpTime())
 
 mn.setCursorPos(1,3)
 mn.setTextColor(colors.orange)
 mn.write("Disk Usage: " .. getDiskUsage())
 
 mn.setCursorPos(1,4)
 mn.setTextColor(colors.cyan)
 mn.write("Running Program: " .. getCurrentProgram())
 
 mn.setCursorPos(1,6)
 mn.setTextColor(colors.red)
 mn.write("Rednet Activity:")
end

--Vars to store RedNet activity

local rednetSendCount = 0
local rednetGetCount = 0
local rednetBroadcastCount = 0

--RedNet Activity Logger

function logRednetActivity()
 while true do
  local event, param1, param2, param3 = os.pullEvent()
  if event == "rednet_message" then
   rednetGetCount = rednetGetCount + 1
  elseif event == "rednet_send" then
   rednetSendCount = rednetSendCount + 1
  elseif event == "rednet_broadcast" then
   rednetBroadcastCount = rednetBroadcastCount + 1
  end
 end
end

--Display RedNet activity

function displayRedNetActivity()
 while true do
  mn.setCursorPos(1,7)
  mn.setTextColor(colors.green)
  mn.write(string.format("Send: %d", rednetSendCount))
  
  mn.setCursorPos(1,8)
  mn.setTextColor(colors.blue)
  mn.write(string.format("Broadcast: %d", rednetBroadcastCount))
  
  mn.setCursorPos(1,9)
  mn.setTextColor(colors.red)
  mn.write(string.format("Receive: %d", rednetGetCount))
 end
end

while true do
 displayStats()
 sleep(1)
end

parallel.waitForAny(logRedNetActivity(), displayRedNetActivity())
