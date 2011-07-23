using terms from application "Quicksilver"
	on process text tasks_text
		tell application "TaskPaper"
			tell front document
				if not (exists project named "Inbox") then
					make new project with properties {name:"Inbox"} at front of projects
				end if
				tell project named "Inbox"
					repeat with each in paragraphs of tasks_text
						-- Add as a task by prepending with -
						set myLine to "- " & each
						make new entry with properties {text line:myLine}
					end repeat
				end tell
			end tell
			-- Autosave the file
			front document save
		end tell
		try
			growlNotify(tasks_text, "Inbox")
		end try
	end process text
end using terms from

-- Growl related code from - http://code.google.com/p/add-to-taskpaper-script/
on growlNotify(task, |project|)
	tell application "GrowlHelperApp"
		register as application "Taskpaper" all notifications {"Task added"} ¬
			default notifications {"Task added"} icon of application "TaskPaper.app"
		notify with name ¬
			"Task added" title "New task added" description task & return & ¬
			"added to \"" & |project| & "\" project" application name "Taskpaper"
	end tell
end growlNotify