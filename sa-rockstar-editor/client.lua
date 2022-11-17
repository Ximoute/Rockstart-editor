_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Rockstar Editor", "~b~Enregistrez et modifiez des séquences")       
_menuPool:Add(mainMenu)
_menuPool:MouseControlsEnabled (false);
_menuPool:MouseEdgeEnabled (false);
_menuPool:ControlDisablingEnabled(false);
_menuPool:MouseControlsEnabled (false);


function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

Citizen.CreateThread(function()
  while true do  
	_menuPool:ProcessMenus()
	if IsControlJustPressed(0, 73) then                                                            -- Touche X pour ouvrir le Rockstar Editor
	    edit(mainMenu)
	    mainMenu:Visible(not mainMenu:Visible())	
	end	
  Citizen.Wait(1)
  end
end)

function edit(menu)

	mainMenu:Clear()
	
	local newitem1 = NativeUI.CreateItem("Enregistrer", "Lancer une séquence.")
	mainMenu:AddItem(newitem1)
	
	local newitem2 = NativeUI.CreateItem("Arreter l'enregistrement", "Arreter la séquence.")                                                   
	mainMenu:AddItem(newitem2)
	
	local newitem3 = NativeUI.CreateItem("Lancer le rockstar éditor", "Éditer une séquence.")                                                   
	mainMenu:AddItem(newitem3)

	menu.OnItemSelect = function(menu, item)
	
		if item == newitem1 then
			StartRecording(1)
			mainMenu:Visible(not mainMenu:Visible())
		
		elseif item == newitem2 then
		
			if(IsRecording()) then
				StopRecordingAndSaveClip()
			else 
				ShowNotification('Vous n êtes pas en train d enregistrer !')
			end
			
		elseif item == newitem3 then

			NetworkSessionLeaveSinglePlayer()
			ActivateRockstarEditor()
		end
	end
end
