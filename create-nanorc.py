from pathlib import Path

with open('.nanorc', 'w') as f:
    f.write('set afterends\n')
    f.write('set autoindent\n')
    f.write('set constantshow\n')
    f.write('set linenumbers\n')
    f.write('set smarthome\n')
    f.write('set smooth\n')
    f.write('set tabsize 4\n')
    f.write('set tabstospaces\n')
    f.write('\n')
    for path in sorted(Path('./.nano').glob('*.nanorc'), key=lambda p: p.name.casefold()):
        f.write(f'include "~/.nano/{path.name}"\n')

with open('.nanorc-legacy', 'w') as f:
    f.write('set autoindent\n')
    f.write('set smarthome\n')
    f.write('set smooth\n')
    f.write('set tabsize 4\n')
    f.write('set tabstospaces\n')
    f.write('\n')
    for path in sorted(Path('./.nano-legacy').glob('*.nanorc'), key=lambda p: p.name.casefold()):
        f.write(f'include "~/.nano/{path.name}"\n')
