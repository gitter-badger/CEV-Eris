// These are basically USB data sticks and may be used to transfer files between devices
/obj/item/weapon/computer_hardware/hard_drive/portable
	name = "data disk"
	desc = "Removable disk used to store data."
	w_class = ITEM_SIZE_SMALL
	icon = 'icons/obj/discs.dmi'
	icon_state = "yellow"
	hardware_size = 1
	power_usage = 30
	max_capacity = 16
	default_files = list()
	origin_tech = list(TECH_DATA = 1)
	price_tag = 10
	var/disk_name
	var/license = 0

/obj/item/weapon/computer_hardware/hard_drive/portable/advanced
	name = "advanced data disk"
	icon_state = "blue"
	max_capacity = 64
	origin_tech = list(TECH_DATA = 2)
	price_tag = 20

/obj/item/weapon/computer_hardware/hard_drive/portable/super
	name = "super data disk"
	desc = "Removable disk used to store large amounts of data."
	icon_state = "black"
	max_capacity = 256
	origin_tech = list(TECH_DATA = 4)
	price_tag = 50

/obj/item/weapon/computer_hardware/hard_drive/portable/Initialize()
	. = ..()
	w_class = ITEM_SIZE_SMALL
	if(disk_name)
		SetName("[initial(name)] - '[disk_name]'")

/obj/item/weapon/computer_hardware/hard_drive/portable/Destroy()
	if(holder2 && (holder2.portable_drive == src))
		holder2.portable_drive = null
	return ..()

/obj/item/weapon/computer_hardware/hard_drive/portable/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/pen))
		var/new_name = input(user, "What would you like to label the disk?", "Tape labeling") as null|text
		if(isnull(new_name)) return
		new_name = sanitizeSafe(new_name)
		if(new_name)
			SetName("[initial(name)] - '[new_name]'")
			to_chat(user, SPAN_NOTICE("You label the disk '[new_name]'."))
		else
			SetName("[initial(name)]")
			to_chat(user, SPAN_NOTICE("You wipe off the label."))
		return

	..()
