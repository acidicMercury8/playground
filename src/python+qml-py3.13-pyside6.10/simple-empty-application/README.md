# Python PySide6 QML Simple Application

## Requirements

- Python 3.13

## Build

Configure environment:

```powershell
py -3 -m venv .venv
.\.venv\Scripts\activate
```

Install dependencies:

```powershell
pip install -r requirements.txt --cache-dir .pip
```

Pack modules:

```powershell
pyinstaller src\QtSimpleApplication\QtSimpleApplication.spec
```
