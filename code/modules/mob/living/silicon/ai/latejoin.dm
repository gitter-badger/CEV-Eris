var/global/list/empty_playable_ai_cores = list()

/hook/roundstart/proc/spawn_empty_ai()
	for(var/obj/landmark/join/start/AI/S in landmarks_list)
		if(locate(/mob/living) in S.loc)
			continue
		empty_playable_ai_cores += new /obj/structure/AIcore/deactivated(get_turf(S))

	return 1

/mob/living/silicon/ai/verb/wipe_core()
	set name = "Wipe Core"
	set category = "OOC"
	set desc = "Wipe your core. This is functionally equivalent to cryo or robotic storage, freeing up your job slot."

/*	if(ticker && ticker.mode && ticker.mode.name == MODE_MALF)
		usr << "<span class='danger'>You cannot use this verb in malfunction. If you need to leave, please adminhelp.</span>"
		return
*/
	// Guard against misclicks, this isn't the sort of thing we want happening accidentally
	if(alert("WARNING: This will immediately wipe your core and ghost you, removing your character from the round permanently (similar to cryo and robotic storage). Are you entirely sure you want to do this?",
					"Wipe Core", "No", "No", "Yes") != "Yes")
		return

	// We warned you.
	empty_playable_ai_cores += new /obj/structure/AIcore/deactivated(loc)
	global_announcer.autosay("[src] has been moved to intelligence storage.", "Artificial Intelligence Oversight")

	//Handle job slot/tater cleanup.
	var/job = mind.assigned_role

	SSjob.FreeRole(job)

	clear_antagonist(mind)

	//daemonize()
	ghostize()
	qdel(src)
