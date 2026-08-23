---
name: xonsh
version: 1.0.0
description: |
  Write, read, or debug xonsh shell code (.xsh files, xonsh -c one-liners, ~/.xonshrc).
  Xonsh is a Python-superset shell: Python 3 plus subprocess operators. Use for
  scripting scenarios: subprocess capture operators ($(), !(), ![], $[]), @() Python
  substitution, environment variables, aliases, path strings, globbing, and translating
  bash idioms to xonsh.
license: MIT
disable-model-invocation: false
---

# Xonsh Scripting Reference

Xonsh is a superset of Python 3 with shell primitives. It has its OWN subprocess
parser — it does NOT delegate to bash. Bash-isms like brace expansion (`{1..5}`)
and `\` escapes do not work. Python replaces them.

```xsh
cd /tmp && ls                     # shell commands
21 + 21                           # python
for i in range(0, 42):            # mix python
    echo @(i+1)                   # and shell
len($(curl https://xon.sh))       # capture output into python
$CONCH='snail' ls                 # per-command env var
p'/etc/passwd'.read_text().find('root')  # p-string -> pathlib.Path
for line in $(cat /etc/passwd).splitlines():
    echo @(line.split(':')[0])
```

Run a script: `xonsh script.xsh` or `xonsh -c 'echo @(2+2)'`.

## Subprocess operators — the core of xonsh

| Operator | Blocking | Captures | Returns | Use for |
| --- | --- | --- | --- | --- |
| `$()`  | yes | stdout | str | grabbing output |
| `!()`  | no  | stdout+stderr | CommandPipeline | return code / async |
| `![]`  | yes | no (streams) | HiddenCommandPipeline | run + check success |
| `$[]`  | yes | strictly no | None | interactive/streaming tools |

### $() — capture stdout as string

```xsh
$(whoami)                      # 'user' (single line: stripped, xonsh >= 0.17)
output = $(echo -e '1\n2')     # '1\n2\n' (universal newlines)
id $(whoami)                   # use inside a command

$XONSH_SUBPROC_OUTPUT_FORMAT = 'list_lines'
$(ls /)                        # ['/bin', '/etc', '/home']
```

### !() — capture all, non-blocking, returns object

```xsh
ret = !(echo 123)     # CommandPipeline: .pid .returncode .output .out .err
if ret:               # truthy when returncode == 0
    print('Success')
for l in ret:         # iterate lines
    print(l)

# NON-BLOCKING: force completion with .end(), .out, .rtn, or str()
worker = !(sleep 3)             # runs in background
echo 'meanwhile...'
if worker.rtn == 0:             # .rtn blocks until done
    echo done
```

Captured mode detaches the terminal — never use `$()`/`!()` on interactive
tools (`vim`, `fzf`, `python -c "input()"`): the OS suspends them.

### ![] — stream to screen, return status object

```xsh
if r := ![ls /nonexistent]:
    print(f'ok: {r.returncode}')
else:
    print(f'failed: {r.returncode}')

with __xonsh__.env.swap(XONSH_CAPTURE_ALWAYS=True):
    r = ![echo hi]     # streams AND captures; r.out == 'hi\n'
```

### $[] — stream only, return None

```xsh
$[vim ~/.xonshrc]      # interactive tools
$[./deploy.sh]         # stream output directly, capture nothing
```

### @() — Python substitution into commands

```xsh
echo @('string') @(['list','of','strings'])   # lists expand to args
name = 'snail'
echo @('--name=' + name.upper())              # --name=SNAIL
echo @(f'Hello {$HOME}')
echo -n '!' | @(lambda args, stdin: 'Callable' + stdin.read())
```

### @$() — split output on whitespace into args (bash's `$()`)

```xsh
showcmd @$(echo -e '1\n2 3\n4')   # ['1', '2', '3', '4']
```

## Arguments and quoting — differs from bash

```xsh
echo "123 456"          # quotes, not backslash-escapes
echo --arg="val"        # quotes are KEPT inside args: --arg="val"
echo --arg "val"        # fully-quoted arg: --arg val
echo {123}              # SyntaxError — braces have meaning
echo "{123}" '[456]'    # {123} [456]
echo """{"json":'ok'}"""  # triple quotes avoid escaping
showcmd echo a @('b') $(echo c)   # showcmd prints the resolved arg list
showcmd -e myalias x    # -e expands aliases
```

When in doubt, quote. To run a pasted bash command verbatim: `bash -c! echo {1..3}`.

## Environment variables

```xsh
$VAR = 'value'
'VAR' in __xonsh__.env             # True
__xonsh__.env.get('VAR2', 'fallback')

$VAR='override' xonsh -c r'echo $VAR'      # per-command
with __xonsh__.env.swap(VAR='tmp', NEW='x'):   # scoped
    echo $VAR

print("home: " + $HOME)     # python mode: no interpolation in strings
echo "home: $HOME"          # subprocess mode: interpolates (single quotes too)
echo! $HOME                 # macro: prints literal $HOME

# $PATH is a list
$PATH.append('/tmp')
$PATH.prepend('/tmp')
$PATH.remove('/tmp')
$PATH.add(p'~/bin', front=True, replace=True)

for d in [p'~/.cargo/bin', p'~/.local/bin']:
    if d.is_dir():
        $PATH.add(d, front=True, replace=True)
```

## Aliases

```xsh
aliases['g'] = 'git status -sb'              # string
aliases['gp'] = ['git', 'pull']              # arg list
aliases['e'] = 'echo @($arg0) @($args[2:])'  # ExecAlias with $args/$argN
del aliases['g']

# python function as command group
def hello(name):
    echo hello @(name)
hello('Alex')

# alias that rewrites the command (prefer over callable when just transforming)
@aliases.register
@aliases.return_command
def _xsudo(args):
    return ['sudo', '--', *aliases.eval_alias(args)]

# callable alias with stdin/stdout (signature: args, stdin, stdout, stderr, spec, stack)
def _exc(args, stdin, stdout):
    for line in stdin.readlines():
        print(line.strip() + '!', file=stdout, flush=True)
aliases['exc'] = _exc
echo hello | exc          # hello!
```

## Path strings and globbing

```xsh
path = p'~/.xonshrc'                 # pathlib.Path('/home/user/.xonshrc')
[path.name, path.exists(), path.parent]
path = p'/tmp' / 'sub' / f'{name}'
p'/tmp/hello'.write_text('Hi')
p'/tmp/hello'.read_text()

with p'/tmp/a/b'.mkdir(parents=True, exist_ok=True).cd():   # cd context manager
    pwd                              # /tmp/a/b, restored after block

for f in gp`/tmp/*.*`:      # glob -> Path objects
    du -sh @(f)
for f in gp`/tmp/*/**`:     # recursive
    print(f)
for f in rp`.*`:            # regex glob -> Path objects
    print(f.exists())
```

## Macros

```xsh
bash -c! echo {1..5} \;     # subprocess macro: raw string, no xonsh parsing
echo! $USER                 # prints "$USER" literally
ssh host -T! uname -a       # pass remaining line raw to the command

from_json = lambda cmd: __import__("json").loads(evalx(f"$({cmd})"))
o = from_json!(echo '{"a":1}')      # function macro: arg arrives as source string

from xonsh.contexts import Block    # capture a code block as text
with! Block() as b:
    qwe
    asd
b.macro_block               # 'qwe\nasd\n\n'
```

## Scripting patterns

```xsh
# script's own path
p"$ARG0".parent

# inline import (xonsh >= 0.18.2)
@.imp.json.loads($(echo '{"a":1}'))
@.imp.hashlib.md5(b'x').hexdigest()

# inline statements / one-liners
for i in range(1,5): $[echo @(i)]
if $(which vim): $[echo vim]
$[echo vim] if $(which vim) else $[echo vi]

# walrus
(servers := $(ls /).splitlines())
echo @(servers[0])

# error handling
$XONSH_SUBPROC_RAISE_ERROR = True   # raise on nonzero exit (like set -e; default)
$XONSH_SUBPROC_CMD_RAISE_ERROR = True   # also raise on every failing command in a chain
if not ![grep -q root /etc/passwd]:
    echo 'not found'

# semicolons inside capture: wrap in ()
$((echo -n 1; echo -n 2))           # '12'  ($(a; b) alone does NOT split)

# exit-code juggling with a python callable in a pipeline
aliases['cdls'] = "cd @($arg0) && @(lambda: 0 if len(g`./*`) < 100 else 1) && ls"

# background jobs
sleep 100 &
while $(jobs):
    __xonsh__.imp.time.sleep(1)
print('done')

# multiline text to file
echo @("""
line 1
line 2
""".strip()) > /tmp/file.txt

# breakpoint in a script
import pdb; pdb.set_trace()

# clean/pure runs
xonsh --no-rc --no-env -DPATH -DTERM -DHOME
xonsh --no-rc --no-env --shell-type readline \
      -DXONSH_HISTORY_BACKEND=dummy -DXONTRIBS_AUTOLOAD_DISABLED=1 script.xsh
```

## Threading gotchas

Xonsh predicts whether a command is "threadable" (capturable). Interactive
tools are predicted unthreadable; capturing them suspends the process.

```xsh
!(@thread ssh host -T "echo 1")   # force-capture a normally interactive tool
!(bash -c "echo 123")             # or wrap in a capturable tool
@unthread ./tool.sh               # frozen terminal fix: force unthreadable
with __xonsh__.env.swap(THREAD_SUBPROCS=False): $[./tool.sh]
__xonsh__.commands_cache.predict_threadable(['ssh'])   # False
```

## Command decorators (output transformers)

```xsh
$(@lines ls /)              # ['/bin', '/etc', '/home']
$(@stream cat file)         # str even when $XONSH_SUBPROC_OUTPUT_FORMAT = 'list_lines'
$(@json curl -s httpbin.org/json)   # parsed dict
$(@jsonl cat data.jsonl)    # list of parsed objects, one per line
y = $(@yaml dig +yaml google.com)   # parsed yaml
$(@toml cat pyproject.toml) # parsed dict
podman exec -it @($(@json podman ps --format json)['ID']) bash

# Path objects from output
$(@path echo '/bin').exists()
[p.exists() for p in $(@paths echo '/bin\n/etc')]

# XML -> xml.etree.ElementTree.Element (.tag .attrib .text .find() .findall())
feed = $(@xml curl -s https://github.com/xonsh/xonsh/releases.atom)
ns = {'a': 'http://www.w3.org/2005/Atom'}
[e.find('a:title', ns).text for e in feed.findall('a:entry', ns)[:5]]
# @lxml: same but lxml.etree._Element with full XPath (needs `xpip install lxml`)
$(@lxml curl -s url).xpath('//a:entry/a:title/text()', namespaces=ns)

# per-command error control (see also $XONSH_SUBPROC_*_RAISE_ERROR)
r = !(@error_raise ls nonono)    # raise on nonzero exit, even inside &&/|| chains
r = !(@error_ignore ls nonono)   # never raise; wins over $XONSH_SUBPROC_RAISE_ERROR
```

`@thread` / `@unthread` are also command decorators — see Threading gotchas above.

## Bash → xonsh quick map

| bash | xonsh |
| --- | --- |
| `$(cmd)` (word-split) | `@$(cmd)` |
| `$(cmd)` (as string) | `$(cmd)` |
| `cmd; echo $?` | `![cmd].returncode` or `@.lastcmd.rtn` |
| `if cmd; then` | `if ![cmd]:` |
| `set -e` | `$XONSH_SUBPROC_RAISE_ERROR = True` (default) |
| `VAR=x cmd` | `$VAR='x' cmd` |
| `export VAR=x` | `$VAR = 'x'` |
| `echo {1..5}` | `echo @(range(1,6))` |
| `[ -f x ]` | `p'x'.is_file()` |
| `for f in *.txt` | ``for f in gp`*.txt` `` |

Full translation table (env vars, `$ARGS`, indirect lookup, tracing, and more): read
[references/bash-to-xsh.md](references/bash-to-xsh.md).
