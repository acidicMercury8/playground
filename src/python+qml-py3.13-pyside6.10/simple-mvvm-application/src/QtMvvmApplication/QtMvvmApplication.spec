# -*- mode: python ; coding: utf-8 -*-

application_name = 'QtMvvmApplication'
entry_point = 'Program.py'

a = Analysis( # type: ignore
    [entry_point],
    pathex=[],
    binaries=[],
    datas=[('Views', 'Views')],
    hiddenimports=[],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)

pyz = PYZ( # type: ignore
    a.pure,
)

exe = EXE( # type: ignore
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name=application_name,
    exclude_binaries=True,
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon='NONE',
)

coll = COLLECT( # type: ignore
    exe,
    a.binaries,
    a.zipfiles,
    a.datas,
    strip=False,
    upx=True,
    upx_exclude=[],
    name=application_name,
)
