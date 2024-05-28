term.clear()
term.setCursorPos(1,1)

print("=== childFind ===")

while true do
 local id, locat = rednet.receive()
 if locat then    
  print("<" .. id .. "> " .. locat)
 end
end
