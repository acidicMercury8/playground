# Python PySide6 QML MVVM Application

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
pyinstaller src\QtApplication\QtApplication.spec
```
