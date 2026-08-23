# Bash to Xonsh Translation Guide

Xonsh equivalents for common Bash patterns. (Source: <https://xon.sh/bash_to_xsh.html>)

| Bash | Xonsh | Notes |
| --- | --- | --- |
| No session object | `@` | The `@` object has `@.env` (env vars), `@.imp` (importer), `@.lastcmd` (last command), etc. |
| `script.sh` | `script.xsh` | Recommended file extension is `.xsh`. |
| `#!/bin/bash` | `#!/usr/bin/env xonsh` | Use `xonsh` in the shebang. |
| `echo --arg="val"` / `echo {}` / `echo \;` | `echo --arg "val"` / `echo "{}"` / `echo ";"` | No escaping character like bash's backslash. Use single or double quotes to remove the special meaning of characters, words, or brackets. |
| `$NAME` or `${NAME}` | `$NAME` | Look up an environment variable by name. |
| `export NAME=Peter` | `$NAME = 'Peter'` | Setting an environment variable. See also `$UPDATE_OS_ENVIRON`. |
| `unset NAME` | `del $NAME` | Unsetting/deleting an environment variable. |
| `echo "$HOME/hello"` | `echo "$HOME/hello"` | Construct an argument using an environment variable. |
| `echo $HOME/$(uname)` | `echo @($HOME + '/' + $(uname))` | Concatenate a variable or text with a command's output. |
| `echo 'my home is $HOME'` | `echo @("my home is $HOME")` | Escape an environment variable from expansion. |
| `${!VAR}` | `${var or expr}` | Indirect env-var lookup; any valid expression works inside `${}`. |
| `ENV1=VAL1 command` | `$ENV1=VAL1 command` or `with @.env.swap(ENV1=VAL1): command` | Temporary env var(s) for a command. The `swap` form with an indented block covers many commands. |
| `alias ll='ls -la'` | `aliases['ll'] = 'ls -la'` | An alias can be a command string, a list of arguments, or any Python function. |
| `$(cmd args)` or `` `cmd args` `` | `@$(cmd args)` | Command substitution: tokenize the output and inject it as arguments. |
| ``v=`echo 1` `` | `v=$(echo 1)` | Bash backticks = captured subprocess = xonsh `$()`. Backticks in xonsh mean regex globbing (`` ls `/etc/pass.*` ``). |
| `echo -e "\033[0;31mRed\033[0m"` | `printx("{RED}Red text{RESET}")` | Print colored text. |
| `shopt -s dotglob` | `$DOTGLOB = True` | Make `*` / `**` globs also match dotfiles. |
| `if [ -f "$FILE" ];` | `p'/path/to/file'.exists()` or `pf'{file}'.exists()` or `if !(test -f $FILE):` | Path objects can be instantiated and checked directly with p-string syntax. |
| `set -e` | `$XONSH_SUBPROC_RAISE_ERROR = True` *(default)* | Raise `subprocess.CalledProcessError` on a non-zero return code of the *final* command in a statement (matches bash `set -e`: intermediate failures in `&&`/`\|\|` chains are allowed). `$XONSH_SUBPROC_CMD_RAISE_ERROR = True` additionally raises on *every* failing individual command. |
| `set -x` | `trace on` and `$XONSH_SUBPROC_TRACE = True` | Trace source lines during execution. |
| `&&` | `&&` or `and` | Logical-and for subprocesses. |
| `\|\|` | `\|\|` or `or` | Logical-or for subprocesses. |
| `$$` | `os.getpid()` | PID of the current shell. |
| `$?` | `@.lastcmd.rtn` | Exit code of the previous command. In scripts use `!(cmd).rtn` for non-interactive processes. |
| `$<n>` | `$ARG<n>` | Command-line argument at index n (`$ARG1` == `$1`). |
| `$@` | `$ARGS` | List of all command-line arguments. |
| `while getopts` | Use [argparse](https://docs.python.org/3/library/argparse.html) or [click](https://click.palletsprojects.com/). | Standard Python CLI parsing. |
| `IFS` | `$XONSH_SUBPROC_OUTPUT_FORMAT` | Controls output representation/splitting. See also `DecoratorAlias` for object output, e.g. `j = $(@json echo '{}')`. |
| `podman run -it bash` | `podman run -it xonsh/xonsh:slim` | Official xonsh containers on Docker Hub, targeting CI/automation. |
| `exit 1` | `exit 1` or `exit(1)` | Exit the current script. |

## Debugging subprocess commands

To see how xonsh tokenizes and executes subprocess commands, use `showcmd` or
set `$XONSH_SUBPROC_TRACE = True`:

```xsh
$XONSH_SUBPROC_TRACE = True
echo $(echo @('hello')) @('wor' + 'ld') | grep hello
# TRACE SUBPROC: (['echo', 'hello'],)
# TRACE SUBPROC: (['echo', 'hello\n', 'world'], '|', ['grep', 'hello'])
```
