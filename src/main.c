#include "main.h"

static int __init driver_entry()
{
	printk(KERN_INFO "Hello, World!\n");
	return 0;
}

static void __exit driver_unload()
{
	printk(KERN_INFO "Goodbye, World!\n");
}

module_init(driver_entry);
module_exit(driver_unload);

MODULE_LICENSE("GPL");

MODULE_AUTHOR("unknown");

MODULE_DESCRIPTION("android kernel driver template");
