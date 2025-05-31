--[[
  * ReaScript Name: SETH_Remove_VST_Prefixes_From_Track_Names
  * Author: SETH & Reaper Script Wizard
  * Version: 1.0
  * Description: Removes VST/VST3/VSTi/VST3i prefixes (case-insensitive) from all track names in the project.
  * REAPER: 7.0
  * Extensions: SWS
  * License: MIT
  * Link to The Reaper Script Wizard Custom GPT-(rated 4+ stars)-: [https://chatgpt.com/g/g-85FO7Oc1y-the-reaper-script-wizard]
  * Instructions: Load and run the script to clean up track names by removing plugin name prefixes like "VST: ", "VSTi ", etc.
--]]

local prefixes = {
  "VSTI: ", "VST3I: ", "VST3: ", "VST: ",
  "VSTi ", "VST3i ", "VST ", "VST3 ",
  "VSTi-", "VST3i-", "VST-", "VST3-"
}

for i = 0, reaper.CountTracks(0) - 1 do
  local track = reaper.GetTrack(0, i)
  local _, name = reaper.GetTrackName(track, "")
  local upper_name = string.upper(name)

  for _, prefix in ipairs(prefixes) do
    if upper_name:find(prefix:upper(), 1, true) == 1 then
      local new_name = name:sub(#prefix + 1)
      reaper.GetSetMediaTrackInfo_String(track, "P_NAME", new_name, true)
      break -- stop after first matching prefix is removed
    end
  end
end

reaper.UpdateArrange()
