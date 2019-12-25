#include <linux/fs.h>
#include <linux/init.h>
#include <linux/proc_fs.h>
#include <linux/seq_file.h>
#include <asm/setup.h>

char patched_command_line[COMMAND_LINE_SIZE];

static int cmdline_proc_show(struct seq_file *m, void *v)
{
	char *needle_address_begin, *needle_address_end;
	size_t length;

	strcpy(patched_command_line, saved_command_line);

	needle_address_begin = strstr(patched_command_line, "androidboot.verifiedbootstate=");
	needle_address_end = needle_address_begin;

	length = strlen(saved_command_line - (needle_address_end - saved_command_line) + 1);

	if (needle_address_end)
	{
		while (*needle_address_end++ != ' ')
			;
		memmove(needle_address_begin, needle_address_end, length);
	}

	seq_printf(m, "%s\n", patched_command_line);
	return 0;
}

static int cmdline_proc_open(struct inode *inode, struct file *file)
{
	return single_open(file, cmdline_proc_show, NULL);
}

static const struct file_operations cmdline_proc_fops = {
		.open = cmdline_proc_open,
		.read = seq_read,
		.llseek = seq_lseek,
		.release = single_release,
};

static int __init proc_cmdline_init(void)
{
	proc_create("cmdline", 0, NULL, &cmdline_proc_fops);
	return 0;
}
fs_initcall(proc_cmdline_init);
