require("config")
--require("os")
require("ver")

--os.pullEvent = os.pullEventRaw

term.setBackgroundColor(bg)
term.setTextColor(txt)

local args = { ... }

if args then
 if args=="Debug" then
  shell.openTab("shell")
 end
end

local w,h = term.getSize()

--PrintCentered FUnction

function printCentered(y,s)
 local x = math.floor((w - string.len(s)) /2)
 term.setCursorPos(x,y)
 term.clearLine()
 term.write(s)
end

--Draw menu indicator

local nOption = 1

local function drawMenu()
 term.clear()
 term.setCursorPos(1,1)
 term.write("smoothieOS " .. version)
 
 term.setCursorPos(w-11,1)
 if nOption == 1 then
  term.write("Shell")
 elseif nOption == 2 then
  term.write("Programs")
 elseif nOption == 3 then
  term.write("Shutdown")
 elseif nOption == 4 then
  term.write("Reboot")
 elseif nOption == 5 then
  term.write("Lock")
 end
end

--Draws GUI

term.clear()

local function drawFrontend()
 printCentered(math.floor(h/2) -3, "")
 printCentered(math.floor(h/2) -2, "smoothieOS Menu")
 printCentered(math.floor(h/2) -1, "")
 printCentered(math.floor(h/2) +0, ((nOption == 1) and "[ Shell    ]") or "  Shell     ")
 printCentered(math.floor(h/2) +1, ((nOption == 2) and "[ Programs ]") or "  Programs  ")
 printCentered(math.floor(h/2) +2, ((nOption == 3) and "[ Shutdown ]") or "  Shutdown  ")
 printCentered(math.floor(h/2) +3, ((nOption == 4) and "[ Reboot   ]") or "  Reboot    ")

 if passcodeRequired == true then
   printCentered(math.floor(h/2) +4, ((nOption == 5) and "[ Lock     ]") or "  Lock      ")
  end
end

--Display

drawMenu()
drawFrontend()

while true do
 local e,p = os.pullEvent()
 
 if e == "key" then
  local key = p
  
  if key == keys.up or key == keys.right then
  
   if nOption > 1 then
    nOption = nOption - 1
    drawMenu()
    drawFrontend()
   end
   
  elseif key == keys.down or key == keys.left then
   if nOption < 5 then
    nOption = nOption + 1
    drawMenu()
    drawFrontend()
   end
 elseif key == keys.enter then
  break
 end
end
end

term.clear()

--Selecting Menus

if nOption == 1 then
 shell.run("/smoothieos/shell")
elseif nOption == 2 then
 shell.run("/smoothieos/programs")
elseif nOption == 3 then
 os.shutdown()
elseif nOption == 4 then
 os.reboot()
elseif nOption == 5 then
 shell.run("smoothieos/os")
end
